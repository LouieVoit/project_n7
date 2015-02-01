function res = spline(k)
    [x,y]=saisi_points;
    %res=zeros(2,length(x)/0.1);
    nodes=0:(length(x)-1+k);
    nodes(1:k)=0;
    nodes((k+1):(length(nodes)-k))=1:(length(nodes)-2*k);
    nodes((length(nodes)-k+1):length(nodes))=nodes(length(nodes)-k);
    nodes
    n=1;
    for t=nodes(k-1):0.1:(nodes(length(x)))
        p=[0;0];
        for m=1:length(x)
            p=[x(m);y(m)]*N(t,nodes,m-1,k)+p;
        end
        res(:,n)=p;
        n=n+1;
    end
end

