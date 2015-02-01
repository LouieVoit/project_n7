function [ i,j ] = unmap( l,n )
    i=mod(l,n);
    if (i==0)
        i=n;
    end
    j=1+(l-i)/n;
end

