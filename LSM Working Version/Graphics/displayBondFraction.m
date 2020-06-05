function displayBondFraction(bondFrac,countL)

    plot(0:countL-1,bondFrac(1:countL)*100,'linewidth',2)
    xlim([0, 60])
    xlabel('Time (s)')
    ylabel('Bond Fraction (%)')
            
end