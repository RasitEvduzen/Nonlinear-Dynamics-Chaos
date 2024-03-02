clc,clear all,close all;
% Logistic Map Equation Bifurcation
% Rasit EVDUZEN
% 02-Mar-2024
%%

xvals = [];
initialval = 1;
finalval = 4;

logistic = @(xk,r) (r*xk*(1-xk));

figure('units','normalized','outerposition',[0 0 1 1],'color','w')
gif('bifurcation.gif')
for r = initialval:5e-3:finalval
    x = 0.5;
    for i=1:1e3
        x = logistic(x,r);
    end
    xss = x;  % steady state value
    for i=1:1e4
        x = logistic(x,r);
        xvals(1,length(xvals)+1) = r;
        xvals(2,length(xvals))   = x;
        if(abs(x-xss)<1e-3)
            break
        end
    end
    
    plot(xvals(1,:),xvals(2,:),'r.','LineWidth',.1,'MarkerSize',1.2,'Color',[1 0 0])
    axis([initialval finalval 0 1]),grid on,title('Logistic Map Bifurcation Diagram')
    drawnow
    gif
end


