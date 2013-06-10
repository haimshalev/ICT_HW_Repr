% Test....

function [ ] = RunTests()
    close all;

    TestImagesList = dir('Test subjects/*.bmp');    % run this command from "Tests" folder
    ImagesCount = length(TestImagesList);           % Number of files found
    
    TestAll = false;
    if TestAll
        Test_Recoloring(TestImagesList,ImagesCount);
    
        Test_RedRecognotion1(TestImagesList,ImagesCount);
        Test_RedRecognotion2(TestImagesList,ImagesCount);

        Test_Daltonize_1(TestImagesList,ImagesCount);
        Test_Daltonize_YIQ(TestImagesList,ImagesCount);
        Test_Daltonize_2(TestImagesList,ImagesCount); 

        Test_Increase_RG_Contrast_1(TestImagesList,ImagesCount); 
        Test_Increase_RG_Contrast_2(TestImagesList,ImagesCount); 
        Test_Increase_RG_Contrast_3(TestImagesList,ImagesCount);
        
        Final_Test_1(TestImagesList,ImagesCount);
        Final_Test_2(TestImagesList,ImagesCount);
        Final_Test_3(TestImagesList,ImagesCount);
        Final_Test_4(TestImagesList,ImagesCount);
    else
        Test_Daltonize_2(TestImagesList,ImagesCount);
        Final_Test_1(TestImagesList,ImagesCount);
        Final_Test_2(TestImagesList,ImagesCount);
        Final_Test_3(TestImagesList,ImagesCount);
        Final_Test_4(TestImagesList,ImagesCount);
    end
    
end


function [ ] = Test_Recoloring(TestImagesList,ImagesCount)    
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);

        TestName = strcat('Recoloring/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        RecoloredImage = Recolor_YIQ_1(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','YIQ_1'),1);
      
        RecoloredImage = Recolor_RGB_1(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','RGB_1'),0);
       
        RecoloredImage = Recolor_LAB_1(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','LAB_1'),0);
       
        RecoloredImage = Recolor_LAB_2(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','LAB_2'),0);
       
        RecoloredImage = Recolor_LAB_3(CurrentImage);
        SaveResults(CurrentImage,RecoloredImage,strcat(TestName,'/','LAB_3'),0);
        
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
        
        for j=30:5:40
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

function [ ] =  SaveResults(OriginalPic_RGB , FixedPic_RGB , FigureName, IsYIQ)   
    figure('name',FigureName,'NumberTitle','off');
    subplot(2,2,1), imshow(OriginalPic_RGB), title('Original pic');
    subplot(2,2,2), imshow(protanopes(OriginalPic_RGB)), title('Original pic through protanopes eyes');
    if(IsYIQ == 1)
        subplot(2,2,3), imshow(FixedPic_RGB/256), title('Fixed pic'); 
    else
        subplot(2,2,3), imshow(FixedPic_RGB), title('Fixed pic'); 
    end
    subplot(2,2,4), imshow(protanopes(FixedPic_RGB)), title('Fixed pic through protanopes eyes ');  

    FileName = strcat('Test results/',FigureName);
    saveas(gcf,FileName, 'pdf');
    close gcf;  
end
function [ ] =  CreateTestResultFolder(TestName)
    DataFolder = strcat('Test results/',TestName);
    mkdir(DataFolder)
end





