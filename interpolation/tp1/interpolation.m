function [p_t] = interpolation(X,Y,liste_t,t_eval)
    p_t=0;
    for j=1:(length(X))
        p_t=p_t+Li(t_eval,j,liste_t)*[X(j);Y(j)];
    end
end

