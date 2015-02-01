function [X,Y] = subdivision(Xi,Yi)
    n=length(Xi);
    X=zeros(1,n+1);
    Y=zeros(1,n+1);
    X(1)=Xi(1);
    Y(1)=Yi(1);
    X(n+1)=Xi(n);
    Y(n+1)=Yi(n);
    for i=2:n
            X(i)=(1-i/(n+1))*Xi(i)+(i/(n+1))*Xi(i-1);
            Y(i)=(1-i/(n+1))*Yi(i)+(i/(n+1))*Yi(i-1);
    end
end

