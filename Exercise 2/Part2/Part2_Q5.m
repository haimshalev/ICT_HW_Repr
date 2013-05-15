function [ ] = Part2_Q5(  )
% Part2 Q5 a

load('munsell.mat');
load('cones.mat');

%% Part2 Q5 a
LMS = cones'* munsell;

figure('name','Part2_Q5: L Vs M');
hold all;
xlabel('L');
ylabel('M');
plot(LMS(1, :), LMS(2, :));

figure('name','Part2_Q5: L Vs S');
hold all;
xlabel('L');
ylabel('S');
plot(LMS(1, :), LMS(3, :));


%% Part2 Q5 b

LMSCovarianceMatrix = (LMS-mean(LMS(:))) * (LMS'-mean(LMS(:)))

[U,S,V] = svd(LMS);
OpponentSpace = U'*LMS;

figure('name','Part2_Q5: O1 Vs O2');
hold all;
xlabel('O1');
ylabel('O2');
plot(OpponentSpace(1, :), OpponentSpace(2, :));

figure('name','Part2_Q5: O1 Vs O3');
hold all;
xlabel('O1');
ylabel('O3');
plot(OpponentSpace(1, :), OpponentSpace(3, :));

%% Part2 Q5 c

OpponentSpaceCovarianceMatrix = ( OpponentSpace-mean(OpponentSpace(:)) ) * ( OpponentSpace'-mean(OpponentSpace(:)));

OpponentSpaceCovarianceMatrix = OpponentSpace*OpponentSpace'



