function val = f2(x)
global nfev;
nfev=nfev+1;
val = 100*(x(2)-x(1)^2)^2+(1-x(1))^2;
