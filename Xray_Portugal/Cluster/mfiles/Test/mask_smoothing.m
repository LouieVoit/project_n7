function ms = mask_smoothing(me,a)
% "Smooth" the mask
    
    [x,y] = size(me);
    ms = zeros(x,y);

    for i = 1:x
        for j = 1:y
            if i > 2 && i < x-2 && j > 2 && j < y-2
                m = (me(i,j-1) + me(i,j+1) + me(i,j+2) + me(i,j-2) + me(i-1,j) + me(i+1,j) + me(i-2,j) + me(i+2,j) + me(i+1,j-1) + me(i+1,j+1) + me(i-1,j+1) + me(i-1,j-1))/12;
                ms(i,j) = m > a;
            end
        end
    end

end

