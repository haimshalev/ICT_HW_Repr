Color blind simulation algorithm Readme File:

Our code implements the "LMS based Simulation" algorithm described in the project documentation file.
This readme file explains what each function in this folder do:

*******************************************************************************************************
1)DichromatsSimulation:

function [ ] = DichromatsSimulation( importedImg )

	A function which simulate what each class of dichromats see.
	It will :
    		1)run the simulating algorithm for each dichrmat type (3 types)
    		2)show the results
	
	Input: importedImg - A 3-dimensional matrix representing the RGB values of the original image

*******************************************************************************************************
2)SimulateColorBlindImage:

function [ SimulatedImage ] = SimulateColorBlindImage( ColorBlindType , RGBImage )

	A generic function which gets a color blind type and an image
	It simulates what the color blind person will see
	
	Input: ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
	       RGBImage - A 3-dimensional matrix representing the RGB values of the original image
	Output: SimulatedImage - A 3-dimensional matrix representing the RGB values of the simulated image

*******************************************************************************************************
3)protanopes:

function [ RGBModifiedImg ] = protanopes( srcImg )

	This function simulate what protanopes color blind people see
	This function sets the LMS points which normal observers and protanopes see
	the same and then calls the Simulating algorithm 

	Input: srcImg - A 3-dimensional matrix representing the RGB values of the original image
	Output: RGBModifiedImg - A 3-dimensional matrix representing the RGB values of the simulated image 

*******************************************************************************************************
4)deuteranopes:

function [ RGBModifiedImg ] = deuteranopes( srcImg )

	This function simulate what deuteranopes color blind people see
	This function sets the LMS points which normal observers and deuteranopes see
	the same and then calls the Simulating algorithm 

	Input: srcImg - A 3-dimensional matrix representing the RGB values of the original image
	Output: RGBModifiedImg - A 3-dimensional matrix representing the RGB values of the simulated image 

*******************************************************************************************************
5)tritanopic:

function [ RGBModifiedImg ] = tritanopic( srcImg )

	This function simulate what tritanopic color blind people see
	This function sets the LMS points which normal observers and tritanopic see
	the same and then calls the Simulating algorithm 

	Input: srcImg - A 3-dimensional matrix representing the RGB values of the original image
	Output: RGBModifiedImg - A 3-dimensional matrix representing the RGB values of the simulated image 

*******************************************************************************************************
6)SimulatingAlgorithm:

function [ RGBModifedImg ] = SimulatingAlgorithm( srcImg , samePoints, type)

	A generic function which gets a color blind type,image and similar stimuli vectors 
	and return a simulated picture of what the color blind person will see using simulation algorithm on the LMS color space
	! This function should not called by the user - It should only run from the [3,4,5] functions listed above.

	Input: srcImg- A 3-dimensional matrix representing the RGB values of the original image
	       samePoints- LMS stimuli which normal observers and the color blind observer see the same  
	       type- 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
	Output: RGBModifedImg - A 3-dimensional matrix representing the RGB values of the simulated image