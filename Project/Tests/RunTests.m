% Test....

function [ ] = RunTests()
    close all;

    TestImagesList = dir('Test subjects/*.bmp');  % run this command from "Tests" folder
    ImagesCount = length(TestImagesList);    % Number of files found
    
    %Test_Recoloring(TestImagesList,ImagesCount);
    
    %Test_RedRecognotion1(TestImagesList,ImagesCount);
    %Test_RedRecognotion2(TestImagesList,ImagesCount);
    
    %Test_Daltonize_1(TestImagesList,ImagesCount);
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
        
        disp(strcat('done recolor-testing:_',CurrentImageName));
    end
    disp('finished all recolor-Testing');
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
        disp(strcat('done RedRecognotion1-testing:_',CurrentImageName));
    end
    disp('finished all RedRecognotion1-Testing');
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
        disp(strcat('done RedRecognotion2-testing:_',CurrentImageName));
    end
    disp('finished all RedRecognotion2-Testing');
end

function [ ] = Test_Daltonize_1(TestImagesList,ImagesCount)   
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        CurrentImage = imread(CurrentImageName);
       
        TestName = strcat('Daltonize/Daltonize 1/',strrep(CurrentImageName,'.bmp',''));      
        CreateTestResultFolder(TestName);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_YIQ_1(CurrentImage));
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','YIQ_1'),1);
              
        FixedPic = Daltonize_1(CurrentImage,Recolor_RGB_1(CurrentImage));
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','RGB_1'),1);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_LAB_1(CurrentImage));
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','LAB_1'),1);
       
        FixedPic = Daltonize_1(CurrentImage,Recolor_LAB_2(CurrentImage));
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','LAB_2'),1);
        
        FixedPic = Daltonize_1(CurrentImage,Recolor_LAB_3(CurrentImage));
        SaveResults(CurrentImage,FixedPic,strcat(TestName,'/','LAB_3'),1);
        disp(strcat('done daltonize1-testing:_',CurrentImageName));
    end
    disp('finished all daltonize1-Testing');
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





