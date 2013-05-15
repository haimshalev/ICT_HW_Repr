function [ ] = Part2_Q4(  )
%Part2_Q4 : 

% loading Thinking Girl
ThinkingGirl_RGB = imread('Thinking.jpg');
figure('name','Part2_Q4: Thinking Girl:');
imshow(ThinkingGirl_RGB);

ThinkingGirl_YIQ = rgb2ntsc(ThinkingGirl_RGB);

% dont know what "use a 2x2x1 filter" means
% used ref from:
% http://stackoverflow.com/questions/2773606/gaussian-filter-in-matlab
%# Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[100 100],10);

figure('name','Part2_Q4: Thinking Girl blur Y:');
ThinkingGirl_BlurY = ThinkingGirl_YIQ;
ThinkingGirl_BlurY(:, :, 1) = imfilter(ThinkingGirl_YIQ(:, :, 1),G,'same');
imshow(ntsc2rgb(ThinkingGirl_BlurY));

figure('name','Part2_Q4: Thinking Girl blur I:');
ThinkingGirl_BlurI = ThinkingGirl_YIQ;
ThinkingGirl_BlurI(:, :, 2) = imfilter(ThinkingGirl_YIQ(:, :, 2),G,'same');
imshow(ntsc2rgb(ThinkingGirl_BlurI));

figure('name','Part2_Q4: Thinking Girl blur Q:');
ThinkingGirl_BlurQ = ThinkingGirl_YIQ;
ThinkingGirl_BlurQ(:, :, 3) = imfilter(ThinkingGirl_YIQ(:, :, 3),G,'same');
imshow(ntsc2rgb(ThinkingGirl_BlurQ));



