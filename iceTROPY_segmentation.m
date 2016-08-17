function [imBG, imPAR, imPPD] = iceTROPY_segmentation(imINPUT, flagFlipud)
% Splits input image into images containing PAR, PPD, and BG data
% Applies a vertical flip if specified

% NOTES
%  This function will need to be changed for new microscope setups
%  This will probably only need to be done once
%
%  imPAR should be an image containing the parallel fluorescence image
%  imPPD should be an image containing the perpendicular fluorescence image
%  imBG  should be an image containing (only) background signal


% 1. INPUT
%   AREA SELECTION for parallel, perpendicular, and background
%   Area 1 and 2 some provide default settings for Eric's setup
cameraAreaSetup = evalin('base','cameraAreaSetup');

[ areaBG,areaPAR,areaPPD,areaANIS,areaANISsmall ] = ...
          iceTROPY_defineROI( cameraAreaSetup );

% 2. PROCESS and OUTPUT
%    Split input image into sub-images for PAR, PPD, and BG

 if(flagFlipud)              % Some files may need a vertical flip
  imINPUT = flipud(imINPUT); 
 end
  
imBG  = imcrop(imINPUT, areaBG );
imPAR = imcrop(imINPUT, areaPAR);
imPPD = imcrop(imINPUT, areaPPD);
end