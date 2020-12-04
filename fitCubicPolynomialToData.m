function [] = fitCubicPolynomialToData()
    [~, dataTrain, dataTest] = GetPrepocessedData();

% Uncomment to experiment with 3 months mortality offset
%     allData = readtable('allDataMortalityOffsetBy3Months.csv');
%     allData = normalize(allData);
%     dataTrain = allData(1:120, :);
%     dataTest = allData(121:end, :);
    
    month = dataTrain.Month;
    mortality = dataTrain.Mortality;
    percentageOfWaiting6PlusWeeks = dataTrain.PercentageOfWaiting6PlusWeeks;

    polyFit = fit([month, percentageOfWaiting6PlusWeeks], mortality, 'poly33', 'Normalize','on','Robust','on');
    
    plot(polyFit, [month, percentageOfWaiting6PlusWeeks], mortality);
    xlabel('Month'); ylabel('Percentage of Waiting 6 Plus Weeks'); zlabel('Mortality');

    monthTest = dataTest.Month;
    mortalityPred = polyFit([monthTest, dataTest.PercentageOfWaiting6PlusWeeks]);

    evaluateFit(dataTest.Mortality, mortalityPred, "Cubic Polynomial Model")
end