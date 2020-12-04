% Split the extracted data into training and testing set with 80:20 ratio accordingly.
function [allData, trainingSet, testingSet] = GetPrepocessedData()
   [WaitingTimes, ~, ~, CovidUnrelatedMortality] = ReadAndProcessAllData();
    
    percWaiting6PlusWeeks = WaitingTimes.Waiting_6_Plus_Weeks ./ WaitingTimes.Total_Waiting * 100 ;
    WaitingTimes = table(WaitingTimes.Year, WaitingTimes.Month, percWaiting6PlusWeeks, 'VariableNames', {'Year', 'Month', 'PercentageOfWaiting6PlusWeeks'});
    
    allData = innerjoin(WaitingTimes, CovidUnrelatedMortality);
    allData.Year = [];
    
    % Feature Mean Normalization
    allData = normalize(allData);
    
    twentyPercentOfDataHeight = height(allData) * 0.2; 

    trainingSet = allData(1:end - twentyPercentOfDataHeight, :);
    testingSet = allData(end - twentyPercentOfDataHeight + 1: end, :);
end


