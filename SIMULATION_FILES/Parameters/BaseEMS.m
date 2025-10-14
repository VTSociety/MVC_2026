%% VTS Motor Vehicles Challenge 2026
% Ludovico Ortombina
% Department of Industrial Engineering
% University of Padova, Italy
% Fabio Tinazzi
% Department of Management and Engineering
% University of Padova, Italy
% Binh Minh Nguyen
% Department of Advanced Energy
% The University of Tokyo, Japan
% Yuki Hosomi
% Department of Advanced Energy
% University of Tokyo, Japan
% Yusaku Takagi
% Department of Advanced Energy
% University of Tokyo, Japan
% Hiroshi Fujimoto
% Department of Advanced Energy
% University of Tokyo, Japan
% https://github.com/VTSociety/MVC_2026 

%% Energy management parameters
% Fast plug charging system param
EMS.PLUGfast.SoCEND             = 95;                      % [%] Final battery SoC to conclude PLUG charging
EMS.PLUGfast.startPosDerating   = CH.PLUG.initPos1-99;     % [m] Position to start speed derating
EMS.PLUGfast.endPosDerating     = CH.PLUG.initPos1+CH.PLUG.lenghtZone; % [m] Position to end speed derating
EMS.PLUGfast.gain               = 0.005;

% First slow plug charging system param
EMS.PLUGslow1.SoCEND            = 90;                      % [%] Final battery SoC to conclude PLUG charging
EMS.PLUGslow1.startPosDerating  = CH.PLUG.initPos2-149;     % [m] Position to start speed derating
EMS.PLUGslow1.endPosDerating    = CH.PLUG.initPos2+CH.PLUG.lenghtZone; % [m] Position to end speed derating
EMS.PLUGslow1.gain               = 0.005;

% Second slow plug charging system param
EMS.PLUGslow2.SoCEND            = 90;                      % [%] Final battery SoC to conclude PLUG charging
EMS.PLUGslow2.startPosDerating  = CH.PLUG.initPos3-249;    % [m] Position to start speed derating
EMS.PLUGslow2.endPosDerating    = CH.PLUG.initPos3+CH.PLUG.lenghtZone; % [m] Position to end speed derating
EMS.PLUGslow2.gain               = 0.005;

% WPT charging system param
EMS.WRT.alpha                   = 0.45;                    % [-] Speed ref derating coeff for WRT charging
EMS.WRT.SoCEND                  = 90;                      % [%] Final battery SoC to conclude WRT charging
EMS.WRT.startPosDerating        = CH.WPT.initPos-20;       % [m] Position to start speed derating
EMS.WRT.endPosDerating          = CH.WPT.endPos;           % [m] Position to end speed derating

% Look-up table to generate motor current references
% The table must be designed only for positive torque. Negative values are
% taken into account in the Simulink file
EMS.FrontMot.Tau_ref            = [0,MOT.Front.Tenom];     % [Nm] Torque breakpoints
EMS.FrontMot.IdOverTorque       = [0 0];                   % [A] d-current reference points
EMS.FrontMot.IqOverTorque       = 1/(1.5*MOT.Front.p*MOT.Front.PMflux)*ones(1,2);
                                                           % [A] q-current reference points
EMS.RearMot.Tau_ref             = [0,MOT.Rear.Tenom];      % [Nm] Torque breakpoints
EMS.RearMot.IdOverTorque        = [0 0];                   % [A] d-current reference points
EMS.RearMot.IqOverTorque        = 1/(1.5*MOT.Rear.p*MOT.Rear.PMflux)*ones(1,2);
                                                           % [A] q-current reference points

