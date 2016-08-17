% iceTROPY_extras_2CameraTest
%    This draft script processes 2-camera anisotropy data

% Notes (8/5/2014) for amyloid fibril (405) anisotropy images:
%    1. No conjugate plane aperture means no easy way to select background 
%       count level within the images. 
%    1b)   Can't find background level in G-factor calibration images...
%       This means assuming a G-factor of 1 - hence spatial variation in 
%       results can't be interpretted
%    1c)   In the data images, the median pixel brightness may provide a 
%       background level estimate, since most of the image is empty 
%       -- in practice, this leads to some bizarre values
% 


%
% 1. REGISTRATION -- for particular CCD area + binning
% 2. G-FACTOR CALIBRATION
% 3. ANISOTROPY EVALUATION
% 4. VISUALISATION: IMAGES OR IMAGE STACK

%   SECTION A -- DEFINE INPUTS
%   User inputs go in this section, and in "List of Control Points" below

% 1. Image for Registration (if a dye soln, can also do G-factor calibr.)

% AREA SELECTION for parallel, perpendicular, and background
% Area 1: use this for the full CCD area, 1004x1002 pixels, PPD at top
% areaBG  = [10 10 30 900];   % Left hand edge is background
% areaPAR = [1 501 1000 500]; % Lower half of CCD image file is PARALLEL
% areaPPD = [1 1 1000 500];   % Upper half of CCD image file if PERPENDICULAR
areaANIS= [10 10 200 200]; % Subarea to evaluate anisotropy

% % Area 2: use this for CCD 1-960, 1-960, 16x16 binning, PPD at top
% areaBG  = [2 2 2 15];
% areaPAR = [1 31 60 30];
% areaPPD = [1 1 60 30];
% areaANIS= [15 10  30 12];

%   RUN REGISTRATION ONCE TO SET PAR and PPD area registation
flagRegister = 0;     % Set 1 to register data, and 0 to skip

% 1x1 binned data:
% myDirReg  = 'dyeCalibration\';
% myFileReg = 'DyeCalib_Fluorescein_100microM_5ms_0EMG.tif';
% 16x16 binned data
myDirReg  = 'C:\Documents and Settings\ejr36\My Documents\Projects\2014_Anisotropy\Gabi_Fibrils\fibrils_020514\';
myFileRegPAR = 'NS_AS_L_01.fits';
myFileRegPPD = 'NS_AS_R_01.fits';

% Background subtraction:
myDirBg  = 'C:\Documents and Settings\ejr36\My Documents\Projects\2014_Anisotropy\Gabi_Fibrils\fibrils_020514\';

myFileBgPAR = 'Left_bg.fits';
myFileBgPPD = 'Right_bg.fits';
imBgPar = int32( imread([myDirBg, myFileBgPAR]) );
imBgPpd = int32( imread([myDirBg, myFileBgPPD]) );
%

% 2. Image for G-factor calibration. (Non-FRETing, non-viscous dye soln.)
% myDirGcal  = 'dyeCalibration\';
% myFileGcal = 'DyeCalib_Fluorescein_100microM_5ms_0EMG.tif';
% 16x16 binned data:
myDirGcal  = 'C:\Documents and Settings\ejr36\My Documents\Projects\2014_Anisotropy\Gabi_Fibrils\fibrils_020514\';

myFileGcalPAR = '100uM_Alexa488_epi_L03.fits';
myFileGcalPPD = '100uM_Alexa488_epi_R03.fits';


% 3. Data image for evaluation
% myDirData  = '100X_cells_coverslip\';
% myFileData = 'area5_100X_1mW_d10x2_200frames.tif';
myDirData  = 'C:\Documents and Settings\ejr36\My Documents\Projects\2014_Anisotropy\Gabi_Fibrils\fibrils_020514\';

myFileDataPAR = 'S_AS_L_01.fits';
myFileDataPPD = 'S_AS_R_01.fits';

% 4. Visualisation
%    Set any flow control here, for image / video visualisation

% Define smoothing filter -- a simple digitised, clipped Gaussian
gridXX = meshgrid(-3:3);
gridYY = gridXX';
myFsigSq = 0.6^2;
myFilter = exp(-(gridXX.^2 + gridYY.^2)/(2*myFsigSq) );


%  SECTION B -- PROCESS IMAGE DATA

% Registration - Area Selection and Point Identification
if(flagRegister)

BGreg = 0;  % Assumes CCD background is zero

imRegPAR = imread([myDirReg, myFileRegPAR]);
imRegPPD = imread([myDirReg, myFileRegPPD]);

imRegPAR = double ( imRegPAR - BGreg );
imRegPPD = double ( imRegPPD - BGreg );

imRegPAR = imRegPAR ./ max(imRegPAR(:));
imRegPPD = imRegPPD ./ max(imRegPPD(:));

cpselect(imRegPAR, imRegPPD);

stop % Program has run its course - copy and paste CPs below for record
% USER: Copy Control Points Below the END IF STATEMENT:
end

% Registration: List of Control Points:
%   06/09/2012:
% input_points = [34.6250000000000,15.1250000000000;177.875000000000,41.6250000000000;82.8750000000000,160.625000000000;196.875000000000,252.875000000000];
% base_points = [15.8750000000000,11.1250000000000;160.625000000000,38.8750000000000;63.8750000000000,158.125000000000;180.125000000000,252.125000000000];

% % Second attempt:
% base_points = [21.6250000000000,132.625000000000;163.875000000000,80.3750000000000;96.8750000000000,220.375000000000;223.125000000000,192.625000000000];
% input_points = [40.6250000000000,135.375000000000;180.625000000000,83.1250000000000;114.125000000000,221.875000000000;239.875000000000,193.875000000000];

% third: use for 10_09_Alexa646
% input_points = [38.3750000000000,70.6250000000000;132.375000000000,123.875000000000;230.125000000000,173.375000000000;121.875000000000,247.625000000000];
% base_points = [38.1250000000000,70.6250000000000;132.125000000000,123.625000000000;230.125000000000,173.625000000000;120.875000000000,248.375000000000];

% fourth: use for S_AS_ 1 to 5 fibrils
input_points = [79.6250000000000,64.1250000000000;161.875000000000,98.3750000000000;161.875000000000,176.125000000000;123.625000000000,213.875000000000];
base_points = [61.3750000000000,60.6250000000000;144.875000000000,95.3750000000000;143.875000000000,173.875000000000;106.375000000000,212.375000000000];

%   For Copy + Paste of new control points:
% input_points =
% base_points =
% 
% Registration - define transform
mytform = cp2tform(input_points, base_points, 'nonreflective similarity');

% % G-factor Calibration - area selection
% 
% BGgcal   = 0;
% 
imGcalPAR = imread([myDirGcal, myFileGcalPAR]);
imGcalPPD = imread([myDirGcal, myFileGcalPPD]);

imGcalPAR = imGcalPAR - imBgPar;
imGcalPPD = imGcalPPD - imBgPpd;
imGcalPAR(imGcalPAR<1) = 1;
imGcalPPD(imGcalPPD<1) = 1;

imGcalPAR = double(imGcalPAR);
imGcalPPD = double(imGcalPPD);

% G-factor Calibration - Registration

imGcalPARreg = imtransform(imGcalPAR, mytform, 'Xdata', [1 size(imGcalPPD,2)], 'Ydata', [1 size(imGcalPPD,1)] );

imGcalPARregFil = conv2(imGcalPARreg, myFilter, 'same');
imGcalPPDfil    = conv2(imGcalPPD, myFilter, 'same');

% G-factor Map
imGcalPARregFilCrop = imcrop(imGcalPARregFil, areaANIS);
imGcalPPDfilCrop    = imcrop(imGcalPPDfil, areaANIS);

G = imGcalPARregFilCrop ./ imGcalPPDfilCrop;

% Overwrite G, since there is no background estimation
% G = 1;

% Experimental Image Data
% Is the Data a Video?
% Mess about, identifying video data files, if necessary
% myImInfo = imfinfo([myDirData, myFileData],'tif');     % Extract file headers and info
% numberOfFrames = numel(myImInfo);   % Number of images in the tif

imageAnisotropy = []; % G isn't an image here.

numberOfFrames  =1;

for lpFrames = 1:numberOfFrames

% Single frame of image data:
% Data - area selection
% imDat = imread([myDirData, myFileData],'tif', lpFrames, 'Info',myImInfo);
% 
% imDatBG = imcrop(imDat, areaBG );
% BGdat   = mean( imDatBG(:) );     % Again, assumes flat background. 

imDatPAR = imread([myDirData, myFileDataPAR]);
imDatPPD = imread([myDirData, myFileDataPPD]);

% background subtraction?!
imDatPAR = imDatPAR - imBgPar;
imDatPPD = imDatPPD - imBgPpd;
imDatPAR(imDatPAR<1) =1; % Avoid divide by zeros
imDatPPD(imDatPPD<1) =1;

imDatPAR = double(imDatPAR);
imDatPPD = double(imDatPPD);

% Data - Registration
imDatPARreg = imtransform(imDatPAR, mytform, 'Xdata', [1 size(imDatPPD,2)], 'Ydata', [1 size(imDatPPD,1)] );

imDatPARregFil = conv2(imDatPARreg, myFilter, 'same');
imDatPPDfil    = conv2(imDatPPD, myFilter, 'same');

imDatPARregFilCrop = imcrop(imDatPARregFil, areaANIS);
imDatPPDfilCrop    = imcrop(imDatPPDfil, areaANIS);

% Data 
% USING "r" for imageAnisotropy
p = (imDatPARregFilCrop - G.*imDatPPDfilCrop) ./ (imDatPARregFilCrop + G.*imDatPPDfilCrop);

% imageAnisotropy(:,:,lpFrames) = r;
end % End of single frame processing


% SECTION C -- Visualisation

% Visualise "r" to get the (final, or only) processed frame
% Visualise the stack "imageAnisotropy" to study the video.

figure(1)
imagesc(flipud(p));
title('Polarisation (estimated)')

% colorbar;
caxis([-0.3 0.5])

figure(2)
imagesc(flipud(imDatPAR))
% colormap(gray)


% Tool to select average value in region
%  myr = floor(getrect());
%  myROI  = imcrop(flipud(p),myr);
% mean(myROI(:))