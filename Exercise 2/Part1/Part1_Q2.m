%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ ] = Part1_Q2(  )
%Part1_Q2 : simulate a monitor

load ('HitachiGuns.mat');
load ('xyz.mat');

%% Part a

% Plot the 3 gun spectra in new window
figure('name','Part1_Q2: HitachiGuns spectra');
hold all;
plot(HitachiGuns(:,1),'r');
plot(HitachiGuns(:,2),'g');
plot(HitachiGuns(:,3),'b');

%% part b

%Plot the CIE-XYZ chromaticity diagram
ChromaticityDiagramFigure = Part1_Q1();
set(ChromaticityDiagramFigure,'Name','Part1_Q2: CIE-XYZ chromaticity diagram')
hold on;

%Calculate the xy values of each gun

%Finding the CIE-XYZ values
%each column shows the Tristimulus values of each gun
XYZ = xyz'*HitachiGuns;

%Converting this values to xyz

%Get the sum of X,Y,Z of each gun (sumXYZ = sum of each column)
sumXYZ = sum(XYZ,1);

%Calculation x y z values by dividing each Tristimulus value on the sum of
%them
myxyz = zeros(3,3);
for i=1:1:3
    myxyz(:,i) = XYZ(:,i)./sumXYZ(i);
end

%Calculating the matrix which transform xyz  to XYZ for part e
%XYZ = M*xyz 
xyz2XYZ = XYZ/myxyz;

%plot the values on the ChromaticityDiagram
plot(myxyz(1,:) , myxyz(2,:) , 'd' ,'Marker' , 'X','MarkerEdgeColor', 'black', 'MarkerSize', 14);
hold on;

%% part c

%xyzValues = RGB2XYZ * rgbValues
%e = MP'e'
%According to this two equations:
RGB2XYZ = xyz'*HitachiGuns;

%% part d

%in rgb white collor is [1 1 1]
whiteRgb = [1; 1; 1];

%Calculating the XYZ values
whiteXYZ = RGB2XYZ*whiteRgb;

%Getting the xy values
myxyz = whiteXYZ./sum(whiteXYZ);

%plotting the value on the Chromaticity Diagram
plot(myxyz(1,:) , myxyz(2,:) , 'd' ,'Marker' , 'X','MarkerEdgeColor', 'black', 'MarkerSize', 14);

%% part e

%Creating a new figure for displaying the colors
Display = figure;

%This figure will hold a rectangle with this endpoints
RecXValues = [0 1 1 0 0];
RecYValues = [0 0 1 1 0];

%Setting back the Chromaticity Diagram on top 
figure(ChromaticityDiagramFigure);

%Getting input from user
[x,y,choice] = ginput(1);

%While the user didn't press the right button
while (choice ~= 3) 
    
    %Calculation the z value from x and y
    z = 1 - x - y;
    
    %Calculating the rgb value of this xyz
    
    %Calculating the XYZ values
    XYZ = xyz2XYZ * [x y z]';
    %And now we can user the RGB2XYZ matrix
    rgbValues = XYZ'/RGB2XYZ;
    
    %Normalizing the RGB values to 1
    if (min(rgbValues) < 0)
        rgbValues = rgbValues - min(rgbValues);
    end
    rgbValues = rgbValues/max(rgbValues);
    
    %Displaying the chosen color on the display figure
    
    %Getting back the Display figure
    figure(Display);
    
    %Displaying a rectangle with the selected color
    fill(RecXValues,RecYValues,rgbValues);
    
    %Setting back the Chromaticity Diagram on top 
    figure(ChromaticityDiagramFigure);

    %Getting input from user
    [x,y,choice] = ginput(1);
    
end



