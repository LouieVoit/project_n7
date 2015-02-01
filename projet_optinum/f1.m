function val = f1(x)
global nfev;
nfev=nfev+1;
val = 2*(x(1)+x(2)-2)^2+(x(1)-x(2))^2;
