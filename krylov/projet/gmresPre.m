function [x, flag, relres, iter, resvec] = gmresPre(A, b, x0, tol, maxit, M1, M2)
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
     while (~convergence) && (j<maxit)
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
         j=j+1;
     end
    
     iter=j-1;
     relres=(norm(b-A*x)/normB);
     flag= (j>=maxit);
end
