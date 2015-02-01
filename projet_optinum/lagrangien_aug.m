function res = lagrangien_aug(f,c,lambda,mu,x)

	res = feval(f,x)-lambda'*feval(c,x)+mu*norm(feval(c,x))^2/2;
