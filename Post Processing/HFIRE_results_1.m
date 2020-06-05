%%

showFinalResults('graphLStatistic_v1');

%%

showFinalResults('displayBondRate');
% % 
% % 
%%
% 
showFinalResults('displayBondFraction');


%%

function showFinalResults(type)
    figure('units','normalized','outerposition',[0 0 1 1])

    subplot(1,2,1)
    displayTrials(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1',12,'b')
%         xlim([0, 30]); ylim([0, 0.2])
%     pause(1)
    displayTrials(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1',12,'c')
%         xlim([0, 30]); ylim([0, 0.2])
%         pause(1)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.8',4,'k')
%         xlim([0, 30]); ylim([0, 0.2])
%         pause(1)
    title('Unipolar')
    set(gca,'fontsize',18)
    
    subplot(1,2,2)
    displayTrials(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 2',12,'b')
%         xlim([0, 30]); ylim([0, 0.2])
%         pause(1)
    displayTrials(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 2',12,'c')
%         xlim([0, 30]); ylim([0, 0.2])
%         pause(1)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.8',4,'k')
%         xlim([0, 30]); ylim([0, 0.2])
%         pause(1)
    title('Bipolar')
    set(gca,'fontsize',18)

end