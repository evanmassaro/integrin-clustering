clc; clear;
close all;

%% SPATIAL

%%
showFinalStatsbyE('Lstar',160)
%showFinalStatsbyP('Lstar', 140)
fig = gcf;
print('Lstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('Rstar',500)
%showFinalStatsbyP('Rstar',500)
fig = gcf;
print('Rstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('LRstar',60000)
%showFinalStatsbyP('LRstar',55000)

fig = gcf;
print('LRstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('Area',75000)
%showFinalStatsbyP('Area',65000)

fig = gcf;
print('Area','-dpng','-r300')

%% TEMPORAL 
%%
cla
showFinalStatsbyE('maxRate',0.21)
%showFinalStatsbyP('maxRate',0.21)

fig = gcf;
print('maxRate','-dpng','-r300')

%%
cla
showFinalStatsbyE('onsetRate',0.05)
%showFinalStatsbyP('onsetRate',0.05)

fig = gcf;
print('onsetRate','-dpng','-r300')

%%
cla
showFinalStatsbyE('onsetTime',20)
%showFinalStatsbyP('onsetTime',14)

fig = gcf;
print('onsetTime','-dpng','-r300')

%%
cla
showFinalStatsbyE('adjHalfwayTime',16)
%showFinalStatsbyP('adjHalfwayTime',16)

fig = gcf;
print('adjHalfwayTime','-dpng','-r300')

%%
cla
showFinalStatsbyE('halfwayRate',0.20)
%showFinalStatsbyP('halfwayRate',0.16)

fig = gcf;
print('halfwayRate','-dpng','-r300')




%%

function showFinalStatsbyE(type, ymax)

    b = [118, 201, 255]/255;
    r = [255, 101, 101]/255;
    g = [140, 255, 160]/255;
    k = [200, 200, 200]/255;
    c = [100, 100, 100]/255;
    or = [255, 153, 51]/255;
    pu = [153, 51, 255]/255;
    
    pad = 0.1;
    x_lims =[0.5-pad,8-0.5+pad];

    figure('units','normalized','outerposition',[0 0 1 1])
    
%%   
    subplot(1,2,1)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,c, ymax)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8, polarity 1',4,2,k, ymax)
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1',4,3, g, ymax)
    displayStats(type,'d 16, E 16000, L 500, k_mem 0.8, polarity 1',4,4, b, ymax)
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1',4,5,r, ymax)
    displayStats(type,'d 16, E 1000000, L 500, k_mem 0.8, polarity 1',3,6,or, ymax)
    displayStats(type,'d 16, E 10000000, L 500, k_mem 0.8, polarity 1',3,7,pu, ymax)
    set(gca,'fontsize',18)
    xlim(x_lims)
    title('Unipolar')
    
%%    
    subplot(1,2,2)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,c, ymax)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8, polarity 2',4,2,k, ymax)
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 2',4,3, g, ymax)
    displayStats(type,'d 16, E 16000, L 500, k_mem 0.8, polarity 2',4,4, b, ymax)
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 2',4,5,r, ymax)
    displayStats(type,'d 16, E 1000000, L 500, k_mem 0.8, polarity 2',3,6,or, ymax)
    displayStats(type,'d 16, E 10000000, L 500, k_mem 0.8, polarity 2',3,7,pu, ymax)
    set(gca,'fontsize',18)
    xlim(x_lims)    
    title('Bipolar')
    
    
    
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
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,c, ymax)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8, polarity 1',4,2,k, ymax)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8, polarity 2',4,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)

    %%
    subplot(2,2,3)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,c, ymax)
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1',4,2,k, ymax)
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 2',4,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    %%
    subplot(2,2,2)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,c, ymax)
    displayStats(type,'d 16, E 16000, L 500, k_mem 0.8, polarity 1',4,2,k, ymax)
    displayStats(type,'d 16, E 16000, L 500, k_mem 0.8, polarity 2',4,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    
    %%
    subplot(2,2,4)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,c, ymax)
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1',4,2,k, ymax)
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 2',4,3,b, ymax)
    
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    
end