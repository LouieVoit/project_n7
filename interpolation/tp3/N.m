function [ res ] = N(t,nodes,i,k)
    %Indice de tableau...
    i=i+1;
    if (t<nodes(i) || t>=nodes(i+k))
        res = 0;
    elseif (k==1)
        res=1;
    else
        if (nodes(i+k)>nodes(i+1) && (nodes(i+k-1)-nodes(i))==0)
            res = ((nodes(i+k)-t)*N(t,nodes,i,k-1)/(nodes(i+k)-nodes(i+1)) );
        elseif (nodes(i+k-1)>nodes(i) && (nodes(i+k)-nodes(i+1))==0)
            res = ((t-nodes(i))*N(t,nodes,i-1,k-1)/(nodes(i+k-1)-nodes(i)) );       
        else
            res = ((t-nodes(i))*N(t,nodes,i-1,k-1)/(nodes(i+k-1)-nodes(i)) ) + ((nodes(i+k)-t)*N(t,nodes,i,k-1)/(nodes(i+k)-nodes(i+1)) );
        end
    end
end

