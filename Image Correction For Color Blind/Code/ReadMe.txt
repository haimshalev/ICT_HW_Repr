"Color Correction For Color Blind" Project Readme:

****************************************************************************************
Project features:

1)Analyze how color blind people perceive colors in the world, and to make a simulation so that people with normal vision can understand what they see. 
2)Make certain modifications to digital pictures to make life easier for the color blind people who use them.

This software will simulate what color blind people will see in an RGB image and correct (Daltonize) the picture so that they see better.

****************************************************************************************
Project structure:

This code is divided into couple of folders:
1.	Color Blind simulation - implements the "LMS Based Simulation algorithm" which described in the project documentation file.
2.	Daltonize - implements the chosen "Daltonize" algorithm which described in the project documentation file.
3.	Misc - A service functions which supports the previous algorithms.
4.	The Main Folder - Holds the graphical user interface for this project and a demo script.
5. 	Appendix - Holds the implementatio to the "xyz Based Simulation algorithm" which described in the project documentation file.

For documentation and function guides for folders 1 , 2 ,3 and 5, please see the "Chosen Algorithms" and "Appendix" sections in the documentation file
and the readme file in each code folder.

The xyz simulation algorithm in not included in the project automatically. To use it please see the "Appendix" section in the documentation file.

! THE PROJECT WAS BUILT AND TESTED ONLY ON THE "MATLAB R2013A" IDE

****************************************************************************************
Main folder guide ( The graphical user interface and the demo scripts):

1)	Graphical user interface :

To run the graphical user interface please enter in the command window the command: "ColorCorrectionForColorBlind".
A graphical user interface should appear and the required folders will be added automatically to the matlab included folders path.
To get more information about the graphical user interface please check the "Graphical user interface - User Guide" section in the documentation file.

2)	Demo script:

To run the main demo script, enter in the command window the command "ColorCorrectionDemo".
This script first will add the required folders to the matlab included folders path.
Then it will load 3 images from the Data folder: "Rainbow Fishes.bmp","Gaugin.bmp" and "Flowers.bmp".
For each image it will plot:
i.	Color blind simulation image for Protanopes , Deuteranopes and Tritanopic.
ii.	Daltonize image for Protanopes , Deuteranopes and Tritanopic.
iii.	Daltonized simulate image for Protanopes , Deuteranopes and Tritanopic. 

****************************************************************************************
Using the main functions manually:

First step is to manually add the algorithm folders to the included path of matlab - You can do it by selecting the folders in the "current folder" window in matlab, right click on them and select the option: "Add to Path" -> "Selected folders and subfolders".
Then you can call:
1) [ SimulatedImage ] = SimulateColorBlindImage( ColorBlindType , RGBImage )
    A generic function which gets a color blind type and an image
    It simulates what the color blind person sees
•	Input:
	o	ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
	o	RGBImage - A 3-dimensional matrix representing the RGB values of the                                                          original image
•	Output: 
	o	SimulatedImage - A 3-dimensional matrix representing the RGB values  of the   simulated image

2)  [ Ifinal , ~ , ~ ] = ColorBlindFix( ColorBlindType, OriginalPic_RGB )
    A generic function which gets a color blind type and an image.  
    Returns a daltonize image for the specific color blind person.

•	Input: 
	o	ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
	o	OriginalPic_RGB - A 3-dimensional matrix representing the RGB values of the original image
•	 Output:
	o	 Ifinal - A 3-dimensional matrix representing the RGB values of the daltonized image.
	o	fileInfo - string which contains the info about the result (Only for debug
	o	folderInfo - string which contains the info about the result (Only for debug)
    
! A normal user should only use the first output parameter, ignoring the other output parameters
