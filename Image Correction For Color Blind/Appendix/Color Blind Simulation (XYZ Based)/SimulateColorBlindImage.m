function [ SimulatedImage ] = SimulateColorBlindImage( ColorBlindType , RGBImage )
%% Summary

%{
    A generic function which gets a color blind type and an image
    Simulate what the color blind person will see

    Types Included:
        ColorBlindType = 1  for protanopes
        ColorBlindType = 2  for deuteranopes
        ColorBlindType = 3  for tritanopic
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

