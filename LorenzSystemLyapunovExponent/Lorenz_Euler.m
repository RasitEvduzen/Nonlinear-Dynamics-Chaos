clear all, close all; clc;
% Lorenz Equation Simulation and Find Lyapunov Exponent
% Written By: Rasit Evduzen
% 27-Feb-2024

delta_zero = 1e-9; % Initial Perturbation
Ts = 1e-2;   % Step Size
tf = 30;     % Final Time
time = 0:Ts:tf; % Time Vec

sigma = 10;     % System Parameters
rho = 28;       % System Parameters
beta = 8/3;     % System Parameters

% Different Initial Condition
X = [2 3 -14]';      % System 1 Initial Condition
Y = [2 3 -14+delta_zero]';      % System 2 Small Perturbated Initial Condition


f = {@ (y,z,sigma)    (sigma*(y - z))
     @ (x,y,z,rho)    (x*(rho - z)-y)
     @ (x,y,z,beta)   (x*y-beta*z) };

error_nrm = delta_zero*ones(3,1);
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
for i = 1:size(time,2)-1
    X(:,i+1) = X(:,i) + (Ts*[f{1}(X(2,i),X(1,i),sigma),
                            f{2}(X(1,i),X(2,i),X(3,i),rho),
                            f{3}(X(1,i),X(2,i),X(3,i),beta)]);
    Y(:,i+1) = Y(:,i) + (Ts*[f{1}(Y(2,i),Y(1,i),sigma),
                             f{2}(Y(1,i),Y(2,i),Y(3,i),rho),
                             f{3}(Y(1,i),Y(2,i),Y(3,i),beta)]);
  error_nrm(i+1) = norm([abs(X(:,i)) - abs(Y(:,i))]);

    if mod(i,(size(time,2)-1)*(0.05)) == 0
        clf
        plot3(X(1,:),X(2,:),X(3,:),'b','linewidth',3),hold on,grid on
        plot3(Y(1,:),Y(2,:),Y(3,:),'r--','linewidth',2)
        legend('Lorenz System Phase Space')
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        axis([-40 40 -40 40 -10 70])
        view(20,20)
        drawnow
    end
end

figure('units','normalized','outerposition',[0 0 1 1],'color','w')
subplot(311)
plot(time,X(1,:),'b','linewidth',2),hold on,grid on
plot(time,Y(1,:),'r--','linewidth',2)
xlabel('time (s)')
ylabel('X')

subplot(312)
plot(time,X(2,:),'b','linewidth',2),hold on,grid on
plot(time,Y(2,:),'r--','linewidth',2)
xlabel('time (s)')
ylabel('Y')

subplot(313)
plot(time,X(3,:),'b','linewidth',2),hold on,grid on
plot(time,Y(3,:),'r--','linewidth',2)
xlabel('time (s)')
ylabel('Z')


% Find Lyapunov Exponent via LSE
y = log(error_nrm);
x = time';
A = [x x.^0];
xlse = A\y;
ylse = xlse(1)*time + xlse(2);
Lyap_exp = log(ylse(end) - ylse(1) / x(end) - x(1))-1; % Lyapunov Exponent

figure('units','normalized','outerposition',[0 0 1 1],'color','w')
semilogy(time,error_nrm),hold on,grid minor
semilogy(time,exp(ylse))
legend('dist(traj_1, traj_2)', sprintf('exp(%1.4f t)', Lyap_exp),'location', 'northwest')
xlabel('time')
title({'Lorenz trajectories Lyapunov Exponent value: ', num2str(Lyap_exp)})
