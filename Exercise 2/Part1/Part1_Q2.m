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

%plot the values on the ChromaticityDiagram
plot(myxyz(1,:) , myxyz(2,:) , 'd' ,'Marker' , 'X','MarkerEdgeColor', 'black', 'MarkerSize', 14);





