%Fitting a Ridge Regression Model
function [] = fitRidgeRegressionToData()
    [~, dataTrain, dataTest] = GetPrepocessedData();

    % Training data split
    mortalityTrain = dataTrain.Mortality;
    PredictorsTrain = [dataTrain.Month, dataTrain.PercentageOfWaiting6PlusWeeks];

    % Testing data split
    mortalityTest = dataTest.Mortality;
    PredictorsTest = [dataTest.Month, dataTest.PercentageOfWaiting6PlusWeeks];

    % Create a vector lambda of integers from 0 to 500. 
    % Perform ridge regression on the training data for the values in lambda. 
    % Return is the coefficients in the scale of the original data.
    lambda = 0:500;
    coeffsForLambda = ridge(mortalityTrain, PredictorsTrain, lambda, 0);

    % Plot b against lambda to see how the coefficients change as λ increases.
    figure
    plot(lambda, coeffsForLambda);
    legend('x1', 'x2', 'x3')
    title("Coefficients Change as λ Increase")
    xlabel("Lambda"); ylabel("Coefficients");
    
    % Predict the mortality for the test data PredictorsTest.
    mortalityPred = PredictorsTest * coeffsForLambda(2:end,:) + coeffsForLambda(1, :);

    % Calculate mean squared error.
    % The result is a row vector of the mean squared error for each parameter in the vector lambda.
    err = mortalityTest - mortalityPred;
    mdlMSE = mean(err.^2);

    % Find smallest MSE
    [~,idx] = min(mdlMSE);
    
    evaluateFit(mortalityTest,mortalityPred(:,idx), "Ridge Regression Model")
end
