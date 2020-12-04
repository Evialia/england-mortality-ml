function [MortalityDataTable] = ProcessMonthlyMortalityData()
    mortalityFigures = []; years = []; months = [];

    % Get total mortality figures for England from April 2008. Required cells: H9:P9
    [years, months, mortalityFigures] = getMortalityData(2008, 'H9:P9', years, months, mortalityFigures);
    
    % Get total mortality figures for England from 2009 - 2010. Required cells: E9:P9
    for year = 2009:2010
        [years, months, mortalityFigures] = getMortalityData(year, 'E9:P9', years, months, mortalityFigures);
    end

    % Get total mortality figures for England from 2011. Required cells: D9:O9
    [years, months, mortalityFigures] = getMortalityData(2011, 'D9:O9', years, months, mortalityFigures);

    % Get total mortality figures for England from 2012 - 2014. Required cells: D10:O10
    for year = 2012:2014
        [years, months, mortalityFigures] = getMortalityData(year, 'D10:O10', years, months, mortalityFigures);
    end

    % Get total mortality figures for England from 2015 - 2020. Required cells: C10:N10
    for year = 2015:2019
        [years, months, mortalityFigures] = getMortalityData(year, 'C10:N10', years, months, mortalityFigures);
    end

    % Get total mortality figures for England for 2020 (only to September). Required cells: C10:N7
    [years, months, mortalityFigures] = getMortalityData(2020, 'C10:K10', years, months, mortalityFigures);

    MortalityDataTable = table (years, months, mortalityFigures, 'VariableNames', {'Year', 'Month', 'Mortality'});
end

function [years, months, mortalityFigures] = getMortalityData(year, cellRange, years, months, mortalityFigures)    
    figures = getMortalityDataFromWorksheet(year, cellRange);
    mortalityFigures = [mortalityFigures; figures];
    years = [years; getYearVector(year, figures)];
    
    if year == 2008
        firstmonth = 4;
        lastmonth = 12;
    else   
        firstmonth = 1;
        lastmonth = length(figures);
    end
    
    months = [months; (firstmonth:lastmonth)'];
end

function [years] = getYearVector(year, data)
    years = zeros(length(data), 1);
    years(:) = year;
end

function [mortalityFigures] = getMortalityDataFromWorksheet(year, cellRange)
    mortalityFigures  = readtable(['Data/MonthlyMortalityData/', num2str(year), '.xls'], 'Sheet', ['Figures for ' num2str(year)], 'Range', cellRange);
    mortalityFigures = table2array(mortalityFigures)';
end
    