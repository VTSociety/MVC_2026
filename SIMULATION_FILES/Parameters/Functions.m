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

% Usefull function

fun1 = @(I,Ld,Lq,p,Lammg,tau_target) 1.5 * p * (Lammg + (Ld - Lq) * ((Lammg - sqrt(Lammg^2 + 8*(Ld - Lq)^2 * I^2)) / (-4 * (Ld - Lq)))) ...
          * sqrt(I^2 - ((Lammg - sqrt(Lammg^2 + 8*(Ld - Lq)^2 * I^2)) / (-4 * (Ld - Lq)))^2) - tau_target;

