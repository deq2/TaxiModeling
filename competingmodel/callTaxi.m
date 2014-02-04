function [comp] = callTaxi(i,j,comp, A, C)

a = taxin(i, comp.tloc, comp.tiu, A, comp.taxis);  %Index of taxi who takes next passenger
comp.tiu(a) = A(i,j) + A(comp.tloc(a),i) + comp.tiu(a,1);
comp.tloc(a) = i;
comp.WAIT = [comp.WAIT (comp.tiu(a) - A(i,j))];
comp.revenue = comp.revenue + C(i,j);