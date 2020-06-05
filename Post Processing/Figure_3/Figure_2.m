clc; clear;

type = 'displayBondFraction';
[q1, p1] = getTrials(type,'d 16, E 0, L 500, k_mem 0.8',4,'b');
[q2, p2] = getTrials(type,'d 16, E 4000, L 500, k_mem 0.8',4,'r');

% type = 'displayLStatistic';
% [q1, p1] = getTrials(type,'d 16, E 0, L 1000, k_mem 0.4',4,'b');
% [q2, p2] = getTrials(type,'d 16, E 4000, L 1000, k_mem 0.4',4,'r');

lgd = legend([p1, p2, q1, q2],...
       {'E = 0 V/cm', 'E = 1500 V/cm', ...
       '$\pm$ 1$\sigma$ confidence interval',...
       '$\pm$ 1$\sigma$ confidence interval'}, 'location', 'northoutside', 'interpreter', 'latex');
set(gca,'fontsize',21)

lgd.NumColumns = 2;

% fig = gcf;
% fig.PaperUnits = 'inches' ;
% fig.PaperPosition = [0 0 6 4.1];
% print(type,'-dpng','-r1000')
