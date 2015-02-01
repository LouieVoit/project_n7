function [ aire, barycentre ] = triangleValeur( sommets,coordinates)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    A=coordinates(sommets(1),1:2);
    B=coordinates(sommets(2),1:2);
    C=coordinates(sommets(3),1:2);
    a=norm(B'-C');
    b=norm(A'-C');
    c=norm(B'-A');
    p=(a+b+c)/2;
    aire=sqrt(p*(p-a)*(p-b)*(p-c));
    barycentre=[(A(1)+B(1)+C(1))/3,(A(2)+B(2)+C(2))/3];
    

end

