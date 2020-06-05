function graphLStatistic_v1(S,LMatrix, countL)
    
%     for i = 1:10:countL
        plot(S,LMatrix(end,:),'linewidth',2)
%     end
    
%     str = cell(1,countL);
%     for i = 1:10:countL
%         str{i} = ['Time = ' ,num2str(i-1), ' s'];
%     end
    %legend(str);
    xlim([S(1), S(end)])
    xlabel('distance (nm)')
    ylabel('L-statistic (nm)')
    
end