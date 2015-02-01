function [T,Y,nphi,ifail] = ode_gauss(phi,t,y0,option)
    N=option(1);
    h=(t(2)-t(1))/N;
    T=t(1):h:t(2);    
    Y=zeros(N+1,size(y0,2));
    Y(1,:)=y0;
    c=[0.5-sqrt(3)/6 0.5+sqrt(3)/6];
    a=[1/4 1/4-sqrt(3)/6;
       1/4+sqrt(3)/6 1/4];
    b=[1/2 1/2];
    nphi=0;
    ifail=zeros(1,N)-1;
    for i=2:(N+1)
       k1=feval(phi,T(i-1)+c(1)*h,Y(i-1,:));
       k2=feval(phi,T(i-1)+c(2)*h,Y(i-1,:));
       nphi=nphi+2;
       normprog=1;
       nbiter=0;
       while (normprog>option(3) && nbiter<=option(2))
           newk1=feval(phi,T(i-1)+c(1)*h,Y(i-1,:)+h*(a(1,1)*k1+a(1,2)*k2));
           newk2=feval(phi,T(i-1)+c(2)*h,Y(i-1,:)+h*(a(2,1)*k1+a(2,2)*k2));
           nphi=nphi+2;
           normprog=norm([newk1-k1;newk2-k2]);
           k1=newk1;
           k2=newk2;
           nbiter=nbiter+1;
       end
       if (nbiter>option(2))
           ifail(i)=1;
       end
       Y(i,:)=Y(i-1,:)+h*(b(1)*k1+b(2)*k2);    
    end
end

