function createFit(x, mean_m)
[fitpoly2,goodness2] = fit(x',mean_m','poly2');
[fitpoly4,goodness4] = fit(x',mean_m','poly4');
[fitpoly9,goodness9] = fit(x',mean_m','poly9');% The fit function produced by the 9th polynomial equation
disp('goodness2');
disp(goodness2);%the goodness would includes the rsquare
disp('goodness4');
disp(goodness4);
disp('goodness9');
disp(goodness9);
figure('Name','Regression 3;polynomial');
scatter(x,mean_m,'b.');
hold on;
plot(fitpoly9,'r');
plot(fitpoly4,'m');
plot(fitpoly2,'g');
if x<1000
    title('Regression 2-1;polynomial(2018)');
else
    title('Regression 2-2;polynomial');
end 
xlabel('number of days');
ylabel('mean usage per day(MW)');
legend('raw data mean','poly9','poly4','poly2');
hold off;