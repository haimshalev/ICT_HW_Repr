function [ ] = SaveResults(OriginalPic_RGB , FixedPic_RGB , FigureName, IsYIQ,ColorBlindType)   
    if ColorBlindType == 1      
        SubPlotName = ' protanopes ';
    elseif ColorBlindType == 2   
        SubPlotName = ' deuteranopes '; 
    elseif ColorBlindType == 3   
        SubPlotName = ' tritanopic ';
    else
        SubPlotName = '0';
    end


    figure('name',FigureName,'NumberTitle','off');
    subplot(2,2,1), imshow(OriginalPic_RGB), title('Original pic');
    subplot(2,2,2), imshow(simulateColorBlindImage(ColorBlindType,OriginalPic_RGB)), title(strcat('Original pic through ',SubPlotName,' eyes'));
    if(IsYIQ == 1)
        subplot(2,2,3), imshow(FixedPic_RGB/256), title('Fixed pic'); 
    else
        subplot(2,2,3), imshow(FixedPic_RGB), title('Fixed pic'); 
    end
    subplot(2,2,4), imshow(SimulateColorBlindImage(ColorBlindType,FixedPic_RGB)), title(strcat('Fixed pic through through ',SubPlotName,' eyes'));  

    FileName = strcat('Test results/',FigureName);
    saveas(gcf,FileName, 'jpg');
    %close gcf;  
end

