%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [] = Q1()
%Q1 - Show color of same surface under 2 different illuminants

%load the macbeth surface
load('macbeth.mat');

%use Macbeth surface #8 - the eight column
surface8 = macbeth(:,8);

%load the Illuminants
load('CIEilluminants.mat');

%Create an illuminant vector which is passive - no illuminant
illuminant = ones(361,1);

%Show the patch under no illuminant
ShowPatchUnderIlluminant(surface8 , illuminant, 'No Illuminant');

%Show the patch under the CIE_D65 illuminant
ShowPatchUnderIlluminant(surface8 , CIE_D65, 'under the CIE_D65 illuminant');

%Show the patch under the CIE_B illuminant
ShowPatchUnderIlluminant(surface8 , CIE_B, 'under the CIE_B illuminant');

end

function [] = ShowPatchUnderIlluminant(surface , illuminant , figureName)
%ShowPatchUnderIlluminant takes a surface and illuminant and dispalyes a
%figure with the color of surface under the provided illuminant

%Output = Sensors * Illuimnant * Surface
color = illuminant .* surface;

%Convert the spd to rgb values

%Load the xyz matching functions
load('xyz.mat');

%Get the xyz values
xyzValues = xyz'*color;

%Load the XYZ 2 RGB matrix
load ('XYZ2RGB.mat');

%Convert the xyz values to rgb values
rgbValues = XYZ2RGB* xyzValues;

%we do not know illumination intensity, 
%so lets scale the resulting RGB values to be maximal in one of the channels
rgbValues = rgbValues ./ max(rgbValues(:));

%show a patch 
x = [0 1 1 0 0];
y = [0 0 1 1 0];
figure('Name',figureName);
fill(x,y,rgbValues');

end