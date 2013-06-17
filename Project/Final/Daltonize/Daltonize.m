function [ FixedPic_RGB ] = Daltonize( OriginalPic_RGB ,ErrorPic , err2mod)

sizeRGB = size(OriginalPic_RGB);

ERR = zeros(sizeRGB);
for i = 1:sizeRGB(1)
    for j = 1:sizeRGB(2)
        err = ErrorPic(i,j,:);
        err = err(:);

        ERR(i,j,:) = err2mod * err;
    end
end

%Return the new improved recolored image
FixedPic_RGB = uint8(OriginalPic_RGB + ERR);

end

