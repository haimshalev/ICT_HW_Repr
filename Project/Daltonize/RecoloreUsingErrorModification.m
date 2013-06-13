function [ FixedPic_RGB ] = RecoloreUsingProjectionDistance( OriginalPic_RGB)

RGB = double(OriginalPic_RGB);
sizeRGB = size(RGB) ;

%Simulate the image shown by dichromats
DichPic = protanopes(RGB);

%calculate errors between two RGB values
errorp = RGB - double(DichPic);

%daltonize for p (modifying errors)
err2mod = [0 0 0; .7 1 0; .7 0 1];

ERR = zeros(sizeRGB);
for i = 1:sizeRGB(1)
    for j = 1:sizeRGB(2)
        err = errorp(i,j,:);
        err = err(:);

        ERR(i,j,:) = err2mod * err;
    end
end

%Return the new improved recolored image
FixedPic_RGB = uint8(RGB + ERR);

end

