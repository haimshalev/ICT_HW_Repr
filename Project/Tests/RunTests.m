% Test....

function [ ] = RunTests()
    close all;

    TestImagesList = dir('Test subjects/*.bmp');    % run this command from "Tests" folder
    ImagesCount = length(TestImagesList);           % Number of files found
       
    Test_ColorBlindFix(TestImagesList,ImagesCount,1);
    
    %{
    M = zeros(10,10);
    M(4,5) = 1;
    M(4,7) = 1;
    M(5,5) = 1;
    M(5,6) = 1;
    M(2,2) = 1
    
    D = FixAnomalies(M,0)
    %}
    
    disp('TheEnd!');
    
end


function [ ] = Test_ColorBlindFix(TestImagesList,ImagesCount,ColorBlindType)   
    TestName = 'ColorBlindFix/';      
    CreateTestResultFolder(TestName);    
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);

        [FixedPic , fileinfo , ~] = ColorBlindFix(ColorBlindType,CurrentImage);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,strcat(strrep(CurrentImageName,'.bmp',''),'_',fileinfo)),0,ColorBlindType);
        
    end
    disp('finished ColorBlindFix');
end




%------------------------------------- Old Tests -------------------------------------
%{

function [ ] = BadPixelsRecognition1_Test(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
        
        TestName = strcat('BadPixelsRecognition/BadPixelsRecognition 1/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        BadPixelMatrix = BadPixelsRecognition1(CurrentImage,110);
        
        New_R = CurrentImage(:,:,1);
        New_G = CurrentImage(:,:,2);
        New_B = CurrentImage(:,:,3);
        
        New_R(BadPixelMatrix) = 256;
        New_G(BadPixelMatrix) = 256;
        New_B(BadPixelMatrix) = 256;
        
        NoBadPixel = CurrentImage;
        
        NoBadPixel(:,:,1) = New_R;
        NoBadPixel(:,:,2) = New_G;
        NoBadPixel(:,:,3) = New_B;
        
        SaveResults(CurrentImage,NoBadPixel,TestName,0);
        
        disp(strcat('done daltonize 1 test for:_',CurrentImageName));
    end
    disp('finished all daltonize 1 Tests');
end
function [ ] = GaussianConvolution_MaxValue_1_Test()
    Temp = zeros(20,20); 
    
    Temp(7,7) =1;Temp(7,8) =1;Temp(7,9) =1;Temp(7,10) =1;Temp(8,7) =1;Temp(8,8) =1;Temp(8,9) =1;Temp(8,10) =1;
    %{
    for i=6:14
        for j=6:14
            Temp(i,j) = 1;
        end
    end
    %}
    Temp2 = GaussianConvolution_MaxValue_1(Temp);
    
    disp('done testing GaussianConvolution_MaxValue_1');
end
function [ ] = SmoothTransformTest()
    Temp1 = zeros(100,100,3);    Temp1(:,:,1) = 0.2;     Temp1(:,:,3) = 0.3;    Temp1(:,:,2) = 0.5;   
    Temp2 = zeros(100,100,3);    Temp2(:,:,1) = 0.6;    Temp2(:,:,3) = 0.4;    Temp2(:,:,2) = 0.1;
    figure('name','RGB Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( Temp1 , Temp2 , 0.5,0.25,0.125);     imshow(Temp3);
    figure('name','HSV Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( rgb2hsv(Temp1) , rgb2hsv(Temp2) , 0.5,0.25,0.125 );     imshow(hsv2rgb(Temp3));
           
    Temp1 = zeros(100,100,3);    Temp1(:,:,1) = 0.4;     Temp1(:,:,3) = 0.5;    Temp1(:,:,2) = 0.6;   
    Temp2 = zeros(100,100,3);    Temp2(:,:,1) = 0.8;    Temp2(:,:,3) = 0.7;    Temp2(:,:,2) = 0.1;
    figure('name','RGB Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( Temp1 , Temp2 , 0.5,0.25,0.125 );     imshow(Temp3);
    figure('name','HSV Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( rgb2hsv(Temp1) , rgb2hsv(Temp2) , 0.5,0.25,0.125 );     imshow(hsv2rgb(Temp3));
           
    Temp1 = zeros(100,100,3);    Temp1(:,:,1) = 0.6;     Temp1(:,:,3) = 0.25;    Temp1(:,:,2) = 0.455;  
    Temp2 = zeros(100,100,3);    Temp2(:,:,1) = 0.278;    Temp2(:,:,3) = 0.87;    Temp2(:,:,2) = 0.63;
    figure('name','RGB Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( Temp1 , Temp2 , 0.5,0.25,0.125);    imshow(Temp3);
    figure('name','HSV Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( rgb2hsv(Temp1) , rgb2hsv(Temp2) , 0.5,0.25,0.125 );    imshow(hsv2rgb(Temp3));
           
    Temp1 = zeros(100,100,3);    Temp1(:,:,1) = 0.75;     Temp1(:,:,3) = 0.13;    Temp1(:,:,2) = 0.32;  
    Temp2 = zeros(100,100,3);    Temp2(:,:,1) = 0.42;    Temp2(:,:,3) = 0.77;    Temp2(:,:,2) = 0.23;
    figure('name','RGB Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( Temp1 , Temp2, 0.5,0.25,0.125 );    imshow(Temp3);
    figure('name','HSV Smoothnes','NumberTitle','off');    Temp3 = SmoothTransform( rgb2hsv(Temp1) , rgb2hsv(Temp2), 0.5,0.25,0.125 );    imshow(hsv2rgb(Temp3));
    
end
function [ ] = Test_Recoloring(TestImagesList,ImagesCount)    
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);

        TestName = strcat('Recoloring/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        RecoloredImage = Recolor_YIQ_1(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','YIQ_1'),1);
      %{
        RecoloredImage = Recolor_RGB_1(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','RGB_1'),0);
       
        RecoloredImage = Recolor_LAB_1(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','LAB_1'),0);
       
        RecoloredImage = Recolor_LAB_2(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','LAB_2'),0);
       
        RecoloredImage = Recolor_LAB_3(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','LAB_3'),0);
        %}
        disp(strcat('done recoloring test for:_',CurrentImageName));
    end
    disp('finished all recoloring Tests');
end

function [ ] = Test_RedRecognotion1(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
        
        TestName = strcat('Red recognition/Red recognition 1/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        for i=40:5:50
            for j=350:-10:330               
                WhiteBlackRedPic = RedRecognition_1(CurrentImage,i,j);
                FigureName = strcat('Thresholds_',num2str(i),'-',num2str(j));
                SaveResults(CurrentImage,WhiteBlackRedPic,strcat(TestName,'/',FigureName),0);
            end
        end
        disp(strcat('done Red Recognotion 1 test for:_',CurrentImageName));
    end
    disp('finished all Red Recognotion 1 Tests');
end
function [ ] = Test_RedRecognotion2(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
        
        TestName = strcat('Red recognition/Red recognition 2/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        for i=70:10:90
            for j=70:10:90
                for k=90:10:100
                WhiteBlackRedPic = RedRecognition_2(CurrentImage,i,j,k);
                FigureName = strcat('Thresholds_',num2str(i),'-',num2str(j));
                SaveResults(CurrentImage,WhiteBlackRedPic,strcat(TestName,'/',FigureName),0);
                end
            end
        end
        disp(strcat('done Red Recognotion 2 test for:_',CurrentImageName));
    end
    disp('finished all Red Recognotion 2 Tests');
end

function [ ] = Test_Daltonize_1(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Daltonize/Daltonize 1/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
              
        FixedPic = Daltonize_1(CurrentImage,Recolor_YIQ_1(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','YIQ_1'),1);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_RGB_1(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','RGB_1'),1);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_LAB_1(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','LAB_1'),1);
       
        FixedPic = Daltonize_1(CurrentImage,Recolor_LAB_2(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','LAB_2'),1);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_LAB_3(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','LAB_3'),1);
        
        disp(strcat('done daltonize 1 test for:_',CurrentImageName));
    end
    disp('finished all daltonize 1 Tests');
end
function [ ] = Test_Daltonize_YIQ(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Daltonize/Daltonize YIQ/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        for j=35:5:35
            FixedPic = Daltonize_1(CurrentImage,Recolor_YIQ_1(CurrentImage),j);
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','Threashold_',num2str(j)),1);
        end
                        
        disp(strcat('done daltonize YIQ test for:_',CurrentImageName));
    end
    disp('finished all daltonize YIQ Tests');
end
function [ ] = Test_Daltonize_2(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Daltonize/Daltonize 2/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
               
        for j=10:5:50
            FixedPic = Daltonize_2(CurrentImage,Recolor_YIQ_1(CurrentImage),j);
            FigureName = strcat('Thresholds_',num2str(j));
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/',FigureName),0);
        end
               
        disp(strcat('done daltonize 2 test for:_',CurrentImageName));
    end
    disp('finished all daltonize 2 Tests');
end
function [ ] = Test_Daltonize_3(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = 'Daltonize/Daltonize 3/';      
        CreateTestResultFolder(TestName);
        
        FixedPic = Daltonize_3(CurrentImage,Recolor_YIQ_1(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,strrep(CurrentImageName,'.bmp','')),0);
                        
        disp(strcat('done daltonize 3 test for:_',CurrentImageName));
    end
    disp('finished all daltonize 3 Tests');
end
function [ ] = Test_Daltonize_4(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Daltonize/Daltonize 4/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        for j=40:10:140
            FixedPic = Daltonize_4(CurrentImage,Recolor_YIQ_1(CurrentImage),j);
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','Threashold_',num2str(j)),0);
        end
                
        disp(strcat('done daltonize 4 test for:_',CurrentImageName));
    end
    disp('finished all daltonize 4 Tests');
end
function [ ] = Test_Daltonize_5(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Daltonize/Daltonize 5/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);

        A=70;
        for j=A:20:A
            FixedPic_RGB = Daltonize_5(CurrentImage,Recolor_YIQ_2(CurrentImage),j);
            SaveResults(CurrentImage,FixedPic_RGB,strcat(TestName,'/','Threashold_',num2str(j)),0);
        end
        
        disp(strcat('done daltonize 5 test for:_',CurrentImageName));
    end
    disp('finished all daltonize 5 Tests');
end

function [ ] = Test_Increase_RG_Contrast_1(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Increase_RG_Contrast/Increase_RG_Contrast_1/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        ConstsVector = [ 1 1.1 1.2 1.3 1.5 2 5 10 ] ;
        for j=ConstsVector
            FixedPic = Increase_RG_Contrast_1(CurrentImage,j);
            FigureName = strcat('IncreasConst_',num2str(j));
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/',FigureName),1);
        end

        disp(strcat('done Increase RG Contrast 1 testing:_',CurrentImageName));
    end
    disp('finished all Increase RG Contrast 1 Testing');
end
function [ ] = Test_Increase_RG_Contrast_2(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Increase_RG_Contrast/Increase_RG_Contrast_2/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        ConstsVector = [ 2 2.5 3 3.5 15] ;
        for j=ConstsVector
            FixedPic = Increase_RG_Contrast_2(CurrentImage,j);
            FigureName = strcat('IncreasConst_',num2str(j));
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/',FigureName),1);
        end

        disp(strcat('done Increase RG Contrast 2 testing:_',CurrentImageName));
    end
    disp('finished all Increase RG Contrast 2 Testing');
end
function [ ] = Test_Increase_RG_Contrast_3(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Increase_RG_Contrast/Increase_RG_Contrast_3/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        ConstsVector = [ 2.5 3.5 4 4.5 ] ;
        for j=ConstsVector
            FixedPic = Increase_RG_Contrast_3(CurrentImage,j);
            FigureName = strcat('IncreasConst_',num2str(j));
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/',FigureName),1);
        end

        disp(strcat('done Increase RG Contrast 3 test for:_',CurrentImageName));
    end
    disp('finished all Increase RG Contrast 3 Tests');
end

function [ ] = Final_Test_1(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Finals/Final_1/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_YIQ_1(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','NoContrast'),1);
       
        CurrentHightContrast = (Increase_RG_Contrast_3(CurrentImage,3.5))/255;
        FixedPic = Daltonize_1(CurrentHightContrast,Recolor_YIQ_1(CurrentImage),35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','OriginalBeforeContrast'),1);
        
        BluePic = Recolor_YIQ_1(CurrentImage)/255;
        BlueHightContrast = (Increase_RG_Contrast_3(BluePic,3.5))/255;
        FixedPic = Daltonize_1(CurrentImage,BlueHightContrast,35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','BlueBeforeContrast'),1);
        
        CurrentHightContrast = (Increase_RG_Contrast_3(CurrentImage,3.5))/255;
        BluePic = Recolor_YIQ_1(CurrentImage)/255;
        BlueHightContrast = (Increase_RG_Contrast_3(BluePic,3.5))/255;
        FixedPic = Daltonize_1(CurrentHightContrast,BlueHightContrast,35);
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','BothBeforeContrast'),1);
                
        FixedPic = Daltonize_1(CurrentImage,Recolor_YIQ_1(CurrentImage),35);
        FixedHightContrast = (Increase_RG_Contrast_3(FixedPic/255,3.5));
        SaveResults(CurrentImage,FixedHightContrast,strcat(TestName,'/','AfterContrast'),1);
        
        disp(strcat('done Final 1 test for:_',CurrentImageName));
    end
    disp('finished all Final 1 Tests');
end
function [ ] = Final_Test_2(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Finals/Final_2/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        BluePic = Recolor_YIQ_1(CurrentImage)/255;
        BlueHightContrast = Increase_RG_Contrast_3(BluePic,3.5);
        
        for j=10:5:50
            FixedPic = (Daltonize_2(CurrentImage,BlueHightContrast,j));
            FigureName = strcat('Thresholds_',num2str(j));
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/',FigureName),0);
        end
               
        disp(strcat('done Final 2 test for:_',CurrentImageName));
    end
    disp('finished all Final 2 Tests');
end
function [ ] = Final_Test_3(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Finals/Final_3/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        OriginalHightContrast = (Increase_RG_Contrast_3(CurrentImage,3.5));
        
        for j=10:5:50
            FixedPic = (Daltonize_2(OriginalHightContrast,Recolor_YIQ_1(CurrentImage),j));
            FigureName = strcat('Thresholds_',num2str(j));
            SaveResults(CurrentImage,FixedPic,strcat(TestName,'/',FigureName),1);
        end
               
        disp(strcat('done Final 3 test for:_',CurrentImageName));
    end
    disp('finished all Final 3 Tests');
end
function [ ] = Final_Test_4(TestImagesList,ImagesCount)
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Finals/Final_4/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
              
        for j=10:5:50
            FixedPic = (Daltonize_2(CurrentImage,Recolor_YIQ_1(CurrentImage),j));
            FigureName = strcat('Thresholds_',num2str(j));
            FixedHightContrast = (Increase_RG_Contrast_3(FixedPic,3.5));
            SaveResults(CurrentImage,FixedHightContrast,strcat(TestName,'/',FigureName),1);
        end
               
        disp(strcat('done Final 4 test for:_',CurrentImageName));
    end
    disp('finished all Final 4 Tests');
end
%}



