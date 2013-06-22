function [ ] = DichromatsSimulation( importedImg )
%% Summary

%{
A function which simulate what each class of dichromats see.
	It will :
    		1)run the simulating algorithm for each dichrmat type (3 types)
    		2)show the results
	
	Input: importedImg - A 3-dimensional matrix representing the RGB values of the original image
%}


%% Run the simulating algorithms

ProtanopesImg = protanopes(importedImg);
DeuteranopesImg = deuteranopes(importedImg);
TritanopicImg = tritanopic(importedImg);


%% Show all images
figure;
subplot(2,2,1), imshow(importedImg) ,title('Real one');
subplot(2,2,2), imshow(ProtanopesImg)  ,title('Protanopes Image');
subplot(2,2,3), imshow(DeuteranopesImg)  ,title('Deuteranopes Image');
subplot(2,2,4), imshow(TritanopicImg)  ,title('Tritanopic Image');
end