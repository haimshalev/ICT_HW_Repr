function [ RGBModifiedImg ] = tritanopic( srcImg )

%% Get the points that looks the same.

load('xyz.mat');

%Observations  suggest that a blue-green at 485 nm and a red
% at 660 nm have the same hue for the normal and tritanopic eyes
SamePoints(:,1) = xyz(116,:)'; %485nm
SamePoints(:,2) = xyz(291,:)'; %660nm

%Transform this XYZ points to xyz points

%Converting this values to xyz
sumPoints = sum(SamePoints,1);

xyzPoints = zeros(3,2);
for i=1:1:2
    xyzPoints(:,i) = SamePoints(:,i)./sumPoints(i);
end

%% Create Confusion Point for tritanopic
ConfusionPoint = [0.171 0]';

%% Run the simulating algorithm with this custom matrices
RGBModifiedImg = SimulatingAlgorithm(srcImg,xyzPoints,ConfusionPoint);

end