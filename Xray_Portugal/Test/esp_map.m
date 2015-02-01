function esp_map = esp_map(me,l1,l2)

    for i = 1:size(me,1)
        for j = 1:size(me,2)
            %-- get windows for localized statistics
            xneg = max(i-l1,1);
            xpos = min(i+l1,size(me,1));
            yneg = max(j-l2,1);
            ypos = min(j+l2,size(me,2));
            % mean
            rect = me(xneg:xpos,yneg:ypos);
            mean = sum(sum(rect))/((xneg-xpos)*(yneg-ypos));
            % variance
            esp_map(i,j) = mean;
        end
    end

end
