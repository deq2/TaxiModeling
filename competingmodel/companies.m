function [avg med sd] = companies(taxis1, taxis2, taxis3, P1, P2, P3)

% A = [2,2,3; 2,2,2;3,3,3]; % Distance matrix
load('matrix_A.mat');
A;
[n1,n2] = size(A);
B = 1.33333*getb(); % Probability matrix
A = A + eye(20);
ll = 1;
trials = 50;
AVG = zeros(ll,1);
MED = zeros(ll,1);
SD = zeros(ll,1);


%     avg = zeros(ll,1);
%     med = zeros(ll,1);
%     sd = zeros(ll,1);
    in = 0;
        in = in+1;

        %taxis=50;
        tiu1 = zeros(taxis1,1);     %Taxis driving passengers
        tiu2 = zeros(taxis2,1);
        tiu3 = zeros(taxis3,1);
        %tiu1 = zeros(taxis,1);    %Taxis driving back to station
        r1 = rand(2*1440*n1*n2,1);  %figure out exact dimensions
        tloc1 = ones(taxis1,1);           %Initial Taxi Location
        tloc2 = ones(taxis2,1);
        tloc3 = ones(taxis3,1);


%         WAIT1 = zeros(1, 10);             %waiting time
%         WAIT2 = zeros(1, 10);
%         WAIT3 = zeros(1, 10);
        index1 = 1;
        index2 = 1;
        index3 = 1;
        WAIT1 = zeros(1, 1);             %waiting time
        WAIT2 = zeros(1, 1);
        WAIT3 = zeros(1, 1);

        for minute = 1:1440        %Looping through all minutes in a day
            tiu1 = dec(tiu1);           %decrease the time of all taxis in use
            tiu2 = dec(tiu2); 
            tiu3 = dec(tiu3); 
            %tiu1 =b;
            for i = 1:n1       %Looping through all nodes
                for j = i:n2
                    if r1(minute +i+j-2)<B(i,j) %If someone needs a taxi from node i to node j
                        rcomp = rand;
                        if rcomp < P3
                            a = taxin(i, tloc3, tiu3, A, taxis3);  %Index of taxi who takes next passenger
                            tiu3(a) = A(i,j) + tiu3(a,1);
                            tloc3(a) = i;
                            WAIT3(index3) = tiu3(a) - A(i,j);
                            index3 = index3 + 1;
                             
                            
                        elseif rcomp < P2
                            a = taxin(i, tloc2, tiu2, A, taxis2);  %Index of taxi who takes next passenger
                            tiu2(a) = A(i,j) + tiu2(a,1);
                            tloc2(a) = i;
                            WAIT2(index2) = tiu2(a) - A(i,j);
                            index2 = index2 + 1;
                 
                        else
                            a = taxin(i, tloc1, tiu1, A, taxis1);  %Index of taxi who takes next passenger
                            tiu1(a) = A(i,j) + tiu1(a,1);
                            tloc1(a) = i;
                            WAIT1(index1) = tiu1(a) - A(i,j);
                            index1 = index1 + 1;
                        end
                        
                        
                        
                        %if ind(tiu) ~=0           %If we have a taxi in the station, send it.


                    end
                    if r1(minute+i+j-1) < B(j,i)  %If someone needs a taxi from node j to node i
                        rcomp = rand;
                        if rcomp < P3
                            a = taxin(i, tloc3, tiu3, A, taxis3);  %Index of taxi who takes next passenger
                            tiu3(a) = A(i,j) + tiu3(a,1);
                            tloc3(a) = i;
                            WAIT3(index3) = tiu3(a) - A(i,j);
                            index3 = index3 + 1;
                             
                            
                        elseif rcomp < P2
                            a = taxin(i, tloc2, tiu2, A, taxis2);  %Index of taxi who takes next passenger
                            tiu2(a) = A(i,j) + tiu2(a,1);
                            tloc2(a) = i;
                            WAIT2(index2) = tiu2(a) - A(i,j);
                            index2 = index2 + 1;
                 
                        else
                            a = taxin(i, tloc1, tiu1, A, taxis1);  %Index of taxi who takes next passenger
                            tiu1(a) = A(i,j) + tiu1(a,1);
                            tloc1(a) = i;
                            WAIT1(index1) = tiu1(a) - A(i,j);
                            index1 = index1 + 1;
                        end         %If we have a taxi in the station, send it.

                    end
                end 
            end
        end


        g = find(WAIT1==0);
        %WAIT = WAIT(1: find(WAIT ==0)-1)

        avg(1) = mean(WAIT1);
        med(1) = median(WAIT1);
        sd(1) = std(WAIT1);
        avg(2) = mean(WAIT2);
        med(2) = median(WAIT2);
        sd(2) = std(WAIT2);
        avg(3) = mean(WAIT3);
        med(3) = median(WAIT3);
        sd(3) = std(WAIT3);

% 
%         %scatterplot(WAIT)
%     avg;
%     AVG;
%     AVG = AVG + ((1/trials)*avg);
%     MED = MED + (1/trials)*med;
%     SD = SD + (1/trials)*sd;


end
