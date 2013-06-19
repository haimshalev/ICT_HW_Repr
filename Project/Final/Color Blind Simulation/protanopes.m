function [ RGBModifiedImg ] = protanopes( srcImg )
%% Summary

%{
    This function simulate what protanopes color blind people see

    This function get the LMS points which normal observers and protanopes see
    the same and then calls the Simulating algorithm 
%}

disp('--- Simulate what protanopes color blind people see'); 

%% Get the points that looks the same

% Normal observers and both protanopes and deuteranopes see 
%the same blue at 475 nm and the same yellow at 575 nm

XYZtoRGB = [ 3.2405 -1.5372 -0.4985;
            -0.9693  1.8760  0.0416;
             0.0556 -0.2040  1.0573];
XYZtoLMS = [ 0.8951  0.2664 -0.1614;
            -0.7502  1.7135  0.0367;
             0.0389 -0.0685  1.0296];
 
%Getting the LMS stimuli values from an rgb values
SamePoints(:,1) =XYZtoLMS*(XYZtoRGB\([0 178 255]')); %475nm
SamePoints(:,2) =XYZtoLMS*(XYZtoRGB\([236 255 0]'));%575nm

%% Run the simulating algorithm with this custom matrices
[RGBModifiedImg] = SimulatingAlgorithm(srcImg,SamePoints,'protanopes');

end