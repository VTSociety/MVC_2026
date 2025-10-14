function [SCORES,resultData] = scoreComputation(resultData,TraceRef)
    %% Scoring computation


    % Get the weighting factors coefficients
    Weighting_Factors;

    % The saved data in Simulink are downsampled to reduced the saved
    % amount of data. Ts_data is the sampling time of saved data.
    Ts_data                 = diff(resultData.alpha.Time(1:2));

    % Convert elapsed time to hours, minutes, and seconds
    SCORES.minutes          = floor(mod(resultData.elapsedTime, 3600) / 60);
    SCORES.seconds          = mod(resultData.elapsedTime, 60);

    % SoC constraint verification (it should always verified)
    SCORES.constraintSoC    = resultData.SoC_BP.data(end)>100 | resultData.SoC_BP.data(end)<=0;
    % Max simulation time constraint verification (it should always verified)
    SCORES.constraintTime   = resultData.clock.Data(end)>=(TraceRef.time(end)*TraceRef.Laps*2.5-1e-8);

    % BP current fluctuation 
    % The derivative of battery current is limited to 10000 A/Ts_data
    s                       = tf('s');
    F                       = 1/(1+s/(2*pi*100));
    Fd                      = c2d(F,Ts_data,'tustin');
    resultData.iBP.Time     = 0:Ts_data:(Ts_data*(length(resultData.iBP.Time)-1));
    if_BP                   = lsim(Fd,resultData.iBP.Data,resultData.iBP.Time);
    temp                    = gradient(if_BP,Ts_data);
    temp(abs(temp)>10000)   = 10000;
    di_BP                   = timeseries(temp,resultData.iBP.Time);
    SCORES.di_BP            = sqrt(sum((di_BP.Data).^2)*Ts_data/di_BP.Time(end));  

    % Time to run simulation
    SCORES.sim_time         = resultData.clock.Data(end);                        

    % Time that overall torque reference is saturated.
    SCORES.torRefSat_time   = sum(resultData.torRefSat.Data)*Ts_data;

    % Time that front torque reference is saturated.
    SCORES.torRefFrSat_time = sum(resultData.torRefFrSat.Data)*Ts_data;          

    % Time that rear torque reference is saturated.
    SCORES.torRefReSat_time = sum(resultData.torRefReSat.Data)*Ts_data;            

    % Energy consumption (this is the only energy provided by the battery)
    SCORES.E_BP             = sum(resultData.P_BP.Data)*Ts_data/3600;             
    
    % Time spent and energy provided by fast plug
    SCORES.FastPlugTime     = sum(resultData.iPLUGfast.Data>eps)*Ts_data;
    SCORES.FastPlugEnergy   = sum(resultData.iPLUGfast.Data.*resultData.vPLUG.Data)*Ts_data/3600;      

    % Time spent and energy provided by slow plug
    SCORES.SlowPlugTime     = sum(resultData.iPLUGslow.Data>eps)*Ts_data;
    SCORES.SlowPlugEnergy   = sum(resultData.iPLUGslow.Data.*resultData.vPLUG.Data)*Ts_data/3600;       

    % Time spent and energy provided by WPT
    SCORES.WPTEnergy        = sum(resultData.vWPT.Data.*resultData.iWPT.Data)*Ts_data/3600;             
    SCORES.WPTTime          = sum(resultData.iWPT.Data>eps)*Ts_data;

    % Time spent and energy provided by emergency charging
    SCORES.EmergencyEnergy  = sum(resultData.vEMERGENCY.Data.*resultData.iEMERGENCY.Data)*Ts_data/3600; 
    SCORES.EmergencyTime    = sum(resultData.iEMERGENCY.Data>eps)*Ts_data;

    clear temp s Fd F Ts_data

    SCORES.phi_batt         = sqrt(SCORES.di_BP);
    SCORES.phi_tau          = SCORES.torRefFrSat_time + SCORES.torRefReSat_time;
    SCORES.phi_time         = SCORES.sim_time;
    SCORES.phi_cost         = [SCORES.FastPlugEnergy; SCORES.SlowPlugEnergy; SCORES.WPTEnergy; SCORES.EmergencyEnergy];
    SCORES.phi_E            = SCORES.E_BP + ones(1,4)*SCORES.phi_cost;
    
    % Final score
    SCORES.Final_Score      =   SCORES.k_batt * SCORES.phi_batt + ...
                                SCORES.k_tau * SCORES.phi_tau + ...
                                SCORES.k_time * SCORES.phi_time + ...
                                SCORES.k_e * SCORES.phi_E + ...
                                SCORES.k_cost * SCORES.phi_cost;
    
end