function hess = hess_f2(x)
global nhev;
nhev=nhev+1;
hess(1,1)=1200*x(1)^2-400*x(2)+2;
hess(1,2)=-400*x(1);
hess(2,1)=hess(1,2);
hess(2,2)=200;
