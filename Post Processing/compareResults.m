clc; clear;
close all;

%% SPATIAL

%%
% showFinalStatsbyE('Lstar',120)
showFinalStatsbyL('Lstar', 120)
%showFinalStatsbyk('Lstar', 120)
%fig = gcf;
%print('Lstar','-dpng','-r1000')
%%
showFinalStatsbyE('Rstar',500)
%showFinalStatsbyL('Rstar',500)
%showFinalStatsbyk('Rstar',500)
%fig = gcf;
%print('Rstar','-dpng','-r1000')
%%
showFinalStatsbyE('LRstar',50000)
%showFinalStatsbyL('LRstar',50000)
%showFinalStatsbyk('LRstar',50000)
%fig = gcf;
%print('LRstar','-dpng','-r1000')
%%
showFinalStatsbyE('Area',60000)
%showFinalStatsbyL('Area',60000)
%showFinalStatsbyk('Area',60000)
%fig = gcf;
%print('Area','-dpng','-r1000')


%% TEMPORAL 
%%
%showFinalStatsbyE('maxRate',0.5)
showFinalStatsbyL('maxRate',0.5)
%showFinalStatsbyk('maxRate',0.5)
%fig = gcf;
%print('Area','-dpng','-r1000')
%%
%showFinalStatsbyE('onsetRate',0.5)
showFinalStatsbyL('onsetRate',0.5)
%showFinalStatsbyk('onsetRate',0.5)
%fig = gcf;
%print('Area','-dpng','-r1000')

%%
%showFinalStatsbyE('onsetTime',20)
showFinalStatsbyL('onsetTime',20)
%showFinalStatsbyk('onsetTime',20)
%fig = gcf;
%print('Area','-dpng','-r1000')

%%
%showFinalStatsbyE('adjHalfwayTime',16)
showFinalStatsbyL('adjHalfwayTime',16)
%showFinalStatsbyk('adjHalfwayTime',16)
%fig = gcf;
%print('Area','-dpng','-r1000')

%%
%showFinalStatsbyE('halfwayRate',0.5)
showFinalStatsbyL('halfwayRate',0.5)
%showFinalStatsbyk('halfwayRate',0.5)
% fig = gcf;
% print('Area','-dpng','-r1000')












%%

function showFinalStatsbyE(type, ymax)

    b = [118, 201, 255]/255;
    r = [255, 101, 101]/255;
    g = [140, 255, 160]/255;
    k = [200, 200, 200]/250;
    
    pad = 0.1;
    x_lims =[0.5-pad,5-0.5+pad];

    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,3,1)
    displayStats(type,'d 16, E 0, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 200, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 200, k_mem 0.4',4,3,b, ymax)
    displayStats(type,'d 16, E 4000, L 200, k_mem 0.4',4,4,r, ymax)
    title('\rho = 200 \mum^{-2}')
    legend('E = 0 V/cm','E = 15 V/cm','E = 150 V/cm','E = 1500 V/cm','location','northwest')
    set(gca,'fontsize',18)
    xlim(x_lims)


    subplot(2,3,4)
    displayStats(type,'d 16, E 0, L 200, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 200, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 200, k_mem 0.8',4,3,b, ymax)
    displayStats(type,'d 16, E 4000, L 200, k_mem 0.8',4,4,r, ymax)
    %title('\rho = 200 \mum^{-2}')
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    %% L = 500

    subplot(2,3,2)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 500, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 500, k_mem 0.4',4,3,b, ymax)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.4',4,4,r, ymax)
    title('\rho = 500 \mum^{-2}')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(2,3,5)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 500, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 500, k_mem 0.8',4,3,b, ymax)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8',4,4,r, ymax)
    %title('\rho = 500 \mum^{-2}')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    %% L = 1000

    subplot(2,3,3)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 1000, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 1000, k_mem 0.4',4,3,b, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4',4,4,r, ymax)
    title('\rho = 1000 \mum^{-2}')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(2,3,6)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 1000, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 1000, k_mem 0.8',4,3,b, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.8',4,4,r, ymax)
    %title('\rho = 1000 \mum^{-2}')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
end

function showFinalStatsbyL(type, ymax)

    b = [118, 201, 255]/255;
    r = [255, 101, 101]/255;
    g = [140, 255, 160]/255;
    k = [200, 200, 200]/250;
    
    pad = 0.1;
    x_lims =[0.5-pad,4-0.5+pad];

    %% E = 0
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,4,1)
    displayStats(type,'d 16, E 0, L 200, k_mem 0.4',4,1,k, ymax)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,3,b, ymax)
    hold on
 
    title('E = 0 V/cm')
    legend('L = 200 \mum^{-2}','L = 500 \mum^{-2}','L = 1000 \mum^{-2}','location','northwest')
    set(gca,'fontsize',18)
    xlim(x_lims)


    subplot(2,4,5)
    displayStats(type,'d 16, E 0, L 200, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.8',4,3,b, ymax)
    %title('E = 0 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    xlim(x_lims)
    

    %% E = 40

    subplot(2,4,2)
    displayStats(type,'d 16, E 40, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 500, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 40, L 1000, k_mem 0.4',4,3,b, ymax)
    title('E = 15 V/cm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(2,4,6)
    displayStats(type,'d 16, E 40, L 200, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 500, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 40, L 1000, k_mem 0.8',4,3,b, ymax)
    %title('E = 15 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    %% E = 400

    subplot(2,4,3)
    displayStats(type,'d 16, E 400, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 400, L 500, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 1000, k_mem 0.4',4,3,b, ymax)
    title('E = 150 V/cm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(2,4,7)
    displayStats(type,'d 16, E 400, L 200, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 400, L 500, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 400, L 1000, k_mem 0.8',4,3,b, ymax)
    %title('E = 150 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
    
    %% E = 4000

    subplot(2,4,4)
    displayStats(type,'d 16, E 4000, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.4',4,2,g, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4',4,3,b, ymax)
    title('E = 1500 V/cm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(2,4,8)
    displayStats(type,'d 16, E 4000, L 200, k_mem 0.8',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8',4,2,g, ymax)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.8',4,3,b, ymax)
    %title('E = 1500 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
end

function showFinalStatsbyk(type, ymax)

    b = [118, 201, 255]/255;
    r = [255, 101, 101]/255;
    g = [140, 255, 160]/255;
    k = [200, 200, 200]/250;
    
    pad = 0.1;
    x_lims =[0.5-pad,3-0.5+pad];

    %% E = 0
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(3,4,1)
    displayStats(type,'d 16, E 0, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 0, L 200, k_mem 0.8',4,2,b, ymax)
 
    title('E = 0 V/cm')
    legend('k = 0.4 pN/nm','k = 0.8 pN/nm','location','northwest')
    set(gca,'fontsize',18)
    xlim(x_lims)


    subplot(3,4,5)
    displayStats(type,'d 16, E 0, L 500, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 0, L 500, k_mem 0.8',4,2,b, ymax)
    %title('E = 0 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    xlim(x_lims)
    
    subplot(3,4,9)
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 0, L 1000, k_mem 0.8',4,2,b, ymax)
    %title('E = 0 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    xlim(x_lims)
    

    %% E = 40

    subplot(3,4,2)
    displayStats(type,'d 16, E 40, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 200, k_mem 0.8',4,2,b, ymax)
    title('E = 15 V/cm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(3,4,6)
    displayStats(type,'d 16, E 40, L 500, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 500, k_mem 0.8',4,2,b, ymax)
    %title('E = 15 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
    
    subplot(3,4,10)
    displayStats(type,'d 16, E 40, L 1000, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 40, L 1000, k_mem 0.8',4,2,b, ymax)
    %title('E = 15 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    %% E = 400

    subplot(3,4,3)
    displayStats(type,'d 16, E 400, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 400, L 200, k_mem 0.8',4,2,b, ymax)
    title('E = 150 V/cm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(3,4,7)
    displayStats(type,'d 16, E 400, L 500, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 400, L 500, k_mem 0.8',4,2,b, ymax)
    %title('E = 150 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
    
    subplot(3,4,11)
    displayStats(type,'d 16, E 400, L 1000, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 400, L 1000, k_mem 0.8',4,2,b, ymax)
    %title('E = 150 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
    
    %% E = 4000

    subplot(3,4,4)
    displayStats(type,'d 16, E 4000, L 200, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 4000, L 200, k_mem 0.8',4,2,b, ymax)
    title('E = 1500 V/cm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)

    subplot(3,4,8)
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 4000, L 500, k_mem 0.8',4,2,b, ymax)
    %title('E = 1500 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
    
    subplot(3,4,12)
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.4',4,1,k, ymax)
    hold on
    displayStats(type,'d 16, E 4000, L 1000, k_mem 0.8',4,2,b, ymax)
    %title('E = 1500 V/cm, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
    set(gca, 'yticklabels', [])
    ylabel('')
    xlim(x_lims)
end