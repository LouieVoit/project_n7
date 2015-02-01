function [x, flag, relres, iter, resvec] = gmresRes(A, b, x0, m, maxit, tol, M1, M2)
     x=x0;
     r=M2\(M1\(b-A*x));
     beta=norm(r);
     normRHS=norm(M2\(M1\b));
     normR=beta;
     normB=norm(b);
     V(:,1)=r/norm(r);
     j=1;
     resvec(j)=norm(r);
     convergence=0;
     while (j<maxit) && (j<=m) && (~convergence)
         w=M2\(M1\(A*V(:,j)));
         for i=1:j
             H(i,j)=V(:,i)'*w;
             w=w-H(i,j)*V(:,i);
         end
         H(j+1,j)=norm(w);
         if (H(j+1,j)==0)
             j=maxit+1;
         else
             V(:,j+1)=w/H(j+1,j);
             e=zeros(j+1,1);e(1)=1;
             [gamma,R]=qr(sparse(H),beta*e);
             y=R\(gamma);
             resvec(j+1)=abs(gamma(j+1));
             normR=resvec(j+1);
         end
         x = x0 + V(:,1:j)*y;
         if (normR/normRHS <= tol)
             convergence = (norm(b-A*x)/normB)<=tol;
         end
         % Cas ou la methode stagne
         if abs(resvec(j+1)-resvec(j))<=1e-12
             convergence=2;
         end
         j=j+1;
     end
    iter=j-1;
    relres=norm(M2\(M1\(b-A*x)))/norm(M2\(M1\b));
    flag= (j>=maxit);
    if (~convergence && j<maxit)
        [x,flag,relres,iter_aux,resvec_aux]=gmresRes(A,b,x,m,maxit-m,tol,M1,M2);
        iter=iter+iter_aux;
        resvec=[resvec,resvec_aux];
    end    
    if (convergence==2)
         flag=2;
     end
end
