%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ illuminant ] = DetermineIlluminationUsingGrayWorldAssumption( img )

% Load all illuminants
load('CIEilluminants.mat');

%Create an array of illuminants
illum = [CIE_A CIE_B CIE_C CIE_D50 CIE_D55 CIE_D65 CIE_D75 ...
                CIE_FL2 CIE_FL7];

% Find the Basis functions
basisFunctions = FindBasisFunctions(illum);
basisFunctions = basisFunctions(:,1:3);

% mean RGB
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
meanR = mean(R(:));
meanG = mean(G(:));
meanB = mean(B(:));
r = [ meanR , meanG , meanB ];

% gray surface
s = ones(361,1)-0.1; 

% Assume sensors are given in kodakFilters.mat
load('KodakFilters.mat');

% Calculating the lambada_s
Ls = kodakFilters' * diag(s) * basisFunctions;

% Calculating w : w = (Ls^-1)r
w = double(Ls)\double(r');

% Calculating illuminant + normalization
illuminant = basisFunctions * w;

end