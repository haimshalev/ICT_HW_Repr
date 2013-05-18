function [ RGBModifedImg ] = SimulatingAlgorithm( srcImg , xyzPoints , ConfusionPoint )
%% Prepere Picture

srcImg = double(srcImg);

%Retrive the size of the image for reshaping it
sizeImage = size(srcImg);

%Reshape the image for applaying transformation - Creates 3XSizeofPicutre
%matrix
reshapedImage = reshape(srcImg, [sizeImage(1)*sizeImage(2) sizeImage(3)])';

%% Load data 

load('xyz.mat');

%% Creating the transformation matrix

XYZtoRGB = [ 3.2405 -1.5372 -0.4985;
            -0.9693  1.8760  0.0416;
             0.0556 -0.2040  1.0573];

%% Transform the rgb image to XYZ

%Instead of - XYZImg = RGBtoXYZ*reshapedImage - we do:
XYZImg = XYZtoRGB\reshapedImage;
%It's much more faster and accurate according to matlab

%% Trasform the XYZ img to xyz

%calculating the syze of each testlight
n = length(XYZImg(1,:));

%Converting this values to xyz
sumXYZ = sum(XYZImg,1);

xyzImg = zeros(3,n);
for i=1:1:n
    xyzImg(:,i) = XYZImg(:,i)./sumXYZ(i);
end

%% Algorithm

%{
For each chromaticity point A(x,y) in chromaticity
space, the chromaticity point Ap (x’,y’) actually seen
by dichromats is found by intersecting the confusion
line passing A with the hue curve
%}

WhitePoint = [0.3116 ; 0.3110]';

%Lets use the spline to get the hue curve
%The curve will pass through the white point and the two same points that
%we got as parameters
CurveX = [ xyzPoints(1,1) WhitePoint(1) xyzPoints(1,2)];
CurveY = [ xyzPoints(2,1) WhitePoint(2) xyzPoints(2,2)];

%Initialize the xyzModifiedImg
xyzModifiedImg = zeros(size(xyzImg));

%for each pixel we will find the line between the chromacity value to the
%Confusion point
for i=1:1:n
    
    x = xyzImg(1,i);
    y = xyzImg(2,i);
    
    %finding the linear line parameters of the line from the selected xy to
    %the white point
    m = (ConfusionPoint(2) - y)/(ConfusionPoint(1) - x);
    c = y -m*x;
    
    %enlarge the line for it to intersect the curve line
    X = [0  1];
    Y = m*X + c;
        
    %Finding the intersection point
    [intersectionX,intersectionY] = polyxpoly(X,Y,CurveX,CurveY);
    
    %this intersection point is the new color
    xyzModifiedImg(1,i) = intersectionX;
    xyzModifiedImg(2,i) = intersectionY;
    xyzModifiedImg(3,i) = 1 - intersectionX - intersectionY;
       
end

%% Transform the x'y'z' to X'Y'Z'

XYZModifiedImg(1,:) = (XYZImg(2,:)./xyzModifiedImg(2,:)) .* xyzModifiedImg(1,:); 
XYZModifiedImg(2,:) =  XYZImg(2,:); 
XYZModifiedImg(3,:) = (XYZImg(2,:)./xyzModifiedImg(2,:)) .* xyzModifiedImg(3,:); 

%% Transform the X'Y'Z' to R'G'B'

RGBModifedImg = XYZtoRGB * XYZModifiedImg;
 
%% Restore the original Image

RGBModifedImg = reshape(RGBModifedImg',[sizeImage(1) sizeImage(2) sizeImage(3)]);
RGBModifedImg = uint8(RGBModifedImg);

end

