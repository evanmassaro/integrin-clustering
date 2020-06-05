function graphLStatistic_v1(S,LMatrix, countL)
    
    figure(2)
    cla
    hold on
    
    for i = 1:countL
        plot(S,LMatrix(i,:),'linewidth',0.1)
    end
    
    str = cell(1,countL);
    for i = 1:countL
        str{i} = ['Time = ' ,num2str(i-1), ' s'];
    end
    legend(str);
    xlabel('distance (nm)')
    ylabel('L-statistic (nm)')
    
end