function [ ] = Part1_Q2(  )
%Part1_Q2 : simulate a monitor

load ('HitachiGuns.mat');

% Plot the 3 gun spectra in new window
figure('name','Part1_Q2: HitachiGuns spectra');
hold all;
plot(HitachiGuns(:,1),'r');
plot(HitachiGuns(:,2),'g');
plot(HitachiGuns(:,3),'b');


ChromaticityDiagramFigure = Part1_Q1();
set(ChromaticityDiagramFigure,'Name','Part1_Q2: CIE-XYZ chromaticity diagram')
hold all;
ax = axes('position',[0,0,1,1],'visible','off');
tx = text(0.4,0.95,'Testing the returned figure from Part1\_Q1 function !!!');
set(tx,'fontweight','bold');
