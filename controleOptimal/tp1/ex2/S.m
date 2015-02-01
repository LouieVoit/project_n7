function [val,T] = S( z )
if (length(z)>2)
    hx=(z(2,1)-z(1,1))/99;
    hy=(z(2,2)-z(1,2))/99;
    i=0;
    j=0;
    Tx=(z(1,1):hx:z(2,1))';
    Ty=(z(1,2):hy:z(2,2))';
    val=zeros(length(Tx),length(Ty));
    for pasx=Tx
        i=i+1;
        for pasy=Ty
            j=j+1;
            [~,Y]=ode45(@phi,[0,2],[0;0;pasx;pasy]);
            val(i,j)=Y(size(Y,1),[1 2])-[0.5 0];
        end
    end
else
   [~,Y]=ode45(@phi,[0,2],[0;0;z(1);z(2)]);
    val=Y(size(Y,1),[1 2])-[0.5 0];
    T=[];
end

