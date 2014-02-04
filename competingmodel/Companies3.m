function [avg med sd revenue] = Companies3(taxi1, taxi2, taxi3, P1, P2, P3)

% if (P1 + P2 + P3 ~= 1.000)
%     disp('SOMETHING WRONG WITH THIS BOAT YO, EJECT EJECT');
% end;

load('matrix_A.mat');
load('matrix_C.mat');
[n1,n2] = size(A);
A(19,20) = 7;
A(20,19) =7;
A = A + eye(20);

B = (7/6)*(3/2)*getb(); % Probability matrix
start = 44;
e = 44;
step = 1;
ll = ((e - start)/step) + 1;
trials =   1;
AVG = zeros(ll,1);
MED = zeros(ll,1);
SD = zeros(ll,1);
wait = zeros(ll,1);

% Probability of picking company
% P1 = 1;
% P2 = 0;
% P3 = 0;

MAXWAIT = 45;
for t=1:trials
    %     t
    avg = zeros(ll,1);
    med = zeros(ll,1);
    sd = zeros(ll,1);
    in = 0;
    taxis = taxi1 + taxi2 + taxi3;
    
    %     for taxis = start: step:e
    in = in+1;
    
    comp1 = struct('taxis', taxi1, 'tiu', zeros(taxi1,1), 'tloc',ones(taxi1,1), 'WAIT', [], 'revenue', 0);
    comp2 = struct('taxis', taxi2, 'tiu', zeros(taxi2,1), 'tloc',ones(taxi2,1), 'WAIT', [], 'revenue', 0);
    comp3 = struct('taxis', taxi3, 'tiu', zeros(taxi3,1), 'tloc',ones(taxi3,1), 'WAIT', [], 'revenue', 0);
    
    tiu = zeros(taxis,1);     %number of minutes until job is complete
    r1 = rand(2*1440*n1,1);  %figure out exact dimensions
    tloc = ones(taxis,1);           %Initial Taxi Location
    
    
    WAIT = zeros(1, 1);             %waiting time
    index = 0;
    
    for minute = 1:1440        %Looping through all minutes in a day
        %DayTime
        
        comp1.tiu = dec(comp1.tiu);
        comp2.tiu = dec(comp2.tiu);
        comp3.tiu = dec(comp3.tiu);
        
        if minute>480
            tiu = dec(tiu);           %decrease the time of all taxis in use
            
            
            %tiu1 =b;
            for i = 1:n1       %Looping through all nodes
                for j = i:n2
                    if (r1(minute*i+j)<B(i,j)) && i ~=7 %If someone needs a taxi from node i to node j
                        index = index+1;
                        
                        estWait1 = comp1.tiu(taxin(i, comp1.tloc, comp1.tiu, A, comp1.taxis));
                        estWait2 = comp2.tiu(taxin(i, comp2.tloc, comp2.tiu, A, comp2.taxis));
                        estWait3 = comp3.tiu(taxin(i, comp3.tloc, comp3.tiu, A, comp3.taxis));
                        
                        whichComp = rand;
                        if whichComp < P3
                            if estWait3 < MAXWAIT
                                comp3 = callTaxi(i, j, comp3, A, C);
                            else
                                if rand < .5
                                    comp2 = callTaxi(i, j, comp2, A, C);
                                else
                                    comp1 = callTaxi(i, j, comp1, A, C);
                                end
                            end
                        elseif whichComp < P3 + P2
                            if estWait2 < MAXWAIT
                                comp2 = callTaxi(i, j, comp2, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(i, j, comp3, A, C);
                                else
                                    comp1 = callTaxi(i, j, comp1, A, C);
                                end
                            end
                        else
                            if estWait1 < MAXWAIT
                                comp1 = callTaxi(i, j, comp1, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(i, j, comp3, A, C);
                                else
                                    comp2 = callTaxi(i, j, comp2, A, C);
                                end
                            end
                        end
                        
                        a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                        tiu(a) = A(i,j) + A(tloc(a),i) + tiu(a,1);
                        tloc(a) = i;
                        WAIT(index) = tiu(a) - A(i,j);
                    elseif i==7
                        %Assume there are 8 periods of when a plane
                        %lands
                        if heaviside(-mod(minute,180)+60)
                            if (r1(minute*i+j)<3*B(i,j))
                                
                                
                                estWait1 = comp1.tiu(taxin(i, comp1.tloc, comp1.tiu, A, comp1.taxis));
                                estWait2 = comp2.tiu(taxin(i, comp2.tloc, comp2.tiu, A, comp2.taxis));
                                estWait3 = comp3.tiu(taxin(i, comp3.tloc, comp3.tiu, A, comp3.taxis));
                                %                                     estWait1 = Inf;
                                
                                whichComp = rand;
                                if whichComp < P3
                                    if estWait3 < MAXWAIT
                                        comp3 = callTaxi(i, j, comp3, A, C);
                                    else
                                        if rand < .5
                                            comp2 = callTaxi(i, j, comp2, A, C);
                                        else
                                            comp1 = callTaxi(i, j, comp1, A, C);
                                        end
                                    end
                                elseif whichComp < P3 + P2
                                    if estWait2 < MAXWAIT
                                        comp2 = callTaxi(i, j, comp2, A, C);
                                    else
                                        if rand < .5
                                            comp3 = callTaxi(i, j, comp3, A, C);
                                        else
                                            comp1 = callTaxi(i, j, comp1, A, C);
                                        end
                                    end
                                else
                                    if estWait1 < MAXWAIT
                                        comp1 = callTaxi(i, j, comp1, A, C);
                                    else
                                        if rand < .5
                                            comp3 = callTaxi(i, j, comp3, A, C);
                                        else
                                            comp2 = callTaxi(i, j, comp2, A, C);
                                        end
                                    end
                                end
                                
                                
                                index = index+1;
                                a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                                tiu(a) = A(i,j) + A(tloc(a),i)+ tiu(a,1);
                                tloc(a) = i;
                                WAIT(index) = tiu(a) - A(i,j);
                            end
                        end
                        
                    end
                    
                    if r1(minute*i+j) < B(j,i)  %If someone needs a taxi from node j to node i
                        
                        whichComp = rand;
                        estWait1 = comp1.tiu(taxin(j, comp1.tloc, comp1.tiu, A, comp1.taxis));
                        estWait2 = comp2.tiu(taxin(j, comp2.tloc, comp2.tiu, A, comp2.taxis));
                        estWait3 = comp3.tiu(taxin(j, comp3.tloc, comp3.tiu, A, comp3.taxis));
                        %                             estWait1 = Inf;
                        
                        if whichComp < P3
                            if estWait3 < MAXWAIT
                                comp3 = callTaxi(j, i, comp3, A, C);
                            else
                                if rand < .5
                                    comp2 = callTaxi(j, i, comp2, A, C);
                                else
                                    comp1 = callTaxi(j, i, comp1, A, C);
                                end
                            end
                        elseif whichComp < P3 + P2
                            if estWait2 < MAXWAIT
                                comp2 = callTaxi(j, i, comp2, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(j, i, comp3, A, C);
                                else
                                    comp1 = callTaxi(j, i, comp1, A, C);
                                end
                            end
                        else
                            if estWait1 < MAXWAIT
                                comp1 = callTaxi(j, i, comp1, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(j, i, comp3, A, C);
                                else
                                    comp2 = callTaxi(j, i, comp2, A, C);
                                end
                            end
                        end
                        
                        index = index+1;
                        a = taxin(j, tloc, tiu, A,taxis);  %Index of taxi who takes next passenger
                        tiu(a) = A(j,i) +A(tloc(a),j)+ tiu(a,1);
                        tloc(a) = j;
                        WAIT(index) = tiu(a,1) - A(j,i);
                    end
                end
            end
            
            %Night-Time
        else
            for i = 1:n1       %Looping through all nodes
                for j = i:n2
                    if r1(minute*i+j)<((B(i,j))/1.5) && i ~=7  %If someone needs a taxi from node i to node j
                        
                        whichComp = rand;
                        estWait1 = comp1.tiu(taxin(i, comp1.tloc, comp1.tiu, A, comp1.taxis));
                        estWait2 = comp2.tiu(taxin(i, comp2.tloc, comp2.tiu, A, comp2.taxis));
                        estWait3 = comp3.tiu(taxin(i, comp3.tloc, comp3.tiu, A, comp3.taxis));
                        %                             estWait1 = Inf;
                        
                        if whichComp < P3
                            if estWait3 < MAXWAIT
                                comp3 = callTaxi(i, j, comp3, A, C);
                            else
                                if rand < .5
                                    comp2 = callTaxi(i, j, comp2, A, C);
                                else
                                    comp1 = callTaxi(i, j, comp1, A, C);
                                end
                            end
                        elseif whichComp < P3 + P2
                            if estWait2 < MAXWAIT
                                comp2 = callTaxi(i, j, comp2, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(i, j, comp3, A, C);
                                else
                                    comp1 = callTaxi(i, j, comp1, A, C);
                                end
                            end
                        else
                            if estWait1 < MAXWAIT
                                comp1 = callTaxi(i, j, comp1, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(i, j, comp3, A, C);
                                else
                                    comp2 = callTaxi(i, j, comp2, A, C);
                                end
                            end
                        end
                        index = index+1;
                        a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                        tiu(a) = A(i,j) + A(tloc(a),i) + tiu(a,1);
                        tloc(a) = i;
                        WAIT(index) = tiu(a) - A(i,j);
                    elseif i==7
                        %Assume there are 8 periods of when a plane
                        %lands
                        if heaviside(-mod(minute,180)+60)
                            if (r1(minute*i+j)<(B(i,j))*2) % assume at night, most people have planned already
                                
                                whichComp = rand;
                                estWait1 = comp1.tiu(taxin(i, comp1.tloc, comp1.tiu, A, comp1.taxis));
                                estWait2 = comp2.tiu(taxin(i, comp2.tloc, comp2.tiu, A, comp2.taxis));
                                estWait3 = comp3.tiu(taxin(i, comp3.tloc, comp3.tiu, A, comp3.taxis));
                                %                                     estWait1 = Inf;
                                
                                if whichComp < P3
                                    if estWait3 < MAXWAIT
                                        comp3 = callTaxi(i, j, comp3, A, C);
                                    else
                                        if rand < .5
                                            comp2 = callTaxi(i, j, comp2, A, C);
                                        else
                                            comp1 = callTaxi(i, j, comp1, A, C);
                                        end
                                    end
                                elseif whichComp < P3 + P2
                                    if estWait2 < MAXWAIT
                                        comp2 = callTaxi(i, j, comp2, A, C);
                                    else
                                        if rand < .5
                                            comp3 = callTaxi(i, j, comp3, A, C);
                                        else
                                            comp1 = callTaxi(i, j, comp1, A, C);
                                        end
                                    end
                                else
                                    if estWait1 < MAXWAIT
                                        comp1 = callTaxi(i, j, comp1, A, C);
                                    else
                                        if rand < .5
                                            comp3 = callTaxi(i, j, comp3, A, C);
                                        else
                                            comp2 = callTaxi(i, j, comp2, A, C);
                                        end
                                    end
                                end
                                index = index+1;
                                a = taxin(i, tloc, tiu, A, taxis);  %Index of taxi who takes next passenger
                                tiu(a) = A(i,j) + A(tloc(a),i)+ tiu(a,1);
                                tloc(a) = i;
                                WAIT(index) = tiu(a) - A(i,j);
                            end
                        end
                        
                    end
                    if r1(minute*i+j) < B(j,i)/1.5  %If someone needs a taxi from node j to node i
                        
                        whichComp = rand;
                        estWait1 = comp1.tiu(taxin(j, comp1.tloc, comp1.tiu, A, comp1.taxis));
                        estWait2 = comp2.tiu(taxin(j, comp2.tloc, comp2.tiu, A, comp2.taxis));
                        estWait3 = comp3.tiu(taxin(j, comp3.tloc, comp3.tiu, A, comp3.taxis));
                        %                             estWait1 = Inf;
                        
                        if whichComp < P3
                            if estWait3 < MAXWAIT
                                comp3 = callTaxi(j, i, comp3, A, C);
                            else
                                if rand < .5
                                    comp2 = callTaxi(j, i, comp2, A, C);
                                else
                                    comp1 = callTaxi(j, i, comp1, A, C);
                                end
                            end
                        elseif whichComp < P3 + P2
                            if estWait2 < MAXWAIT
                                comp2 = callTaxi(j, i, comp2, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(j, i, comp3, A, C);
                                else
                                    comp1 = callTaxi(j, i, comp1, A, C);
                                end
                            end
                        else
                            if estWait1 < MAXWAIT
                                comp1 = callTaxi(j, i, comp1, A, C);
                            else
                                if rand < .5
                                    comp3 = callTaxi(j, i, comp3, A, C);
                                else
                                    comp2 = callTaxi(j, i, comp2, A, C);
                                end
                            end
                        end
                        index = index+1;
                        a = taxin(j, tloc, tiu, A,taxis);  %Index of taxi who takes next passenger
                        tiu(a) = A(j,i) + A(tloc(a),j)+ tiu(a,1);
                        tloc(a) = j;
                        WAIT(index) = tiu(a,1) - A(j,i);
                    end
                end
            end
        end
    end
    
    wt(25,WAIT);
    wait(in) = wait(in) + (1/trials)*wt(25, WAIT);
    %WAIT
    
    %         WAIT;
    %         g = find(WAIT==0);
    %WAIT = WAIT(1: find(WAIT ==0)-1)
    
    avg(in) = mean(WAIT);
    med(in) = median(WAIT);
    sd(in) = std(WAIT);
    
    %scatterplot(WAIT)
    %     end
    %     avg;
    %     AVG;
    AVG = AVG + ((1/trials)*avg);
    MED = MED + (1/trials)*med;
    SD = SD + (1/trials)*sd;
end

avg = [mean(comp1.WAIT) mean(comp2.WAIT) mean(comp3.WAIT)];
med = [median(comp1.WAIT) median(comp2.WAIT) median(comp3.WAIT)];
sd = [std(comp1.WAIT) std(comp2.WAIT) std(comp3.WAIT)];
revenue = [comp1.revenue comp2.revenue comp3.revenue];
% AVG;
% MED;
% SD;
% wait;  %Proportion having to wait more than 25 minutes
%clf;
%plot([start: step:e], AVG, [start e], [15 15], '--r')
%figure
%plot([start: step:e], wait, [start e], [.1 .1], '--r')

%x3{
%Plot avg waiting time versus # of Taxis
%Plot # of customers having to wait more than 25 minutes versus # of taxis
%Plot for ideal # of taxis, proporition of customers having to wait more n minutes.(n versus # of customers)
%} One for weekday only, one for weekend only, and one for both.



