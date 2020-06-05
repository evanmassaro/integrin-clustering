function [forceC, energyC] = new_getFits_v1(del_gly,k_gly,k_mem,version,visualize,randC)
    global nm2m
    fileName = ['del_gly ', num2str(del_gly) ' k_gly ', num2str(k_gly*10^(3)),' k_mem ', num2str(k_mem*10^(3)), '_', version '.mat'];
    load(fileName)
    dNew = d(d > 0); 
    forceNew = force(d > 0);
    deltaEnergyNew = deltaEnergy(d > 0);
    
    d1 = dNew;
    force = forceNew/10^12;
    deltaEnergy = deltaEnergyNew/10^21;
    
    degree = 2;
    
    forceC = polyfitZero(d1,force,degree);
    [mdlF,S_F] = fit(d1',force',['poly',num2str(degree)]);
%     disp(fileName)
%     fprintf('R^2 = %.4f \n',S_F.rsquare)

    d2 = d1.^2;
    energyC = polyfit(d2,deltaEnergy,degree);
    [mdlE,S_E] = fit(d2',deltaEnergy',['poly',num2str(degree)]);
%     fprintf('R^2 = %.4f \n',S_E.rsquare)
%     disp('-------------------------------------')
    

   if visualize 
    maxD1 = 1*max(d1);
    maxD2 = maxD1^2;
    x1 = linspace(0, maxD1,100);
    forceY = polyval(forceC,x1);

    x2 = linspace(0, maxD2,100);
    energyY = polyval(energyC,x2);

    subplot(2,1,1)
    plot(x1,forceY,'linewidth',2,'color',randC)
    hold on
    scatter(d1,force,10,'o','filled','markeredgecolor','k','markerfacecolor',randC)
    title(['l_g = ',num2str(del_gly), ' nm, \sigma_g = ', num2str(k_gly*10^(3)),' pN/nm', ', \sigma_m = ', num2str(k_mem*10^(3)),' pN/nm'])
    ylabel('Force (pN)')
    xlabel('Distance (nm)')
    ylim([0 14])
    xlim([0 max(d1)])
    set(gca,'fontsize',18)
    grid on

    subplot(2,1,2)
    plot(x2,energyY,'linewidth',2,'color',randC)
    hold on
    scatter(d2,deltaEnergy,10,'o','filled','markeredgecolor','k','markerfacecolor',randC)
    ylabel('\DeltaE (pN*nm)')
    xlabel('Distance squared (nm^2)')
    ylim([-3 80])
    xlim([0 max(d1)^2])
    set(gca,'fontsize',18)
    grid on
   end
    
end