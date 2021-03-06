function [x, flag, relres, iter, resvec, resvect] = krylov(A, b, x0, tol, maxit, type)
     x=x0;
     r=b-A*x;
     beta=norm(r);
     normb=norm(b);
     V(:,1)=b/norm(b);
     j=1;
     resvec(j)=norm(r);
     while (j<maxit && (resvec(j)/normb>tol))
         w=A*V(:,j);
         for i=1:j
             H(i,j)=V(:,i)'*w;
             w=w-H(i,j)*V(:,i);
         end
         H(j+1,j)=norm(w);
         if (H(j+1,j)==0)
             j=maxit+1;
         else
             V(:,j+1)=w/H(j+1,j);
             if (type==0)
                 e=zeros(j,1);e(1)=1;
                 y=H(1:j,:)\(beta*e);
                 resvect(j+1)=H(j+1,j)*abs(y(j));
             else
                 e=zeros(j+1,1);e(1)=1;
                 [gamma,R]=qr(sparse(H),beta*e);
                 y=R\(gamma);
                 resvect(j+1)=abs(gamma(j+1));
             end
         end
         x=x0+V(:,1:j)*y;
         resvec(j+1) = norm(b -A*x);  
         j=j+1;
    end
     iter=j-1;
     relres=resvec(j-1);
     flag= (j>=maxit);
end