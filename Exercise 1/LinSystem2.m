function outVect = LinSystem2(inVect)

if sum(size(inVect) ~= [1,16]) >0 
   disp('LinSystem2: Input should be a row vector of length 16');
   return;
end;

outVect = LinSystem(inVect) + fliplr(LinSystem(inVect));

