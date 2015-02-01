function [x, flag, relres, iter, resvec] = dqgmres(A, b, x0, k, maxit, tol,M1,M2)
     x=x0;
     r=M2\(M1\(b-A*x));
     beta=norm(r);
     V(:,1)=r/beta;
     normRHS=norm(M2\(M1\b));
     normR=beta;
     normB=norm(b);
     j=1;
     resvec(j)=beta;
     convergence=0;
     %Variables utiles pour la facto QR
     gamma2=beta;
     while (~convergence) && (j<maxit) 
         w=M2\(M1\(A*V(:,j)));
         for i=max(1,j-k+1):j
             H(i,j)=V(:,i)'*w;
             w=w-H(i,j)*V(:,i);
         end
         H(j+1,j)=norm(w);
         if (H(j+1,j)==0)
             j=maxit+1;
         else
             %Calcul du nouveau vecteur de la base
             V(:,j+1)=w/H(j+1,j);
             %Mise a jour de la factorisation QR par les matrices de Givens
             for i=max(1,j-k):j-1
                 %On recréé la matrice de rotation de Givens a partir du
                 %vecteur stockant les coefficients des matrices de Givens
                 c=giv(1,i);
                 s=giv(2,i);
                 aux=eye(j);
                 aux(i,i)=c;aux(i+1,i+1)=c;aux(i+1,i)=-s;aux(i,i+1)=s;
                 H(1:j,j)=aux*H(1:j,j);
             end
             %On calcul les nouveaux coefficients des matrices de Givens
             c=H(j,j)/sqrt(H(j,j)^2+H(j+1,j)^2);
             s=H(j+1,j)/sqrt(H(j,j)^2+H(j+1,j)^2);
             giv(1,j)=c;
             giv(2,j)=s;
             %On fait l'inrémentation de la factor QR de H
             gamma1=c*gamma2;
             gamma2=-s*gamma2;
             H(j,j)=c*H(j,j)+s*H(j+1,j);
             H(j+1,j)=0;
             if (j>1)
                P(:,j)=(V(:,j)-P*H(1:j-1,j))/H(j,j);
             else
                P(:,j)=V(:,j)/H(j,j); 
             end
             %On incremente x
             x=x+gamma1*P(:,j);
         end
         resvec(j+1)=abs(gamma2);
         normR=resvec(j+1);
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
     relres=(norm(b-A*x)/normB);
     flag= (j>=maxit);
     if (convergence==2)
         flag=2;
     end
end