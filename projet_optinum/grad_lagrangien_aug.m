function res = grad_lagrangien_aug(grad_f,c,jac_c,lambda,mu,x)
	jac_c_x=feval(jac_c,x);
	res = feval(grad_f,x)-jac_c_x'*lambda+mu*jac_c_x'*feval(c,x);
	 
