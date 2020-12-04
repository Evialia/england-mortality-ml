% Fit binary regression decision tree 
function [] = fitDecisionTreeToData()
    [~, dataTrain, dataTest] = GetPrepocessedData();
    
    treeMdl = fitrtree(dataTrain,"Mortality", "MinLeafSize", 8);
    mortalityPred = predict(treeMdl,dataTest);

    evaluateFit(dataTest.Mortality, mortalityPred, "Binary Regression Decision Tree");
    view(treeMdl, 'Mode', 'graph');
end


