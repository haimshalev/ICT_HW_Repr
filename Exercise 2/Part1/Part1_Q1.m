function [ ] = Part1_Q1(  )
%Part1_Q1 : Plot the CIE-XYZ chromaticity diagram

%load the supplied variables
load ('xyz.mat');

%Calculating x and y
myxyz = [];
myxyz(:,1) = xyz(:,1)./(xyz(:,1)+xyz(:,2)+xyz(:,3));
myxyz(:,2) = xyz(:,2)./(xyz(:,1)+xyz(:,2)+xyz(:,3));
myxyz(:,3) = xyz(:,3)./(xyz(:,1)+xyz(:,2)+xyz(:,3));

%Plot a line which shows the horse
figure;plot(myxyz(:,1),myxyz(:,2));

%calculating the syze of each primary
n = length(xyz(:,1));

%Reshape the xy Matrix for applying transformation to rgb (Matlab shows
%only rgb)
xyzMatrix = reshape([myxyz],[n 3]);

%xyz to rgb transformation matrix , as showen in class
toRgbMatrix = [0.49 0.31 0.20;
               0.17 0.81 0.01;
               0.00 0.01 0.99];
      
%Applying the transformation
rgb = xyzMatrix/toRgbMatrix;

%Reshaph the matrix to an image dimensions
rgb = reshape([rgb],[n 1 3]);

%Fill the line with the rgb colors
patch(myxyz(:,1),myxyz(:,2),rgb);

end

