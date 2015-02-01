function [minf,f_minf,nbIter] = min_grad(f,grad,hess,x0,epsilon,pas,c1,c2,nbIterMax)

tic
nbIter=0;
x=x0;
x_old=x0+2*epsilon;
d=-feval(grad,x);

while (norm(d)>epsilon && nbIter<nbIterMax) 
    % l'argument aprés grad correspond a la valeur du pas lorsque le pas
    % est constant (c'est pas trés propre...)
	alpha = feval(pas,f,grad,d'*d/(d'*feval(hess,x)*d),x,d,c1,c2);
	x_old=x;
	x=x+alpha*d;
	nbIter=nbIter+1;
	d=-feval(grad,x);
end
minf=x;
f_minf=feval(f,x);
disp(['   x_min = ' mat2str(minf)]) ;
disp(['   f(x_min) = ' num2str(f_minf)]) ;
disp(['   nbIter = ' num2str(nbIter)]) ;
toc

