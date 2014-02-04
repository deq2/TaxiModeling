%Decrease time of all Taxis in Use

function [a] = dec(tiu)
    [n1, n2] = size(tiu);
    for i = 1:n1
        if tiu(i) >1 
            tiu(i) = tiu(i)-1;
        end
        
    end
    a=tiu;

end