close all;
clc;

% Read the seismic data
data = readmatrix("siesmic_data.csv"); % Use readmatrix for robustness

% Plot original data
figure;
subplot(2,1,1)
plot(data);
title('Original Data');
xlabel('Sample Index');
ylabel('Amplitude');

% Data points
y = []; % Initialize y as empty
j = 1;
for i = 1:10:19999
    y(j) = data(i);
    j = j + 1;
end
L = length(y); % Calculate the length after y is filled
t = [1:2000]; % Time vector

% Plot sampled data
subplot(2,1,2)
plot(y)
title('Sampled Data (every 10th point)');
xlabel('Sample Index');
ylabel('Amplitude');

% Number of Fourier coefficients
% N = 100;
% N=500;
N=2000;

% Plot sampled data for Fourier transform
 figure;
 plot(t, y, 'b', 'DisplayName', 'Sampled Amplitude');
 grid on
 xlabel('Sample Index')
ylabel('Amplitude')
hold on;

% Function to calculate area using trapezoidal rule
function[area]=calc_area(t,fx)
    area = 0;
    for i = 1:length(t)-1 % Ensure not to exceed bounds
        width = t(i+1) - t(i);
        height = (fx(i+1) + fx(i)) / 2;
        area = area + (height * width);
    end
end

% Calculate a0 coefficient
a0 = (1/L) * calc_area(t, y);

% Initialize Fourier coefficients
an = zeros(1, N);
bn = zeros(1, N);

% Calculate Fourier coefficients
for ii = 1:N
    ft1 = y .* cos(((2 * pi * ii) / L) * t);
    ft2 = y .* sin(((2 * pi * ii) / L) * t);
    an(ii) = (2/L) * calc_area(t, ft1);
    bn(ii) = (2/L) * calc_area(t, ft2);
end

% Reconstruct the signal using Fourier series
ft_ii = zeros(1, length(t)) + a0; % Initialize with a0
for ii = 1:N
    fourier_coeff = (an(ii) * cos(((2 * pi * ii) / L) * t) + bn(ii) * sin(((2 * pi * ii) / L) * t));
    ft_ii = ft_ii + fourier_coeff;
end

% Plot the reconstructed signal
plot(t, ft_ii, 'r', 'LineWidth', 2, 'DisplayName', ['N = ', num2str(N)]);
legend show;
title('Fourier Series Approximation');
