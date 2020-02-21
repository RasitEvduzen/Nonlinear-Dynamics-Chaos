clc,clear all,close all;
% Logistic Map Equation Bifurcation
% Rasit EVDUZEN
%21-Feb-2020

xvals=[];
initialval = 1;
finalval = 4;
for r = initialval:0.001:finalval
    x = 0.5;
    clf
    for i=1:10000
        x = logistic(x,r);
    end
    xss = x;  % steady state x
    for i=1:1000
        x = logistic(x,r);
        xvals(1,length(xvals)+1) = r;
        xvals(2,length(xvals))   = x;
        if(abs(x-xss)<.001)
            break
        end
    end
    
end
%% PLOT
set(gcf,'Position',[100 100 1000 800])
plot(xvals(2,:),xvals(1,:),'.','LineWidth',.1,'MarkerSize',1.2,'Color',[1 0 0])
axis([0 1 1 finalval]),grid on,title('Logistic Map Bifurcation Diagram')
axis ij

