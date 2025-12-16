%**********************************************************************
% Data processing for adg_443 values in the Magdalena River
% Script for data analysis
% This script takes 13 minutes aprox to run
%**********************************************************************
clear,close all,clc

%=====================================================================
% (1) Create the time vector
%=====================================================================
% Start date
startDate = datetime(1997, 9, 15);

% End Date
endDate = datetime(2023, 12, 15);

timevector= startDate:calmonths(1):endDate;

disp(timevector);

%=====================================================================
%(2)  Create the directories (USER MUST EDIT THIS)
%=====================================================================

% --- USER CONFIGURATION ---
% Path to the RAW data folder for the selected river
% Example:
% baseDir = 'C:\Users\YOURNAME\...\raw\Magdalena';

baseDir = 'C:\Users\santi\OneDrive\Desktop\thesis-doc-satelital\data\raw\Magdalena';
% -------------------------

years = 1997:2023;
for y = years
    varName = sprintf('directory%d', y);
    varPath = fullfile(baseDir, num2str(y));
    eval([varName ' = varPath;']);
end
%=====================================================================
% (3) MAGDALENA
% Initialize the pixel grid
% A pixel grid was created using a script that iterates through text files,
% extracting CDM values according to predefined X and Y coordinate ranges
%=====================================================================

%Define the ranges of X and Y values for Magalena
x_range = 2516.5:1:2530.5;
y_range = 1879.5:1:1893.5;

% Initialize a cell to store the result vectors
results_docp_mag = cell(length(y_range), length(x_range));
% Initialize another cell to store NaN values
resultados_Nans_mag = cell(length(y_range), length(x_range));
% Initialize another cell to store the values of adg_443
results_adg_443_mag = cell(length(y_range), length(x_range));
% Initialize a cell to store the coordinate values of the pixels
pixels_coord_mag = cell(length(y_range), length(x_range));


% Nested loop to traverse X and Y
for i = 1:length(x_range)
    for j = 1:length(y_range)
        % Define the current values of X and Y
        pixel_x_target = x_range(i);
        pixel_y_target = y_range(j);

       % Call the function get_adg_443 for each combination of X and Y
       % Get the results for 1997 to 2023
        resultTable1997 = obtain_adg_443(directory1997, pixel_x_target, pixel_y_target);
       
        resultTable1998 = obtain_adg_443(directory1998, pixel_x_target, pixel_y_target);
       
        resultTable1999 = obtain_adg_443(directory1999, pixel_x_target, pixel_y_target);
       
        resultTable2000 = obtain_adg_443(directory2000, pixel_x_target, pixel_y_target);
      
        resultTable2001 = obtain_adg_443(directory2001, pixel_x_target, pixel_y_target);
       
        resultTable2002 = obtain_adg_443(directory2002, pixel_x_target, pixel_y_target);
       
        resultTable2003 = obtain_adg_443(directory2003, pixel_x_target, pixel_y_target);
        
        resultTable2004 = obtain_adg_443(directory2004, pixel_x_target, pixel_y_target);
        
        resultTable2005 = obtain_adg_443(directory2005, pixel_x_target, pixel_y_target);
  
        resultTable2006 = obtain_adg_443(directory2006, pixel_x_target, pixel_y_target);

        resultTable2007 = obtain_adg_443(directory2007, pixel_x_target, pixel_y_target);
    
        resultTable2008 = obtain_adg_443(directory2008, pixel_x_target, pixel_y_target);
       
        resultTable2009 = obtain_adg_443(directory2009, pixel_x_target, pixel_y_target);
       
        resultTable2010 = obtain_adg_443(directory2010, pixel_x_target, pixel_y_target);
      
        resultTable2011 = obtain_adg_443(directory2011, pixel_x_target, pixel_y_target);
    
        resultTable2012 = obtain_adg_443(directory2012, pixel_x_target, pixel_y_target);
      
        resultTable2013 = obtain_adg_443(directory2013, pixel_x_target, pixel_y_target);
    
        resultTable2014 = obtain_adg_443(directory2014, pixel_x_target, pixel_y_target);
      
        resultTable2015 = obtain_adg_443(directory2015, pixel_x_target, pixel_y_target);
  
        resultTable2016 = obtain_adg_443(directory2016, pixel_x_target, pixel_y_target);
     
        resultTable2017 = obtain_adg_443(directory2017, pixel_x_target, pixel_y_target);
     
        resultTable2018 = obtain_adg_443(directory2018, pixel_x_target, pixel_y_target);
    
        resultTable2019 = obtain_adg_443(directory2019, pixel_x_target, pixel_y_target);
    
        resultTable2020 = obtain_adg_443(directory2020, pixel_x_target, pixel_y_target);
    
        resultTable2021 = obtain_adg_443(directory2021, pixel_x_target, pixel_y_target);
   
        resultTable2022 = obtain_adg_443(directory2022, pixel_x_target, pixel_y_target);
   
        resultTable2023 = obtain_adg_443(directory2023, pixel_x_target, pixel_y_target);

        % Calculate the vectors of adg_443 and DOCp
        [vector_adg_443_total, docp_imputado, nan_positions] = calpot(timevector,resultTable1997, resultTable1998, resultTable1999, resultTable2000, ...
                                                               resultTable2001, resultTable2002, resultTable2003, resultTable2004, ...
                                                               resultTable2005, resultTable2006, resultTable2007, resultTable2008, ...
                                                               resultTable2009, resultTable2010, resultTable2011, resultTable2012, ...
                                                               resultTable2013, resultTable2014, resultTable2015, resultTable2016, ...
                                                               resultTable2017, resultTable2018, resultTable2019, resultTable2020, ...
                                                               resultTable2021, resultTable2022, resultTable2023);

        results_adg_443_mag{j, i} = vector_adg_443_total  %  Save in the corresponding position
        % Save the resulting vector from doc in the cell
        results_docp_mag{j, i} = docp_imputado;  % Save in the corresponding position
        % Save the coordinates of the pixels in the cell
        pixels_coord_mag{j, i} = [pixel_x_target, pixel_y_target]; %  Store the coordinates as a vector
    end
end



%=====================================================================
% (1) Create the directories
%=====================================================================
% List of predefined directories
directories = {directory1997, directory1998, directory1999, directory2000, ...
               directory2001, directory2002, directory2003, directory2004, ...
               directory2005, directory2006, directory2007, directory2008, ...
               directory2009, directory2010, directory2011, directory2012, ...
               directory2013, directory2014, directory2015, directory2016, ...
               directory2017, directory2018, directory2019, directory2020, ...
               directory2021, directory2022, directory2023};


%=====================================================================
% (2) Initialization for coordinates
%=====================================================================
% Define X and Y ranges
x_range = 2516.5:1:2530.5;
y_range = 1879.5:1:1893.5;

% Initialize cells to store Longitude and Latitude
longitudes_mag = cell(length(y_range), length(x_range));
latitudes_mag = cell(length(y_range), length(x_range));

% List of months
meses = {'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', ...
         'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'};

%=====================================================================
% (3) Main loop to iterate over X, Y, and data files
%=====================================================================
for i = 1:length(x_range)
    for j = 1:length(y_range)
        pixel_x_target = x_range(i);  % Current X value
        pixel_y_target = y_range(j);  % Current Y value

        % Initialize temporary variables for Longitude and Latitude
        longitude_temp = NaN; 
        latitude_temp = NaN;

        % Iterate through all directories and files
        for d = 1:length(directories)
            for k = 1:length(meses)
                % Generate the path for the current file
                filename = fullfile(directories{d}, [meses{k}, '.txt']);

                % Check if the file exists
                if exist(filename, 'file') == 2
                    % Read the file as a table
                    opts = detectImportOptions(filename, 'Delimiter', '\t');
                    data = readtable(filename, opts);

                    % Search for matches with the target pixels
                    index = data.Pixel_X == pixel_x_target & data.Pixel_Y == pixel_y_target;

                    if any(index)
                        % Extract Longitude and Latitude values
                        longitude_temp = data.Longitude(index);
                        latitude_temp = data.Latitude(index);
                        break;  % Exit loop if value is found
                    end
                end
            end
            if ~isnan(longitude_temp) && ~isnan(latitude_temp)
                break;  % If values are found, exit loop
            end
        end

        % Store values in the corresponding cells
        longitudes_mag{j, i} = longitude_temp;
        latitudes_mag{j, i} = latitude_temp;
    end
end


