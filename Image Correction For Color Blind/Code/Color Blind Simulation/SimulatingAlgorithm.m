function [ RGBModifedImg ] = SimulatingAlgorithm( srcImg , samePoints , type)
%% Summary

%{
    A generic function which gets a color blind type,image and similar stimuli vectors 
    and return a simulated picture of what the color blind person will see using simulation algorithm on the LMS color space

    Input: srcImg- A 3-dimensional matrix representing the RGB values of the original image
	   samePoints- LMS stimuli which normal observers and the color blind observer see the same  
	   type- 1  for protanopes, 2  for deuteranopes, 3 for tritanopic
    Output: RGBModifedImg - A 3-dimensional matrix representing the RGB values of the simulated image
%}

%% Prepere Picture

srcImg = double(srcImg);

%Retrive the size of the image for reshaping it
sizeImage = size(srcImg);

%Reshape the image for applaying transformation - Creates 3XSizeofPicutre
%matrix
reshapedImage = reshape(srcImg, [sizeImage(1)*sizeImage(2) sizeImage(3)])';


%% Creating the transformation matrix

XYZtoRGB = [ 3.2405 -1.5372 -0.4985;
            -0.9693  1.8760  0.0416;
             0.0556 -0.2040  1.0573];
        
XYZtoLMS = [ 0.8951  0.2664 -0.1614;
            -0.7502  1.7135  0.0367;
             0.0389 -0.0685  1.0296];
         
%% Transform the rgb image to XYZ

%Instead of - XYZImg = RGBtoXYZ*reshapedImage - we do:
XYZImg = XYZtoRGB\reshapedImage;
%It's much more faster and accurate according to matlab

%% Trasform the XYZ img to LMS

n = length(XYZImg(1,:));

LMSImg = XYZtoLMS * XYZImg;

%% Algorithm

%Calculating the LMS values of E - the brightest
%possible metamer of an equal-energy stimulus on this
%monitor. We have selected a metamer of the equal energy
%stimulus E as the neutral color

whiteLMS = XYZtoLMS * (XYZtoRGB\[255 ,255 ,255]');

Le = whiteLMS(1);
Me = whiteLMS(2);
Se = whiteLMS(3);


%Initialize the xyzModifiedImg
LMSModifiedImg = zeros(size(LMSImg));

%for each pixel we will find the line between the chromacity value to the
%Confusion point
for i=1:1:n
    
    Lq = LMSImg(1,i);
    Mq = LMSImg(2,i);
    Sq = LMSImg(3,i);
    
    if (strcmp(type,'protanopes') == 1)
        %Finding the monochromatic index according to the specific color
        if(Sq/Mq < Se/Me)
            %In this case we should projec the values to the wavelenge 575
            idx = 2;
        else
            %In this case we should projec the values to the wavelenge 475
            idx = 1;
        end

        %Getting the stimulus values of this monochromatic light
        La = samePoints(1,idx); Ma = samePoints(2,idx); Sa = samePoints(3,idx); 

        %calulatin a b & c
        a = Me*Sa - Se*Ma;
        b = Se*La - Le*Sa;
        c = Le*Ma - Me*La;

        %this intersection point is the new color
        LMSModifiedImg(1,i) = -(b*Mq + c*Sq)/a;
        LMSModifiedImg(2,i) = Mq;
        LMSModifiedImg(3,i) = Sq;
        
        
    else if (strcmp(type,'deuteranopes') == 1)
            %Finding the monochromatic index according to the specific color
            if(Sq/Lq < Se/Le)
                %In this case we should projec the values to the wavelenge 575
                idx = 2;
            else
                %In this case we should projec the values to the wavelenge 475
                idx = 1;
            end

            %Getting the stimulus values of this monochromatic light
            La = samePoints(1,idx); Ma = samePoints(2,idx); Sa = samePoints(3,idx); 

            %calulatin a b & c
            a = Me*Sa - Se*Ma;
            b = Se*La - Le*Sa;
            c = Le*Ma - Me*La;

            %this intersection point is the new color
            LMSModifiedImg(1,i) = Lq;
            LMSModifiedImg(2,i) = -(a*Lq + c*Sq)/b;
            LMSModifiedImg(3,i) = Sq;

            
        else if (strcmp(type,'tritanopic') == 1)
                %Finding the monochromatic index according to the specific color
                if(Mq/Lq < Me/Le)
                    %In this case we should projec the values to the
                    %wavelenge 660
                    idx = 2;
                else
                    %In this case we should projec the values to the
                    %wavelenge 485
                    idx = 1;
                end

                %Getting the stimulus values of this monochromatic light
                La = samePoints(1,idx); Ma = samePoints(2,idx); Sa = samePoints(3,idx); 

                %calulatin a b & c
                a = Me*Sa - Se*Ma;
                b = Se*La - Le*Sa;
                c = Le*Ma - Me*La;

                %this intersection point is the new color
                LMSModifiedImg(1,i) = Lq;
                LMSModifiedImg(2,i) = Mq;
                LMSModifiedImg(3,i) = -(a*Lq + b*Mq)/c;

            end
        end
    end
       
end

%% Transform the L'M'S' to X'Y'Z'

XYZModifiedImg = XYZtoLMS\LMSModifiedImg;

%% Transform the X'Y'Z' to R'G'B'

RGBModifedImg = XYZtoRGB * XYZModifiedImg;
 
%% Restore the original Image

RGBModifedImg = reshape(RGBModifedImg',[sizeImage(1) sizeImage(2) sizeImage(3)]);
RGBModifedImg = uint8(RGBModifedImg);

end

