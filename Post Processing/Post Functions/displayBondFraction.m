function displayBondFraction(bondFrac,countL,color,maxt)
    time = 0:countL-1;
    
    idx = find(bondFrac~=0, 1, 'first')-1;
    time = time(idx:end) - time(idx);
    bondFrac = bondFrac(idx:end);
    
    plot(time,bondFrac*100,'linewidth',2, 'color', color)
    
%     scatter(countL, bondFrac(countL), 'markerfacecolor', color, 'markeredgecolor', color)

%     set(gca, 'xscale', 'log')
    hold on
%     pause(2)
%     xlim([0, maxt])
    xlabel('Time (s)')
    ylabel('Bond Fraction (%)')   
end