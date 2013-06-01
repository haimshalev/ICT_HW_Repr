%Zahi Kfir          200681476
%Haim Shalelashvili 200832780

function [Normalized] = NormalizeIlluminants(Illuminants)
%Returns a normalized illuminants matrix

%Initialize the output matrix
Normalized = zeros(size(Illuminants));

%Iterate over all illuminants
for i=1:size(Illuminants,2)
    
    %Check if we don't divide in zero
    if (max(Illuminants(:,i)) - min(Illuminants(:,i)) ~= 0)
        
        %Build a normalized matrix
        Normalized(:,i) = (Illuminants(:,i) - min(Illuminants(:,i)))/ ...
            (max(Illuminants(:,i)) - min(Illuminants(:,i)));
        
    end
end

end