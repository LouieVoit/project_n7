function res = pas_constant(f,grad,hess,x,d,c1,c2)
   % res=d'*d/(d'*feval(hess,x)*d)
    res = hess;