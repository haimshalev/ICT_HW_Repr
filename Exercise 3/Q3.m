%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q3(  )
%Q3 -Find basis for Macbeth Surfaces

%Load Macabeth surfaces
load('macbeth.mat');

%Find the Basis functions
basisFunctions = FindBasisFunctions(macbeth);

%% A: Plot the first 4 basis functions

%The bases are in the cols of u ordered from largest Eigen value to lowest
basisFunctions = basisFunctions(:,1:4);

%Plot the basis functions
figure('Name','Macbeth surface basis functions');
plot(basisFunctions);
legend('Base illuminant1', 'Base illuminant2','Base illuminant3', 'Base illuminant4');

%% B: Print the mean squared error between the true illuminants and their 
      %approximation (sum MSE over all illuminants) using 1,2,3,4 basis functions

Approximations = PrintMeanSquareError(basisFunctions,macbeth);

%% C: Display image of macbeth surface colors for approximations

%In each loop change the number of basis functions
for i = 1:size(basisFunctions,2)
    
    %Get the current aproximations
    CurrentAproxs = Approximations(i,:,:);
    CurrentAproxs = reshape(CurrentAproxs,size(CurrentAproxs,2),size(CurrentAproxs,3));
    
    %Convert the spr to rgb values
    rgbValues = GetRGBValues(CurrentAproxs');
    
    %Display the macbeth surface
    figure('Name',['Macbeth surface using ', num2str(i),' basis']);
    display_colors(rgbValues); 
    
end

%% D: Plot the full spectra Macbeth image
   
%Convert the spd to rgb values
rgbValues = GetRGBValues(macbeth);

%Display the macbeth surface
figure('Name','Full Spectra Macbeth Image');
display_colors(rgbValues); 

end

