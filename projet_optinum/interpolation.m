function s = interpolation(f,grad,hess,x,d,s0,c1)
    function res = phi(s)
        res = feval(f,x+s*d);
    end
    function res = phi_der(s)
        res=d'*feval(grad,x+s*d);
    end

w0 = phi(s0)>phi(0)+c1*s0*phi_der(0);
if (w0)
    s1 = (-phi_der(0)*s0^2)/(2*(phi(s0)-phi(0)-s0*phi_der(0)));
    w0 = phi(s1)>phi(0)+c1*s1*phi_der(0);
    while (w0)
        v=[s0^2,-s1^2;-s0^3,s1^3]*[phi(s1)-phi(0)-phi_der(0)*s1;phi(s0)-phi(0)-phi_der(0)*s0]/(s0^2*s1^2*(s1-s0));
        a=v(1);
        b=v(2);
        if (a~=0)
            s2 = (-b+sqrt(b^2-3*a*phi_der(0)))/(3*a);
            w0 = phi(s2)>phi(0)+c1*s2*phi_der(0);
            s0=s1;
            s1=s2;
        else
            w0=0;
        end
    end
    s=s1;
else
    s=s0;
end
end

