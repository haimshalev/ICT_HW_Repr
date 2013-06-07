function [ FixedPic_RGB ] = Recolor_YIQ_1(OriginalPic_RGB)

OriginalPic_YIQ = rgb2ntsc(OriginalPic_RGB);

Y_Channel = OriginalPic_YIQ(:,:,1);
I_Channel = OriginalPic_YIQ(:,:,2);
Q_Channel = OriginalPic_YIQ(:,:,3);

New_Y = Y_Channel;
New_I = Q_Channel;
New_Q = I_Channel;

FixedPic_YIQ = cat(3, New_Y,New_I , New_Q);
FixedPic_RGB = ntsc2rgb(FixedPic_YIQ)*256;

end