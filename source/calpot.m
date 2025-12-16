function [vector_adg_443_total, docp_imputado, porcentaje_nans, nan_positions] = calpot(timevector, varargin)
    % This function takes a variable number of tables as input and returns
    % a vector with all adg_443 values, calculates the DOCp,
    % interpolates NaN values, and generates the percentage of NaNs.

    %    Initialize the vector to store all values of adg_443
    vector_adg_443_total = [];

    % Iterate over each table provided
    for i = 1:nargin-1  % Subtract 1 because the first argument is time_vector
        resultTable = varargin{i};
        % Extract the adg_443 vector from the table
        vector_adg_443_total = [vector_adg_443_total; resultTable.value_adg_443(:)];
    end
    
    % Locate the NaNs in the adg_443 vector
    total_elements = numel(vector_adg_443_total);
    num_nans = sum(isnan(vector_adg_443_total));
    porcentaje_nans = (num_nans / total_elements) * 100;
    disp([' NaNs % in adg_443: ', num2str(porcentaje_nans), '%']);
    
    % Locate NaNs and NO NaNs indices
    ii = find(isnan(vector_adg_443_total));
    jj = find(~isnan(vector_adg_443_total));
    
    % Interpolation to fill in the NaNs in adg_443
    if ~isempty(jj) && ~isempty(ii) % Ensure that there are values to interpolate
        Vq = interp1(timevector(jj), vector_adg_443_total(jj), timevector(ii), 'pchip');

        % Identify the positions of the NaNs
        nan_positions = isnan(vector_adg_443_total);
        
        % Assign the interpolated values to the NaN positions
        vector_adg_443_total(nan_positions) = Vq;  % Asignar valores interpolados

        % If there are NaNs that could not be interpolated, replace them with 0.
        vector_adg_443_total(isnan(vector_adg_443_total)) = 0;  
    else
        warning('There is insufficient data to interpolate in adg_443. All NaNs will be replaced with 0.');
        vector_adg_443_total(isnan(vector_adg_443_total)) = 0;  % Replace NaNs with 0
        nan_positions = isnan(vector_adg_443_total);
    end

    % Initialize the docp_imputado vector with zeros
    docp_imputado = zeros(size(vector_adg_443_total));

    % Calculate salinity and DOCp after interpolation (from the model in the study)
    salinity = (36.65 - (26.1 * vector_adg_443_total));

    % Iterate through each value of vector_adg_443_total and apply the condition
    for i = 1:length(vector_adg_443_total)
        if vector_adg_443_total(i) == 0
            docp_imputado(i) = 0; % If vector_adg_443_total is 0, docp_imputado is 0
        else
        docp_imputado(i) = 5.3 - (0.12 * salinity(i)); % Otherwise, calculate docp_imputado
        end
    end

% Display results
disp('Imputed DOCp vector (mg C/L)');
disp(docp_imputado);