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


%% Hybrid energy storage system (HESS) parameters

%% Battery Pack Information

switch BAT.BatterySelection
    case 1 
        BAT.P_nom	= 150e3;		                    % [W] Rated power
        BAT.Weight  = 200;                              % [kg] Battery weight
        BAT.SoC_0   = 0.95;     			            % [-] Initial state-of-charge
    case 2
        BAT.P_nom	= 200e3;  		                    % [W] Rated power
        BAT.Weight  = 266;                              % [kg] Battery weight
        BAT.SoC_0   = 0.72;     			            % [-] Initial state-of-charge
    case 3
        BAT.P_nom	= 250e3;		                    % [W] Rated power
        BAT.Weight  = 333;                              % [kg] Battery weight
        BAT.SoC_0   = 0.57;     			            % [-] Initial state-of-charge
    case 4
        BAT.P_nom	= 300e3;  		                    % [W] Rated power
        BAT.Weight  = 400;                              % [kg] Battery weight
        BAT.SoC_0   = 0.48;     			            % [-] Initial state-of-charge
end

BAT.V_nom           = 350;	                            % [V] Rated voltage
BAT.I_nom           = BAT.P_nom/BAT.V_nom/20;           % [A] Rated current
BAT.Q_nom           = BAT.I_nom*3600;                   % [C] Rated capacity
BAT.E_nom           = BAT.Q_nom*BAT.V_nom;	            % [J] Rated energy
BAT.r               = 0.01;				                % [Ohm] Series resistance
BAT.rho             = 1e-3;			                    % [Ohm] RC branch resistance
BAT.ci              = 0.1;				                % [F] RC branch capacitance
BAT.SoC_min			= 0.05;							    % [-] Miminum state-of-charge
BAT.SoC_max			= 1+eps;						    % [-] Maximum state-of-charge

%% 3 Phase Front PMSM Information 
% Electric parameters 
MOT.Front.R         = 5e-4;						        % [Ohm] Phase resistance
MOT.Front.Ld        = 1e-4;					            % [H] Self-inductance
MOT.Front.Lq        = 3.5e-4;					        % [H] Self-inductance
MOT.Front.p         = 3;							    % [-] Pole pairs
MOT.Front.PMflux    = 0.085;			                % [Vs] PM flux-linkage, 

% Rated values 
MOT.Front.Wmnom     = 10000/30*pi;				        % [rad/s] Rated mechanical speed 
MOT.Front.Wmenom    = MOT.Front.p*MOT.Front.Wmnom;      % [rad/s] Rated electrical speed 
MOT.Front.Tenom     = min(POWERTRAIN.Power*POWERTRAIN.FrontSharing,250e3)/MOT.Front.Wmnom;
                                                        % [Nm] Rated torque
MOT.Front.Weight    = MOT.Front.Tenom/0.7;              % [kg] Weight

% Design of motor rated current
fun                 = @(I) fun1(I,MOT.Front.Ld,MOT.Front.Lq,MOT.Front.p,MOT.Front.PMflux,MOT.Front.Tenom);

% Nominal motor current
options             = optimoptions('fsolve', 'Display', 'off');
MOT.Front.Inom      = fsolve(fun, 100, options);        % [A] Rated current

MOT.Front.Pjnom     = 4\3*MOT.Front.R*MOT.Front.Inom^2; % [W] Rated joule loss
MOT.Front.Pmnom     = MOT.Front.Tenom*MOT.Front.Wmnom;  % [W] Rated mechanical power 
MOT.Front.Pnom      = MOT.Front.Pjnom + MOT.Front.Pmnom;% [W] Rated electrical power

% Mechanical parameters
MOT.Front.Dnom      = MOT.Front.Tenom/(MOT.Front.Wmnom);
MOT.Front.D         = 0.03*MOT.Front.Dnom;              % [Nms/rad] Rotor damping coeff 
MOT.Front.J         = 0.2*MOT.Front.D/6;                % [kgm^2] Rotor inertia 

% Losses coefficiencies
MOT.Front.P_hyst_OC = 10;                               % Open circuit hysteresis losses
MOT.Front.P_eddy_OC = 20;                               % Open circuit eddy losses
MOT.Front.P_exce_OC = 00;                               % Open circuit excess losses
MOT.Front.P_hyst_SC = 10;                               % Short circuit hysteresis losses
MOT.Front.P_eddy_SC = 10;                               % Short circuit eddy losses
MOT.Front.P_exce_SC = 00;                               % Short circuit excess losses


%% 3 Phase Rear PMSM Information 
% Electric parameters
MOT.Rear.R          = 5e-4;				        		% [Ohm] Phase resistance
MOT.Rear.Ld         = 8e-5;					            % [H] Self-inductance
MOT.Rear.Lq         = 15e-5;					        % [H] Self-inductance
MOT.Rear.p          = 3;							    % [-] Pole pairs
MOT.Rear.PMflux     = 0.08;			                    % [Vs] PM flux-linkage

% Rated values
MOT.Rear.Wmnom      = 12000/30*pi;				        % [rad/s] Rated mechanical speed 
MOT.Rear.Wmenom     = MOT.Rear.p*MOT.Rear.Wmnom;	    % [rad/s] Rated electrical speed 
MOT.Rear.Tenom      = min(POWERTRAIN.Power*(1-POWERTRAIN.FrontSharing),450e3)/MOT.Rear.Wmnom;
                                                        % [Nm] Rated torque
MOT.Rear.Weight     = MOT.Rear.Tenom/0.7;                 % [kg] Weight

% Design of motor rated current
fun                 = @(I) fun1(I,MOT.Rear.Ld,MOT.Rear.Lq,MOT.Rear.p,MOT.Rear.PMflux,MOT.Rear.Tenom);

% Nominal motor current
MOT.Rear.Inom       = fsolve(fun, 200, options);        % [A] Rated current

MOT.Rear.Pjnom      = 4\3*MOT.Rear.R*MOT.Rear.Inom^2;   % [W] Rated joule loss
MOT.Rear.Pmnom      = MOT.Rear.Tenom*MOT.Rear.Wmnom;    % [W] Rated mechanical power 
MOT.Rear.Pnom       = MOT.Rear.Pjnom + MOT.Rear.Pmnom;  % [W] Rated electrical power

% Mechanical parameters
MOT.Rear.Dnom       = MOT.Rear.Tenom/(MOT.Rear.Wmnom);
MOT.Rear.D          = 0.03*MOT.Rear.Dnom;               % [Nms/rad] Rotor damping coeff 
MOT.Rear.J          = 0.2*MOT.Rear.D/6;                 % [kgm^2] Rotor inertia 

% Losses coefficiencies
MOT.Rear.P_hyst_OC  = 10;                               % Open circuit hysteresis losses
MOT.Rear.P_eddy_OC  = 20;                               % Open circuit eddy losses
MOT.Rear.P_exce_OC  = 00;                               % Open circuit excess losses
MOT.Rear.P_hyst_SC  = 10;                               % Short circuit hysteresis losses
MOT.Rear.P_eddy_SC  = 10;                               % Short circuit eddy losses
MOT.Rear.P_exce_SC  = 00;                               % Short circuit excess losses

clear fun fun1 id_mtpa_fcn iq_mtpa_fcn tor_fcn options Id_mtpa Iq_mtpa

%% DC-link parameters
BUS.Vdc             = 800;                              % [V] DC-link rated voltage
BUS.Idc_nom         = (MOT.Front.Pnom + MOT.Rear.Pnom)/BUS.Vdc;
                                                        % [A] DC-link rated current

%% Others
Ts                  = 3e-4;
DF                  = 1;

%% Charging sistem parameters
% Plug
CH.PLUG.V           = 560;                              % [V] Plug voltage 
CH.PLUG.IFast       = 200;                              % [A] Fast plug current referred to BUS 
CH.PLUG.ISlow       = 100;                              % [A] Slow plug current referred to BUS 
CH.PLUG.initPos1    = 99;                               % [m] Starting high power charging position
CH.PLUG.initPos2    = 450;                              % [m] Starting low power charging position 
CH.PLUG.initPos3    = 1300;                             % [m] Starting low power charging position 
CH.PLUG.maxSpeed    = 0.1;                              % [m/s] Max vehicle speed for starting charging phase
CH.PLUG.lenghtZone  = 2;                                % [m] Charging region lenght is 2 meters

% WPT
CH.WPT.V            = 650;                              % [V] WPT voltage (V)
CH.WPT.I            = 125;                              % [A] WPT current referred to BUS (A)
CH.WPT.initPos      = 500;                              % [m] Starting charging position (m)
CH.WPT.endPos       = 900;                              % [m] Starting charging position (m)
CH.WPT.maxSpeed     = 15;                               % [m/s] Max vehicle speed for WPT (m/s)
CH.WPT.CHprof.gain  = [0 0 1 1 0.9 1 1 0 0];            % [-] Charging profile gain as a function of vehicle position
CH.WPT.CHprof.th    = [0 1 7 9 10 11 13 19 20]*2;       % [m] Breakpoints of charging profile

% Emergency
CH.EMER.V           = 600;                              % [V] Emergency voltage 
CH.EMER.I           = 100;                              % [A] Emergency current referred to BUS 
CH.EMER.minSoC      = 5;                                % [%] Min emergency battery SoC
CH.EMER.maxSoC      = 50;                               % [%] Final emergency charging SoC
CH.EMER.maxSpeed    = 0.1;                              % [%] Final emergency charging SoC


%% DC/DC converter efficiency  
% Battery converter losses
CONV.BAT.Loss_0A    = 100;                              % [W] Constant losses
CONV.BAT.Eff_FullPower = 97;                            % [%] Efficiency at full power is BAT.P_nom

% Plug converter efficiency
CONV.PLUG.eta       = [.75 .85 .92 .93 .94 .95 .95 .96 .95 .94 .92*ones(1,6)]*100;
                                                        % [-] Efficiency 
CONV.PLUG.I         = (0:0.1:1.5)*CH.PLUG.IFast;        % [A] Current vector to tabulate converter efficiency

% WPT converter efficiency
CONV.WPT.eta        = [.75 .85 .92 .93 .94 .95 .95 .96 .95 .94 .92*ones(1,6)]*100;
                                                        % [-] Efficiency of battery DC/DC converter
CONV.WPT.I          = (0:0.1:1.5)*CH.WPT.I;             % [A] Current vector to tabulate converter efficiency

% Emergency converter efficiency
CONV.EMER.eta       = [.75 .85 .92 .93 .94 .95 .95 .96 .95 .94 .92*ones(1,6)]*100;
                                                        % [-] Efficiency of battery DC/DC converter
CONV.EMER.I         = (0:0.1:1.5)*CH.EMER.I;            % [A] Current vector to tabulate converter efficiency


%% Vehicle data
VEH.BrackingPressure = 15000;                           % [bar] Bracking pressure
VEH.FrontGearBoxRatio= 6;                               % [-] Front axial gear ratio
VEH.RearGearBoxRatio = 8;                               % [-] Front axial gear ratio
VEH.FrontTireRadius  = 0.3;                             % [m] Front tyre radius
VEH.RearTireRadius   = 0.3;                             % [m] Front tyre radius 

VEH.Mass             = (12000 + BAT.Weight + MOT.Front.Weight + MOT.Rear.Weight)*scaleF;   % [kg] Vehicle mass
VEH.FrontArea        = 7;                               % [m^2] Frontal area
VEH.DragCoeff        = 0.4;                             % [-] Drag coefficient
VEH.AirDensity       = 1.18;                            % [kg/m^3] Air density 


