
function s = approche(f,grad,hess,x,d,c1,c2)
    function res = phi(s)
        res = feval(f,x+s*d);
    end
    function res = phi_der(s)
        res=d'*feval(grad,x+s*d);
    end
    function s = finition(smin, smax)
        continuer=true;
        while continuer
            if (smin<=smax)
                sj=smin+bissection(f, grad, hess, x+smin*d, d, c1, c2); %choisir sj
            else
                sj=smin-bissection(f, grad, hess, x+smin*d, -d, c1, c2); %choisir sj
            end
            if phi(sj) > phi(0) + c1*sj*phi_der(0) || phi(sj) >= phi(smin)
                smax = sj;
            else
                if norm( phi_der(sj) ) <= -c2*phi_der(0)
                    s=sj;
                    continuer=false;
                else
                    if phi_der(sj)*(smax-smin) >= 0
                        smax=smin;
                        smin=sj;
                    else
                        smin=sj;
                    end
                end
            end
        end
    end
s1=0.1;
smax=1;
s0=0;    
i=0;
continuer=true;
while continuer
    if (phi(s1)>phi(0)+c1*s1*phi_der(0) || (i>1 && phi(s1)>=phi(s0)))
        s=finition(s0,s1);
        continuer=false;
    elseif (abs(phi_der(s1))<=-c2*phi_der(0))
        s=s1;
        continuer=false;
    elseif (phi_der(s1)>=0)
        s=finition(s1,s0);
        continuer=false;
    else
        i=i+1;
        s_aux=s1;
        s1=(s1+smax)/2;
        s0=s_aux;
        s=s0;
    end
end
end



