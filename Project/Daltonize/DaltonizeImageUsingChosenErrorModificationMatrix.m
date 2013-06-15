function [ Ifinal , fileinfo , folderInfo ] = DaltonizeImageUsingChosenErrorModificationMatrix( OriginalPic_RGB , ErrModificationMatrix)

%% Initializing stage

%Display Figures for debuging
dispFig = 0;

%% Algorithm 

I1 = double(OriginalPic_RGB);
if (dispFig), figure('Name','I1');imshow(uint8(I1)); end

%Simulating what protanopes people see
I2 = protanopes(I1);
if (dispFig), figure('Name','I2');imshow(uint8(I2));end

%calculate errors between two RGB values
E = abs(I1 - double(I2));
if (dispFig),figure('Name','E');imshow(uint8(E));end
    
%Creating a binary mask  - ones in the places that needs daltonize and
%zeros in the rest
Iand = (E > 55);
Iand = Iand(:,:,1) | Iand(:,:,2) | Iand(:,:,3);
Iand = repmat(Iand , [1 1 3]);
if (dispFig), figure('Name','Iand');imshow(uint8(Iand*255));end

%Finding the image that needs to daltonized
I3 = I1 .* Iand;
if (dispFig), figure('Name','I3');imshow(uint8(I3));end

%Finding the correct image - the complement of I3
Icorrect = I1 .* ~Iand;
if (dispFig), figure('Name','Icorrect');imshow(uint8(Icorrect));end

%Simulate the image shown by dichromats
DichI3 = protanopes(I3);

%calculate errors between two RGB values
errorp = abs(I3 - double(DichI3));
    
%Run daltonize function on the image that needs daltonize (I3)
I4 = RecoloreUsingErrorModification(I3 ,errorp, ErrModificationMatrix);
if (dispFig), figure('Name','I4');imshow(uint8(I4));end

%% Create the final Image (addding in our case is join because the mask
%created zeroed cells
Ifinal = uint8(Icorrect) + uint8(I4);
if (dispFig), figure('Name','Ifinal');imshow(uint8(Ifinal)); end

end