function [ RGBModifiedImg ] = protanopes( srcImg )
%% Summary

%{
    This function simulate what protanopes color blind people see
	This function sets the xyz points which normal observers and protanopes see
	the same and then calls the Simulating algorithm 

	Input: srcImg - A 3-dimensional matrix representing the RGB values of the original image
	Output: RGBModifiedImg - A 3-dimensional matrix representing the RGB values of the simulated image
%}
%% Get the points that looks the same

load('xyz.mat');

%Normal observers and both protanopes and deuteranopes see 
%the same blue at 470 nm and the same yellow at 575 nm
SamePoints(:,1) =  xyz(101,:)'; %470nm
SamePoints(:,2) = xyz(206,:)'; %575nm

%Transform this XYZ points, to xyz points

%Converting this values to xyz
sumPoints = sum(SamePoints,1);

xyzPoints = zeros(3,2);
for i=1:1:2
    xyzPoints(:,i) = SamePoints(:,i)./sumPoints(i);
end

%% Create Confusion Point for protanopes
ConfusionPoint = [0.747 0.253]';

%% Run the simulating algorithm with this custom matrices
RGBModifiedImg = SimulatingAlgorithm(srcImg,xyzPoints,ConfusionPoint);

end
