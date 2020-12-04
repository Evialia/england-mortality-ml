% Import raw data sets & extract essential features.

% The raw data sets include:
%   1. Monthly waiting times and activity for diagnostic tests and procedures for
%      NHS England from April 2008 to September 2020.
%   2. Monthly figures on deaths registered in England and Wales from
%      January 2008 to September 2020.
%   3. COVID-19 daily mortality figures as of March 2020.

% Required features:
%   1. Total waiting list, number of patients waiting 6+ weeks and 13+
%   weeks per month per year.
%   2. Total Mortality figures per month per year (for England only).
%   3. COVID-19 mortality data per month (March - September 2020) for England
%   only.
%   4. COVID-19 unrelated mortality figures per month per year (for England
%   only).

function [WaitingTimes, TotalMortality, CovidRelatedMortality, CovidUnrelatedMortality] = ReadAndProcessAllData()
    WaitingTimes = ProcessWaitingTimesData();
    TotalMortality = ProcessMonthlyMortalityData();
    CovidRelatedMortality = ProcessCovidMortalityData();
    CovidUnrelatedMortality = getCovidUnrelatedMortality(TotalMortality, CovidRelatedMortality);
end

function [CovidUnrelatedMortality] = getCovidUnrelatedMortality(TotalMortality, CovidRelatedMortality)
    CovidUnrelatedMortality = TotalMortality;
    
    for monthno = 3:9
        monthIndexTotalMortality = find(TotalMortality.Year == 2020 & TotalMortality.Month == monthno);
        monthIndexCovidRelatedMortality = find(CovidRelatedMortality.Month == monthno);
        
        mortalityExludingCovidPerMonth = CovidUnrelatedMortality.Mortality(monthIndexTotalMortality) - CovidRelatedMortality.Mortality(monthIndexCovidRelatedMortality);
        
        CovidUnrelatedMortality.Mortality(monthIndexTotalMortality) = mortalityExludingCovidPerMonth;
    end
end