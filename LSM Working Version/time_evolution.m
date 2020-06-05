
base_str = 'd 16, E 400, L 200, k_mem 0.4_';
f = '.mat';

t = [1,4,24];
subplot(2,2,1)
load([base_str,num2str(t(1)),f])
updateDisplay_v1()
title(['t = ',num2str(t(1)),'s'])

subplot(2,2,2)
load([base_str,num2str(t(2)),f])
updateDisplay_v1()
title(['t = ',num2str(t(2)),'s'])
% c = colorbar('eastoutside');
% c.Label.String = 'Height (nm)';
% caxis([del_bond del_gly])

subplot(2,2,3)
load([base_str,num2str(t(3)),f])
updateDisplay_v1()
title(['t = ',num2str(t(3)),'s'])
%%
subplot(2,2,4);
load([base_str,num2str(t(1)),f])
graphLStatistic_v1(S,LMatrix, countL); hold on;
load([base_str,num2str(t(2)),f])
graphLStatistic_v1(S,LMatrix, countL)
load([base_str,num2str(t(3)),f])
graphLStatistic_v1(S,LMatrix, countL)
xticks([0, (max(S)+1)/2,max(S)+1])
axis square
legend(['t = ',num2str(t(1)),'s'],['t = ',num2str(t(2)),'s'],['t = ',num2str(t(3)),'s'],'location','southeast')
set(gca,'fontsize',18)