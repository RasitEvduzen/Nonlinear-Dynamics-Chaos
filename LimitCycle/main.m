clc,clear all,close all;
% Limit Cycle simulation
% Written By: Rasit Evduzen
% 29-Feb-2024
%% 
options = odeset('MaxStep',1e-2);
tspan = [0 10];
init = [-0.2 -0.5]';
[t,y] = ode45(@(t,y) VanderPol(t,y),tspan,init,options);

dxdt = @(x,y) y;
dydt = @(x,y) -x+y-2*(x+2*y).*y.^2;

[X,Y] = meshgrid(linspace(-1,1,100));
[SX,SY] = meshgrid(linspace(0,0.75,20),0.2);
[verts,~] = streamslice(X,Y,dxdt(X,Y),dydt(X,Y));

% Plot Simulation
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
plot(y(:,1),y(:,2),'r',LineWidth=3),hold on,grid on
streamline(verts);
streamparticles(verts,100,"Animate",1,"FrameRate",30);


function dydt = VanderPol(t,y)
    dydt = zeros(2,1);
    dydt(1) = y(2);
    dydt(2) = -y(1)+y(2)-2*(y(1)+2*y(2)).*y(2).^2;
    
end

