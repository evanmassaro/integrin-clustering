clc; clear;
close all;

%% SPATIAL

%%
figure('units','normalized','outerposition',[0 0 0.5 0.5])
% subplot(2,1,1)
% HFIRE_pulse()

% subplot(2,1,2)

showFinalStatsbyE('Lstar',160)
%showFinalStatsbyP('Lstar', 30)
% fig = gcf;
% print('Lstar','-dpng','-r1000')

%%
cla
showFinalStatsbyE('Rstar',500)
%showFinalStatsbyP('Rstar',250)
% fig = gcf;
% print('Rstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('LRstar',60000)
%showFinalStatsbyP('LRstar',6500)

% fig = gcf;
% print('LRstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('Area',70000)
%showFinalStatsbyP('Area',12000)

% fig = gcf;
% print('Area','-dpng','-r300')

%% TEMPORAL 
%%
cla
showFinalStatsbyE('maxRate',0.18)
%showFinalStatsbyP('maxRate',0.35)

% fig = gcf;
% print('maxRate','-dpng','-r300')

%%
cla
showFinalStatsbyE('onsetRate',0.05)
%showFinalStatsbyP('onsetRate',0.3)

% fig = gcf;
% print('onsetRate','-dpng','-r300')

%%
cla
showFinalStatsbyE('onsetTime',15)
%showFinalStatsbyP('onsetTime',2)

% fig = gcf;
% print('onsetTime','-dpng','-r300')

%%
cla
showFinalStatsbyE('adjHalfwayTime',10)
%showFinalStatsbyP('adjHalfwayTime',4)

% fig = gcf;
% print('adjHalfwayTime','-dpng','-r300')

%%
cla
showFinalStatsbyE('halfwayRate',0.26)
%showFinalStatsbyP('halfwayRate',0.26)
% 
% fig = gcf;
% print('halfwayRate','-dpng','-r300')












%%

function showFinalStatsbyE(type, ymax)

    k = [150, 150, 150]/255;
    b = [30, 100, 235]/255;
    c = [158, 201, 255]/255;
    r = [227, 45, 45]/255;
    rr = [255, 152, 152]/255;
    
%     pad = 0.1;
%     x_lims =[0.5-pad,5-0.5+pad];

%     figure('units','normalized','outerposition',[0 0 1 1])
    
%     subplot(1,2,1)
  
    hBar0 = displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 2',1:12, 2.5-0.9/8, 0.45, b, ymax);
    hBar1 = displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1',1:12, 2.5+0.9/8, 0.45, r, ymax);
    
    hBar2 = displayStats(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 2, pulse_width 100',1:12,3.75-0.9/8, 0.45, b, ymax);
    hBar3 = displayStats(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 100',1:12,3.75+0.9/8, 0.45, r, ymax);
    
    hBar4 = displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 2',1:12,5.0-0.9/8, 0.45, b, ymax);
    hBar5 = displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1',1:12,5.0+0.9/8, 0.45, r, ymax);
%     title('\sigma_m = 0.8 pN/nm, \rho = 500 \mum^{-2}')
    
    hBar6 = displayStats(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',1:12, 1.5, 0.9/2, k, ymax);
    
    set(gca,'xtick',[1.5,2.5,3.75, 5.0])
    set(gca,'xticklabel',{'0','3','10', '30'})
    legend([hBar6, hBar1, hBar0], {'Control', 'Unipolar', 'Bipolar'}, ...
        'location', 'northwest', 'orientation', 'horizontal', 'NumColumns', 1)
    xlabel('Electric Field Strength (kV/cm)')
    grid off
    set(gca,'fontsize',18)
    xlim([1.2, 5.5])
%     ylim([0, ymax])
%     set(gca,'ytick',[0, 35, 70, 105, 170])
 
    
end
