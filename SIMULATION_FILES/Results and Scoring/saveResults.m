function [folderName] = saveResults(UserDataName)
    
    
    % Create new folder
    currentDateTime = datetime('now');
    currentDateTimeFormatted = datestr(currentDateTime, 'yyyymmdd_HHMMSS');
    
    % Set the folder name
    folderName = fullfile('Results and Scoring',strcat(UserDataName,'_',currentDateTimeFormatted));
    
    % Check if folder exists
    if ~exist(folderName, 'dir')
        mkdir(folderName)
    end

    % Move the workspace file to destination. The 'workspace.mat' file is stored in the 'Results and Scoring' folder, so we need to move it to the new folder.
    workspaceFile   = fullfile('Results and Scoring','workspace.mat');
    movefile(workspaceFile,folderName);
    
    %%%
    % Copy html file to the same result folder
    htmlFolder  = fullfile('Results and Scoring','html');
    copyfile(htmlFolder, fullfile(folderName,'html'));

end