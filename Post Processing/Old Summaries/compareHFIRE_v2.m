clc; clear;
close all;

%% SPATIAL

%%
showFinalStatsbyE('Lstar',35)
%showFinalStatsbyP('Lstar', 30)
% fig = gcf;
% print('Lstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('Rstar',250)
%showFinalStatsbyP('Rstar',250)
% fig = gcf;
% print('Rstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('LRstar',6500)
%showFinalStatsbyP('LRstar',6500)

% fig = gcf;
% print('LRstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('Area',12000)
%showFinalStatsbyP('Area',12000)

% fig = gcf;
% print('Area','-dpng','-r300')

%% TEMPORAL 
%%
cla
showFinalStatsbyE('maxRate',0.35)
%showFinalStatsbyP('maxRate',0.35)

% fig = gcf;
% print('maxRate','-dpng','-r300')

%%
cla
showFinalStatsbyE('onsetRate',0.3)
%showFinalStatsbyP('onsetRate',0.3)

% fig = gcf;
% print('onsetRate','-dpng','-r300')

%%
cla
showFinalStatsbyE('onsetTime',2)
%showFinalStatsbyP('onsetTime',2)

% fig = gcf;
% print('onsetTime','-dpng','-r300')

%%
cla
showFinalStatsbyE('adjHalfwayTime',4)
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

    b = [118, 201, 255]/255;
    r = [255, 101, 101]/255;
    g = [140, 255, 160]/255;
    k = [200, 200, 200]/255;
    c = [100, 100, 100]/255;
    
    pad = 0.1;
    x_lims =[0.5-pad,6-0.5+pad];

    figure('units','normalized','outerposition',[0 0 1 1])
    
%%   
    subplot(1,2,1)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,c, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4, polarity 1',3,2,k, ymax)
    displayStats(type,'d 16, E 8000, L 1000, k_mem 0.4, polarity 1',3,3, g, ymax)
    displayStats(type,'d 16, E 16000, L 1000, k_mem 0.4, polarity 1',3,4, b, ymax)
    displayStats(type,'d 16, E 80000, L 1000, k_mem 0.4, polarity 1',3,5,r, ymax)
    set(gca,'fontsize',18)
    title('Unipolar: \sigma_m = 0.4, \rho = 1000')
    xlim(x_lims)
    
%%    
    subplot(1,2,2)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,c, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4, polarity 2',3,2,k, ymax)
    displayStats(type,'d 16, E 8000, L 1000, k_mem 0.4, polarity 2',3,3, g, ymax)
    displayStats(type,'d 16, E 16000, L 1000, k_mem 0.4, polarity 2',3,4, b, ymax)
    displayStats(type,'d 16, E 80000, L 1000, k_mem 0.4, polarity 2',3,5,r, ymax)
    set(gca,'fontsize',18)
    title('Bipolar: \sigma_m = 0.4, \rho = 1000')
    xlim(x_lims)
    
    
    
end

function showFinalStatsbyP(type, ymax)

    b = [118, 201, 255]/255;
    r = [255, 101, 101]/255;
    g = [140, 255, 160]/255;
    k = [200, 200, 200]/255;
    c = [100, 100, 100]/255;
    
    pad = 0.1;
    x_lims =[0.5-pad,4-0.5+pad];

    
    figure('units','normalized','outerposition',[0 0 1 1])
    
    %%
    subplot(2,2,1)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,c, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4, polarity 1',3,2,k, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4, polarity 2',3,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)

    %%
    subplot(2,2,3)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,c, ymax)
    displayStats(type,'d 16, E 8000, L 1000, k_mem 0.4, polarity 1',3,2,k, ymax)
    displayStats(type,'d 16, E 8000, L 1000, k_mem 0.4, polarity 2',3,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    %%
    subplot(2,2,2)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,c, ymax)
    displayStats(type,'d 16, E 16000, L 1000, k_mem 0.4, polarity 1',3,2,k, ymax)
    displayStats(type,'d 16, E 16000, L 1000, k_mem 0.4, polarity 2',3,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    
    %%
    subplot(2,2,4)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,c, ymax)
    displayStats(type,'d 16, E 80000, L 1000, k_mem 0.4, polarity 1',3,2,k, ymax)
    displayStats(type,'d 16, E 80000, L 1000, k_mem 0.4, polarity 2',3,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    
end