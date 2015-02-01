function [ res ] = bernstein( n,i,t )
    res = factorial(n)/(factorial(i)*factorial(n-i));
    res=res*(t.^i).*(1-t).^(n-i);
end

