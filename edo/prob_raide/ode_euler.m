function [T,Y] = ode_euler(phi,t,y0,N)
    h=(t(2)-t(1))/N;
    T=t(1):h:t(2);    
    Y=zeros(N+1,size(y0,2));
    Y(1,:)=y0;
    for i=2:(N+1)
        Y(i,:)=Y(i-1,:)+h*feval(phi,T(i-1),Y(i-1,:));
    end
end

