tic
trials = 30;
cars = 10;
AVG1 = 0;
AVG2 = 0;
AVG3 = 0;
avRev = 0;
avProf1 = 0;
avProf2 = 0;
avProf3 = 0;
costpercar = 190;
profit1 = [];
profit2 = [];
profit3 = [];



for t = 1:trials
    index = 1;
    avg1 = [];
    avg2 = [];
    avg3 = [];
    for c=1:1 

            [avg med sd revenue] = Companies3(10,7,1, .7, .2, .1);
            %         [avg med sd] = companies(43, 1, 1, 1, 0, 0);
            avg1 = [avg1 avg(1)];
            avg2 = [avg2 avg(2)];
            avg3 = [avg3 avg(3)];
            profit1(index) = revenue(1) - costpercar*10;
            profit2(index) = revenue(2) - costpercar*7;
            profit3(index) = revenue(3) - costpercar*1;
            index = index + 1;
        
    end
    
    AVG1 = AVG1 + (avg1);
    AVG2 = AVG2 + (avg2);
    AVG3 = AVG3 + (avg3);
    avRev = avRev + revenue;
    avProf1 = avProf1 + profit1;
    avProf2 = avProf2 + profit2;
    avProf3 = avProf3 + profit3;
end
AVG1 = AVG1/trials;
AVG2 = AVG2/trials;
AVG3 = AVG3/trials;
avRev = avRev/trials;
avProf1 = avProf1/trials;
avProf2 = avProf2/trials;
avProf3 = avProf3/trials;

clear figure
hold on
plot(AVG1, 'r')
plot(AVG2, 'b')
plot(AVG3, 'k')

hold off
toc