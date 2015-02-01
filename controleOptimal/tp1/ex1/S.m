function [val,T] = S( z )
if (length(z)>1)
    h=(z(2)-z(1))/99;
    i=1;
    T=z(1):h:z(2)';
    val=zeros(length(T),1);
    for pas=T
        [~,Y]=ode45(@phi,[0,2],[0;pas]);
        val(i)=Y(size(Y,1),1)-0.5;
        i=i+1;
    end
else
   [~,Y]=ode45(@phi,[0,2],[0;z]);
    val=Y(size(Y,1),1)-0.5;
    T=[];
end

