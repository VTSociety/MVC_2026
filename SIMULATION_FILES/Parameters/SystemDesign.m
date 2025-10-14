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

% The lorry can be equipped with a battery than can be choose among 4
% choises
 
BAT.BatterySelection = 1;                     % 150kW, 7.5 kWh
% BAT.BatterySelection = 2;                   % 200kW, 10 kWh
% BAT.BatterySelection = 3;                   % 250kW, 12.5 kWh
% BAT.BatterySelection = 4;                   % 300kW, 15 kWh

% Powertrain power can be decided by the user as well as the powersharing
% between the two motors
POWERTRAIN.Power = 400e3;        % [W] Overall power of the powertrain
POWERTRAIN.FrontSharing = .5;    % Front power motor is FrontSharing*Power

% --max front motor power is 250e3 kW
% --max rear  motor power is 450e3 kW