clc; clear; close all;
% Chaotic Rossler-System Simulation
% Written By: Rasit
% Date: 22-Dec-2024
%%
% System Parameters
a = 0.2;
b = 0.2;
c = 5.7;
t_start = 0;
t_end = 32*pi;
dt = 1e-3;
num_steps = round((t_end - t_start) / dt);
t = linspace(t_start, t_end, num_steps);

% Initial conditions
x = zeros(1, num_steps);
y = zeros(1, num_steps);
z = zeros(1, num_steps);


% Solve the Rossler system
figure('units', 'normalized', 'outerposition', [0 0 1 1], 'color', 'w')
for k = 1:num_steps-1
    [x(k+1), y(k+1), z(k+1)] = rossler_integration(x(k), y(k), z(k), dt, a, b, c);

    if mod(k,1e3) == 0 || mod(k,num_steps-1) == 0
        clf
        subplot(3, 2, 1);
        plot(t(1:k), x(1:k), 'r', 'LineWidth', 2);
        xlabel('t');
        ylabel('x(t)');
        title('State-X');
        axis([t_start, t_end, min(x), max(x)]);

        subplot(3, 2, 3);
        plot(t(1:k), y(1:k), 'r', 'LineWidth', 2);
        xlabel('t');
        ylabel('y(t)');
        title('State-Y');
        axis([t_start, t_end, min(y), max(y)]);

        subplot(3, 2, 5);
        plot(t(1:k), z(1:k), 'r', 'LineWidth', 2);
        xlabel('t');
        ylabel('z(t)');
        title('State-Z');
        axis([t_start, t_end, min(z), max(z)]);

        subplot(3, 2, [2, 4, 6]);
        plot3(x(1:k), y(1:k), z(1:k), 'k', 'LineWidth', 3);
        xlabel('x(t)');
        ylabel('y(t)');
        zlabel('z(t)');
        title('Rossler System in 3D');
        grid on;axis tight
        drawnow
    end


end




function [x_next, y_next, z_next] = rossler_integration(x_current, y_current, z_current, dt, a, b, c)
% Rossler differential equations
x_next = x_current + dt * (-y_current - z_current);
y_next = y_current + dt * (x_current + a * y_current);
z_next = z_current + dt * (b + z_current * (x_current - c));
end
