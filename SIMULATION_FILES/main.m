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

% (optimization tool is required)

%% Preparation
clearvars
close all
clc

%%%
% Prepare the MATLAB path to include the necessary folders. This folder 
% will be automatically deleted once Matlab is closed.
addpath('Results and Scoring');
addpath('Parameters')
addpath('Reference')
Functions;

%% Save results settings
% If YES option is selected, all simulation results are saved in the
% project folder "Result and Scoring" with the file nomenclature:
% "UserName_data_time", where "UserDataName" can be set as desired.
% The entire workspace, which will include the simulation results, is
% saved as well as the html report. The simulation results are, at the end
% of the simulation, present in the Matlab workspace in form of stucture of
% timeseries by the name "out". The sampling time of save data is set by
% "saveDataSampling" variable.

% saving_results = 'yes';
saving_results = 'no';

saveDataSampling = 0.01;
UserDataName = 'MVC2026_ref1';

%% Close figure
% If YES option is selected, all matlab figures generated at the end of the
% simulation reporting main results will be closed. The sampling time of 
% all scopes is set by "figureDataSampling" variable.

close_figure = 'yes';
% close_figure = 'no';

figureDataSampling = 0.01;

%% Generate CSV file
% If YES option is selected, all timeseries vectors are saved as a csv file
% in the "UserName_data_time" folder. It works only if saving_results =
% 'yes'.

% saving_csv = 'yes';
saving_csv = 'no';

%% Scale factor
scaleF      = 1/10;

%% References
% Select a number in the range [1-4] to load a driving cycle
referenceCycleNumber = 4;    % 1 - 4

run(strcat('reference',num2str(referenceCycleNumber)));
close all
% Wind prfile is erased because it is an unknown variable during the EMS
% design.
clear WindRef

%% System design
% In this section the battery size must be selected by the user as well as
% the powertrain power.
SystemDesign;

%% Load system parameters
% DO NOT MODIFY
Parameters;

%% Load control system parameters
% DO NOT MODIFY
ControlSysParameters;

%% EMS
% Participants must uncomment the file "ProposedEMS" and insert in all 
% variables necessary for their solution."
% The file BaseEMS must be commented out.
BaseEMS;
% ProposedEMS;

%% Run simulation
run(strcat('reference',num2str(referenceCycleNumber)));

tic
out = sim("MVC2026_sim.slx");

elapsedTime = toc;

%% Post processing
postProcessing;

