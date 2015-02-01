function res = tracerSpline(nodes,i,k)
    m=1;
    i=i+1;
    pas=0.001;
    abscisse=nodes(i):pas:nodes(i+k);
    for t=abscisse
        res(m)=N(t,nodes,i-1,k);
        m=m+1;
    end
    plot(abscisse,res);
end

