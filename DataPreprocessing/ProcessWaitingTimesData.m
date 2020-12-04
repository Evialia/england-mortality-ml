% Data source: https://www.england.nhs.uk/statistics/statistical-work-areas/diagnostics-waiting-times-and-activity/monthly-diagnostics-waiting-times-and-activity/

% Data points collected from the original Data (xls workbooks):
%   1. Total Waiting List
%   2. Number waiting 6+ Weeks
%   3. Number waiting 13+ Weeks

% Exceptions:
%   1. 2008 data only available from April
%   2. 2008 May - Dec & 2009 Jan - Feb there are pre-calculated total values for required data points; 
%      cell range: F6:H6
%   3. 2010 Jun - Nov there are pre-calculated total values for required data points; 
%      cell range: F7:H7
%   4. Jun 2017 onwards data contains pre-calculated total values for required
%      data points; cell range: F15:H15
%   5. 2020 data - only available upto September
%   6. Because of the abnormal inconsistency of the dataset the total values for the required 
%      data points have been manually added  in the rest of he xls
%      workbooks; cell Ranges F1:H1

function [WaitingTimesDataTable] = ProcessWaitingTimesData()
    years = []; months = []; totalWaiting = []; waiting6PlusWeeks = []; waiting13PlusWeeks = [];

    for year = 2008:2020
        for monthNo = 1:12
            if year == 2008 && (monthNo < 4)
                continue;
            elseif year == 2008 && (monthNo > 4) || (year == 2009 && (monthNo < 3))
                [years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks] = getData(year, monthNo, years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks, 'F6:H6');
            elseif year == 2010 && (monthNo > 5 && monthNo < 12)
                [years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks] = getData(year, monthNo, years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks, 'F7:H7');
            elseif year == 2020 && (monthNo > 9)
                 continue;
            elseif year > 2017 || (year == 2017 && monthNo > 6)
                [years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks] = getData(year, monthNo, years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks, 'F15:H15');
            else
                [years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks] = getData(year, monthNo, years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks, 'F1:H1');
            end
        end
    end
    WaitingTimesDataTable = table (years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks, 'VariableNames', {'Year', 'Month', 'Total_Waiting', 'Waiting_6_Plus_Weeks', 'Waiting_13_Plus_Weeks'});
end

function [years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks] = getData(year, monthNo, years, months, totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks, cellRange)
    [totalWaitingTemp, waiting6PlusWeeksTemp, waiting13PlusWeeksTemp] = getWaitingTimeDataForEngland(year, monthNo, cellRange);
    
    totalWaiting = [totalWaiting; totalWaitingTemp];
    waiting6PlusWeeks = [waiting6PlusWeeks; waiting6PlusWeeksTemp];
    waiting13PlusWeeks = [waiting13PlusWeeks; waiting13PlusWeeksTemp];

    years = [years; year];
    months = [months; monthNo];
end

function [totalWaiting, waiting6PlusWeeks, waiting13PlusWeeks] = getWaitingTimeDataForEngland(year, monthNo, cellRange)
    monthStr = char(month(datetime(year, monthNo, 01), 'shortname'));
    yearStr = num2str(year);
    
    waitingTimeFigures  = readtable(['Data/WaitingTimesPerMonth/', yearStr, '/', monthStr, ' ', yearStr, '.xls'], 'Range', cellRange);
    totalWaiting = waitingTimeFigures.Var1;
    waiting6PlusWeeks = waitingTimeFigures.Var2;
    waiting13PlusWeeks = waitingTimeFigures.Var3;
end