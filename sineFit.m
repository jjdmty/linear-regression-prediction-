function [sineeee]=sineFit(x, mean_m,type,ii)
color=['r','g','c','m','y','k'];%color code,ensure each plot has different color
[sineeee,goodness] = fit(x',mean_m',type);
fprintf('GOODNESS ');
fprintf(type);
disp(goodness);
plot(sineeee,color(ii));


