%% Summary

%{
This Script will simulate what each class of dichromats see.
It will :
    1)load a testing picture
    2)run the simulating algorithm for each dichrmat type (3 types)
    3)show the results
%}

%% Prepere Picture

%Load the flowers Image
importedImg = imread('stand.png');

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