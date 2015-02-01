function ms = find_teeth(me,n)

    [x,y] = size(me);
    s = 0;
    hx = floor(x/n)
    hy = floor(y/n);
    
    for ix1 = 1:n
        for ix2 = (ix1+5):n
            for iy1 = 1:n
                for iy2 = (iy1+5):n
                    A = (ix2-ix1)*(iy2-iy1);
                    stmp = sum(sum(me((hx*ix1):(hx*ix2),(hy*iy1):(hy*iy2))))/A;
                    if stmp > s
                        idx = [hx*ix1 hx*ix2 hy*iy1 hy*iy2];
                        s = stmp;
                    end
                end
            end
        end
    end
    s
    idx
    ms = zeros(x,y);
    ms(idx(1):idx(2),idx(3):idx(4))= me(idx(1):idx(2),idx(3):idx(4));

end

