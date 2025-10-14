%% Proposed EMS
% Write here all variables for the proposed EMS

% Look-up table to generate motor current references
% The table must be designed only for positive torque. Negative values are
% taken into account in the Simulink file
% (example copied by BaseEMS)
EMS.FrontMot.Tau_ref            = [0,MOT.Front.Tenom];     
                                                % [Nm] Torque breakpoints
EMS.FrontMot.IdOverTorque       = [0 0];                   
                                        % [A] d-current reference points
EMS.FrontMot.IqOverTorque       = 1/(1.5*MOT.Front.p*MOT.Front.PMflux)*ones(1,2);
                                        % [A] q-current reference points
EMS.RearMot.Tau_ref             = [0,MOT.Rear.Tenom];      
                                        % [Nm] Torque breakpoints
EMS.RearMot.IdOverTorque        = [0 0];                   
                                        % [A] d-current reference points
EMS.RearMot.IqOverTorque        = 1/(1.5*MOT.Rear.p*MOT.Rear.PMflux)*ones(1,2);
                                        % [A] q-current reference points


