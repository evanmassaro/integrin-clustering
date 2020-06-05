
% Load file then run this script 

dNew = d(d > 0); 
forceNew = force(d > 0);
deltaEnergyNew = deltaEnergy(d > 0);

d1 = dNew;
force = forceNew;
deltaEnergy = deltaEnergyNew;

degree = 2;

forceC = polyfitZero(d1,force,degree);

d2 = d1.^2;
energyC = polyfit(d2,deltaEnergy,degree);

maxD1 = 1*max(d1);
maxD2 = maxD1^2;
x1 = linspace(0, maxD1,100);
forceY = polyval(forceC,x1);

x2 = linspace(0, maxD2,100);
energyY = polyval(energyC,x2);

subplot(2,1,1)
plot(x1,forceY,'linewidth',2)
hold on
scatter(d1,force,100,'o','filled','markeredgecolor','k')
ylabel('Force (pN)')
xlabel('Distance (nm)')
ylim([0 12])
xlim([0 max(d1)])
set(gca,'fontsize',18)
grid on

subplot(2,1,2)
plot(x2,energyY,'linewidth',2)
hold on
scatter(d2,deltaEnergy,100,'o','filled','markeredgecolor','k')
ylabel('\DeltaE (pN*nm)')
xlabel('Distance squared (nm^2)')
ylim([-3 60])
xlim([0 max(d1)^2])
set(gca,'fontsize',18)
grid on