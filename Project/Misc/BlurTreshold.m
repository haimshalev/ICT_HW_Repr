function [ BlurIand ] = BlurTreshold( Iand )
    
   WindowSize = 3;
   
   s =  size(Iand);
   
   BlurIand = zeros(size(Iand));
   
   for i = (WindowSize : s(1)-WindowSize)
       for j = (WindowSize : s(2)-WindowSize)
        
           window = Iand(i-WindowSize+1 : i+WindowSize , j-WindowSize+1:j+WindowSize);
          
           if (sum(window(:)) > 8*((2*WindowSize).^2)/10)
                BlurIand(i-WindowSize+1 : i+WindowSize , j-WindowSize+1:j+WindowSize) = ones(size(window));
           end
           
       end
   end
end


