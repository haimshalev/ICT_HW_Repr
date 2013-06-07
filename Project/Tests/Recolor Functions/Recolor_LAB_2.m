function [ FixedPic_RGB ] = Recolor_LAB_2(OriginalPic_RGB)

cform = makecform('srgb2lab');
OriginalPic_LAB = applycform(OriginalPic_RGB, cform); 

L_channel = OriginalPic_LAB(:,:,1);
A_channel = OriginalPic_LAB(:,:,2);
B_channel = OriginalPic_LAB(:,:,3);

L_channelNew = L_channel;
A_channelNew = A_channel;
B_channelNew = 255-B_channel;

FixedPic_LAB = cat(3, L_channelNew, A_channelNew, B_channelNew);
cform2 = makecform('lab2srgb');
FixedPic_RGB = applycform(FixedPic_LAB,cform2); 

end