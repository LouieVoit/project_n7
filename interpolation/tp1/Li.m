function res = Li(t,i,liste_t)
    res=1;
    for j=1:length(liste_t)
        if (j~=i)
            res=res*(t-liste_t(j))/(liste_t(i)-liste_t(j));
        end
    end    
end

