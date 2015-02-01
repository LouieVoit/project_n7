function [ res ] = phiSV( t,y )
%PHISV Summary of this function goes here
%   Detailed explanation goes here
res=zeros(4,1);
res(1:2,1)=phi(t,y(1:2));
res(3:4,1)=Dphi(t,y(1:2))*[y(3);y(4)];

end

