function [X,Y] = subdivisionSpline(x,y,n,fermee)
    %On double les points
    if (fermee)
        X=zeros(1,length(x)*2);
        Y=zeros(1,length(y)*2);
        for j=1:2:(2*length(x)-1)
            X(j)=x((j+1)/2);
            X(j+1)=x((j+1)/2);
            Y(j)=y((j+1)/2);
            Y(j+1)=y((j+1)/2);
        end
    else
        X=zeros(1,length(x)*2+2*(n-1));
        Y=zeros(1,length(y)*2+2*(n-1));
        for j=1:(n-1)
            X(j)=x(1);
            Y(j)=y(1);
            X(j+(2*length(x)-1)+n)=x(length(x));
            Y(j+(2*length(y)-1)+n)=y(length(y));
        end
        for j=1:2:((2*length(x)-1))
            X(j+n-1)=x((j+1)/2);
            X(j+n)=x((j+1)/2);
            Y(j+n-1)=y((j+1)/2);
            Y(j+n)=y((j+1)/2);
        end
    end
    %Fin doublage
    for k=1:n
        aux = [X(1),Y(1)];
        for j=1:length(X)
            if (j~=length(X))
                X(j)=0.5*X(j)+0.5*X(j+1);
                Y(j)=0.5*Y(j)+0.5*Y(j+1);
            elseif (fermee)
                X(j)=0.5*X(j)+0.5*aux(1);
                Y(j)=0.5*Y(j)+0.5*aux(2);
            end    
        end
    end
    if (fermee)
        %On ferme la courbe
        X(length(X)+1)=X(1);
        Y(length(Y)+1)=Y(1);
    end
end

