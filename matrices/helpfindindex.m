t = [];
    for a = 1:3:40
        for b = 1:3:43-a
            t = [t; a, b, (44 -a -b)];
            
            
        end
    end
    
    [b ix] = sort(t(:,1));
    c = t(:,2);
    c2 = t(:,3);
    for i = 1:44
        b2 = c(ix);
        b3 = c2(ix);
        
    end

    
%    [b2 ix2] = sort(t(:,3));
%     for i = 1:44
%         p3 = avProf3(ix2);
%     end
