function d=sqdist(a,b,dist)
% SQDIST - computes squared Euclidean distance matrix
%          computes a rectangular matrix of pairwise distances d
% between points in a (given in columns) and points in b
% dist == 1 : L1, else L2

% NB: very fast implementation taken from Roland Bunschoten

alpha=0.05;
beta=0.95;

if size(b,1)==3 % b(3,:) correspond au niveau de gris
    % distance geometrique
    if dist==1
        %distance geometrique + niveau de gris L1
        aa = sum(a(1:2,:).*a(1:2,:),1); bb = sum(b(1:2,:).*b(1:2,:),1); ab = a(1:2,:)'*b(1:2,:); 
        aaI = sum(a(3,:).*a(3,:),1); bbI = sum(b(3,:).*b(3,:),1); abI = a(3,:)'*b(3,:); 
        %   Distance geometrique + niveau de gris L1
        d = (alpha*abs(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab)+beta*abs(repmat(a(3,:)',[1 size(bbI,2)]) - repmat(b(3,:),[size(aaI,2) 1])));
    else
        % Distance geometrique + niveau de gris L2
        aa = sum(a(1:2,:).*a(1:2,:),1); bb = sum(b(1:2,:).*b(1:2,:),1); ab = a(1:2,:)'*b(1:2,:);
        aaI = sum(a(3,:).*a(3,:),1); bbI = sum(b(3,:).*b(3,:),1); abI = a(3,:)'*b(3,:); 
        d = (alpha*abs(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab)+beta*abs(repmat(aaI',[1 size(bbI,2)]) + repmat(bbI,[size(aaI,2) 1])- 2*abI));
    end
else
    % distance niveau de gris
    if dist==1
        % distance L1
        d= abs(repmat(a',[1 size(b,2)]) - repmat(b,[size(a,2) 1]));   
    else
        %distance L2
        aa = sum(a.*a,1); bb = sum(b.*b,1); ab = a'*b; 
        d = abs(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);%/(std(a)*std(b));
    end
end    

end
