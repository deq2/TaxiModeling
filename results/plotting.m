load('Nice2/nicep3.mat');
load('Nice2/nicep2.mat');
load('Nice2/niceprof1.mat');

clear figure
hold on
plot(avProf1, 'color', [0 .5 0])
plot(p2, 'b')
plot(p3, 'r')
plot([0 105], [0 0], 'k--')
legend('Company 1', 'Company 2', 'Company 3')

ylabel('Expected Profit')
xlabel('Number of Cabs')
% set(gca,'xticklabel',[])