function grad=grad_f2(x)
global ngev;
ngev=ngev+1;
grad=zeros(2,1);
grad(1,1)=-200*2*x(1)*(x(2)-x(1)^2)-2*(1-x(1));
grad(2,1)=200*(x(2)-x(1)^2);
