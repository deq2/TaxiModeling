%Find the taxi to send to individual


function [ret] = taxin(i, tloc, tiu, A,taxis)     %i is node passenger is at. tloc is location of each taxi, tiu is time needed to arrive to location.

n = 20;
ind = 1;
MIN = A(i,tloc(1)) + tiu(1);   


for j = 2:taxis
    if  A(i,tloc(j)) + tiu(j) < MIN
        MIN = A(i,tloc(j)) + tiu(j);
        ind = j;
    end
end

ret = ind;
end