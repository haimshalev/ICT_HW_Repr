function [ Hight_RG_Contrast_RGB ] = Increase_RG_Contrast_1(OriginalPic_RGB,IncreaseConst)
    
    OriginalPic_YIQ = rgb2ntsc(OriginalPic_RGB);    %# convert the picture to YIQ   
    Hight_RG_Contrast_YIQ = OriginalPic_YIQ;        %# HightContrast picture = original picture  
    OriginalPic_Q = OriginalPic_YIQ(:,:,3);         %# get the red green plane    
    New_Q = (OriginalPic_Q)*(IncreaseConst);        %# increase the Q (RedGreen) contrast by IncreaseConst input

    %# normalize New_I between -1 and 1
    mmin = min(New_Q(:));
    mmax = max(New_Q(:));
    Normalized_New_Q = (New_Q-mmin);                    %# first subtract mmin to have      [0 - (mmax-mmin)]
    Normalized_New_Q = Normalized_New_Q ./ (mmax-mmin); %# then normalize by highest value  [0 - 1]
    Normalized_New_Q = Normalized_New_Q .* 2;           %# then normalize by 2              [0 - 2]
    Normalized_New_Q = Normalized_New_Q - 1;            %# the normalize to -1              [(-1) - 1 ]
   
    Hight_RG_Contrast_YIQ(:,:,3) = Normalized_New_Q;                %# update the new Q plane 
    Hight_RG_Contrast_RGB = ntsc2rgb(Hight_RG_Contrast_YIQ)*255;    %# convert the picture to RGB
end