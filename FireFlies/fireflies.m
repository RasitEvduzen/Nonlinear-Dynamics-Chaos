clc,clear,close all;
% Kuramoto Fireflies Synchronization Simulation
% Written By: Rasit Evduzen
% 09-Dec-2024
%%
rng(0)
K = .45;   % Coupling
N = 36;     % Number of fireflies
omega = .1; % Frequency of fireflies flashing
tf = 35;   % End time of simulation  [Sn]
dt = 1e-3;              % Sampling Time

% Initialize
init = 2*pi*rand(N,1);   % Random Angular Frequency for each fireflies
params = [K,N,omega];    % System Parameters
tSpan = [0,tf];          % Time Vector
sol = ode45(@(t,states) fireflyODE(states,params),tSpan,init); % ODE Solution via RK4
t = 0:dt:tf;
y = deval(sol,t)';

%% FireFlies Simulation
figure('units', 'normalized', 'outerposition', [0 0 1 1], 'color', 'k')
axis equal; hold on; axis off;
grid_size = 6;          
radius = 6;             % Circle Radius
angular_velocity = omega;   % Angular Velocity [rad/s]
phase_angles = y;       % Phase Angle [rad]
center_spacing = 4*radius; 
[x_centers, y_centers] = meshgrid(...
    linspace(-(grid_size-1)/2*center_spacing, (grid_size-1)/2*center_spacing, grid_size), ...
    linspace(-(grid_size-1)/2*center_spacing, (grid_size-1)/2*center_spacing, grid_size));

circles = gobjects(grid_size, grid_size);
for row = 1:grid_size
    for col = 1:grid_size
        x_circle = radius * cos(linspace(0, 2*pi, 100)) + x_centers(row, col);
        y_circle = radius * sin(linspace(0, 2*pi, 100)) + y_centers(row, col);
        circles(row, col) = fill(x_circle, y_circle, 'w', 'EdgeColor', 'k'); 
    end
end
gif('FireFlies.gif')
for ti = 1:1e2:length(t)-dt
    for row = 1:grid_size
        for col = 1:grid_size
            phase_index = (row-1)*grid_size + col;
            current_angle = angular_velocity * t(ti) + phase_angles(ti, phase_index);
            if sin(current_angle) > 0
                set(circles(row, col), 'FaceColor', 'yellow'); 
            else
                set(circles(row, col), 'FaceColor', 'white');   
            end
        end
    end
    if sum(abs(diff(phase_angles(ti,:))) < 1e-4)
        title(['Fireflies Simulation'; "Sim Time: "+num2str(ti*dt)+" Sn"; "Synchronization"], 'Color', 'r','FontSize',30,Position=[-100, 0, 0]);
        str = "ONLINE";
    else
        title(['Fireflies Simulation'; "Sim Time: "+num2str(ti*dt)+" Sn"; "Synchronization"], 'Color', 'r','FontSize',30,Position=[-100, 0, 0]);
        str = "OFFLINE";
    end
    htext = text(-115,-5,str,FontSize=40,Color="c");
    pause(.1)
    gif
    delete(htext);
end

%% Plotting Result
figure('units', 'normalized', 'outerposition', [0 0 1 1], 'color', 'w')
subplot(212)
for c=1:N
    hold on
    plot(t,y(:,c),".",LineWidth=4);
end
title('Phase shift over time')
ylabel('Phase shift')
xlabel('Time (Seconds)')
grid on

subplot(211)
for c=1:N
    hold on
    plot(t,sin(t'+y(:,c)),".",LineWidth=4);
end
grid on
title(['Firefly signal';"Number of Fireflies: "+num2str(N)])
ylabel('Signals')
xlabel('Time (Seconds)')



function [state_dot] = fireflyODE(states,params)
% params(1) = K
% params(2) = N
% params(3) = Omega
kn = (params(1)/params(2));
state_dot = states;
for i=1:params(2)
    state_dot(i) = 0;
    for j=1:params(2)
        state_dot(i) =  state_dot(i) + params(3) + (kn*sin(states(j)-states(i)));
    end
end
end
