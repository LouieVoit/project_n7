function [val,J,T] = S( z )
%options=odeset('RelTol',1e-10,'AbsTol',1e-10);
if (length(z)>1)
    h=(z(2)-z(1))/99;
    i=1;
    T=z(1):h:z(2)';
    val=zeros(length(T),1);
    for pas=T
        [~,Y]=ode45(@phi,[0,2],[0;pas]);
        val(i)=Y(size(Y,1),1)-0.5;
        i=i+1;
    end
else 
   [~,Y]=ode45(@phi,[0,2],[0;z]);
    val=Y(size(Y,1),1)-0.5;
    T=[];
[~,YD]=ode45(@phiSV,[-2 2],[0;z;0;1]);
%J=YD(size(YD,1),3);
[~,Yg]=ode45(@phi,[-2 2],[0,z+10^-2]);
[~,Yd]=ode45(@phi,[-2 2],[0,z]);
J=10^2*(Yg(size(Yg,1),1)-Yd(size(Yd,1),1));
end

