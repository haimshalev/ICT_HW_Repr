function [ FixedPic_RGB ] = Recolor_YIQ_With_Histogram(OriginalPic_RGB)

OriginalPic_YIQ = rgb2ntsc(OriginalPic_RGB);

Y_Channel = OriginalPic_YIQ(:,:,1);
I_Channel = OriginalPic_YIQ(:,:,2);
Q_Channel = OriginalPic_YIQ(:,:,3);

New_Y = Y_Channel;
New_I = 0 - I_Channel;
New_Q = Q_Channel;


%% My new algorithm

%Quantize size
QuantizeSize = 128;

%Setting Color Boundreries
UpperValue = 1; LowerValue = -1; 
NumOfColors = UpperValue-LowerValue;

%Get the size of the original picture
s = size(I_Channel);

%Reshape the i Channel to be  vetor 
I_Channel = reshape(I_Channel,s(1)*s(2) , 1);

%Create an histogram of 128 bins
[h,centers] = hist(I_Channel,QuantizeSize);

%Get the bin size - bins are of equal size
binSize = centers(2)-centers(1);

%Create a distribution vector - each cell holds the precentege of
%quantized values
d = h/(s(1)*s(2));

%Calculating how many different colors each bin needs
c = floor(QuantizeSize*d);

%Creating inner binns centers vector
InnerBinnsCenters = zeros(size(QuantizeSize));
current = 1;

for i = 1: QuantizeSize
    
    %if we need to create inner cells
    if (c(i) ~= 0 )
        
        startBin = centers(i) - binSize/2;
        innerBinSize = binSize/c(i);
        
        %for every cell
        for j = 1:c(i)
            InnerBinnsCenters(current)  = startBin + j*innerBinSize - innerBinSize/2;
            current = current + 1;
        end
    end
    
end

%Initialize the new I_Channel vector
New_Q = zeros(size(I_Channel));

for i = 1:size(I_Channel,1)
    
    %Taking every I value and selecting is bin
    [~,bin]=histc(I_Channel(i),InnerBinnsCenters);
    
    %Save the new color
    New_Q(i) = LowerValue + (NumOfColors/QuantizeSize)*bin;
    
end

%Reshape the vectored I_Channel to matrix
New_Q = reshape(New_Q,s(1),s(2));

%Enance Contrast
New_I = 0 - New_Q;

%% Return to the Recolor section

FixedPic_YIQ = cat(3, New_Y,New_I , New_Q);
FixedPic_RGB = ntsc2rgb(FixedPic_YIQ)*256;
end