function [minf,f_minf,nbIter] = bfgs(f,grad,B0,x0,epsilon,pas,c1,c2,nbIterMax,affichage)
  
if (affichage)
    tic
end
nbIter=0;
x=x0;
grad_f=feval(grad,x);
B=B0;

while (norm(grad_f)>epsilon && nbIter<nbIterMax)
	d=-B*grad_f;
	%Recherche linéaire du pas (1 correspond a la valeur du pas lorsque le pas est contant)   
	alpha=feval(pas,f,grad,1,x,d,c1,c2);
	x=x+alpha*d;
	%Fin recherche linéaire
	y=feval(grad,x)-grad_f;
	if (y~=0)
	B=B+((alpha*d-B*y)*d'+d*(alpha*d-B*y)')/(d'*y)-((alpha*d-B*y)'*y/(d'*y)^2)*d*d';
	end
	nbIter=nbIter+1;
	grad_f=feval(grad,x);
end
minf=x;
f_minf=feval(f,x);
if (affichage)
    disp(['   x_min = ' mat2str(minf)]) ;
    disp(['   f(x_min) = ' num2str(f_minf)]) ;
    disp(['   nbIter = ' num2str(nbIter)]) ;
    toc
end
end
