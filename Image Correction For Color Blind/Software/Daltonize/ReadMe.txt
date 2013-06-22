Daltonize Algorithm Readme File:

This readme file explains what each function in this folder those:

*******************************************************************************************************
1)ColorBlindFix:

function [ Ifinal , fileinfo , folderInfo ] = ColorBlindFix( ColorBlindType, OriginalPic_RGB )

    A generic function which gets a color blind type and an image.  
    Finds the optimal transformation matrix.
    Returns a daltonize image and debug information about the result:
        ModificationConst,EdgeSize,Iterations...

    Input: ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
	   OriginalPic_RGB - A 3-dimensional matrix representing the RGB values of the original image
    Output: Ifinal - A 3-dimensional matrix representing the RGB values of the daltonized image
            fileInfo - string which contains the info about the result (Only for debug)
            folderInfo - string which contains the info about the result (Only for debug)

*******************************************************************************************************
2)Daltonize:

function [ FixedPic_RGB ] = Daltonize( OriginalPic_RGB ,ErrorPic , err2mod)

   Make a linear transformation on the error matrix so that it can be conveyed
   and add this on the original picture to find the daltonized image

   Input: OriginalPic_RGB - A 3-dimensional matrix representing the RGB values of the original image
          ErrorPic - A 3-dimensional matrix representing the RGB values of the error image (simulated image substructed from the original image)
          err2mod - The selected transformation matrix which found in ColorBlindFix function.
   Output:FixedPic_RGB - A 3-dimensional matrix representing the RGB values of the daltonized image

*******************************************************************************************************
3)AdjustDaltonizationMatrix:

function [ New_M ] = AdjustDaltonizationMatrix( ColorBlindType ,M , ModificationConst )

    Adjust the error transformation matrix accordingly to the
    dichromat type

    Input: ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
           M - The current transformation matrix
           ModificationConst - scalar which represent the amount of modifcation to M in each channel
    Output:New_M - the updated transformation matrix after modification

*******************************************************************************************************
4)GetDaltonizationMatrix:

function [ M ] = GetDaltonizationMatrix( ColorBlindType )

    Get the initial error transformation matrix accordingly to the dichromat type

    Input: ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
    Output: M - The initial transformation matrix for the specified type of dichromat(As shown in the project documentation)
