function res = phi(t,y)
    res=zeros(1,2);
    res(1)=y(2);
    res(2)=(1-y(1)^2)*y(2)-y(1);
end

