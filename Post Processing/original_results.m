%%
showFinalResults('graphLStatistic_v1');


%%
showFinalResults('displayBondRate');


%%
showFinalResults('displayBondFraction');


%%

function showFinalResults(type)
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,3,1)
    displayTrials(type,'d 16, E 0, L 200, k_mem 0.4',4,'g')
    displayTrials(type,'d 16, E 40, L 200, k_mem 0.4',4,'k')
    displayTrials(type,'d 16, E 400, L 200, k_mem 0.4',4,'b')
    displayTrials(type,'d 16, E 4000, L 200, k_mem 0.4',4,'r')

    title('\rho = 200 \mum^{-2}, \sigma_m = 0.4 pN/nm')
    %legend('k_E = 400 s^{-1}','k_E = 400 s^{-1}','k_E = 4000 s^{-1}','k_E = 4000 s^{-1}','location','northeast')
    set(gca,'fontsize',18)


    subplot(2,3,4)
    displayTrials(type,'d 16, E 0, L 200, k_mem 0.8',4,'g')
    displayTrials(type,'d 16, E 40, L 200, k_mem 0.8',4,'k')
    displayTrials(type,'d 16, E 400, L 200, k_mem 0.8',4,'b')
    displayTrials(type,'d 16, E 4000, L 200, k_mem 0.8',4,'r')
    title('\rho = 200 \mum^{-2}, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)

    % L = 500

    subplot(2,3,2)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.4',4,'g')
    displayTrials(type,'d 16, E 40, L 500, k_mem 0.4',4,'k')
    displayTrials(type,'d 16, E 400, L 500, k_mem 0.4',4,'b')
    displayTrials(type,'d 16, E 4000, L 500, k_mem 0.4',4,'r')
    title('\rho = 500 \mum^{-2}, \sigma_m = 0.4 pN/nm')
    set(gca,'fontsize',18)

    subplot(2,3,5)
    displayTrials(type,'d 16, E 0, L 500, k_mem 0.8',4,'g')
    displayTrials(type,'d 16, E 40, L 500, k_mem 0.8',4,'k')
    displayTrials(type,'d 16, E 400, L 500, k_mem 0.8',4,'b')
    displayTrials(type,'d 16, E 4000, L 500, k_mem 0.8',4,'r')
    title('\rho = 500 \mum^{-2}, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)

    % L = 1000

    subplot(2,3,3)
    displayTrials(type,'d 16, E 0, L 1000, k_mem 0.4',4,'g')
    displayTrials(type,'d 16, E 40, L 1000, k_mem 0.4',4,'k')
    displayTrials(type,'d 16, E 400, L 1000, k_mem 0.4',4,'b')
    displayTrials(type,'d 16, E 4000, L 1000, k_mem 0.4',4,'r')
    title('\rho = 1000 \mum^{-2}, \sigma_m = 0.4 pN/nm')
    set(gca,'fontsize',18)

    subplot(2,3,6)
    displayTrials(type,'d 16, E 0, L 1000, k_mem 0.8',4,'g')
    pause(1)
    displayTrials(type,'d 16, E 40, L 1000, k_mem 0.8',4,'k')
        pause(1)
    displayTrials(type,'d 16, E 400, L 1000, k_mem 0.8',4,'b')
        pause(1)
    displayTrials(type,'d 16, E 4000, L 1000, k_mem 0.8',4,'r')
        pause(1)
    title('\rho = 1000 \mum^{-2}, \sigma_m = 0.8 pN/nm')
    set(gca,'fontsize',18)
end