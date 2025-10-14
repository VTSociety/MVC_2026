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

% check if the elapsed time is available
if ~exist('elapsedTime', 'var')
    elapsedTime = 0;
end

% Prepare the results for the final score board
resultData     = prepareResultsData(out,elapsedTime,CH,BUS,MOT);

% Compute the scores
[SCORES,resultData] = scoresComputation(resultData,TraceRef);

% Show the results in the final report
disp('Please wait for the score board processing');
disp('Note: DO NOT close any plots');
options_doc_nocode.showCode = false;
web(publish('ResultsVTSChallenge2026.m',options_doc_nocode));
clear options_doc_nocode

% If desired, the results can be saved in a .mat file along with the workspace content
if (strcmp(saving_results,'yes'))
    % Save the current workspace in a .mat file of the temporary folder. The resultData structure is saved in the same file.
    workspace = fullfile('Results and Scoring','workspace.mat');
    save(workspace);
    % Then save the results in a specific folder for each simulation
    folderName = saveResults(UserDataName);
    if(strcmp(saving_csv,'yes'))
        csvFigure(resultData,folderName);
    end
    clear workspace
end

% If desired, all figure can be closed at the end of the simulation
if (strcmp(close_figure,'yes'))
    close all;
end
clc;
disp('Finished');