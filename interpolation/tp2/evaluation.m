function res = evaluation( t )
    [X,Y]=saisi_points;
    n=length(X)-1;
    i_max=n-1;
    for j=1:n-1
        for i=1:i_max
            X(i)=(1-t)*X(i)+t*X(i+1);
            Y(i)=(1-t)*Y(i)+t*Y(i+1);
        end
        i_max=i_max-1;
    end
    res=[X(1);Y(1)];
end

