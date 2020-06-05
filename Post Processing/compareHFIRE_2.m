clc; clear;
close all;

%% SPATIAL

%%
showFinalStatsbyE('Lstar',[40, 170])
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
showFinalStatsbyE('LRstar',70000)
%showFinalStatsbyP('LRstar',6500)

% fig = gcf;
% print('LRstar','-dpng','-r300')

%%
cla
showFinalStatsbyE('Area',90000)
%showFinalStatsbyP('Area',12000)

% fig = gcf;
% print('Area','-dpng','-r300')

%% TEMPORAL 
%%
cla
showFinalStatsbyE('maxRate',[0.05,0.40])
%showFinalStatsbyP('maxRate',0.35)

% fig = gcf;
% print('maxRate','-dpng','-r1000')

%%
cla
showFinalStatsbyE('onsetRate',0.2)
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
showFinalStatsbyE('adjHalfwayTime',15)
%showFinalStatsbyP('adjHalfwayTime',4)

% fig = gcf;
% print('adjHalfwayTime','-dpng','-r1000')

%%
cla
showFinalStatsbyE('halfwayRate',0.26)
%showFinalStatsbyP('halfwayRate',0.26)
% 
% fig = gcf;
% print('halfwayRate','-dpng','-r300')


%%

function showFinalStatsbyE(type, yrange)
    if length(yrange) == 1
        yrange = [0 yrange];
    end
        
    k = [100, 100, 100]/255;
    b = [50, 100, 255]/255;
    c = [108, 158, 255]/255;
    r = [227, 45, 45]/255;
    rr = [255, 152, 152]/255;
    p = [128, 0, 255]/255;
    
%     pad = 0.1;
%     x_lims =[0.5-pad,5-0.5+pad];

    figure('units','normalized','outerposition',[0 0 0.3 1])
    
    oset = 0;
    
    % Field 3 kV/cm
    subplot(3,1,1)
    h = displayStats(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',1:12, 1, 0.9, b, yrange);
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1, pulse_width 10',1:12, 2-oset, 0.9, b, yrange);
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1', 1:12, 3-oset, 0.9, b, yrange);
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1, pulse_width 1000', 1:12, 4-oset, 0.9, b, yrange);
    displayStats(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 0, pulse_width 100',1:12, 5-oset, 0.9, b, yrange);
    legend(h, '3 kV/cm', 'location', 'northwest')
    set(gca, 'xtick', 1:5)
%     set(gca, 'xticklabels', {'Off', '10', '100', '1000', 'Constant'})
%     xlabel('pulse width \mus')
    set(gca, 'xticklabels', {})
    xlim([0.8,5.2])
    ylim(yrange)
%     ylim([50,170])
    
    
    % Field 10 kV/cm
    subplot(3,1,2)
    h = displayStats(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',1:12, 1, 0.9, p, yrange);
    displayStats(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 10',1:12, 2, 0.9, p, yrange);
    displayStats(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 100',1:12, 3, 0.9, p, yrange);
    displayStats(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 1000', 1:12, 4, 0.9, p, yrange);
    displayStats(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 0, pulse_width 100', 1:12, 5, 0.9, p, yrange);
    legend(h, '10 kV/cm', 'location', 'northwest')
    set(gca, 'xtick', 1:5)
%     set(gca, 'xticklabels', {'Off', '10', '100', '1000', 'Constant'})
%     xlabel('pulse width \mus')
    set(gca, 'xticklabels', {})
    xlim([0.8,5.2])
    ylim(yrange)
%     ylim([50,170])
    
    % Field 30 kV/cm
    subplot(3,1,3)
    h = displayStats(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',1:12, 1, 0.9, r, yrange);
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1, pulse_width 10',1:12, 2+oset, 0.9, r, yrange);
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1',1:12, 3+oset, 0.9, r, yrange);
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1, pulse_width 1000', 1:12, 4+oset, 0.9, r, yrange);
    displayStats(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 0, pulse_width 100', 1:12, 5+oset, 0.9, r, yrange);
    legend(h, '30 kV/cm', 'location', 'northwest')
    set(gca, 'xtick', 1:5)
    set(gca, 'xticklabels', {'0', '10', '100', '1000', '\infty'})
    xlabel('pulse width \mus')
    xlim([0.8,5.2])
    ylim(yrange)
%     ylim([50,170])
    
end

