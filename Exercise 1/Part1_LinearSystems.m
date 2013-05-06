%Exercise 1

%part1 - Linear Systems

%Zahi Kfir 200681476 && Haim Shalelashvili 200832780
%% -------------------------- Global variables --------------------------
TestsCount = 50;    % Number of tests
prompt = 'Press any key to continue';

%% -------------------------- Part 1 - 1. --------------------------

disp('1.');

AdditivityMaxDifference = -1;       % max difference between (LinSystem(X)+LinSystem(Y)) and LinSystem(X+Y)
HomogeneityMaxDifference = -1;      % max difference between Y*LinSystem(X) and LinSystem(Y*X)    

% loop TestsCount times: testing via random vector
for MyIter=1:TestsCount
    
    vFirstVector = randn(1,16);     % Generate Random vector size 16
    vSecondVector = randn(1,16);    % Generate Random vector size 16
    iScalar = rand;                 % Generate Random Scalar
    
    % Testing Additivity of LinSystem
    AdditivityTest = abs( (LinSystem(vFirstVector) + LinSystem(vSecondVector)) - LinSystem(vFirstVector + vSecondVector) );
    
    % Testing Homogeneity of LinSystem
    HomogeneityTest = abs( (iScalar*LinSystem(vFirstVector)) - LinSystem(iScalar * vFirstVector) ); 
    
    [CurrentTestMax] = max(AdditivityTest(:));                                  % CurrentTestMax = max difference of current Additivity Test
    AdditivityMaxDifference = max(AdditivityMaxDifference,CurrentTestMax);      % AdditivityMaxDifference = max difference of all Additivity Tests
    [CurrentTestMax] = max(HomogeneityTest(:));                                 % CurrentTestMax = max difference of current Homogeneity Test
    HomogeneityMaxDifference = max(HomogeneityMaxDifference,CurrentTestMax);    % HomogeneityMaxDifference = max difference of All Homogeneity Tests
end

fprintf(1,'LinSystem Additivity Test: %d Tests No more then %d deviation\n',TestsCount,AdditivityMaxDifference); 
fprintf(1,'LinSystem Homogeneity Test: %d Tests No more then %d deviation\n',TestsCount,HomogeneityMaxDifference); 

result = input(prompt);
    
%% -------------------------- Part 1 - 2. --------------------------

disp('2.');

%Create the point spread function vector from one of the impulse vector
disp('Create the point spread function vector from one of the impulse vectors:');
disp('psfVec = LinSystem([0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 ])');
psfVec = LinSystem([0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 ]);

%Show results
disp('See Figure 1: LinSystem: Point-Spread Function');
figure('name','LinSystem: Point-Spread Function');
plot(psfVec)
disp('LinSystem: Point-Spread Function is:');
disp(psfVec);

result = input(prompt);
%% -------------------------- Part 1 - 3. --------------------------

disp('3.');

%The modulation transfer function (MTF) is defined as the discrete 
%Fourier transform of the psf vector
disp('The modulation transfer function (MTF) is defined as the discrete Fourier transform of the psf vector');
mtfVec = fft(psfVec);

%Show results
disp('See Figure 2: LinSystem: Modultaion-Transform Function');
figure('name','LinSystem: Modultaion-Transform Function (absoulte)');
plot(abs(mtfVec)) ;
disp('LinSystem Modultaion-Transform Function is:');
disp(mtfVec);

result = input(prompt);
%% -------------------------- Part 1 - 4. --------------------------

disp('4.');

%initalize a test result counter
shiftInveriantTest = 0;

%Run TestsCount shiftinveriant tests
for MyIter=1:TestsCount
    
    %Create a random test vector
    vTest = randn(1,16);  
    iScalar = round(rand(1)*16); % random Integer between 0-15
    
    %create a substruction vector from both 
    %1. Shift of the LinSystem output of the test vector
    %2. LinSystem output of the shifted test vector 
    shiftInveriantSubMatrix = abs(circshift(LinSystem(vTest),[0,iScalar]) - LinSystem(circshift(vTest,[0,iScalar])));
      
    %sum the differnces
    shiftInveriantTest = shiftInveriantTest + sum(shiftInveriantSubMatrix);
       
end

%if all the tests had no differences
if (shiftInveriantTest == 0)
    %Print success message
    fprintf(1,'LinSystem Shift inveriant  Test: %d Tests Succeed! \n',TestsCount);
    disp('LinSystem is shift invariant!');
else
    %Print failure message
    fprintf(1,'LinSystem Shift inveriant  Test: %d Tests Failed! \n',TestsCount);
    disp('LinSystem is NOT shift invariant!');
end

result = input(prompt);
%% -------------------------- Part 1 - 5. --------------------------

disp('5.');

% trivial - LinSystem is a linear System 

LinSystemMatrix = [ LinSystem([1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 ]);
                    LinSystem([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ])
                  ];

LinSystemMatrixMaxDifference = -1;      % max difference between LinSystem(X) and LinSystemMatrix* X       

for iMyIter=0:TestsCount
    vTestRandomVector = randn(1,16);    % Generate Random vector size 16

    vMatrixMultiplicationResult = vTestRandomVector*LinSystemMatrix;    % calculating result using matrix
    vFunctionResult = LinSystem(vTestRandomVector);                     % calculating result using LinSystem Funciton
    vResultVector = abs(vMatrixMultiplicationResult-vFunctionResult);   % vResultVector = defference between function result and matrix result

    [CurrentTestMax] = max(vResultVector(:));                                           % CurrentTestMax = max difference of current Test                                           
    LinSystemMatrixMaxDifference = max(LinSystemMatrixMaxDifference,CurrentTestMax);    % LinSystemMatrixMaxDifference = max difference of All Tests
end

 fprintf(1,'LinSystem: System Matrix Test: %d Tests No more then %d deviation\n',TestsCount,AdditivityMaxDifference); 

result = input(prompt);
%% -------------------------- Part 1 - 6.1. --------------------------

disp('---------------------------------------------');
disp('Starting testing LinSystem2');

disp('6.1.');

AdditivityTestResult = 1;       % max difference between (LinSystem(X)+LinSystem(Y)) and LinSystem(X+Y)
HomogeneityTestResult = 1;      % max difference between Y*LinSystem(X) and LinSystem(Y*X) 

% loop TestsCount times: testing via random vector
for MyIter=1:TestsCount
    
    vFirstVector = randn(1,16);     % Generate Random vector size 16
    vSecondVector = randn(1,16);    % Generate Random vector size 16
    iScalar = rand;                 % Generate Random Scalar
    
    % Testing Additivity of LinSystem
    AdditivityTest = abs( (LinSystem2(vFirstVector) + LinSystem2(vSecondVector)) - LinSystem2(vFirstVector + vSecondVector) );
    
    % Testing Homogeneity of LinSystem2
    HomogeneityTest = abs( (iScalar*LinSystem2(vFirstVector)) - LinSystem2(iScalar * vFirstVector));
    
    [CurrentTestMax] = max(AdditivityTest(:));                                  % CurrentTestMax = max difference of current Additivity Test
    AdditivityMaxDifference = max(AdditivityMaxDifference,CurrentTestMax);      % AdditivityMaxDifference = max difference of all Additivity Tests
    [CurrentTestMax] = max(HomogeneityTest(:));                                 % CurrentTestMax = max difference of current Homogeneity Test
    HomogeneityMaxDifference = max(HomogeneityMaxDifference,CurrentTestMax);    % HomogeneityMaxDifference = max difference of All Homogeneity Test  
end

fprintf(1,'LinSystem2 Additivity Test: %d Tests No more then %d deviation\n',TestsCount,AdditivityMaxDifference); 
fprintf(1,'LinSystem2 Homogeneity Test: %d Tests No more then %d deviation\n',TestsCount,HomogeneityMaxDifference);

result = input(prompt);
%% -------------------------- Part 1 - 6.2. --------------------------

disp('6.2.');

%Create the point spread function vector from one of the impulse vector
psfVec = LinSystem2([0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 ]);

%Show results
disp('See Figure 3: LinSystem2: Point-Spread Function');
figure('name','LinSystem2: Point-Spread Function');
plot(psfVec) 
disp('LinSystem2: Point-Spread Function is:');
disp(psfVec);

result = input(prompt);
%% -------------------------- Part 1 - 6.3. --------------------------

disp('6.3.');

%The modulation transfer function (MTF) is defined as the discrete 
%Fourier transform of the psf vector
mtfVec = fft(psfVec);

%Show results
%figure('ModultaionTransformFunction','sdaasd');
disp('See Figure 4: LinSystem2: Modultaion-Transform Function');
figure('name','LinSystem2: Modultaion-Transform Function (absoulte)');
plot(abs(mtfVec)); 
disp('LinSystem2 Modultaion-Transform Function is:');
disp(mtfVec);

result = input(prompt);
%% -------------------------- Part 1 - 6.4. --------------------------


disp('6.4.');

%initalize a test result counter
shiftInveriantTest = 0;

%Run TestsCount shiftinveriant tests
for MyIter=1:TestsCount
    
    %Create a random test vector
    vTest = randn(1,16);  
    iScalar = round(rand(1)*16); % random Integer between 0-15
    
    %create a substruction vector from both 
    %1. Shift of the LinSystem2 output of the test vector
    %2. LinSystem2 output of the shifted test vector 
    shiftInveriantSubMatrix = abs(circshift(LinSystem2(vTest),[0,iScalar]) - LinSystem2(circshift(vTest,[0,iScalar])));
      
    %sum the differnces
    shiftInveriantTest = shiftInveriantTest + sum(shiftInveriantSubMatrix);
       
end

%if all the tests had no differences
if (shiftInveriantTest == 0)
    %Print success message
    fprintf(1,'LinSystem2 Shift inveriant  Test: %d Tests Succeed! \n',TestsCount);
    disp('LinSystem is Shift invariant!');
else
    %Print failure message
    fprintf(1,'LinSystem2 Shift inveriant  Test: %d Tests Failed! \n',TestsCount);
    disp('LinSystem is NOT shift invariant!');
end

result = input(prompt);
%% -------------------------- Part 1 - 6.5. --------------------------

fprintf('6.5.');

% trivial - LinSystem is a linear System 
LinSystem2Matrix = [ LinSystem2([1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 ]);
                     LinSystem2([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ])
                   ];
               
LinSystemMatrixMaxDifference = -1;      % max difference between LinSystem(X) and LinSystemMatrix* X            

for iMyIter=0:TestsCount
    vTestRandomVector = randn(1,16);    % Generate Random vector size 16

    vMatrixMultiplicationResult = vTestRandomVector*LinSystemMatrix;    % calculating result using matrix
    vFunctionResult = LinSystem2(vTestRandomVector);                    % calculating result using LinSystem2 Funciton
    vResultVector = abs(vMatrixMultiplicationResult-vFunctionResult);   % vResultVector = defference between function result and matrix result

    [CurrentTestMax] = max(vResultVector(:));                                           % CurrentTestMax = max difference of current Test
    LinSystemMatrixMaxDifference = max(LinSystemMatrixMaxDifference,CurrentTestMax);    % LinSystemMatrixMaxDifference = max difference of All Tests
end

 fprintf(1,'LinSystem2: System Matrix Test: %d Tests No more then %d deviation\n',TestsCount,AdditivityMaxDifference); 
               

