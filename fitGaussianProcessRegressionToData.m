% Fit Gaussian Process Regression
function [] = fitGaussianProcessRegressionToData()
    gaussianProcessRegModel = fitrgp(dataTrain, "Mortality", "KernelFunction", "rationalquadratic", 'DistanceMethod', 'accurate');
    mortalityPred = predict(gaussianProcessRegModel, dataTest);
    evaluateFit(dataTest.Mortality, mortalityPred, "GPR Model");
end
