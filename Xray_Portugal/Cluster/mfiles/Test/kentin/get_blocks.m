function [b,blocs_nb] = get_blocks(me, renum)
    
    [x,y] = size(me);

    % b x*y matrix giving bloc number (0 if a point isn't in the mask)
    b = zeros(x,y);
    
    % Divide the work to avoid recurence issues (recursion limit)
    div = 22;
    px = 1:div:x;
    if px(length(px)) ~= x+1
        px = [px x+1];
    end
    py = 1:div:y;
    if py(length(py)) ~= y+1
        py = [py y+1];
    end
    blocs_nb = 1;
    for t = 1:(length(px)-1)
        for q = 1:(length(py)-1)
            % We search connex components of a graph
            for i = px(t):(px(t+1)-1)
                for j = py(q):(py(q+1)-1)
                    if me(i,j) == 1 && b(i,j) == 0
                        b(i,j) = blocs_nb;
                        b(px(t):(px(t+1)-1),py(q):(py(q+1)-1)) = mark_neighboors(me(px(t):(px(t+1)-1),py(q):(py(q+1)-1)),b(px(t):(px(t+1)-1),py(q):(py(q+1)-1)),i-px(t)+1,j-py(q)+1,blocs_nb);
                        blocs_nb = blocs_nb + 1;
                    end
                end
            end
        end
    end    
    
    % Concatene the work done on smalls blocks
    for q = 1:(length(py)-1)
        for t = 1:(length(px)-2)
            % Look at the bottom boundary
            rep = [];
            for i = py(q):(py(q+1)-1)
                % If it should be a single block
                if b(px(t+1)-1,i) ~= 0 && b(px(t+1)-1,i) ~= b(px(t+1),i)
                    idx = find(rep == b(px(t+1),i));
                    changed_yet = ~isempty(idx);
                else
                    changed_yet = false;
                end
                if b(px(t+1)-1,i) ~= 0 && b(px(t+1),i) ~= 0 && ~changed_yet
                    b(px(t+1):(px(t+2)-1),py(q):(py(q+1)-1)) = replace_value(b(px(t+1),i),b(px(t+1)-1,i),b(px(t+1):(px(t+2)-1),py(q):(py(q+1)-1)));
                    rep = [rep b(px(t+1)-1,i)];
                elseif changed_yet
                    b(px(t):(px(t+1)-1),py(q):(py(q+1)-1)) = replace_value(b(px(t+1)-1,i),b(px(t+1),i),b(px(t):(px(t+1)-1),py(q):(py(q+1)-1)));
                end
            end     
        end
    end
    % Meme opération sur les colonnes
    for q = 1:(length(py)-2)
        % Visiting the right boundary
        rep = [];
        for i = 1:x
            % If it should be a single block
            if b(i,py(q+1)-1) ~= 0 && b(i,py(q+1)-1) ~= b(i,py(q+1))
                idx = find(rep == b(i,py(q+1)));
                changed_yet = ~isempty(idx);
            else
                changed_yet = false;
            end
            if b(i,py(q+1)-1) ~= 0 && b(i,py(q+1)) ~= 0 && ~changed_yet
                b(1:x,py(q+1):(py(q+2)-1)) = replace_value(b(i,py(q+1)),b(i,py(q+1)-1),b(1:x,py(q+1):(py(q+2)-1)));
                rep = [rep b(i,py(q+1)-1)];
            elseif changed_yet
                b(1:x,py(q):(py(q+1)-1)) = replace_value(b(i,py(q+1)-1),b(i,py(q+1)),b(1:x,py(q):(py(q+1)-1)));
            end
        end
    end
    
    if renum    
        % Renumérotation des blocs
        vals = [];
        % Comptage
        for i = 1:size(b,1)
            for j = 1:size(b,2)
                if b(i,j) ~= 0
                    id = find(vals == b(i,j));
                    if isempty(id)
                        vals = [vals b(i,j)];
                    end
                end
            end
        end
        nb = length(vals);
        blocs_nb = nb;
        % Renumérotation
        for i = 1:nb
            id = find(b == vals(i));
            b(id) = i;
        end
        vals
    end
    
            
    
    
                     
end

function bs = mark_neighboors(m,be,i,j,blocks_nb)

    bs = be;
    % Point intérieur
    if i > 1 && j > 1 && i < size(m,1) && j < size(m,2)
        % On regarde tout les voisins non marqués
        if m(i,j-1) == 1 && be(i,j-1) == 0
            bs(i,j-1) = blocks_nb;
            bs = mark_neighboors(m,bs,i,j-1,blocks_nb);
        end
        if m(i,j+1) == 1 && be(i,j+1) == 0
            bs(i,j+1) = blocks_nb;
            bs = mark_neighboors(m,bs,i,j+1,blocks_nb);
        end
        if m(i-1,j) == 1 && be(i-1,j) == 0
            bs(i-1,j) = blocks_nb;
            bs = mark_neighboors(m,bs,i-1,j,blocks_nb);
        end
        if m(i+1,j) == 1 && be(i+1,j) == 0
            bs(i+1,j) = blocks_nb;
            bs = mark_neighboors(m,bs,i+1,j,blocks_nb);
        end
    % Point sur la première ligne
    elseif i == 1
        % Coin 1 1
        if j == 1 
            if size(m,1) > 1 && m(i+1,j) == 1 && be(i+1,j) == 0  
                bs(i+1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i+1,j,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j+1) == 1 && be(i,j+1) == 0 
                bs(i,j+1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j+1,blocks_nb);
            end
        % Coin 1 n
        elseif j == size(m,2)
            if size(m,1) > 1 && m(i+1,j) == 1 && be(i+1,j) == 0 
                bs(i+1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i+1,j,blocks_nb);
            end
            if  size(m,2) > 1 && m(i,j-1) == 1 && be(i,j-1) == 0 
                bs(i,j-1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j-1,blocks_nb);
            end
        % Bord 1
        else
            if  size(m,1) > 1 && m(i+1,j) == 1 && be(i+1,j) == 0 
                bs(i+1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i+1,j,blocks_nb);
            end
            if  size(m,2) > 1 && m(i,j-1) == 1 && be(i,j-1) == 0 
                bs(i,j-1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j-1,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j+1) == 1 && be(i,j+1) == 0  
                bs(i,j+1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j+1,blocks_nb);
            end
        end
    % Dernière ligne
    elseif i == size(m,1) 
        % Coin n 1
        if j == 1
            if size(m,1) > 1 && m(i-1,j) == 1 && be(i-1,j) == 0 
                bs(i-1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i-1,j,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j+1) == 1 && be(i,j+1) == 0 
                bs(i,j+1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j+1,blocks_nb);
            end
        % Coin n n
        elseif j == size(m,2)
            if size(m,1) > 1 && m(i-1,j) == 1 && be(i-1,j) == 0 
                bs(i-1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i-1,j,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j-1) == 1 && be(i,j-1) == 0 
                bs(i,j-1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j-1,blocks_nb);
            end
        % Bord n
        else
            if size(m,1) > 1 && m(i-1,j) == 1 && be(i-1,j) == 0 
                bs(i-1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i-1,j,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j-1) == 1 && be(i,j-1) == 0 
                bs(i,j-1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j-1,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j+1) == 1 && be(i,j+1) == 0 
                bs(i,j+1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j+1,blocks_nb);
            end
        end
    % 1ère colonne    
    elseif j == 1
        if i > 1 && i < size(m,1)
            if size(m,1) > 1 && m(i-1,j) == 1 && be(i-1,j) == 0 
                bs(i-1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i-1,j,blocks_nb);
            end
            if size(m,1) > 1 && m(i+1,j) == 1 && be(i+1,j) == 0
                bs(i+1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i+1,j,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j+1) == 1 && be(i,j+1) == 0 
                bs(i,j+1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j+1,blocks_nb);
            end
        end
    % Dernière colonne    
    elseif j == size(m,2)
        if i > 1 && i < size(m,1)        
            if size(m,1) > 1 && m(i-1,j) == 1 && be(i-1,j) == 0 
                bs(i-1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i-1,j,blocks_nb);
            end
            if size(m,1) > 1 && m(i+1,j) == 1 && be(i+1,j) == 0 
                bs(i+1,j) = blocks_nb;
                bs = mark_neighboors(m,bs,i+1,j,blocks_nb);
            end
            if size(m,2) > 1 && m(i,j-1) == 1 && be(i,j-1) == 0 
                bs(i,j-1) = blocks_nb;
                bs = mark_neighboors(m,bs,i,j-1,blocks_nb);
            end
        end
    end

end

function new_m = replace_value(old,new,old_m)
    new_m = old_m;
    idx = find(old_m == old);
    new_m(idx) = new;
end
    


