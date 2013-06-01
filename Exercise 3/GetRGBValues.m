function [ rgbValues ] = GetRGBValues( SpdMatrix )
%GETRGBVALUES - return a normalized rgb values for the input spd matrix

%Load the xyz matching functions
load('xyz.mat');

%Get the xyz values
xyzValues = xyz'*SpdMatrix;

%Load the XYZ 2 RGB matrix
load ('XYZ2RGB.mat');

%Convert the xyz values to rgb values
rgbValues = XYZ2RGB* xyzValues;

%we do not know illumination intensity, 
%so lets scale the resulting RGB values to be maximal in one of the channels
if (min(rgbValues(:)) < 0)
    rgbValues = rgbValues - min(rgbValues(:));
end
rgbValues = rgbValues ./ max(rgbValues(:));

end

