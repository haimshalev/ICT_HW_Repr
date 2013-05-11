%Zahi Kfir         200681476
%Haim Shalelasvili 200832780

function [ChromaticityDiagramFigure , myxyz] = Part1_Q1(  )
%Part1_Q1 : Plot the CIE-XYZ chromaticity diagram

%load the supplied variables
load ('xyz.mat');

%transpose the cmf (working with cmf's transpose dimensions as learned in class ,3x361)
xyz = xyz';

ChromaticityDiagramFigure = figure('name','Part1_Q1: CIE-XYZ chromaticity diagram');

%Calculating x and y
%Finding the CIE-XYZ values

%calculating the syze of each testlight
n = length(xyz(1,:));

%Converting this values to xyz
sumXYZ = sum(xyz,1);

myxyz = zeros(3,n);
for i=1:1:n
    myxyz(:,i) = xyz(:,i)./sumXYZ(i);
end

%Closing the polygon

myxyz(:,n) = myxyz(:,1);

%Plot a line which shows the horse curve
plot(myxyz(1,:),myxyz(2,:));


%Applying transformation to rgb (Matlab shows
%only rgb)

%xyz to rgb transformation matrix , as showen in class
toRgbMatrix = [0.49 0.31 0.20;
               0.17 0.81 0.01;
               0.00 0.01 0.99];
      
%Applying the transformation
rgb = myxyz'/toRgbMatrix;

%Reshaph the matrix to an image dimensions
rgb = reshape([rgb],[n 1 3]);

%Fill the line with the rgb colors
patch(myxyz(1,:),myxyz(2,:),rgb);

end

