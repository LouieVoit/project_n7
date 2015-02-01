function [ res ] = phi( t,y )
%PHI Summary of this function goes here
%   Detailed explanation goes here
res=zeros(2,1);
res(2)=y(2);
if (abs(y(2))<=2)
    res(1)=-y(1)-y(2)/2;
else
    res(1)=-y(1)-y(2)/abs(y(2));
end

end

