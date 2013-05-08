function [ ] = Part1_Q2(  )
%Part1_Q2 : simulate a monitor

load ('HitachiGuns.mat');

% Plot the 3 gun spectra in new window
figure('name','Part1_Q2: HitachiGuns spectra');
hold all;
plot(HitachiGuns(:,1),'r');
plot(HitachiGuns(:,2),'g');
plot(HitachiGuns(:,3),'b');