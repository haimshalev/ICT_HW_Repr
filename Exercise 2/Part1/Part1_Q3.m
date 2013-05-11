%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ ] = Part1_Q3(  )
%Part1_Q3 : Mapping xy values to Hue & Saturation

%plot the chromaticity diagram
[ChromaticityDiagramFigure , myxyz] = Part1_Q1();
set(ChromaticityDiagramFigure,'Name','Part1_Q2: CIE-XYZ chromaticity diagram')
hold on;

%Setting the white values found in Q2
whitexyz = [0.3116 ; 0.3110 ; 0.3775];

%Getting input from user
[x,y,choice] = ginput(1);

%While the user didn't press the right button
while (choice ~= 3)  
    %% Calculating Hue
    
    %Hue defined as the angle (in degrees) of the line between xy and white point 
    %(relative to the horizontal)
    
    %Computing the z value from x & y
    z = 1 - x - y;
    
    %Calculating the difference between the selected point to the white
    %point 
    diff = [x y z]' - whitexyz;
    
    %Calculating the angle between the two points by applying arcTan
    %on the difference (arctan gives us the inverse function to tan which
    %maps differnces from the horizontal line to angle)
    Hue = radtodeg(atan2(diff(2),diff(1)));
    
    %Print Hue value
    fprintf('Hue : %f \n',Hue);
    
    %% Calculating Staturation
    
    %Saturation defined  as the ratio of the distance between the xy point to the  
    %whitepoint to the distance between white point and the xy's dominant wavelength
    
    %Calculating the distance between white point and the xy's dominant
    %wavelength
   
    %finding the linear line parameters of the line from the selected xy to
    %the white point
    m = (whitexyz(2) - y)/(whitexyz(1) - x);
    c = y -m*x;
    
    %enlarge the line for it to intersect the polygon line
    newX = [0  1];
    newY = m*newX + c;
     
    %Finding the intersection points
    [intersectionX,intersectionY] = polyxpoly(newX,newY,myxyz(1,:),myxyz(2,:));
    
    %Find the dominant xy from the two results - the closet to the selected
    %point
    distanceTointersection1 = pdist([x y; intersectionX(1) intersectionY(1)],'euclidean');
    distanceTointersection2 = pdist([x y; intersectionX(2) intersectionY(2)],'euclidean');
    
    selectedDistance = min(distanceTointersection1,distanceTointersection2);
    
    if (selectedDistance == distanceTointersection1)
        dominant = [intersectionX(1) intersectionY(1)];
    else
        dominant = [intersectionX(2) intersectionY(2)];
    end
    
    %Calculating the distance of the selected point to the white color
    distanceBetweenSelectedToWhite = pdist([x y; whitexyz(1) whitexyz(2)],'euclidean');
    
    %Calculating the distance of the dominant wavelength to the white color
    distanceBetweenDominantToWhite = pdist([dominant(1) dominant(2); whitexyz(1) whitexyz(2)],'euclidean');
    
    %Checking if the Saturation is available , the distance between the
    %selected x,y to the white point is lower than the distance between the
    %dominant wavelength to the white color
    if (distanceBetweenSelectedToWhite > distanceBetweenDominantToWhite)
        %If we exeeded the polyline area
        disp('Dominant wavelength does not exist');
        
    else
        %Saturation is the ratio of the distance between the xy point to the
        %whitpoint and the xy of the dominant wavelength
        Saturation = distanceBetweenSelectedToWhite/distanceBetweenDominantToWhite;

        %Print the saturation value
        fprintf('Saturation : %f \n\n',Saturation);
    end
        
    
    %% Getting input from user
    [x,y,choice] = ginput(1);
    
end