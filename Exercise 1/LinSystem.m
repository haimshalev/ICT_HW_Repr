function outVect= LinSystem(inVect)
%
% A linear system.
% Input is a row vector of length 16 , out put is vector of length 16.
%
% No additional information provided on function - on purpose.
%

if sum(size(inVect) ~= [1,16]) >0 
   disp('Input should be a row vector of length 16');
   return;
end;

large = inVect;
%small = [0.6408    0.1909    0.8439    0.1909    0.6408];
small = [   0.1131    0.8121    0.9083    0.1564    0.1221];


ly = size(large,1);
lx = size(large,2);
sy = size(small,1);
sx = size(small,2);
sy2 = floor(sy/2);
sx2 = floor(sx/2);

clarge = [ 
    large(ly-sy2+1:ly,lx-sx2+1:lx), large(ly-sy2+1:ly,:), ...
	large(ly-sy2+1:ly,1:sx-sx2-1); ...
    large(:,lx-sx2+1:lx), large, large(:,1:sx-sx2-1); ...
    large(1:sy-sy2-1,lx-sx2+1:lx), ...
	large(1:sy-sy2-1,:), ...
	large(1:sy-sy2-1,1:sx-sx2-1) ];
outVect= conv2(clarge,small,'valid');