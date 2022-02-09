 %% ELEC2103/ELEC9103 Assignment 2019
% Put your assignment title in this comment 

%% Student details
NAME =  'Yuhan Su';
SID =   '470054570';
DATE =  '2019/09/27';


%% Abstract
% This Matlab code processed and analysis the electrical usage of Adamstown
% from 2015 to 2018. There are two sections in the code. The first section
% majority works on some basic data processing includes data loading, mean
% analysing, regression modelling and prediction, and also the goodness analysis.While the
% second section is more focus on the predictions and some advance process.

%% Section 1 Title
% In this section, I load the data first.Then I calculate the mean usage
% for 15mins each day as the raw data that I'm working on. After that I
% applys the three types of regression sinking for a better regression
% model for the data set. After that, I used the processed data getting
% some interesting value.
% After that, I would applicate the sin fit regression model prediction for 2019 with
% substitude the date of 2019 into the function resulted from the sin 9
% model, and then plot both 2015-2018 raw data and the prediction of 2019 
% in the same figure and analysis the accuraty. 
a=1;
%% 1.1 LOAD DATA
% In this part, I'm aiming to load the data file into the software successfully
% The file given is csv file,so i load the file using csvread
% majority operate for 2018,use 2015-2017 for assist
m=csvread('Adamstown 132_11kV FY2018.csv',1,4);
m17=csvread('Adamstown 132_11kV FY2017.csv',1,4);
m16=csvread('Adamstown 132_11kV FY2016.csv',1,4);
m15=csvread('Adamstown 132_11kV FY2015.csv',1,4);
%get the size for all the data
%notice:there are 366 days in 2016 while 365 days for other years.
%For eaiser analysis,i choose to ignore the last day of 2016
size_m = size(m);
size_m17 = size(m17);
size_m16 = size(m16);
size_m15 = size(m15);
%% 1.2 CALCULATE MEAN
% In this part, I'm aiming to do the primary processing to the data with
% calculating the 15-min-mean each day for all four years 
mean_m=[];
i=1;%index i
%use while loop run through the each data and find the average load for
%each 15 mins each day
%notice: the trend for 15-min-mean and daily load are same. as 15min*96= 1 day
%for easoer calculation and smaller plotting numbers, i choose to analysis
%the 15-min-mean here
while true
    mean_m(i)=mean(m(i,:));
    mean_m17(i)=mean(m17(i,:));
    mean_m16(i)=mean(m16(i,:));
    mean_m15(i)=mean(m15(i,:));
%     max_m(i)=max(m(i,:));
%     min_m(i)=min(m(i,:));
%     err_m(i)=max_m(i)-min_m(i)
    if i==size_m(1)
        break
    else 
        i=i+1;
    end 
end
%time=['0:15','0:30','0:45','1:00','1:15','1:30','1:45','2:00','2:15','2:30','2:45','3:00','3:15','3:30','3:45','4:00','4:15','4:30','4:45','5:00','5:15','5:30','5:45','6:00','6:15','6:30','6:45','7:00','7:15','7:30','7:45','8:00','8:15','8:30','8:45','9:00','9:15','9:30','9:45','10:00','10:15','10:30','10:45','11:00','11:15','11:30','11:45','12:00','12:15','12:30',	'12:45','13:00','13:15','13:30','13:45','14:00','14:15','14:30','14:45','15:00','15:15','15:30','15:45','16:00','16:15','16:30','16:45','17:00','17:15','17:30','17:45','18:00','18:15','18:30','18:45','19:00','19:15','19:30','19:45','20:00','20:15','20:30','20:45','21:00','21:15','21:30','21:45','22:00','22:15','22:30','22:45','23:00','23:15','23:30','23:45','24:0','0:00'];
Y = [mean_m15,mean_m16,mean_m17,mean_m]; 
%combine mean usage for four years in one array for easier analysis of the
%trend by years
figure('Name','Mean usage per 15mins for each day(2018)');
%figure 1 shows the usage trend for 2018 (raw data)
x = 1:1:365;
plot(x,mean_m);
title('Mean usage vs number of days(2018)');
xlabel('number of days');
ylabel('mean usage per 15mins(MW)');
%figure 2-1 shows the raw data for the four years parallelly,we can see that
%the rough trend of the four years are similar.While figure 2-2 shows the
%continous data from 2015-2018.According to the results, the electrical
%usage in summer and winter is much higher than other seasons.It seems
%there is a increasing trend over years, therefore I decided to work on the 
%continious data of 2015-2018.
figure('Name','Mean usage per 15mins each day for 2015-2018');
subplot(2,1,1);
plot(x,mean_m);
hold on;
plot(x,mean_m17);
plot(x,mean_m16);
plot(x,mean_m15);
title('Mean usage per 15mins each day for 2015-2018---1')
xlabel('number of days');
ylabel('mean usage per 15min(MW)');
legend('2018','2017','2016','2015');
hold off;
subplot(2,1,2);
plot(Y);
title('Mean usage per 15mins each day for 2015-2018--continous')
xlabel('number of days');
ylabel('mean usage per 15min(MW)');

%% 1.3.1 REGRESSION 1: linear -not works 
% As the data is too noisy, I decided to smooth it first as the basic
% processing, therefore I use regressions for data proecessing.It will not
% only smooth the data, but also shows the trend of changing.
% In this part, I'm aiming to test the linear regression model on the data
% set and check if it models well.
%figure 3 plots both raw data and the linear regression of the data, as we
%can see directly,the red line is in the region of blue dot
%distribution,thererfore the regression is valid. But,the linear regression
%isn't accurate,as the red line didn't follow the the changing trend of
%blue dot distribution (which we can see clearly as a wave shape).
%Therefore, I will try few more regression steps until find a more accurate
%one for further analysis
X = 1:1:length(Y);
p=polyfit(X,Y,1);
pp=polyval(p,X);
figure('Name','regression 1(2018)');
scatter(X,Y,'b.');
hold on;
plot(X,pp,'-r');
xlabel('number of days');
ylabel('mean usage per day(MW)');
title('regression 1(2018)');
hold off;
%% 1.3.2 REGRESSION 2: POLY FIT -not works 
% In this part, I'm aiming to test the poly fit regression modelling on the
% data, and check its goodness.
% Figure 4 shows the ploy fit of the raw data 2015-2018. poly2 to poly 9.
% As we know the rsquare value is closer to 1 while the regression is more
% accurate. In this way, we can see that while the poly number increase,
% the regression is more accurate. However, poly9 gives the 0.0841 rsquare
% for figure 4. Meanwhile we could also observe from the figure 4, polyfit
% regression is not suitable for long datas, such as the combined data of
% 2015-2018
createFit(X,Y);
% Then I try the polyfit method on raw data of 2018(figure 5)
% As mentiened above,the higher the poly number, the better fitness we
% could get, but accoridng to the feature of the poly fit function,the
% maximum poly number we that we could applied for the 2D curve is poly9,
% therefore we choose poly9 as the largest poly fit regression.
createFit(x,mean_m);
% As we can see in figure5, the poly9 regression fits the trend of raw data
% well with rsquare up tp 0.4541. Compare with the combination data of 2015
% - 2018 above, we can see that, the polyfit process is more suitable for
% shorter data rather than longer one. However, as we can see in the
% figure 5,the last part has fast decreasing unnormally, which makes the
% incaccurate of poly regression.

%% 1.3.3 REGRESSION 3: Sine fit
% Because of the inaccurate of poly fit regression, I tried the sin fit
% regression, which it did the regression by using the summation of sine
% waves.
figure('Name','Regression 3;sine wave fit(2015-2018)');
scatter(X,Y,'b.');%raw data
hold on
ii=1;%index to indicate the colors
sin2=sineFit(X,Y,'sin2',ii);
ii=ii+1;
sin4=sineFit(X,Y,'sin4',ii);
ii=ii+1;
sin6=sineFit(X,Y,'sin6',ii);
ii=ii+1;
sin9=sineFit(X,Y,'sin9',ii);
legend('raw data mean','sine2','sine4','sine6','sin9');
title('Regression 3-1;sine wave fit(2015-2018)');
xlabel('number of days');
ylabel('mean usage per 15mins(MW)');
hold off;
%figure 6 shows the sin fit regression modelling of the usage change from
%2015 to 2018. The higher the sin order, the more accurate it will be.
%As we can see, the rsquare of sin 9 is up to 0.4977, which is much higher
%than the ploy fit's. Therefore, we can say that, compare with other
%regression models sin fit regression is more accurate for these datas.
%I would like to choose the sin 9 expression for further modelling and
%prediction.

figure('Name','Regression 3;sine wave fit(2018)');
% Then I plot the data for single years and found sin 9 for single-year's
% data is too massy, which sin 6 would be better. As the rsquare reaches
% 0.5293, I choose sin6 for single year regression modelling.
scatter(x,mean_m,'b.');
hold on
ii=1;
sine2 = sineFit(x,mean_m,'sin2',ii);
ii=ii+1;
sine4 = sineFit(x,mean_m,'sin4',ii);
ii=ii+1;
sine6 = sineFit(x,mean_m,'sin6',ii);
legend('raw data mean','sine2','sine4','sine6');
title('Regression 3-2;sine wave fit(2018)');
xlabel('number of days');
ylabel('mean usage per 15mins(MW)');
hold off;
% The sine fit regression is still not really accurate. It is because the
% data for each years are continous changing in a trend of increasing or
% decreasing while the sine wave regression would always keeps in constant
% and periodic changing trend. In this way, it's hard for sine wave
% regression perfectly matches raw data. Therefore, the sine fit regression
% modelling still didn't models well.

%% 1.4  MAXIMUM DAILY LOAD - interesting values 
% In this part, I used the primary processed 15-min-mean data as the raw
% data to analysis the trend of daily load and distribution of maximum
% daily load.
load_m=mean_m*size_m(1);
load_m17=mean_m17*size_m(1);
load_m16=mean_m16*size_m(1);
load_m15=mean_m15*size_m(1);
% the daily load can be calculate using the 15 mins mean
[max_daily_load,ind] = max(load_m);%the maximum daily load and the date
[max_daily_load17,ind17] = max(load_m17);
[max_daily_load16,ind16] = max(load_m16);
[max_daily_load15,ind15] = max(load_m15);
%the max daily load of each year can be calculated by finding the maximum
%value of daily load. Meanwhile, the exact date for the max daily load can
%be known through the index, which is the nth day of the year.
printt(2018,max_daily_load,ind);
printt(2017,max_daily_load17,ind17);
printt(2016,max_daily_load16,ind16);
printt(2015,max_daily_load15,ind15);

figure ('Name','daily load(2018)');
plot(x,load_m);
title('daily load vs number of days');
xlabel('number of days');
ylabel('Daily load(MW)');
% in figure 9, we can easily observe that the daily load has exactly same
% trend as the 15-mins mean trend. Which is, there are more electrical
% usage in summer and winter of every years. However, the usage signal in 
%winter is a little bit noisy which means the uasge in winter is not
%stable.
figure('Name','max daily load');
scatter(ind15,max_daily_load15,'b*');
hold on;
scatter(ind16,max_daily_load16,'c*');
scatter(ind17,max_daily_load17,'k*');
scatter(ind,max_daily_load,'m*');
legend({'2015','2016','2017','2018'},'Location','northwest');
title('max daily load');
ylabel('load (MW)');
xlabel('Date(the xxth day)');
hold off;                     
%as we can see in the figure10, the max usage date majority distributed in winter
% However,more compirasons are requires for further analysis.
%% 1.5 prediction (sin fit regression model)
%As shown above, the sin 9 model is the most fit model for regressions,
%therefore,we would use it for the first prediction method. The predition
%would be achieved by substitude the date of 2019 as the fifth year's date
%into the sin 9 model.
XX=[length(X):1:length(X)+364];%the dates for 2019
pred_Y=sin9(XX);%sub the 2019 dates to the model and gets 15-mins-mean load

figure('Name','prediction of 2019');
plot(sin9);
hold on;
plot(Y);
plot(XX,pred_Y);
xlabel('number of days');
ylabel('Mean usage per 15mins each day(MW)');
legend('-2018regression','rawdata','2019 pred');
hold off;
% The figure 11 showns the result of predition as a combination of raw data
% of 2015-2018 and presiction of 2019 based on 'sin9'.Accoring to the
% verify of the prediction result, I found that the highest point of 
% electrical usage (ignore noise)in the first 100 days of the five years are very close to each
% other, while the increasing and decreasing trend are nearly unanimity,
% especially compare with 2015-2017. However, the predictions for the rest
% days are totally different from preior years. Therefore,I can say that
% the model is successful for predicting the first 100 days of next year (ignore the noise).
%% Section 2 Title
% In this section, some more advanced process would be applied for
% accessing the modelling and do predictions for future years. 
% Firstly, I would apply the horizontal prediction model to predict data
% in 2019 horizontally. This model works by comparing the usage of each day 
% for the four years and cames up a linear trend for the usage change in
% on the same date but different year. Then I will use the linear trends to
% calculate the usage for the fifth year, which is 2019. In this way, the
% predict result could be reletively accurate. After that,I would do an
% advance proccess by applying the ARIMA model and using the residual error
% analysis to assess the model. In addition,I made a neural network time series model, which is not works for this data
b=1;

%% 2.1 horizontal prediction 2019
% Base on the prediction by regression in section 1,I found that it might
% be a good way if I do the horizontal comparison of the data for each day
% in four years, then come up a linear trend for the changing of the same
% day usage over years. Therefore the fifth year's (2019) usage on the same
% day could be calculated. 
% To achieve that, I used a for loop to go through every day in the four
% years, and use the linear equation I got from last four years to
% calculate and predict the fifth year's, which is the value pf.
for i=1:365
    yf=[mean_m15(i),mean_m16(i),mean_m17(i),mean_m(i)];
    f = fit([1:1:4]',yf','smoothingspline');
    pf(i)=f(5); % the prediction of 2019
end 
figure('Name','Horizontal prediction 2019');
subplot(2,1,1);
plot(mean_m);
hold on;
plot(mean_m15);
plot(pf);
legend('2018','2015','predict 2019')
hold off;
title('predict 2019 vs number of days');
xlabel('number of days');
ylabel('Mean usage per 15mins each day(MW)');
subplot(2,1,2);
plot(X,Y);
hold on;
plot(XX,pf);
title('predict 2019 & raw data 2015~2018');
xlabel('number of days');
ylabel('Mean usage per 15mins each day(MW)');
legend('2015-2018','2019');
hold off;
figure('Name','Mean 15 mins load 2015-2019(predict 19)');
plot([mean(mean_m15),mean(mean_m16),mean(mean_m17),mean(mean_m),mean(pf)]);
% In figure 12, the upper figure shows the parallel comparison of 2015,2018
% and the predicted data of 2019. As mentioned before in figure 3, we can
% observe an increasing trend of electrical usage over years and also the
% tough trend are similar for 2015-2018. Then I substitude the observation
% to the top figure of figure 12 and observed that there is a increasing
% trend from 2015-2019 over the years while the touch trend of single years
% are very similar. And we can also see that the predict data of 2019
% joints well with 2015-2018 in the bottom figure of figure 12. However,
% because there are some noises exists in 2015-2018 data,the prediction
% inherit the noise from all years,which might lower the accuracy of the
% horizontal prediction. In addition, if there is any real data for 2019,
% we can check the accuracy by calculating the error between real data and
% the predict data.
% As the model is built by the comparison and find the linear equation of
% the same date for each years, the accuracy would highly denpends on the
% noise rate for each years. But because of the linear comarison, the
% predition is reliable.
% However, in figure 13, I did a double check of the increasing trend over
% years. The figure plots the whole year' s average for 15mins usage
% in 2015-2019. In which the trend is quite similar with each single days.
% Overall, the Horizontal prediction of 2019 is reliable but not too
% accurate due to the noises.


%% 2.2 ARIMA model 
% The ARIMA process is always used for preicting time series. The model was
% built base on a long-termed time based real data, which commonly applied
% in predicting stock market quotation. Therefore, it could be a good model
% for the electrical usage over time.
% In this section,I would do the stationary test first. If the data didn't
% pass the test, I would process it until it pass. Then form the ARIMA
% model and do the residual examination for the model to check if it is
% accurate and reliable.
% stationary test: Use ADF and KPSS function test
% notice: we want te testing result as 1,0
yadf = adftest(Y);
ykpss = kpsstest(Y);%result as 1,1, not pass
% then we use the log value of the data, therefore to eliminate the
% increasing trend, hope it would make the data pass the test
Ylog = log(Y);
ylog_df = adftest(Ylog);
ylog_kpss = kpsstest(Ylog);%result as 0,1, not pass!
%disassembly the data until it states and pass the 
for i = 1:length(Y)-1
    YY(i) = Ylog(i+1)-Ylog(i);
end
YY_adf = adftest(YY);
YY_kpss = kpsstest(YY);%result as 1,0, pass
% The data pass the stationary test just after the first disassembly
% process,then I move to determine the order of model. In this part, we are
% using ACF and PACF to determine the order.
figure('Name','ACF & PACF(raw data)');
subplot(2,1,1);
title('ACF(2015-2018)');
autocorr(Y);
subplot(2,1,2)
title('PACF(2015-2018)');
parcorr(Y)
% figure14(code above), shows the  ACF and PACF of the raw data before
% processing, while the figure 15 (code below) shows the result for data
% after the primary processing during the stationary test.
figure('Name','ACF & PACF(after processing)');
subplot(2,1,1);
title('ACF(2015-2018)');
autocorr(YY);
subplot(2,1,2)
title('PACF(2015-2018)');
parcorr(YY);
%according to the figure 15 p is the last point over threshold (blue line)in the top figure,
%which is 12, while q is the lower figures, which is 17. However,the
%coeffitient is a little bit large, which were supposed to be below 3. The 
%large coeffitient shows that the model would not be so accurate. The ideal
%condition for the result is that there is no points get over the blue
%threshold line.
p=12;
q=17;
%residual error analysis
arimaa(Y,YY,p,q);
%The residual error analysis gives me figure 16 and 17. While figure 16
%shows the figures for standardized residuals, which is used to check if
%the residual error is in normal distribution,the ideal condition is which
%in normal distribution, as we got. And the figure 17 is the QQ plot which
%is also used to check for the normal distribution of restribution error.
%However,the ideal condition is when all the blue plots are close to the
%red line. As shown in the figure, our result is pretty good.
%according to the figure plotted, the model has ability for prodiction. But
%according to the p and q number,the pq number is too high, as it supposed 
%to be lower than 3 the prediction would not be so accurate. In this way,
%we can say that, the ARIMA model is reliable and predictable but not so 
%accurate.

%% 2.3 neural net work model (fail)
% The neural network system is inspired by the human nad other animal brain
% network system. The system could "learn" from different data. Which means
% it could develop by training. And it could catch the features.
%In this part, I built a neural network model using the APP provided by
%MATLAB software. The data I used to train the system is the 15mins-mean
%usage for 2015-2018. However, as shown in figure, the model is totaly not
%accurate. More data should be used to train the model, therefore it could
%get a more accurate model.
figure('Name','Neural network Model');
plot(X,Y);
hold on;
plot(X,myNeuralNetworkFunction(1:1460,[1,1]));
hold off;    
legend('raw data(2015-2018)','modelling');

%% University of Sydney statement concerning plagiarism
% I certify that:
%
% (1) I have read and understood the University of Sydney Academic Dishonesty and Plagiarism Policy  (found by following the  Academic Honesty link on the Unit web page).';
%
% (2) I understand that failure to comply with the Student Plagiarism: Coursework Policy and Procedure can lead to the University commencing proceedings against me for potential student misconduct under Chapter 8 of the University of Sydney By-Law 1999 (as amended).';
%
% (3) This Work is substantially my own, and to the extent that any part of this Work is not my own I have indicated that it is not my own by Acknowledging the Source of that part or those parts of the Work as described in the assignment instructions.';
%
% Name: Yuhan Su
%
% SID: 470054570
%
% Date: 28/09/2019
