function hess=hess_f1(x)
global nhev;
nhev=nhev+1;
hess(1,1) = 6;
hess(1,2)=2;
hess(2,1)=2;
hess(2,2)=6;
