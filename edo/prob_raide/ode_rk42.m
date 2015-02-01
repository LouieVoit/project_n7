function [T,Y] = ode_rk42(phi,t,y0,N)
    h=(t(2)-t(1))/N;
    T=t(1):h:t(2);    
    Y=zeros(N+1,size(y0,2));
    Y(1,:)=y0;
    for i=2:(N+1)
        k1=feval(phi,T(i-1),Y(i-1,:));
        k2=feval(phi,T(i-1)+h/3,Y(i-1,:)+(h/3)*k1);
        k3=feval(phi,T(i-1)+(2*h/3),Y(i-1,:)-(h/3)*k1+h*k2);
        k4=feval(phi,T(i-1)+h,Y(i-1,:)+h*k1-h*k2+h*k3);
        Y(i,:)=Y(i-1,:)+(h/8)*k1+(3*h/8)*k2+(3*h/8)*k3+(h/8)*k4;
    end
end

