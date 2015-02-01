function grad = grad(x)
global ngev;
ngev=ngev+1;
grad=zeros(2,1);
grad(1,1)=4*(x(1)+x(2)-2)+2*(x(1)-x(2));
grad(2,1)=4*(x(1)+x(2)-2)-2*(x(1)-x(2));

