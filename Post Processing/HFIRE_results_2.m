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

    %% E = 3000
    
    subplot(1,3,1)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',12,'k')
    
%     displayTrials(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1, pulse_width 10',12,'c')
    displayTrials(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1',12,'b')
    displayTrials(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 1, pulse_width 1000',12,'r')
    
    displayTrials(type,'d 16, E 8000, L 500, k_mem 0.8, polarity 0, pulse_width 100',12,'m')
    
%     title('Unipolar')
    set(gca,'fontsize',18)
    
    
    %% E = 10000
    subplot(1,3,2)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',12,'k')
    
    displayTrials(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 10',12,'c')
    displayTrials(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 100',12,'b')
    displayTrials(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 1, pulse_width 1000',12,'r')
    
    displayTrials(type,'d 16, E 26666.6667, L 500, k_mem 0.8, polarity 0, pulse_width 100',12,'m')
    
%     title('Unipolar')
    set(gca,'fontsize',18)
    
    
    %% E = 30000
    
    subplot(1,3,3)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.8, polarity 0, pulse_width 100',12,'k')
    
    displayTrials(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1, pulse_width 10',12,'c')
    displayTrials(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1',12,'b')
    displayTrials(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 1, pulse_width 1000',12,'r')
 
    displayTrials(type,'d 16, E 80000, L 500, k_mem 0.8, polarity 0, pulse_width 100',12,'m')
    
%     title('Unipolar')
    set(gca,'fontsize',18)
    

end