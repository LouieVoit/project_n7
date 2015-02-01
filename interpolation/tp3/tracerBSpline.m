function tracerBSpline( n,fermee )
    [x,y]=saisi_points;
    [X,Y]=subdivisionSpline(x,y,n,fermee);
    if (fermee)
        plot(X,Y,'b+-');
    else
        plot(X(1:(length(X)-n)),Y(1:(length(Y)-n)),'b+-');
    end
    hold off;
end

