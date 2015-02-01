function [minf,f_minf,nbIter] = min_newton(f,grad,hess,x0,epsilon,nbIterMax)

tic
nbIter=0;
x=x0;
grad_f=feval(grad,x);

while (norm(grad_f)>epsilon & nbIter<nbIterMax) 
	hess_inv = pinv(feval(hess,x));
	d=-hess_inv*grad_f;
	x=x+d;
	nbIter=nbIter+1;
	grad_f=feval(grad,x);;
end
minf=x;
f_minf=feval(f,x);
disp(['   x_min = ' mat2str(minf)]) ;
disp(['   f(x_min) = ' num2str(f_minf)]) ;
disp(['   nbIter = ' num2str(nbIter)]) ;
toc



