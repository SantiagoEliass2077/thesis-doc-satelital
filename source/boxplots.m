%**********************************************************************
% Data processing for adg_443 values in the Magdalena River
% Script for data analysis
%**********************************************************************

% Box-and-whisker plot with outlier visualization

% Pixels to be analyzed 
pixels_analized = {
    results_docp_mag{1,1}, ...
    results_docp_mag{2,1}, ...
    results_docp_mag{3,1}, ...
    results_docp_mag{4,1}
};

names = {'Pixel1', 'Pixel2', 'Pixel3', 'Pixel4'};
n = length(pixels_analized);

% Concatenate original data and generate grouping labels
data_all = [];
groups = {};
outliers_x = []; % Outlier values
outliers_g = []; % Group indices for each outlier

for i = 1:n
    serie = pixels_analized{i};
    Q1 = quantile(serie, 0.25);
    Q3 = quantile(serie, 0.75);
    IQR = Q3 - Q1;
    
    % Limits for outlier detection
    li = Q1 - 1.5 * IQR;
    ls = Q3 + 1.5 * IQR;
    
    % Outlier detection
    idx_outliers = (serie < li) | (serie > ls);
    
    % Store outliers and their corresponding group (horizontal position)
    outliers_x = [outliers_x; serie(idx_outliers)];
    outliers_g = [outliers_g; i * ones(sum(idx_outliers), 1)];
    
    % Append data to the combined array
    data_all = [data_all; serie(:)];
    
    % Create labels for the boxplot
    etiquetas = repmat(names(i), length(serie), 1);
    groups = [groups; etiquetas];
end

% Create figure
figure('Units', 'centimeters', 'Position', [5, 5, 18, 10]);
boxplot(data_all, groups, 'Symbol', ''); % Remove default outlier symbols

% Add outliers as red crosses
hold on;
plot(outliers_g, outliers_x, 'rx', 'MarkerSize', 4, 'LineWidth', 0.5);
hold off;

% Visual adjustments
ylabel('DOC_s (mg-C/L)', 'Interpreter', 'tex', 'FontSize', 12);
ylim([0 10]);
set(gca, 'FontSize', 11, 'Box', 'on', 'TickDir', 'out', 'YGrid', 'on');

%**********************************************************************
% Data processing to extract monthly vectors
%**********************************************************************
% Initialize variables to store values for each month
%**********************************************************************
% (1) Magdalena – Monthly boxplot
%**********************************************************************

% Initialize vectors for each month
january_vector_pixel1 = [];
february_vector_pixel1 = [];
march_vector_pixel1 = [];
april_vector_pixel1 = [];
may_vector_pixel1 = [];
june_vector_pixel1 = [];
july_vector_pixel1 = [];
agugust_vector_pixel1 = [];
september_vector_pixel1 = [];
october_vector_pixel1 = [];
november_vector_pixel1 = [];
december_vector_pixel1 = [];

% September is defined as the first month
num_meses = 316;
serie = results_docp_mag{1,}; % Use the Magdalena river-mouth time series

% Loop to distribute values into their corresponding monthly vectors
for i = 1:num_meses
    mes = mod(i - 1, 12) + 1; % Month indexing (1 = September, 2 = October, ..., 12 = August)

    % Store values in the corresponding vector
    switch mes
        case 1, september_vector_pixel1 = [september_vector_pixel1; serie(i)];
        case 2, october_vector_pixel1 = [october_vector_pixel1; serie(i)];
        case 3, november_vector_pixel1 = [november_vector_pixel1; serie(i)];
        case 4, december_vector_pixel1 = [december_vector_pixel1; serie(i)];
        case 5, january_vector_pixel1 = [january_vector_pixel1; serie(i)];
        case 6, february_vector_pixel1 = [february_vector_pixel1; serie(i)];
        case 7, march_vector_pixel1 = [march_vector_pixel1; serie(i)];
        case 8, april_vector_pixel1 = [april_vector_pixel1; serie(i)];
        case 9, may_vector_pixel1 = [may_vector_pixel1; serie(i)];
        case 10, june_vector_pixel1 = [june_vector_pixel1; serie(i)];
        case 11, july_vector_pixel1 = [july_vector_pixel1; serie(i)];
        case 12, agugust_vector_pixel1 = [agugust_vector_pixel1; serie(i)];
    end
end

% Create a matrix containing monthly values
datos_mensuales = {september_vector_pixel1, october_vector_pixel1, november_vector_pixel1, december_vector_pixel1, ...
                   january_vector_pixel1, february_vector_pixel1, march_vector_pixel1, april_vector_pixel1, ...
                   may_vector_pixel1, june_vector_pixel1, july_vector_pixel1, agugust_vector_pixel1};

% Create a box-and-whisker plot for monthly data in a single figure

% Month labels (January to December)
etiquetas_meses = {'J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'};

% Monthly grouped data (January to December)
datos_meses = {january_vector_pixel1, february_vector_pixel1, march_vector_pixel1, april_vector_pixel1, may_vector_pixel1, ...
               june_vector_pixel1, july_vector_pixel1, agugust_vector_pixel1, september_vector_pixel1, ...
               october_vector_pixel1, november_vector_pixel1, december_vector_pixel1};

% Create combined data vector and grouping variable (months)
data = [];
groups = [];

for mes = 1:12
    data = [data; datos_meses{mes}]; % Concatenate data for each month
    groups = [groups; mes * ones(size(datos_meses{mes}))]; % Assign month index
end

% Create figure
figure;
boxplot(data, groups, 'Labels', etiquetas_meses, 'Colors', 'k'); % No LineWidth specified
grid on;

% Manually increase boxplot line widths
h = findobj(gca, 'Type', 'Line');
set(h, 'LineWidth', 0.6);

% Plot configuration
ylabel('mg-C/L', 'FontSize', 10);
xlabel('Months', 'FontSize', 10);
set(gca, 'FontSize', 10);
ylim([0 10]);

% Add partial horizontal lines for seasons 
hold on; % IMPORTANT: draw on top of existing plot

% Horizontal reference lines
plot([0 1], [9.5 9.5], 'Color', 'y', 'LineWidth', 2, 'LineStyle', '-');
plot([4 5], [9.5 9.5], 'Color', 'y', 'LineWidth', 2, 'LineStyle', '-');
plot([7 9], [9.5 9.5], 'Color', 'y', 'LineWidth', 2, 'LineStyle', '-');
plot([11 12.5], [9.5 9.5], 'Color', 'y', 'LineWidth', 2, 'LineStyle', '-');
plot([1 4], [9.5 9.5], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '-');
plot([5 7], [9.5 9.5], 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-');
plot([9 11], [9.5 9.5], 'Color', 'b', 'LineWidth', 2, 'LineStyle', '-');








