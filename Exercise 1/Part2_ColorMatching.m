%Exercise 1

%part2 - Color Matching

%Zahi Kfir 200681476 && Haim Shalelashvili 200832780
%% -------------------------- Global variables --------------------------
epsilon = 0.01;
prompt = 'Press any key to continue';

load('ColorMatchExperiment1') % load cmf, primaries, wavelength from ColorMatchExperiment1
cmf1 = cmf';                  % To maintain consistency with the presentation of the course
primaries1 = primaries';      % To maintain consistency with the presentation of the course

load('ColorMatchExperiment2') % load cmf, primaries, wavelength from ColorMatchExperiment2
cmf2 = cmf';                  % To maintain consistency with the presentation of the course
primaries2 = primaries';      % To maintain consistency with the presentation of the course


%% -------------------------- part 2 - 1. --------------------------

disp('1.');

IdentityMatrix3X3 = eye(3);     % 3X3 Identity Matrix

Differences = abs(IdentityMatrix3X3 - (cmf1 * primaries1) );    % testing if primaries1*cmf1 = 3X3 Identity Matrix
[Deviation] = max(Differences(:));                              % Deviation = max Difference 
fprintf('Primaries1 is the pseudo inverse of Cmf1. (%d deviation)\n',Deviation);
                                                                   
Differences = abs(IdentityMatrix3X3 - (cmf2 * primaries2) );    % testing if primaries2*cmf3 = 3X3 Identity Matrix
[Deviation] = max(Differences(:));                              % Deviation = max Difference     
fprintf('Primaries2 is the pseudo inverse of Cmf2. (%d deviation)\n',Deviation);

result = input(prompt);
%% -------------------------- part 2 - 2. --------------------------
disp('2.');

%Finding the 3x3 matrix the converts cmf1 to cmf2
disp('Finding the RelateMatrix by calculating cmf2*primaries1');
Cmf1toCmf2Matrix = cmf2*primaries1;

%Calculate cmf2
cmf2Aprox = Cmf1toCmf2Matrix * cmf1;

%Check the difference
DiffMat = (cmf2Aprox-cmf2).^2;
meanSquareError = mean(DiffMat(:));
fprintf('cmf2 = (RelateMatrix*cmf1) , with %d MSE \n',meanSquareError);

%Plot both M*cmf1 && cmf2
fprintf('See Figure 1: The related matrix*cmf1 VS cmf2 \n');

figure('name','The related matrix*cmf1 (cmf2)');
plot(wavelength,cmf2Aprox(1,:),'-',wavelength,cmf2Aprox(2,:),'-',wavelength,cmf2Aprox(3,:),'-');
hold on
plot(wavelength,cmf2(1,:),'--',wavelength,cmf2(2,:),'--',wavelength,cmf2(3,:),'--');
legend('cmf1*M','cmf1*M','cmf1*M','cmf2','cmf2','cmf2');

result = input(prompt);
%% -------------------------- part 2 - 3. --------------------------
disp('3.');

load('macbeth.mat');

%Creating the Experiment1 Tristimulus matrix for the 24 reflectances
Tristimulus1 = cmf1*macbeth;

%Creating the Experiment2 Tristimulus matrix for the 24 reflectances
Tristimulus2 = cmf2*macbeth;

%plot both M*Tristimulus1 && Tristimulus2

disp('See Figure 2: The related matrix*Tristimulus1 VS Tristimulus2 ');

figure('name','M*Tristimulus1 && Tristimulus2');
plot(Tristimulus2', '-');
hold on
plot((Cmf1toCmf2Matrix * Tristimulus1)', '--');
legend('Tristimulus2','Tristimulus2','Tristimulus2','Cmf1toCmf2Matrix * Tristimulus1','Cmf1toCmf2Matrix * Tristimulus1','Cmf1toCmf2Matrix * Tristimulus1');

%Checking the conversetion 3x3 matrix
DiffMat = (Tristimulus2'-(Cmf1toCmf2Matrix * Tristimulus1)').^2;
meanSquareError = mean(DiffMat(:));
fprintf('Tristimulus2 = (Cmf1toCmf2Matrix*Tristimulus1) , with %d MSE \n',meanSquareError);

result = input(prompt);
%% -------------------------- part 2 - 4. --------------------------

disp('4.');

load('cones.mat');
cones = cones';     % To maintain consistency with the presentation of the course

%Find the 3x3 matrix that linear transform cmf1 to cones
disp('Finding the RelateMatrix by calculating cones*primaries1');
M= cones * primaries1;
conesAprox = M * cmf1;

%disp the differences between the cones and the product of M and cmf1
DiffMat = (conesAprox-cones).^2;
meanSquareError = mean(DiffMat(:));
fprintf('The meanSquareError between cones and M*cmf1:');
disp(meanSquareError);

%plot both matrices 
disp('See Figure 3: M * cmf1 VS cones:');
figure('name','M*cmf1 && cones');
plot(conesAprox', '-');
hold on
plot(cones', '--');
legend('M*cmf1','M*cmf1','M*cmf1','cones','cones','cones');

%Find the 3x3 matrix that linear transform cmf2 to cones
disp('Finding the RelateMatrix by calculating cones*primaries2');
M= cones * primaries2;
conesAprox = M * cmf2;

%disp the differences between the cones and the product of M and cmf2
DiffMat = (conesAprox-cones).^2;
meanSquareError = mean(DiffMat(:));
disp('The meanSquareError between cones and M*cmf2:');
disp(meanSquareError);

%plot both matrices 
disp('See Figure 4: M * cmf2 VS cones:');
figure('name','M*cmf2 && cones');
plot(conesAprox', '-');
hold on
plot(cones', '--');
legend('M*cmf2','M*cmf2','M*cmf2','cones','cones','cones');

result = input(prompt);
%% -------------------------- part 2 - 5. --------------------------

disp('5.');

load('spd1.mat');
load('spd2.mat');

%Testing both spd's using cmf1
difMat = cmf1*spd1 - cmf1*spd2;
disp('Testing both SPDs using cmf1:');
disp('The differnce matrix , cmf1*spd1 - cmf1*spd2, is :'); 
disp(difMat);
fprintf(2,'the bigest differnce is %f (%f precent from the values range)\n',max(difMat),(max(difMat)/max(cmf1*spd1)));

%Testing both spd's using cmf2
difMat = cmf2*spd1 - cmf2*spd2;
disp('Testing both SPDs using cmf2:');
disp('The differnce matrix , cmf2*spd1 - cmf2*spd2, is :'); 
disp(difMat);
fprintf(2,'the bigest differnce is %f (%f precent from the values range)\n',max(difMat),(max(difMat)/max(cmf2*spd1)));

%Testing both spd's using LMS
difMat = cones*spd1 - cones*spd2;
disp('Testing both SPDs using cones:');
disp('The differnce matrix , cones*spd1 - cones*spd2, is :'); 
disp(difMat);
fprintf(2,'the bigest differnce is %f (%f precent from the values range)\n',max(difMat),(max(difMat)/max(cones*spd1)));

result = input(prompt);
%% -------------------------- part 2 - 6. --------------------------
disp('6.');

disp('The answer is not, Lets see an example ');

disp ('Generate Negative Tristimulus');
NegativeTristimulus = [ 74.1769 ; -1 ; 28.4478];
disp(NegativeTristimulus);

disp('Find the spd that give us that negative tristimulus values using cmf1');
disp('NegativeTristimulus = cmf1*spd');
spd = linsolve(cmf1,NegativeTristimulus); % NegativeTristimulus = cmf1*spd

disp('And now white this spd: ' );
disp('Calculate the tristimulus values using cmf1:');
disp(cmf1*spd);
disp('Calculate the tristimulus values using cmf2:');
disp(cmf2*spd);

disp('The tristimulus values that we getting using cmf2 is positive althouge there is negative values using cmf1');
  
  


 
  
  
  
  
  
  
  
  
  
  