
iceTROPY Development History

2014
Eric Rees


This is a set of MATLAB code for analysing fluorescence anisotropy image data.

For more information please refer to www.laser.ceb.cam.ac.uk 
Please reference or acknowledge this software if is is helpful.
Refer also to "readme_license.txt" for LGPL details and disclaimer. 






********************************

DEVELOPMENT HISTORY AND UPDATES:

Version 1-4
June 2014

 1. Added a script "iceTROPY_extras_analyse_region" which is now called by default
   It returns the average anisotropy of the brightest regions in a single image.
   The region selection is controlled by:
 
   flagSelectPolygon     = 0;
   flagSelectByThreshold = 1;

   And you can edit the automatic region selection by editing:

   % Setting for threshold selection:
   brighnessPercentThreshold = 40;
   radiusDilation  = 15;


Version 1-3
March 2014

 1. Added a "Save analysis framewise" option
    Which is for saving output of large tif stacks which 
    have pixel values corresponding to fluorescence anisotropy
    (E.g. for Localisation Microscopy data)
    NOTE the saved TIFs are truncated to anisotropy values on [0 1] 
         and scaled to 8-bit. 
         The result will need to be interpreted in light of this
         And 16-bit might be needed for some purposes.
         Refer to 'flagVidFramewise' in iceTROPY_process
    Output files are saved into "/vid/frame1.tif" etc. 
    which is a folder in the iceTROPY directory. 
    Edit "iceTROPY_process.m" if you want to write them elsewhere.




Version 1-2
March 2014

 1. Fixed a few misleading names on graph titles.
 2. Implemented "fitsread()" where needed in iceTROPY_process.m 
 3. Fixed some MATLAB programming style warnings
 4. Used "axis image" for better image result output
 5. Improved result font sizes a bit
 6. Added a third GUI menu option, so users can easily define new
    camera segmentations in "iceTROPY_defineROI.m"

 7.  Edited GUI so the "Data" (i.e. the specimen) files are not 
     loaded (and so over-written) by loading a setup.
 8.  Edited GUI so Browsing for data starts by trying the existing 
     data path. See "uigetfile()"
 9.  Browsing for g-factor data is likewise edited so the uigetfile
     looks at the same place first. 
 10. Change data filename font size to 11 points, for easier user-
     editing while skimming several files with similar names
     (typically I have "myFileName_X" where X=1,2,3...)

 11. Starting on Batch Process function for GUI...
     Added "Batch process" which is ONLY MEANT FOR SINGLE FRAME INPUT
     and NOT FOR TIF STACK (video) input.

 Still needed:
     Add a "process large tif stacks framewise" option
     to prevent excess memory being needed by large files
  


Version 1-1
24 February 2014

 1.  Created a first draft of the software tools.

     Added option to disable (slow) video display
     Added option for different camera area setup 

     Added sample data for stills and TIF stack video
     Added "Getting Started"


This is a development version of the software.
Once it is developed ( refer to www.laser.ceb.cam.ac.uk/ for news ), 
it may be distributed under the GNU LGPL, version 3+

