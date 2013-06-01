%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ approximationsMatrix ] = PrintMeanSquareError( basisFunctions, SpdMatrix )
%PRINTMEANSQUAREERROR -  Print the mean squared error between the true illuminants and their 
%approximation (sum MSE over all illuminants) using 1,2,3,4 basis functions

%This function also returns the approximations matrix which is a container
%for all aproximations- First dimension is the number of basis functions
                     %- Second dimension is the number of colors
                     %- Third dimension is the coorosponding spd

%Initialize the approximatioins matrix
approximationsMatrix = zeros(size(basisFunctions,2)...
                             ,size(SpdMatrix,2) , size(SpdMatrix,1));

%In each loop change the number of basis functions
for i=1:size(basisFunctions,2);
    
    %Initialize an MSE counter
    sumMSE = 0;
    
    %Getting the current Basis functions
    base = basisFunctions(:, 1:i);
    
    %Iterate over all the illuminants
    for j=1:size(SpdMatrix,2)
        
        %Calculate the weigth of each basis function : e = Be*w
        w = linsolve(base,SpdMatrix(:, j));
        
        %Create the approximation spd
        approximation = base * w;
        
        %Store the approximation in the approximations matrix
        approximationsMatrix(i,j,:) = approximation;
        
        %Add the MSE to the MSE counter
        sumMSE = sumMSE + sum((SpdMatrix(:, j) - approximation).^2);
    end
    
    %Print the sum MSE over all illuminants
    fprintf('Sum MSE over all illiminants using %d basis functions is %f \n',i,sumMSE);
end

end

