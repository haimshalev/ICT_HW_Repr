%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ u ] = FindBasisFunctions( SpdMatrix )
%FINDBASISFUNCTIONS - gets as an input an spd matrix and returns an orderd
%list of basis functions best representing the SpdMatrix

%Calculate the covariance matrix of illum without substructing the mean
Cp = SpdMatrix * SpdMatrix';

%Find the bases using svd on Cp
[u , ~ , ~ ] = svd(Cp);

end

