function displayBondFraction(bondFrac,countL)

    figure(3)
    plot(0:countL-1,bondFrac(1:countL)*100)
    xlim([0, countL-1])
    xlabel('Time (s)')
    ylabel('Bond Fraction (%)')
            
end