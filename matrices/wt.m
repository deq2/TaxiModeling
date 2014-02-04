%This function find the proportion of customers who have to wait for more
%than n minutes

function[a] = wt(n, WAIT)
[zds, ll] = size(WAIT);
count = 0;
for i = 1:ll
    if WAIT(1,i) >n
        count = count+1;
    end
end

a = count/ll;