function [ D ] = Dphi( t,y )
%DPHI Summary of this function goes here
%   Detailed explanation goes here
D=-eye(2);
r=1-abs(y(2));
D(1,2)=( -2*0.01*(1+(r/sqrt(r^2+4*0.01^2)))/(r+2*0.01+sqrt(r^2+4*0.01^2))^2 );

end

