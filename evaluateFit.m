function evaluateFit(y,ypred,name)
figure
% Plot against sample number
subplot(2,2,1)
plot(y,'O')
hold on
plot(ypred,'X')
hold off
title(name)
legend('Actual', 'Predicted');
xlabel('Sample Number')
ylabel('Mortality')


% Plot predicted and actual against each other
subplot(2,2,2)
scatter(y,ypred,'o')
% Add 45-degree line
xl = xlim;
hold on
plot(xl,xl,'k:')
hold off
title(name)
xlabel('Actual Mortality')
ylabel('Predicted Mortality')


% Distribution of errors
subplot(2,2,3)
err = y-ypred;
MSE = mean(err.^2,'omitnan');
histogram(err)
title(['MSE = ',num2str(MSE,4)])
xlabel('Prediction error')


% Distribution of percentage errors
subplot(2,2,4)
err = 100*err./y;
MAPE = mean(abs(err),'omitnan');
histogram(err)
title(['MAPE = ',num2str(MAPE,4)])
xlabel('Prediction percentage error')
