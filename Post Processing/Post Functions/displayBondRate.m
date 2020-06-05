function displayBondRate(bondFrac,countL,color,maxt,maxy)

    time = 0:countL-2;
    delta_bonds = bondFrac(2:countL) - bondFrac(1:countL-1);
    
    idx = find(delta_bonds~=0, 1, 'first');
    time = time(idx:end) - time(idx);
    delta_bonds = delta_bonds(idx:end);
    
    scatter(time,delta_bonds,'markerfacecolor',color, 'markeredgecolor', color)
    xlim([0, maxt])
    ylim([0, maxy])
    xlabel('Time (s)')
    ylabel('Formation Rate (#/s)')
end