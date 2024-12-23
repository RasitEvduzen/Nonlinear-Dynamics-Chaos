clc; clear; close all;
% Mandelbrot Fractals
% Written By: Rasit
% Date: 23-Dec-2024

%% Params
m = 1920; % Image width
n = 1080; % Image height
x = linspace(-2, 1, m);
y = linspace(-1, 1, n);
[C, Y] = meshgrid(x, y);
Z = zeros(n, m);
M = true(n, m);
iterMax = 1e2; % Number Of Iter
IterCount = zeros(n, m);

figure('units', 'normalized', 'outerposition', [0 0 1 1], 'color', 'w')
for i = 1:iterMax
    Z(M) = Z(M).^2 + C(M) + 1i * Y(M); % Z = Z^2 + C
    M(abs(Z) > 2) = false;             % Update the mask if |Z| > 2
    IterCount(~M & IterCount == 0) = i;
    clf
    imagesc(x, y, IterCount);
    axis equal off;
    colormap(jet);
    title('Mandelbrot Fractal', 'FontSize', 16);
    drawnow
end

