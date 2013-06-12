function [ ] = SaveResults(OriginalPic_RGB , FixedPic_RGB , FigureName, IsYIQ)   
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
    saveas(gcf,FileName, 'jpg');
    close gcf;  
end

