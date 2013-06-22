function [ SimulatedImage ] = SimulateColorBlindImage( ColorBlindType , RGBImage )
%% Summary

%{
    A generic function which gets a color blind type and an image
    It simulates what the color blind person will see

    Input: ColorBlindType - 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
	   RGBImage - A 3-dimensional matrix representing the RGB values of the original image
    Output: SimulatedImage - A 3-dimensional matrix representing the RGB values of the simulated image
%}

    if ColorBlindType == 1      
        SimulatedImage = protanopes(RGBImage);
    elseif ColorBlindType == 2   
        SimulatedImage = deuteranopes(RGBImage); 
    elseif ColorBlindType == 3   
        SimulatedImage = tritanopic(RGBImage);
    else
        SimulatedImage = 0;
    end
end

