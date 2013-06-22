Misc folder Readme File:

This readme file explains what each function in this folder those:

*******************************************************************************************************
1)AddMandatoryFolders:

function [] = AddMandatoryFolders()
	
	Add the necessery folders and subfolders to project searching paths.
	The function gets the necessery folders from the configuration file which available in this folder.
	To add more folders to the searching path of matlab in the future, just add the folder to the configuration file. 

*******************************************************************************************************
2)CheckColorIntersection:

function [ FoundSimilarity ] = CheckColorIntersection( Colors1 , Colors2 , EdgeSize )

	Check if there is no color in Colors1 that is close to color in Colors2.
	We say that a color in near to other color if the LAB distance between them is lower than the EdgeSize param.

	Input: Colors1 - A 3-dimensional matrix representing the RGB values of a group of colors
	       Colors2 - A 3-dimensional matrix representing the RGB values of another group of colors
	       EdgeSize - The allowe LAB distance between two tested colors
	Output: If there is a near color FoundSimilarity = true 
				    else FoundSimilarity = false


*******************************************************************************************************
3)CreateColorsVector:

function [colorsVector] = CreateColorsVector(image , MaxDif) 
	
	Create colors vector - consisting all colors in image with an LAB distance greater the the MaxDif
	
	Input:image- A 3-dimensional matrix representing the RGB values of an image
	      MaxDif- The allowed lab distance between two pixel in the ouput colors matrix
	Output: colorsVector - A 3-dimensional matrix representing the quantize list of the colors in the imput image(RGB)


