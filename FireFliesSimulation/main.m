clc,clear all,close all;
% Beautiful FireFlies Synchronization Simulation
% Written By: Rasit 
% 24-Mar-2024
%%

SimTime = 20;
NoD = 1e3;
time = linspace(0,2*pi,NoD);
y = @(t,tau) sin((t)-tau);
figure('units','normalized','outerposition',[0 0 1 1],'color','k')
timer1 = tic;

while 1

    if (SimTime - floor(toc(timer1))) == 0
        break
    end
    xpose = rand*.02+.95;
    ypolse = rand*.02+.95;
     
    clf
%     subplot(121)
    plot(time,y(time,toc(timer1)),'w'),hold on,axis off, axis([0 2*pi -1.2 1.2])
    xline(0),yline(0)
%     subplot(122)
    if y(0,toc(timer1)) >= .999
        scatter(xpose,ypolse,"filled","r",SizeData=100),axis off
    else
        scatter(xpose,ypolse,"filled","w",SizeData=100),axis off
    end
    drawnow
end