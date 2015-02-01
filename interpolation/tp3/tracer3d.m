function [x,y,Z] = tracer3d( x,y,z,m,n,fermee )
%TRACER Surface avec B-Spline, c'est trop cool
%   x,y vecteurs de R^n ; z matrice de R^n*n, m degré des splines suivant
%   x, n suivant y;
    figure;
    grid on
    hold on
    for i=1:length(x)
        for j=1:length(y)
            plot3(y(j),x(i),z(i,j),'ro');
        end
    end   
   %Subdivision par rapport au 1er paramètre x
    ny=length(y);
    for j=1:ny
        if (j==1)
            [x,Zaux(:,j)]=subdivisionSpline(x,z(:,j),m,fermee);
        else
             %on ne fait qu'une fois la subdivision suivant x
             [~,Zaux(:,j)]=subdivisionSpline(z(:,j),z(:,j),m,fermee);
        end
    end
    %Subdivision par rapport au second paramètre y
    nx=length(x);
    for i=1:nx
        if (i==1)
            [y,Z(i,:)]=subdivisionSpline(y,Zaux(i,:),n,fermee);
        else
             %on ne fait qu'une fois la subdivision suivant x
             [~,Z(i,:)]=subdivisionSpline(Zaux(i,:),Zaux(i,:),n,fermee);
        end
    end
    for i=1:length(x)
        for j=1:length(y)
            plot3(y(j),x(i),Z(i,j),'h');
        end
    end 
    [Y,X]=meshgrid(y,x);
    surf(Y,X,Z);
    axis auto
    hold off


end

