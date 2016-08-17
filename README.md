# Getting started


Here are basic instructions for using the iceTROPY GUI.

Contents: 
  1. Starting MATLAB (and system requirements)
  2. Starting the iceTROPY GUI
  3. Registering image data (parallel and perpendicular images)
  4. Providing g-factor calibration data 
  5. Processing images of a specimen (or tif stack video data)
  6. Batch processing multiple files
  7. Notes



1. Start MATLAB. 
(a) iceTROPY has been tested with version 2013a, 
    with the image processing toolkit.
    It also seems to work with Matlab version 2011b, 
    again, with the image processing toolkit.
    Version 1_6 tested OK with Matlab 2016a.

2. Run the function "iceTROPY.m" to start the GUI.
(a) Do not try to start the GUI by opening the figure "iceTROPY.fig"
    because that will not work.

3. REGISTRATION
(a) In the "input image registration" panel, browse to the 
    sample registration data. 
    \sampleData\
    Try loading the file:
    registration_and_gFactorCal_fluoresceinWater_setup1.fits
    Which is a 1004x1002 pixel image with rectangular regions of 
    parallel (upper half) and perpendicular (lower half) 
    polarisation-resolved fluorescence measurement.    

   (ii) SEGMENTATION
   Select "Camera_area_setup_1" in the dropdown menu. 
   This sets the rectangular regions of interest for the two 
   fluorescence channels. 
   For other camera setups, you may need to edit iceTROPY_defineROI

(b) Note that, in the file selection dialog box, the default 
    option is to open a "TIF" file, and the second option is to 
    look for "FITS" files. 
    You must change to select "FITS" to get the sample data.
    You may also look for other image formats using "all files"
    but this may not (or may) work. ("imread" will often 
    be able to open other data, but the numerical values in the 
    image may not make sense.)
   
(c) Click the "Register" button.

(d) Use the MATLAB "cpselect" interface to select corresponding points.
    Usually I select 4 pairs of points, at the corners of the 
    rectangular mask.

(e) Close the MATLAB selection tool using its "File" menu
    "File > Close control point selection tool"

(f) You may use the "save" and "load" for the image registration 

(g) For different camera setups to the one used with the sample data
    You may need to edit "iceTROPY_defineROI.m" 
    So that the camera data is sliced up into appropriate regions
    The GUI menu for "camera area setup 1" etc. allows extra 
    layouts to be programmed in - it is also useful if you 
    want to change the camera to used binned data. 
    For video data with 8x8 binning, and EJR's setup, 
    try using "camera area setup 2"


4. G-factor CALIBRATION

(a) In the "source of G-factor calibration" panel, browse to the 
    sample G-factor calibration data.

(b) This will normally be something like a fluorescent dye in water,
    with known anisotropy of zero.

5. PROCESS IMAGE DATA

(a) In the " Process image data panel", browse to the 
    sample data (e.g. for fluorescein in  glycerol)

(b) Note that you may update file names in the 
    second text box on this panel, if you want to (for example)
    keep changing a suffix to process many files.

(c) You may check the "flip input data vertically" if your 
    image acquisition setup requires you to do this.
    (Vertical flips sometimes happen when recording TIF stack data,
    or just because of an accidental camera setting, so this
    check box is provided in case it is needed.)

(d) Click the "Process" button. 

(e) You may select a filter using the popup menu. 

(f) If you check "Evaluate video data" the 
    sofware will assume it is processing a TIF stack, and will
    attempt to process multiple frames.

    Video data can display quite slowly (1 to 3 frames/second say)
    Hence only check "Show video results" if you're sure you want to 
    wait that long.


6. Batch processing

 (a) The "Batch" button on the iceTROPY GUI will make iceTROPY 
     analyse a number of files that are located in the same folder. 
 (b) The g-factor calibration file specified in the 
     "Source of g-factor calibration" panel will be used to 
     calibrate every data file processed.
 (c) The folder specified in the "Process image data" panel
     will be searched for files whose name matches the pattern 
     specified in the field next to the "Batch" button. 
     By default, this means searching for the string "*.fits" 
     which means all the FITS files in the folder.
     See MATLAB's docuentation on dir() for more ways to 
     use this name pattern input. 
 (d) The iceTROPY analysis will be run on each of the chosen 
     files. 
 (e) Assuming the video processing flags are not checked, this 
     means that a list of file names and some average anisotropy
     values will be displayed on the MATLAB console. 
 (f) You may want to edit the "Visualise outputs" of the 
     iceTROPY_process.m function to change the way data is 
     presented.
 (g) You might want to edit "iceTROPY_batch.m" to capture the data
     in a different way.


7. Notes
(a)  Most processing is done in iceTROPY_process.m 
     The quantitative meaning of different figures can be obtained 
     from this script. 
(b)  Figures 5 and 6 come from iceTROPY_analyse_region
