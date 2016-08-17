List of contents of this folder, and short description of functions



iceTROPY.m		The GUI. Run this to start the program.
iceTROPY.fig		A figure which defines the appearance of the GUI.
			(Opening this figure will not start the program
			so make sure to run iceTROPY.m instead.)

iceTROPY_segmentation.m	Splits the input image into regions containing
			Parallel, Perpendicular, and Background signal


iceTROPY_defineROI	Defines sub-areas for segmentation and analysis
                        Can be edited to make the 
                        software suitable for different camera setups

iceTROPY_registration.m	Allows user to register PAR and PPD images


iceTROPY_process.m      Evaluates anisotropy image from data
                        Can be set to process single frames, or video data
                        Produces some output graphs



Still to do:

iceTROPY_redEdge.m	Converts "red-Edge" + "main Band" anisotropy into 
			an estimate of homoFRET within a sample. 
			Be careful - this analysis is sensitive to noise and
			background, and the user must judge the reliability
			independently.  




