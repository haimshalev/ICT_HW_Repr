%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [illuminant] = DetermineIlluminationUsingLinearModel(img)
% Determine illumination of a scene using linear model of illuminants and returns it

% Using 3 basis functions found in Q2
%Load all illuminants
load('CIEilluminants.mat');

%Create an array of illuminants
illum = [CIE_A CIE_B CIE_C CIE_D50 CIE_D55 CIE_D65 CIE_D75 ...
                CIE_FL2 CIE_FL7];

%Find the Basis functions
basisFunctions = FindBasisFunctions(illum);

%The bases are in the cols of u ordered from largest Eigen value to lowest
basisFunctions = basisFunctions(:,1:3);

% Assume sensors are given in kodakFilters.mat
load('KodakFilters.mat');

% Load our Surface 
load('macbeth.mat');

%We using only one surface and its corrspoind pixel color
s = macbeth(:,1);

% Create an rgb vector 

r = reshape(img,size(img,1)*size(img,2),3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating the illumintation

%Calculating the lambada_s
Ls = kodakFilters' * diag(s) * basisFunctions;

%Calculating w : w = (Ls^-1)r
w = double(Ls)\double(r');

%Calculating illuminant
illuminant = basisFunctions * w;
end