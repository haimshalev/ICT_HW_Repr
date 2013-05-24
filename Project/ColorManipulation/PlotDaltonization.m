function [ ] = PlotDaltonization(OriginalPic_RGB , FixedPic_RGB, FigureName)

figure('name',FigureName);
subplot(2,2,1), imshow(OriginalPic_RGB), title('Original pic');
subplot(2,2,2), imshow(protanopes(OriginalPic_RGB)), title('Original pic through protanopes eyes');
subplot(2,2,3), imshow(FixedPic_RGB), title('Fixed pic');
subplot(2,2,4), imshow(protanopes(FixedPic_RGB)), title('Fixed pic through protanopes eyes ');

end