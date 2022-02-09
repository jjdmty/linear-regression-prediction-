function arimaa(Y,YY,p,q)
Mdl = arima(p, 0, q);
estimated_Mdl = estimate(Mdl,YY');
[res,~,logL] = infer(estimated_Mdl,Y');   %residual 
ss = res/sqrt(estimated_Mdl.Variance);
% plot figures
figure('Name','Standardized Residuals')
subplot(2,1,1);
plot(ss)
title('Standardized Residual--1')
subplot(2,1,2);
histogram(ss,10)
title('Standardized Residuals--2')
figure
qqplot(ss);


%reference:https://zhuanlan.zhihu.com/p/69630638 