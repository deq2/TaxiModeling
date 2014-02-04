load('matrix_A.mat');
[n1,n2] = size(A);
A(19,20) = 7;
A(20,19) =7;
A = A + eye(20);

B =(7/6)*(3/2)*getb(); % Probability matrix

start = 16;
e = 44;
step = 1;
ll = ((e - start)/step) + 1;
trials = 70;
AVG = zeros(ll,1);
MED = zeros(ll,1);
SD = zeros(ll,1);
wait = zeros(ll,1);
for t=1:trials
    t
    avg = zeros(ll,1);
    med = zeros(ll,1);
    sd = zeros(ll,1);
    in = 0;
    for taxis = start: step:e
        in = in+1;
        
        tiu = zeros(taxis,1);     %number of minutes until job is complete
        r1 = rand(2*1440*n1,1);  %figure out exact dimensions
        tloc = ones(taxis,1);           %Initial Taxi Location
        
        
        WAIT = zeros(1, 1);             %waiting time
        index = 0;
        
        for minute = 1:1440        %Looping through all minutes in a day
            
            %DayTime
            if minute>480
                tiu = dec(tiu);           %decrease the time of all taxis in use
                %tiu1 =b;
                for i = 1:n1       %Looping through all nodes
                    for j = i:n2
                        if (r1(minute*i+j)<B(i,j)) && i ~=7 %If someone needs a taxi from node i to node j
                            index = index+1;
                            a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                            tiu(a) = A(i,j) + A(tloc(a),i) + tiu(a,1);
                            tloc(a) = j;
                            WAIT(index) = tiu(a) - A(i,j);
                        elseif i==7
                            %Assume there are 8 periods of when a plane
                            %lands
                            if heaviside(-mod(minute,180)+60)
                                minute;
                                if (r1(minute*i+j)<3*B(i,j))
                                    index = index+1;
                                    a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                                    tiu(a) = A(i,j) + A(tloc(a),i)+ tiu(a,1);
                                    tloc(a) = j;
                                    WAIT(index) = tiu(a) - A(i,j);
                                end
                            end
                            
                        end
                        
                        if r1(minute*i+j) < B(j,i)  %If someone needs a taxi from node j to node i
                            index = index+1;
                            a = taxin(j, tloc, tiu, A,taxis);  %Index of taxi who takes next passenger
                            tiu(a) = A(j,i) +A(tloc(a),j)+ tiu(a,1);
                            tloc(a) = i;
                            WAIT(index) = tiu(a,1) - A(j,i);
                        end
                    end
                end
                
                %Night-Time
            else
                for i = 1:n1       %Looping through all nodes
                    for j = i:n2
                        if r1(minute*i+j)<((B(i,j))/1.5) && i ~=7  %If someone needs a taxi from node i to node j
                            index = index+1;
                            a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                            tiu(a) = A(i,j) + A(tloc(a),i) + tiu(a,1);
                            tloc(a) = j;
                            WAIT(index) = tiu(a) - A(i,j);
                        elseif i==7
                            %Assume there are 8 periods of when a plane
                            %lands
                            if heaviside(-mod(minute,180)+60)
                                minute;
                                if (r1(minute*i+j)<B(i,j))*2 % assume at night, most people have planned already
                                    index = index+1;
                                    a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                                    tiu(a) = A(i,j) + A(tloc(a),i)+ tiu(a,1);
                                    tloc(a) = j;
                                    WAIT(index) = tiu(a) - A(i,j);
                                end
                            end
                            
                        end
                        if r1(minute*i+j) < B(j,i)/1.5  %If someone needs a taxi from node j to node i
                            index = index+1;
                            a = taxin(j, tloc, tiu, A,taxis);  %Index of taxi who takes next passenger
                            tiu(a) = A(j,i) + A(tloc(a),j)+ tiu(a,1);
                            tloc(a) = i;
                            WAIT(index) = tiu(a,1) - A(j,i);
                        end
                    end
                end
            end
        end
        
        wt(25,WAIT);
        wait(in) = wait(in) + (1/trials)*wt(25, WAIT);
        %WAIT
        
        WAIT;
        g = find(WAIT==0);
        %WAIT = WAIT(1: find(WAIT ==0)-1)
        
        avg(in) = mean(WAIT);
        med(in) = median(WAIT);
        sd(in) = std(WAIT);
        
        %scatterplot(WAIT)
    end
    avg;
    AVG;
    AVG = AVG + ((1/trials)*avg);
    MED = MED + (1/trials)*med;
    SD = SD + (1/trials)*sd;
end

AVG
MED
SD
wait  %Proportion having to wait more than 25 minutes
close all
clf;
plot([start: step:e], AVG, [start e], [15 15], '--r')
figure
plot([start: step:e], wait, [start e], [.1 .1], '--r')

%x3{
%Plot avg waiting time versus # of Taxis
%Plot # of customers having to wait more than 25 minutes versus # of taxis
%Plot for ideal # of taxis, proporition of customers having to wait more n minutes.(n versus # of customers)
%} One for weekday only, one for weekend only, and one for both.



