function [resultData] = prepareResultsData(out,elapsedTime,CH,BUS,MOT)

    % The "to file" Simulink block does not allow to save data in a file name by reading from the workspace. Therefore, the data are loaded in the workspace and then moved to the "tempSimResults" folder.

    % The list of measurement that are going to be used are: (must be updated)
    %measList    = {'P_ABC', 'P_DEF', 'P_BP', 'P_SM', 'i_BP', 'v_BP', 'i_SM', 'v_SM', 'SoC_BP', 'SoE_SM', 'iDC_ABC', 'vDC_ABC', 'iDC_DEF', 'vDC_DEF', 'Te_ref', 'iABC', 'iDEF', 'Pe', 'DTe_star', 'wm_star', 'V_star', 'V', 'Ft', 'Fr', 'Te', 'Tp'};

    resultData.SoC_BP           = out.SoC_BP;
    resultData.SoC_BP.Name      = 'SoC';
    resultData.vBP              = out.vBP;
    resultData.vBP.Name         = 'Battery voltage';
    resultData.iBP              = out.iBP;
    resultData.vBP.Name         = 'Battery current';
    resultData.P_BP             = timeseries(resultData.vBP.Data.*resultData.iBP.Data,resultData.vBP.Time);
    resultData.P_BP.Name        = 'Battery power';

    resultData.alpha            = out.alpha;
    resultData.alpha.Name       = 'Derating coeff';
    resultData.clock            = out.clock;
    resultData.clock.Name       = 'Clock';
    resultData.brakeIsAct       = out.brakingIsActive;
    resultData.brakeIsAct.Name  = 'Brake is active';

    resultData.iEMERGENCY       = out.iEMERGENCY;
    resultData.iEMERGENCY.Name  = 'Emergency current';
    resultData.iWPT             = out.iWPT;
    resultData.iWPT.Name        = 'WPT current';
    resultData.iPLUG            = out.iPLUG;
    resultData.iPLUG.Name       = 'Plug current';
    resultData.vPLUG            = out.vPLUG;
    resultData.vPLUG.Name       = 'Plug voltage';
    resultData.vWPT             = out.vWPT;
    resultData.vWPT.Name        = 'WPT voltage';
    resultData.vEMERGENCY       = out.vEMERGENCY;
    resultData.vEMERGENCY.Name  = 'Emergency voltage';
    resultData.iPLUGfast        = timeseries((resultData.iPLUG.Data>(0.9*CH.PLUG.IFast*BUS.Vdc/CH.PLUG.V)).*resultData.iPLUG.Data,resultData.iPLUG.Time);
    resultData.iPLUGfast.Name   = 'Fast plug current';
    resultData.iPLUGslow        = timeseries(((resultData.iPLUG.Data<(1.15*CH.PLUG.ISlow*BUS.Vdc/CH.PLUG.V))&(resultData.iPLUG.Data>(0.9*CH.PLUG.ISlow*BUS.Vdc/CH.PLUG.V))).*resultData.iPLUG.Data,resultData.iPLUG.Time);
    resultData.iPLUGslow.Name   = 'Slow plug current';

    resultData.roadAngle        = out.roadAngle;
    resultData.roadAngle.Name   = 'Road angle';
    resultData.speedRef         = out.speedProfile;
    resultData.speedRef.Name    = 'Vehicle speed ref';
    resultData.vehAddMass       = out.vehAddMass;
    resultData.vehAddMass.Name  = 'Additional mass';
    resultData.windSpeed        = out.windSpeed;
    resultData.windSpeed.Name   = 'Wind speed';

    resultData.vehPosition      = out.vehPosition;
    resultData.vehPosition.Name = 'Vehicle position';
    resultData.vehSpeed         = out.vehSpeed;
    resultData.vehSpeed.Name    = 'Vehicle speed';

    resultData.torRef           = out.torRef;
    resultData.torRef.Name      = 'Overall torque ref';
    resultData.torFrMot         = out.TeFrMot;
    resultData.torFrMot.Name    = 'Front motor torque';
    resultData.torReMot         = out.TeReMot;
    resultData.torReMot.Name    = 'Rear motor torque';
    resultData.torRefFrMot      = out.torRefFrMot;
    resultData.torRefFrMot.Name = 'Front motor torque ref';
    resultData.torRefReMot      = out.torRefReMot;
    resultData.torRefReMot.Name = 'Rear motor torque ref';
    resultData.torSplit         = out.torqueSplit;
    resultData.torSplit.Name    = 'Torque split ratio';
    resultData.torRefSat        = timeseries(abs(resultData.torRef.Data)>(MOT.Front.Tenom + MOT.Rear.Tenom - 1e-6), resultData.torRef.Time);
    resultData.torRefSat.Name   = 'Torque ref saturation flag';
    resultData.torRefFrSat      = timeseries(abs(resultData.torRefFrMot.Data)>(MOT.Front.Tenom - 1e-6), resultData.torRefFrMot.Time);
    resultData.torRefFrSat.Name = 'Front motor torque ref saturation flag';
    resultData.torRefReSat      = timeseries(abs(resultData.torRefReMot.Data)>(MOT.Rear.Tenom - 1e-6), resultData.torRefReMot.Time);
    resultData.torRefReSat.Name = 'Rear motor torque ref saturation flag';

    resultData.wmFrMotor        = out.wmFrMotor;
    resultData.wmFrMotor.Name   = 'Front motor speed';
    resultData.wmReMotor        = out.wmReMotor;
    resultData.wmReMotor.Name   = 'Rear motor speed';   

    resultData.vDCFrMot         = out.vDCFrMot;
    resultData.vDCFrMot.Name    = 'Front motor DC voltage';
    resultData.vDCReMot         = out.vDCReMot;
    resultData.vDCReMot.Name    = 'Rear motor DC voltage';
    resultData.iDCFrMot         = out.iDCFrMot;
    resultData.iDCFrMot.Name    = 'Front motor DC current';
    resultData.iDCReMot         = out.iDCReMot;
    resultData.iDCReMot.Name    = 'Rear motor DC current';

    % Save the elapsed time
    resultData.elapsedTime = elapsedTime;

end
