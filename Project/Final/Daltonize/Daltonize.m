function [ FixedPic_RGB ] = Daltonize( OriginalPic_RGB ,ErrorPic , err2mod)
%% Summary

%{
   Make a linear transformation on this error matrix so that it can be conveyed
   and add this on the original picture to find the daltonized image
%}

%% Daltonize

%Preper the Vectors
reshapedError = reshape(ErrorPic,[size(ErrorPic,1)*size(ErrorPic,2) 3]);

%Calculate how musch we should add to each color
ERR = err2mod * reshapedError';

%Reshaped the ERR matrix to 3 dimensional
ERR = reshape(ERR',[size(ErrorPic,1) size(ErrorPic,2) 3]);

%Return the new improved recolored image
FixedPic_RGB = uint8(OriginalPic_RGB + ERR);

end

