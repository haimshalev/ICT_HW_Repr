%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [ ] = Part2_Q6(  )
% Part2 Q6

load('cones.mat');

% as in lecture 4 slide 24
DecorrelationMatrix = [ 1.00 0.00 0.00 ; -0.59 0.80 -0.12 ; -0.34 -0.11 0.93 ];

OSpace = DecorrelationMatrix * cones';

figure('name','Part2_Q6: opponent space:');
hold all;
plot(OSpace(1,:),'black');
plot(OSpace(2,:),'r');
plot(OSpace(3,:),'b');
legend('O1: Black-White','O2: Red-Green','O3: Blue-Yellow');


% normalize the max to 1,
% similar to that shown in class – Lecture 4 slide 24
Normalized_O1 = OSpace(1,:);
Normalized_O1 = Normalized_O1 ./ max(Normalized_O1);

Normalized_O2 = OSpace(2,:);
Normalized_O2 = Normalized_O2 ./ max(Normalized_O2);

Normalized_O3 = OSpace(3,:);
Normalized_O3 = Normalized_O3 ./ max(Normalized_O3);

figure('name','Part2_Q6: Normalized opponent space: ');
hold all;
plot(Normalized_O1,'black','LineWidth',2);
plot(Normalized_O2,'r');
plot(Normalized_O3,'b--');
legend('O1: Black-White','O2: Red-Green','O3: Blue-Yellow');
text(50,-0.92,'similar to that shown in class – Lecture 4 slide 24');
















