function [forceC, energyC] = getFits_v1(del_gly,k_gly,k_mem,version,visualize,randC)
    
    if ~exist('version','var')
        version = '1';
    end
    fileName = ['del_gly ', num2str(del_gly) ' k_gly ', num2str(k_gly),' k_mem ', num2str(k_mem), '_', version '.mat'];
    load(fileName)
    dNew = d(d > 0);
    forceNew = force(d > 0);
    deltaEnergyNew = deltaEnergy(d > 0);
    
    d1 = dNew;
    force = forceNew;
    deltaEnergy = deltaEnergyNew;
    
    DEGREE = 2;
    
    forceC = polyfitZero(d1,force,DEGREE);
    

    d2 = d1.^2;
    energyC = polyfit(d2,deltaEnergy,DEGREE);
    
    if nargin <= 4
       visualize = false;
    end
    
    if visualize 
        
        [mdlF,S_F] = fit(d1',force',['poly',num2str(DEGREE)]);
        disp(fileName)
        fprintf('R^2 = %.4f \n',S_F.rsquare)
        %ci = confint(mdl,0.95)

        [mdlE,S_E] = fit(d2',deltaEnergy',['poly',num2str(DEGREE)]);
        fprintf('R^2 = %.4f \n',S_E.rsquare)
        disp('-------------------------------------')
        %ci = confint(mdl,0.95)
        
        if nargin <= 5
            randC = 'b';
        end
        maxD1 = 1*max(d1);
        maxD2 = maxD1^2;
        x1 = linspace(0, maxD1,100);
        forceY = polyval(forceC,x1);

        x2 = linspace(0, maxD2,100);
        energyY = polyval(energyC,x2);
        
        % Force curve
        subplot(2,1,1)
        plot(x1,forceY,'linewidth',2,'color',randC)
        hold on
        scatter(d1,force,10,'o','filled','markeredgecolor','k','markerfacecolor',randC)
        title(['l_g = ',num2str(del_gly), ' nm, \sigma_g = ', num2str(k_gly),' pN/nm', ', \sigma_m = ', num2str(k_mem),' pN/nm'])
        ylabel('Force (pN)')
        xlabel('Distance (nm)')
        ylim([0 14])
        xlim([0 max(d1)])
        set(gca,'fontsize',18)
        grid on
        
        % Energy curve
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