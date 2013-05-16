%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ ] = Part2_Q6(  )
% Part2 Q6

load('cones.mat');

% as in lecture 4 slide 24
DecorrelationMatrix = [ 1.00 0.00 0.00 ; -0.59 0.80 -0.12 ; -0.34 -0.11 0.93 ];

OSpace = DecorrelationMatrix * cones';

figure('name','Part2_Q6: Black-White');
plot(OSpace(1,:),'black');
legend('O1: Black-White');

figure('name','Part2_Q6: Red-Green');
plot(OSpace(2,:),'r');
legend('O2: Red-Green');

figure('name','Part2_Q6: Blue-Yellow');
plot(OSpace(3,:),'b');
legend('O3: Blue-Yellow');

figure('name','Part2_Q6: similar to that shown in class');
hold all;
plot(OSpace(1,:),'black');
plot(OSpace(2,:),'r');
plot(OSpace(3,:),'b');
legend('O1: Black-White','O2: Red-Green','O3: Blue-Yellow');