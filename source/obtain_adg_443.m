function resultTable = obtain_adg_443(directory, pixel_x_target, pixel_y_target)
    % List of month names (needs to be changed on your language)
    months = {'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', ...
             'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'};

    % Initialize an array of cells to store the results
    resultCellArray = cell(0, 1);  % Create an empty cell array

    % Iterate over each month
    for k = 1:length(months)
        % Generate the file name for the current month
        filename = fullfile(directory, [months{k}, '.txt']);
        
        % Check if the file exists
        if exist(filename, 'file') == 2
            % El archivo existe, procede a leerlo
            opts = detectImportOptions(filename, 'Delimiter', '\t');
            data = readtable(filename, opts);

            % Find the corresponding index for the pixels
            index = data.Pixel_X == pixel_x_target & data.Pixel_Y == pixel_y_target;

            % Extract the value of adg_443 and flags
            value_adg_443 = data.CDM(index);
            flags_value = data.flags(index);  % Get the value of flags

            % Check if a value was found for adg_443
            if isempty(value_adg_443)
                value_adg_443 = NaN;  % If no value is found, assign NaN
            elseif iscell(value_adg_443)
                value_adg_443 = cell2mat(value_adg_443);  % Convert cells to array if necessary
            end

            % Assign value_adg_443 to 0 if flags equals 1
            if ~isempty(flags_value) && flags_value == 1
                value_adg_443 = 0;  % Assign 0 if flags is 1
            end
            
            % Add the value to the cell
            resultCellArray{end + 1, 1} = value_adg_443;  % Store the value in the cell array
        else
            % The file does not exist.
            warning('File %s don´t exist. Skipping...', filename);
            continue;
        end   
    end

    % Convert the cell array to a table
    resultTable = cell2table(resultCellArray, 'VariableNames', {'value_adg_443'});

    % Display the results table
    disp(resultTable);
end


