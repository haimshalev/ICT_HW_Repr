function [ Temp8 ] = SmoothTransform (Temp1, Temp2,B,C,D)
    [SizeX,SizeY,~] = size(Temp1);
    
    Temp3 = zeros(SizeX,SizeY,3);
    Temp3(:,:,1) = (1)*(Temp2(:,:,1))  +  (0)*(Temp1(:,:,1)) ;
    Temp3(:,:,2) = (1)*(Temp2(:,:,2))  +  (0)*(Temp1(:,:,2)) ;
    Temp3(:,:,3) = (1)*(Temp2(:,:,3))  +  (0)*(Temp1(:,:,3)) ;
    
    Temp4 = zeros(SizeX,SizeY,3);
    Temp4(:,:,1) = (B+C+D)*(Temp2(:,:,1))  +  (1-B-C-D)*(Temp1(:,:,1)) ;
    Temp4(:,:,2) = (B+C+D)*(Temp2(:,:,2))  +  (1-B-C-D)*(Temp1(:,:,2)) ;
    Temp4(:,:,3) = (B+C+D)*(Temp2(:,:,3))  +  (1-B-C-D)*(Temp1(:,:,3)) ;
    
    Temp5 = zeros(SizeX,SizeY,3);
    Temp5(:,:,1) = (C+D)*(Temp2(:,:,1))  +  (1-C-D)*(Temp1(:,:,1)) ;
    Temp5(:,:,2) = (C+D)*(Temp2(:,:,2))  +  (1-C-D)*(Temp1(:,:,2)) ;
    Temp5(:,:,3) = (C+D)*(Temp2(:,:,3))  +  (1-C-D)*(Temp1(:,:,3)) ;
    
    Temp6 = zeros(SizeX,SizeY,3);
    Temp6(:,:,1) = (D)*(Temp2(:,:,1))  +  (1-D)*(Temp1(:,:,1)) ;
    Temp6(:,:,2) = (D)*(Temp2(:,:,2))  +  (1-D)*(Temp1(:,:,2)) ;
    Temp6(:,:,3) = (D)*(Temp2(:,:,3))  +  (1-D)*(Temp1(:,:,3)) ;
    
    Temp7 = zeros(SizeX,SizeY,3);
    Temp7(:,:,1) = (0)*(Temp2(:,:,1))  +  (1)*(Temp1(:,:,1)) ;
    Temp7(:,:,2) = (0)*(Temp2(:,:,2))  +  (1)*(Temp1(:,:,2)) ;
    Temp7(:,:,3) = (0)*(Temp2(:,:,3))  +  (1)*(Temp1(:,:,3)) ;
       
    Temp8 = cat(2,Temp3,Temp4,Temp5,Temp6,Temp7);
end