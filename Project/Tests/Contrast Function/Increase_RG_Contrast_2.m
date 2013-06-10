function [ Hight_RG_Contrast_RGB ] = Increase_RG_Contrast_1(OriginalPic_RGB,IncreaseConst)
    
    OriginalPic_YIQ = rgb2ntsc(OriginalPic_RGB);                    %# convert the picture to YIQ  
    Hight_RG_Contrast_YIQ = OriginalPic_YIQ;                        %# HightContrast picture = original picture
    OriginalPic_Q = OriginalPic_YIQ(:,:,3);                         %# get the red green plane   
    New_Q = (OriginalPic_Q)*(IncreaseConst);                        %# increase the I (RedGreen) contrast by IncreaseConst input   
    Hight_RG_Contrast_YIQ(:,:,3) = New_Q;                           %# update the new Q plane
    Hight_RG_Contrast_RGB = ntsc2rgb(Hight_RG_Contrast_YIQ)*255;    %# convert the picture to RGB

end