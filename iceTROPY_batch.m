function [listOfFiles, listOfAnisotropies]= ...
          iceTROPY_batch(pathDat,fullFileGf,namePattern)
%iceTROPY_batch Batch process multiple files for anisotropy
%   The "Batch" button on the iceTROPY GUI will make iceTROPY 
%   analyse a number of files that are located in the same folder.

% NOTES:
%  1. The assumption for this file is that we are looking at several 
%  image files that each contain a single frame.
%  Other inputs (TIF stacks) have not been tested 
%  -- particularly, the way that average anisotropies are listed may not 
%     make sense for video data (the value from the first frame of each 
%     TIF stack would be saved). 
%     So clearly this function may need changes depending on how you want 
%     a batch of files to be processed.
%  2. 

% 1. Inputs
% Determine which files are being processed
listOfFiles = dir([pathDat, namePattern]);
listOfAnisotropies = zeros(length(listOfFiles),1);


% 2. Process
% Analyse each file in turn
for lpFiles = 1:length(listOfFiles)
  fullFileDat = fullfile(pathDat, listOfFiles(lpFiles).name );

  [flagImAnis avAnis,avInts]= iceTROPY_process( fullFileDat, fullFileGf );
  
  listOfAnisotropies(lpFiles) = avAnis(1); % Sensible for single frame data
end


% 3. Output
% Produce a list of anisotropies and file names
% -- This is already produced above

end

