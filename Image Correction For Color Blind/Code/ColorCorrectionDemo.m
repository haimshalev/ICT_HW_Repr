function [ ] = ColorCorrectionDemo()
%# Plot Foreach one of the 3 Demo images:   
%# Color blind simulation image for Protanopes , Deuteranopes and Tritanopic
%# Daltonize image for Protanopes , Deuteranopes and Tritanopic
%# Daltonized simulate image for Protanopes , Deuteranopes and Tritanopic 
    
    %# Turn all warnings off 
    warning ('off','all');
    
    % add all necessary files to matlab path
    addpath(genpath('Misc'));
    AddMandatoryFolders();
    
    % Read Demo images
    RainbowFishes_RGB = imread('../Data/Input Images/Rainbow Fishes.bmp');
    Gaugin_RGB = imread('../Data/Input Images/Gaugin.bmp');
    Flowers_RGB = imread('../Data/Input Images/Flowers.bmp');
    
    % Color Blind Fix And Plot Demo images for Protanopes , Deuteranopes and Tritanopic 
    ColorBlindFixAndPlot(RainbowFishes_RGB, 'Ranibow Fishes');
    ColorBlindFixAndPlot(Gaugin_RGB, 'Gaugin');
    ColorBlindFixAndPlot(Flowers_RGB, 'Flowers');
end



function [ ] = ColorBlindFixAndPlot(OriginalImage_RGB, FigureName) 
%# input: RGB image
%# plot color blind simulation image for Protanopes , Deuteranopes and Tritanopic
%# plot daltonize image for Protanopes , Deuteranopes and Tritanopic
%# plot daltonized simulate image for Protanopes , Deuteranopes and Tritanopic


    % simulate color blinds for Protanopes , Deuteranopes and Tritanopic
    ProtanopesSimulated = SimulateColorBlindImage(1,OriginalImage_RGB);
    DeuteranopesSimulated = SimulateColorBlindImage(2,OriginalImage_RGB);
    TritanopicSimulated = SimulateColorBlindImage(3,OriginalImage_RGB);
    
    % Daltonize for Protanopes , Deuteranopes and Tritanopic
    ProtanopesDaltonized = ColorBlindFix(1,OriginalImage_RGB);
    DeuteranopesDaltonized = ColorBlindFix(2,OriginalImage_RGB);
    TritanopicDaltonized = ColorBlindFix(3,OriginalImage_RGB);
    
    % simulate daltonize image for Protanopes , Deuteranopes and Tritanopic
    ProtanopesDaltonizeSimulated = SimulateColorBlindImage(1,ProtanopesDaltonized);
    DeuteranopesDaltonizeSimulated = SimulateColorBlindImage(2,DeuteranopesDaltonized);
    TritanopicDaltonizeSimulated = SimulateColorBlindImage(3,TritanopicDaltonized);
    
    % plot results
    hFig = figure('Name',FigureName,'NumberTitle','off');
    set(hFig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);  
   
    A = 0.02;
    B = 0.02;
    C = 0.02;
    subaxis(4,3,2, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(OriginalImage_RGB),        title('Original Image');
    
    subaxis(4,3,4, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(ProtanopesSimulated),      title('Protanopes Simulated');
    subaxis(4,3,5, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(DeuteranopesSimulated),    title('Deuteranopes Simulated');
    subaxis(4,3,6, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(TritanopicSimulated),      title('Tritanopic Simulated');
    
    subaxis(4,3,7, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(ProtanopesDaltonized),     title('Protanopes Daltonized');
    subaxis(4,3,8, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(DeuteranopesDaltonized),   title('Deuteranopes Daltonized');
    subaxis(4,3,9, 'Spacing', C, 'Padding', B, 'Margin', A);  imshow(TritanopicDaltonized),     title('Tritanopic Daltonized');
    
    subaxis(4,3,10, 'Spacing', C, 'Padding', B, 'Margin', A); imshow(ProtanopesDaltonizeSimulated),     title('Protanopes Daltonize Simulated');
    subaxis(4,3,11, 'Spacing', C, 'Padding', B, 'Margin', A); imshow(DeuteranopesDaltonizeSimulated),   title('Deuteranopes Daltonize Simulated');
    subaxis(4,3,12, 'Spacing', C, 'Padding', B, 'Margin', A); imshow(TritanopicDaltonizeSimulated),     title('Tritanopic Daltonize Simulated');
       
    axis off;   
end






















