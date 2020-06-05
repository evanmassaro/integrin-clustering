%%
showFinalResults('graphLStatistic_v1');

%%

showFinalResults('displayBondRate');
% 
% 
%%

showFinalResults('displayBondFraction');


%%

function showFinalResults(type)
%     figure('units','normalized','outerposition',[0 0 1 1])
%     
%     subplot(1,3,1)
%     displayTrials(type,'d 16, E 40, L 500, k_mem 0.8',4,'b')
%     displayTrials(type,'d 16, E 400, L 500, k_mem 0.8',4,'g')
%     displayTrials(type,'d 16, E 4000, L 500, k_mem 0.8',4,'c')
%     set(gca,'fontsize',18)
    
    subplot(1,2,1)
    displayTrials(type,'d 16, E 0, L 1000, k_mem 0.4',4,'k')
    displayTrials(type,'d 16, E 4000, L 1000, k_mem 0.4, polarity 1',3,'r')
    displayTrials(type,'d 16, E 8000, L 1000, k_mem 0.4, polarity 1',3,'b')
    displayTrials(type,'d 16, E 16000, L 1000, k_mem 0.4, polarity 1',3,'g')
    displayTrials(type,'d 16, E 80000, L 1000, k_mem 0.4, polarity 1',3,'c')
    set(gca,'fontsize',18)
    
    subplot(1,2,2)
    displayTrials(type,'d 16, E 0, L 1000, k_mem 0.4',4,'k')
    displayTrials(type,'d 16, E 4000, L 1000, k_mem 0.4, polarity 2',3,'r')
    displayTrials(type,'d 16, E 8000, L 1000, k_mem 0.4, polarity 2',3,'b')
    displayTrials(type,'d 16, E 16000, L 1000, k_mem 0.4, polarity 2',3,'g')
    displayTrials(type,'d 16, E 80000, L 1000, k_mem 0.4, polarity 2',3,'c')
    set(gca,'fontsize',18)

end