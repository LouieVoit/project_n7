function  [x,y,z] = casteljau_3d( x,y,z,ite )
    %x,y vecteurs de R^n ; z matrice de R^n*n
    figure;
    grid on
    hold on
    for i=1:length(x)
        for j=1:length(y)
            plot3(x(i),y(j),z(i,j),'ro');
        end
    end   
    for k=1:ite
        %Subdivision par rapport au 1er paramètre
        ny=length(y);
        nx=length(x);
        z(nx+1,:)=0;
        for j=1:ny
            if (j==1)
                [x,z(:,j)]=subdivision(x,z(1:nx,j));
            else
                 %on ne fait qu'une fois la subdivision suivant x
                 [~,z(:,j)]=subdivision(z(1:nx,j),z(1:nx,j));
            end
        end
        %Subdivision par rapport au second paramètre
        z(:,ny+1)=0;
        nx=length(x);
        for i=1:nx
            if (i==1)
                [y,z(i,:)]=subdivision(y,z(i,1:ny));
            else
                 %on ne fait qu'une fois la subdivision suivant x
                 [~,z(i,:)]=subdivision(z(i,1:ny),z(i,1:ny));
            end
        end
    end
    for i=1:length(x)
        for j=1:length(y)
            plot3(x(i),y(j),z(i,j),'h');
        end
    end
    [X,Y]=meshgrid(x,y);
    surf(X',Y',z);
    axis auto
    hold off
end

