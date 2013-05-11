%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ ] = Part1_Q3(  )
%Part1_Q3 : Mapping xy values to Hue & Saturation

%plot the chromaticity diagram
ChromaticityDiagramFigure = Part1_Q1();
set(ChromaticityDiagramFigure,'Name','Part1_Q2: CIE-XYZ chromaticity diagram')
hold on;

%Setting the white values found in Q2
whitexyz = [0.3116 ; 0.3110 ; 0.3775];

%Getting input from user
[x,y,choice] = ginput(1);

%While the user didn't press the right button
while (choice ~= 3) 
    
    %Todo: Add all the logic!
    
    %Getting input from user
    [x,y,choice] = ginput(1);
    
end