% function noircir
% black the input image away from the mask m
% It is only to muliply I by max((1+d/D)^deg,MIN)
% INPUT : - m the mask
%         - I the image
%         - deg is the degree of the coefficient
%         - D
%         - MIN treshold to avoid the image to be to dark
% OUTPUT : - I black image
function I = noircir(m,I,deg,D,MIN)

    d = bwdist(m);
    I = double(I);
    Tmp = zeros(size(I,1),size(I,2));
    Tmp(:,:) = MIN;
    for i = 1:3
        I(:,:,i) = max(I(:,:,i).*(1+d/D).^-deg,Tmp);
    end    
    I = uint8(I);

end

