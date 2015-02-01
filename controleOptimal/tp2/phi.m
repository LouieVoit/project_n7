function [ res ] = phi( t,y )
%PHI Summary of this function goes here
%   Detailed explanation goes here
res=zeros(2,1);
res(1)=-y(1);
p=y(2);
if p~=0
    r=1-abs(p);
    res(1)=res(1)+(-2*0.01*(p/abs(p)))/(r+2*0.01+sqrt(r^2+4*0.01^2));
else
    res(1)=res(1)+2*0.01/(1+2*0.01+sqrt(1+4*0.01^2));
end
res(2)=-y(2);

