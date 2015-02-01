function [X,Y] = moindreCarre( pasConstant )
%MOINDRECARRE
    [x,y]=saisi_points;
    m=length(x);
    temps = 1:m;
    if (~pasConstant)
        for i=2:m
            temps(i)= temps(i-1)+sqrt(norm([x(i)-x(i-1);y(i)-y(i-1)]))/3;
        end
    end
    if (pasConstant)
        temps=temps/3;
    end
    noeuds = (floor(temps(1))-2):(floor(temps(m)));
    n=length(noeuds);
    %Remplissage matrice A
    A=zeros(m,n);
    for i=1:m
        for j=1:n
            A(i,j)=N(temps(i),noeuds(j),3);
        end
    end
    A=[A,zeros(m,n);zeros(m,n),A];
    A=pinv(A);
    b=[x';y'];
    aux=A*b;
    X=aux(1:n);
    Y=aux(n+1:2*n);
    plot(X,Y,'ro');
    %%Tracer spline
    pas=0.01;
    ab=[];
    or=[];
    for t=temps(1):pas:temps(m)
        auxX=0;
        auxY=0;
        for i=1:n
          auxX=X(i)*N(t,noeuds(i),3)+auxX;
          auxY=Y(i)*N(t,noeuds(i),3)+auxY;
        end
        ab=[ab,auxX];
        or=[or,auxY];
    end
    hold on
    plot(ab,or,'r');
    hold off

