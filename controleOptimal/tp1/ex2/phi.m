function [ res ] = phi( t,y )
%PHI Summary of this function goes here
%   Detailed explanation goes here
res=zeros(4,1);
res(1)=y(2);
if (abs(y(4)/2)<=1)
    res(2)=-y(4)/2;
else
    res(2)=y(4)/abs(y(4));
end
res(3)=0;
res(4)=-y(3);
end

