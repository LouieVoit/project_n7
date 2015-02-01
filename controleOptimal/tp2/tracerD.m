function tracerD()
    %10^-2 et 10^-4
    T=-2:4/99:2;
    D2=[];
    D1=[];
    for pas=T
        [~,Yg]=ode45(@phi,[-2 2],[0,pas+10^-2]);
        [~,Yd]=ode45(@phi,[-2 2],[0,pas]);
        D1=[D1,10^2*(Yg(size(Yg,1),1)-Yd(size(Yd,1),1))];
        [~,Yg]=ode45(@phi,[-2 2],[0,pas+10^-4]);
        [~,Yd]=ode45(@phi,[-2 2],[0,pas]);
        D2=[D2,10^4*(Yg(size(Yg,1),1)-Yd(size(Yd,1),1))];
    end
    %Systeme variationnel
    D3=[];
    for pas=T
        [~,YD]=ode45(@phiSV,[-2 2],[0;pas;0;1]);
        D3=[D3;YD(size(YD,1),3)];
    end
    plot(T,D1,T,D2,T,D3);    
end

