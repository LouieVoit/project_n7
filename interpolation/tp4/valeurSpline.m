function res = valeurSpline(i,k)
    m=1;
    i=i+1;
    pas=0.1;
    abscisse=i:pas:i+k;
    res=zeros(1,length(abscisse));
    for t=abscisse
        res(m)=N(t,i,k);
        m=m+1;
    end
end

