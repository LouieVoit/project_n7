function s =  bissection(f,grad,hess,x,d,c1,c2)

alpha=0;
beta=inf;
s=1;
w1 = (feval(f,x+s*d)>(feval(f,x)+c1*s*feval(grad,x)'*d));
w2 = feval(grad,x+s*d)'*d<c2*feval(grad,x)'*d;

while (w1 || w2)
	if (w1) 
		beta=s;
		s=0.5*(alpha+beta);
	else
		if isinf(beta) 
			alpha=s;
			s=2*alpha;
       		else
			s=0.5*(alpha+beta);
		end
	end
	w1 = feval(f,x+s*d)>(feval(f,x)+c1*s*feval(grad,x)'*d);
	w2 = feval(grad,x+s*d)'*d<c2*feval(grad,x)'*d;
end 



