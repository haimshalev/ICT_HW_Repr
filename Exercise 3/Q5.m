%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q5(  )

img = imread('macbethUnderIllumX.jpg');

% gray world assumption + normalization 
GrayAssumpIllum = DetermineIlluminationUsingGrayWorldAssumption(img);
GrayAssumpIllum_Normalized = NormalizeIlluminants(GrayAssumpIllum);

% Linear model + normalization
LinIllum = DetermineIlluminationUsingLinearModel(img);
LinIllum = LinIllum(:,1);
LinIllum_Normalized = NormalizeIlluminants(LinIllum);

figure('Name','Linear model  VS  Gray World assumption');
hold all;
plot(GrayAssumpIllum_Normalized);
plot(LinIllum_Normalized);

end