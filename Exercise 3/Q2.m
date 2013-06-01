%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q2(  )
%Q2 - Find basis for illuminants 

%Load all illuminants
load('CIEilluminants.mat');

%Create an array of illuminants
illum = [CIE_A CIE_B CIE_C CIE_D50 CIE_D55 CIE_D65 CIE_D75 ...
                CIE_FL2 CIE_FL7];

%Calculate the covariance matrix of illum without substructing the mean
Cp = illum * illum';

%Find the bases using svd on Cp
[u , ~ , ~ ] = svd(Cp);

%% A: Plot the first 4 basis functions

%The bases are in the cols of u ordered from largest Eigen value to lowest
basisFunctions = u(:,1:4);

%Plot the basis functions
figure;
plot(basisFunctions);
legend('Base illuminant1', 'Base illuminant2','Base illuminant3', 'Base illuminant4');

%% B: Print the mean squared error between the true illuminants and their 
      %approximation (sum MSE over all illuminants) using 1,2,3,4 basis functions

%In each loop change the number of basis functions
for i=1:4
    
    %Initialize an MSE counter
    sumMSE = 0;
    
    %Getting the current Basis functions
    base = basisFunctions(:, 1:i);
    
    %Iterate over all the illuminants
    for j=1:size(illum,2)
        
        %Calculate the weigth of each basis function : e = Be*w
        w = linsolve(base,illum(:, j));
        
        %Create the approximation spd
        approximation = base * w;
        
        %Add the MSE to the MSE counter
        sumMSE = sumMSE + sum((illum(:, j) - approximation).^2);
    end
    
    %Print the sum MSE over all illuminants
    fprintf('Sum MSE over all illiminants using %d basis functions is %f \n',i,sumMSE);
end

end

