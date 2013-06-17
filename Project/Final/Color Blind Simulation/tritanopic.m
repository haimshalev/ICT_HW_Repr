function [RGBModifiedImg,ProjectionDistanceMatrix] = tritanopic( srcImg )

%% Get the points that looks the same.

load('cones.mat');

%Observations  suggest that a blue-green at 485 nm and a red
% at 660 nm have the same hue for the normal and tritanopic eyes

XYZtoRGB = [ 3.2405 -1.5372 -0.4985;
            -0.9693  1.8760  0.0416;
             0.0556 -0.2040  1.0573];
XYZtoLMS = [ 0.8951  0.2664 -0.1614;
            -0.7502  1.7135  0.0367;
             0.0389 -0.0685  1.0296];
 
%Calculating the points from cones cmf
%SamePoints(:,1) = cones(116,:)'; %485nm
%SamePoints(:,2) = cones(291,:)'; %660nm

SamePoints(:,1) = XYZtoLMS*(XYZtoRGB\([0 229 255]'));%485nm
SamePoints(:,2) = XYZtoLMS*(XYZtoRGB\([255 0 0]'));%660nm

%% Run the simulating algorithm with this custom matrices
[RGBModifiedImg,ProjectionDistanceMatrix] = SimulatingAlgorithm(srcImg,SamePoints,'tritanopic');

end