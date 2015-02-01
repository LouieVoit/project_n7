function [minf,f_minf,c,nbIter] = prob_cont(f,grad_f,hess_f,c,jac_c,x0,lambda0,mu0,tau,epsilon)

    tic
	lambda = lambda0;
	mu=mu0;
	x=x0;
    nbIter=0;
	x = bfgs(@(x) lagrangien_aug(f,c,lambda,mu,x),@(x) grad_lagrangien_aug(grad_f,c,jac_c,lambda,mu,x),eye(2),x,tau,@backtracking,0.6,0.7,10000,0);
	while ( feval(c,x)>epsilon || norm(feval(grad_f,x)-lambda*feval(jac_c,x)')>epsilon )
        lambda = lambda-mu*feval(c,x);
		mu=10*mu;
        x = bfgs(@(x) lagrangien_aug(f,c,lambda,mu,x),@(x) grad_lagrangien_aug(grad_f,c,jac_c,lambda,mu,x),eye(2),x,tau,@backtracking,0.6,0.7,10000,0);
        nbIter=nbIter+1;
    end
	minf = x;
	f_minf = feval(f,minf);
    c=feval(c,x);
    disp(['   x_min = ' mat2str(minf)]) ;
    disp(['   f(x_min) = ' num2str(f_minf)]) ;
    disp(['   contraintes = ' num2str(c)]) ;
    disp(['   nbIter = ' num2str(nbIter)]) ;
    toc