function ms = find_teeth_2(me,th)

    [x,y] = size(me);
    ms = me;
    [b,blocs_nb] = get_blocks(me, true);
    % Calculer l'aire des blocs
    A = zeros(blocs_nb,1);
    for i = 1:x
        for j = 1:y
            if b(i,j) > 0;
                A(b(i,j)) = A(b(i,j)) + 1;
            end
        end
    end
    n=0;
    % Elimination des blocs sous le seuil
    A
    th*x*y
    A(1) < th*x*y
    for i = 1:blocs_nb
        A(i) < th*x*y
        if A(i) < th*x*y
            % Elimination du blocs
            for i = 1:x
                for j = 1:y
                    if b(i,j) == i
                        n=n+1;
                        ms(i,j) = 0;
                    end
                end
            end
        end
    end       

  
end

