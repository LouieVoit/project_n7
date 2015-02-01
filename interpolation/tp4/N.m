function [ res ] = N(t,i,k)
    if (t<i || t>=(i+k))
        res = 0;
    elseif (k==1)
        res=1;
    else
        res = (t-i)*N(t,i,k-1)/(k-1) + (i+k-t)*N(t,i+1,k-1)/(k-1);
    end
end

