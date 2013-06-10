%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [  ] = Q7(  )
    
    %% A:
      
    %# read images
    MacbethUnderIllum_X = imread('macbethUnderIllumX.jpg'); 
    MacbethUnderIllum_Y = imread('macbethUnderIllumY.jpg');
    
    %# reshape into 2 dimensions matrixes 
    MacbethUnderIllum_X_3X24 = double(reshape(MacbethUnderIllum_X, 24, 3))';
    MacbethUnderIllum_Y_3X24 = double(reshape(MacbethUnderIllum_Y, 24, 3))';
    
    %# claculate the transformation matrix
    M = MacbethUnderIllum_Y_3X24*pinv(MacbethUnderIllum_X_3X24);

    %% B:
  
    %Getting the white surface from each image
    whiteSurface_X = MacbethUnderIllum_X_3X24(: , 24);
    whiteSurface_Y = MacbethUnderIllum_Y_3X24(: , 24);
    
    %Calculating the diagonal transformation matrix using Von Kries Coefficient Law
    M2 = diag(whiteSurface_Y./whiteSurface_X);
    
    
    %% Display Results
    
    % MacbethUnderIllum X
    figure('Name','MacbethUnderIllum X');
    display_colors(MacbethUnderIllum_X_3X24/256);
    
    % MacbethUnderIllum Y
    figure('Name','MacbethUnderIllum Y');
    display_colors(MacbethUnderIllum_Y_3X24/256);
    
    % Direct Mapping Transfirmation Matrix * MacbethUnderIllumX 
    figure('Name','Direct Mapping Transfirmation Matrix * MacbethUnderIllumX');
    display_colors((M*MacbethUnderIllum_X_3X24)/256);
    
    % Von Kries Transformation Matrix * MacbethUnderIllumX 
    figure('Name','Von Kries Transformation Matrix * MacbethUnderIllumX');
    display_colors((M2*MacbethUnderIllum_X_3X24)/256);

end


