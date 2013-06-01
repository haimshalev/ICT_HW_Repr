%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q2(  )
%Q2 - Find basis for illuminants 

%Load all illuminants
load('CIEilluminants.mat');

%Create an array of illuminants
illum = [CIE_A CIE_B CIE_C CIE_D50 CIE_D55 CIE_D65 CIE_D75 ...
                CIE_FL2 CIE_FL7];

%Find the Basis functions
basisFunctions = FindBasisFunctions(illum);

%% A: Plot the first 4 basis functions

%The bases are in the cols of u ordered from largest Eigen value to lowest
basisFunctions = basisFunctions(:,1:4);

%Plot the basis functions
figure('Name','CIEilluminants basis functions');
plot(basisFunctions);
legend('Base illuminant1', 'Base illuminant2','Base illuminant3', 'Base illuminant4');

%% B: Print the mean squared error between the true illuminants and their 
      %approximation (sum MSE over all illuminants) using 1,2,3,4 basis functions

PrintMeanSquareError(basisFunctions,illum);

end

