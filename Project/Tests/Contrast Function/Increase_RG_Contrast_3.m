function [ Hight_RG_Contrast_RGB ] = Increase_RG_Contrast_3(OriginalPic_RGB,IncreaseConst)
    
    OriginalPic_YIQ = rgb2ntsc(OriginalPic_RGB);    %# convert the picture to YIQ   
    Hight_RG_Contrast_YIQ = OriginalPic_YIQ;        %# HightContrast picture = original picture  
    OriginalPic_Q = OriginalPic_YIQ(:,:,3);         %# get the red green plane    
    New_Q = (OriginalPic_Q)*(IncreaseConst);        %# increase the Q (RedGreen) contrast by IncreaseConst input

    %# normalize New_I between -1 and 1 only if needed!
    Normalized_New_Q = New_Q;
    mmin = min(Normalized_New_Q(:));    
    if mmin < (-1)
        Normalized_New_Q = Normalized_New_Q ./ (-mmin);
    end
    mmax = max(Normalized_New_Q(:));
    if mmax > (1)
        Normalized_New_Q = Normalized_New_Q ./ (mmax);
    end

    Hight_RG_Contrast_YIQ(:,:,3) = Normalized_New_Q;                %# update the new Q plane 
    Hight_RG_Contrast_RGB = ntsc2rgb(Hight_RG_Contrast_YIQ)*255;    %# convert the picture to RGB
end