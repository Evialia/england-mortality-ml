% Import COVID-19 Daily Mortality Data and format into monthly
% Data source: https://coronavirus.data.gov.uk/details/deaths

function [CovidMortalityData] = ProcessCovidMortalityData()

% Import COVID-19 daily mortality data for England only,
% date range 2 March 2020 - 30 September 2020
Data  = readtable('Data/Covid-19MortalityData/data_2020-Nov-24.csv', 'Range', 'D56:E268');
CovidMortalityData = table(month(datetime(Data.Var1)), Data.Var2, 'VariableNames', {'Month', 'Mortality'});

MortalityMonthlyTemp = [];

for monthNo = 3:9
    indicesForGivenMonth = find(CovidMortalityData.Month == monthNo);
    totalMortalityPerMonth = sum(CovidMortalityData.Mortality(indicesForGivenMonth(1):indicesForGivenMonth(end)));
    
    MortalityMonthlyTemp = [MortalityMonthlyTemp; monthNo, totalMortalityPerMonth];
end

CovidMortalityData = table(MortalityMonthlyTemp(:, 1), MortalityMonthlyTemp(:, 2), 'VariableNames', {'Month', 'Mortality'});