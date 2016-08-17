function [ areaBG,areaPAR,areaPPD,areaANIS,areaANISsmall ] = ...
          iceTROPY_defineROI( areaSelector )
% Defines regions of interest for anisotropy image processsing
%  Can be user-modified to add options to cut up the image input in
%  a different way. 
%  Either overwrite the "Area 3" setup below,
%  Which is a duplicate of "Area 2" (which may be wanted for testing the 
%  sample video data that is based on "Area 2" setup)
%  Or add new options to the GUI menu using (with "guide") and define here

% Setup #1 1 for EJR setup
if(areaSelector == 1) 
 % Area 1: 
 %   Use this for the full CCD area, 1004x1002 pixels, PPD at top
 areaBG  = [290 450 470 100];    % Background area, central
 areaPAR = [1 501 1000 500];     % Lower half of CCD image file is PARALLEL
 areaPPD = [1 1 1000 500];

 areaANIS= [250 150 500 200];     % Subarea to evaluate anisotropy image
 areaANISsmall = [50 50 300 100]; % Part of anisotropy image for histogram..
end 

% Setup # 2 for EJR system. Typically for 8x8 binning and video data.
if(areaSelector ==2)
 % Area 2: 
 %   Use this for CCD area 1-960, 1-960, with 8x8 binning, PPD at top
 areaBG  = [2 2 2 15];
 areaPAR = [1 63 124 63];
 areaPPD = [1 1 124 63];
 
 areaANIS= [30 20 60 25];
 areaANISsmall = [30 20 60 25];
end

% Setup # 3 Is a copy of "2" for users to edit with their own camera setup
if(areaSelector ==3)
 % Area 3: 
 %   Users may re-define Area 3 however is wanted
 areaBG  = [2 2 2 15];     % See "imcrop()" for info on how this is used
 areaPAR = [1 63 124 63];  % 
 areaPPD = [1 1 124 63];
 
 areaANIS= [30 20 60 25];
 areaANISsmall = [30 20 60 25];
end

end

