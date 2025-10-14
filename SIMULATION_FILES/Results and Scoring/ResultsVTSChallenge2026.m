%% IEEE-VTS Motor Vehicles Challenge 2026
% Design of Powertrain and Energy Management Strategy for a Refrigerated Lorry

fprintf('Simulation Results: %s\n',UserDataName)
fprintf('\n')

if (SCORES.constraintSoC)
    fprintf('-----------------------------------------------------------------------\n');
    fprintf('Battery constraints NOT verified. Simulation results NOT valid.\n');
    fprintf('-----------------------------------------------------------------------\n');
    fprintf ('\n')
    fprintf('Final State-of-Charge of battery subsystem: %f%%\n', resultData.SoC_BP.Data(end));
    fprintf ('\n')
elseif (SCORES.constraintTime)
    fprintf('-----------------------------------------------------------------------\n');
    fprintf('The simulation exceeded the maximum allowed time. Simulation results NOT valid.\n');
    fprintf('-----------------------------------------------------------------------\n');
    fprintf ('\n')
    fprintf('Simulation Duration: %f (s) \n ', resultData.clock.Data(end));
    fprintf ('\n')
else
    fprintf('-----------------------------------------------------------------------\n');
    fprintf('The FINAL SCORE is: %f\n', SCORES.Final_Score);
    fprintf('-----------------------------------------------------------------------\n');
    fprintf ('\n')
    
    %%%
    
    fprintf('Final State-of-Charge of battery subsystem: %f%%\n', resultData.SoC_BP.Data(end));
    fprintf ('\n')
    
    fprintf('Impact of each cost function term on the final score:\n')
    fprintf('Battery current fluctuation impact on total cost: %f%%\n', (SCORES.k_batt*SCORES.phi_batt/SCORES.Final_Score*100));
    fprintf('Energy consumption impact on total cost: %f%%\n', (SCORES.k_e*SCORES.phi_E/SCORES.Final_Score*100));
    fprintf('Time to complete the mission impact on total cost: %f%%\n', (SCORES.k_time*SCORES.phi_time/SCORES.Final_Score*100));
    fprintf('Powertrain overloading impact on total cost: %f%%\n', (SCORES.k_tau*SCORES.phi_tau/SCORES.Final_Score*100));
    fprintf('Fast charging cost impact on total cost: %f%%\n', (SCORES.k_cost(1)*SCORES.phi_cost(1)/SCORES.Final_Score*100));
    fprintf('Slow charging cost impact on total cost: %f%%\n', (SCORES.k_cost(2)*SCORES.phi_cost(2)/SCORES.Final_Score*100));
    fprintf('WPT charging cost impact on total cost: %f%%\n', (SCORES.k_cost(3)*SCORES.phi_cost(3)/SCORES.Final_Score*100));
    fprintf('Emergency charging cost impact on total cost: %f%%\n', (SCORES.k_cost(4)*SCORES.phi_cost(4)/SCORES.Final_Score*100));
    fprintf ('\n')

    fprintf('Some figure of merits are reported:\n');
    fprintf('Battery current fluctuation: %f\n', SCORES.di_BP);
    fprintf('Simulation duration: %f (s)\n', SCORES.sim_time);
    fprintf('Overall motors torque reference saturation: %f (s)\n', SCORES.torRefSat_time);
    fprintf('Front motor torque reference saturation: %f (s)\n', SCORES.torRefFrSat_time);
    fprintf('Rear motor torque reference saturation: %f (s)\n', SCORES.torRefReSat_time);
    fprintf('Battery energy consumption: %f (kWh)\n', SCORES.E_BP/1000);
    fprintf('Fast plug charging time: %f  (s)\n', SCORES.FastPlugTime);
    fprintf('Fast plug energy delivered: %f (kWh)\n', SCORES.FastPlugEnergy/1000);
    fprintf('Slow plug charging time: %f (s)\n', SCORES.SlowPlugTime);
    fprintf('Slow plug energy delivered: %f (kWh)\n', SCORES.SlowPlugEnergy/1000);
    fprintf('WPT charging time: %f (s)\n', SCORES.WPTTime);
    fprintf('WPT energy deliverd: %f (kWh)\n', SCORES.WPTEnergy/1000);
    fprintf('Emergency charging time: %f (s)\n', SCORES.EmergencyTime);
    fprintf('Emergency energy delivered: %f (kWh)\n', SCORES.EmergencyEnergy/1000);
    fprintf('The battery capacity is: %f (C)\n', BAT.Q_nom);
    fprintf('The battery weight is: %f (kg)\n', BAT.Weight);
    fprintf('The front motor power is: %f (kW)\n', MOT.Front.Pnom/1000);
    fprintf('The front motor weight is: %f (kg)\n', MOT.Front.Weight);
    fprintf('The rear motor power is: %f (kW)\n', MOT.Rear.Pnom/1000);
    fprintf('The rear motor weight is: %f (kg)\n', MOT.Rear.Weight);
end

fprintf ('\n')
% The simulation time is calculated in minutes and seconds
fprintf('Elapsed time: %d minutes, and %.2f seconds\n', SCORES.minutes, SCORES.seconds);
fprintf('\n')

%% Plot of results

% Wrapped vehicle position
vehPositionWrap = mod(resultData.vehPosition.Data,TraceRef.PosRef(end));

%% Charging stations quantities
figure
plot(resultData.vehPosition.Time,vehPositionWrap, 'k', 'LineWidth', 1.5, 'DisplayName', 'Position')
hold on; grid on;
plot([0 resultData.vehPosition.Time(end)],CH.PLUG.initPos1*[1,1], 'r', 'LineWidth', 1.5, 'DisplayName', 'Fast Plug')
plot([0 resultData.vehPosition.Time(end)],(CH.PLUG.initPos1+2)*[1,1], 'r', 'LineWidth', 1.5, 'HandleVisibility','off')
plot([0 resultData.vehPosition.Time(end)],CH.PLUG.initPos2*[1,1], 'm', 'LineWidth', 1.5, 'DisplayName', 'Slow Plug')
plot([0 resultData.vehPosition.Time(end)],(CH.PLUG.initPos2+2)*[1,1], 'm', 'LineWidth', 1.5, 'HandleVisibility','off')
plot([0 resultData.vehPosition.Time(end)],CH.PLUG.initPos3*[1,1], 'g', 'LineWidth', 1.5, 'DisplayName', 'Slow Plug')
plot([0 resultData.vehPosition.Time(end)],(CH.PLUG.initPos3+2)*[1,1], 'g', 'LineWidth', 1.5, 'HandleVisibility','off')
plot([0 resultData.vehPosition.Time(end)],CH.WPT.initPos*[1,1], 'b', 'LineWidth', 1.5, 'DisplayName', 'WPT')
plot([0 resultData.vehPosition.Time(end)],CH.WPT.endPos*[1,1], 'b', 'LineWidth', 1.5, 'HandleVisibility','off')
title('')
xlim([resultData.vehPosition.time(1) resultData.vehPosition.time(end)])
xlabel('Time (s)')
ylabel('Vehicle position and charging zones (m)')
legend show
box on;

figure
subplot(211)
yyaxis right
plot(resultData.vehPosition.Time,(vehPositionWrap>CH.PLUG.initPos1)&(vehPositionWrap<(CH.PLUG.initPos1+2)), 'LineWidth', 1.5, 'DisplayName', 'Fast Plug')
hold on; grid on;
plot(resultData.vehPosition.Time,(vehPositionWrap>CH.PLUG.initPos2)&(vehPositionWrap<(CH.PLUG.initPos2+2)), 'LineWidth', 1.5, 'DisplayName', 'Slow Plug')
plot(resultData.vehPosition.Time,(vehPositionWrap>CH.PLUG.initPos3)&(vehPositionWrap<(CH.PLUG.initPos3+2)), 'LineWidth', 1.5, 'DisplayName', 'Slow Plug')
ylabel('Available plug zones')
ylim([0 1.1])
yyaxis left
plot(resultData.iPLUG, 'LineWidth', 1.5, 'HandleVisibility','off')
ylabel('Plug current (A)')
ylim([0 1+1.05*max(resultData.iPLUG)])
xlim([resultData.iPLUG.time(1) resultData.iPLUG.time(end)])
legend show
subplot(212)
yyaxis right
plot(resultData.vehPosition.Time,(vehPositionWrap>CH.WPT.initPos)&(vehPositionWrap<(CH.WPT.endPos)), 'LineWidth', 1.5, 'HandleVisibility','off')
hold on; grid on;
ylabel('Available WPT zones')
ylim([0 1.1])
yyaxis left
plot(resultData.iWPT, 'LineWidth', 1.5, 'HandleVisibility','off')
ylabel('WPT current (A)')
ylim([0 1+1.05*max(resultData.iWPT)])
title('')
xlim([resultData.iPLUG.time(1) resultData.iPLUG.time(end)])
xlabel('Time (s)')
%legend show
box on;

figure
subplot(311)
plot(resultData.vPLUG, 'LineWidth', 1.5, 'DisplayName', 'PLUG')
hold on; grid on;
plot(resultData.vWPT, 'LineWidth', 1.5, 'DisplayName', 'WPT')
plot(resultData.vEMERGENCY, 'LineWidth', 1.5, 'DisplayName', 'EMERGENCY')
ylabel('Charging voltages (V)')
title('')
xlim([resultData.vPLUG.time(1) resultData.vPLUG.time(end)])
ylim([0 500])
xlabel('')
legend show
subplot(312)
plot(resultData.iPLUG, 'LineWidth', 1.5, 'DisplayName', 'PLUG')
hold on; grid on;
plot(resultData.iWPT, 'LineWidth', 1.5, 'DisplayName', 'WPT')
plot(resultData.iEMERGENCY, 'LineWidth', 1.5, 'DisplayName', 'EMERGENCY')
ylabel('Charging currents (A)')
xlabel('')
title('')
xlim([resultData.iPLUG.time(1) resultData.iPLUG.time(end)])
legend show
subplot(313)
plot(resultData.SoC_BP, 'LineWidth', 1.5, 'DisplayName', 'SoC')
grid on;
ylabel('Battery SoC (%)')
title('')
xlim([resultData.SoC_BP.time(1) resultData.SoC_BP.time(end)])
xlabel('Time (s)')
legend show
box on;


%% Battery quantities
figure
subplot(311)
plot(resultData.vBP, 'LineWidth', 1.5, 'DisplayName', 'Voltage')
grid on;
title('')
xlabel('')
ylabel('Voltage (V)')
xlim([resultData.SoC_BP.time(1) resultData.SoC_BP.time(end)])
subplot(312)
plot(resultData.iBP, 'LineWidth', 1.5, 'DisplayName', 'Current')
grid on;
title('')
xlabel('')
ylabel('Current (A)')
xlim([resultData.SoC_BP.time(1) resultData.SoC_BP.time(end)])
subplot(313)
plot(resultData.SoC_BP, 'LineWidth', 1.5, 'DisplayName', 'SoC')
grid on;
title('')
xlim([resultData.SoC_BP.time(1) resultData.SoC_BP.time(end)])
xlabel('Time (s)')
ylabel('SoC (%)')
box on;


%% Electric motors quantities
figure
plot(resultData.wmFrMotor, 'LineWidth', 1.5, 'DisplayName', 'Front')
hold on; grid on
plot(resultData.wmReMotor, 'LineWidth', 1.5, 'DisplayName', 'Rear')
title('')
xlim([resultData.wmFrMotor.time(1) resultData.wmFrMotor.time(end)])
xlabel('Time (s)')
ylabel('Motor speed (rad/s)')
legend show
box on;

figure
subplot(211)
hold on; grid on;
plot(resultData.vDCFrMot,'LineWidth', 1.5, 'DisplayName', 'Front')
plot(resultData.vDCReMot,'LineWidth', 1.5, 'DisplayName', 'Rear')
title('')
xlim([resultData.vDCFrMot.time(1) resultData.vDCFrMot.time(end)])
ylim([min([resultData.vDCFrMot.Data; resultData.vDCFrMot.Data])-10, max([resultData.vDCFrMot.Data; resultData.vDCFrMot.Data])+10])
xlabel('')
ylabel('DC Voltage (V)')
legend show
subplot(212)
hold on; grid on;
plot(resultData.iDCFrMot,'LineWidth', 1.5, 'DisplayName', 'Front')
plot(resultData.iDCReMot,'LineWidth', 1.5, 'DisplayName', 'Rear')
title('')
xlim([resultData.iDCFrMot.time(1) resultData.iDCFrMot.time(end)])
xlabel('Time (s)')
ylabel('DC Current (A)')
legend show
box on;

figure
yyaxis left
plot(resultData.torRef, 'LineWidth', 1.5, 'DisplayName', 'Total ref.')
hold on; grid on
plot(resultData.torRefFrMot, 'LineWidth', 1.5, 'DisplayName', 'Front ref.')
plot(resultData.torRefReMot, 'LineWidth', 1.5, 'DisplayName', 'Rear ref.')
plot(resultData.torFrMot, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Front')
plot(resultData.torReMot, 'r-.', 'LineWidth', 1.5, 'DisplayName', 'Rear')
ylabel('Motor torque and reference (Nm)')
yyaxis right
plot(resultData.torSplit, 'LineWidth', 1.5, 'HandleVisibility','off')
ylim([-0.1 1.1])
title('')
xlim([resultData.torFrMot.time(1) resultData.torFrMot.time(end)])
xlabel('Time (s)')
ylabel('Torque split')
legend show
box on;

figure
yyaxis left
plot(resultData.torRefSat, 'LineWidth', 1.5, 'DisplayName', 'Total')
hold on; grid on
plot(resultData.torRefFrSat, 'LineWidth', 1.5, 'DisplayName', 'Front')
plot(resultData.torRefReSat, 'LineWidth', 1.5, 'DisplayName', 'Rear')
ylim([-0.1 1.1])
ylabel('Torque reference saturation flag')
yyaxis right
plot(resultData.torSplit, 'LineWidth', 1.5, 'HandleVisibility','off')
ylim([-0.1 1.1])
title('')
xlim([resultData.torFrMot.time(1) resultData.torFrMot.time(end)])
xlabel('Time (s)')
ylabel('Torque split')
legend show
box on;

figure
hold on; grid on;
plot(resultData.vDCFrMot.*resultData.iDCFrMot/1000,'LineWidth', 1.5, 'DisplayName', 'Front')
plot(resultData.vDCReMot.*resultData.iDCReMot/1000,'LineWidth', 1.5, 'DisplayName', 'Rear')
xlim([resultData.vDCFrMot.time(1) resultData.vDCFrMot.time(end)])
ylabel('Power (kW)')
legend show
xlabel('Time (s)')
legend show
box on;


%% Vehicle quantities
figure
yyaxis left
plot(resultData.speedRef, 'LineWidth', 1.5, 'DisplayName', 'Ref')
hold on; grid on
plot(resultData.vehSpeed, 'LineWidth', 1.5, 'DisplayName', 'Actual')
ylabel('Vehicle speed [m/s]')
yyaxis right
plot(resultData.brakeIsAct, 'LineWidth', 1.5,  'HandleVisibility','off')
ylim([-0.1 1.1])
title('')
xlim([resultData.speedRef.time(1) resultData.speedRef.time(end)])
ylabel('Braking is active')
ylim([-0.5,1.5])
xlabel('Time (s)')
legend show
box on;

figure
yyaxis left
plot(resultData.speedRef, 'LineWidth', 1.5, 'DisplayName', 'Ref')
hold on; grid on
plot(resultData.vehSpeed, 'LineWidth', 1.5, 'DisplayName', 'Actual')
ylabel('Vehicle speed (m/s)')
yyaxis right
plot(resultData.alpha, 'LineWidth', 1.5,  'HandleVisibility','off')
ylim([-0.1 1.1])
title('')
xlim([resultData.speedRef.time(1) resultData.speedRef.time(end)])
ylabel('Derating coeff')
ylim([-0.5,1.5])
xlabel('Time (s)')
legend show
box on;

%% External variables
figure
plot(resultData.vehAddMass, 'LineWidth', 1.5,  'HandleVisibility','off')
title(''); grid on
xlim([resultData.vehAddMass.time(1) resultData.vehAddMass.time(end)])
ylim([0 1.05*max(resultData.vehAddMass)])
xlabel('Time (s)')
ylabel('Good weight (kg)')
box on;

figure
plot(resultData.windSpeed, 'LineWidth', 1.5,  'HandleVisibility','off')
title(''); grid on
xlim([resultData.windSpeed.time(1) resultData.windSpeed.time(end)])
xlabel('Time (s)')
ylabel('Wind speed (m/s)')
box on;

figure
plot(resultData.roadAngle, 'LineWidth', 1.5,  'HandleVisibility','off')
title(''); grid on
xlim([resultData.roadAngle.time(1) resultData.roadAngle.time(end)])
xlabel('Time (s)')
ylabel('Road slope (rad)')
box on;


clear gamma

% delete all timeseries files
vars = whos;
for i = 1:length(vars)
    if strcmp(vars(i).class, 'timeseries')
        clear(vars(i).name); % Delete the time series variable
    end
end

clear i

