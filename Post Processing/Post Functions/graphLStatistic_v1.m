function [S, L] = graphLStatistic_v1(S,LMatrix,color,countL)
    
    L = LMatrix(countL,:);
    plot(S,L,'linewidth',2,'color',color)
    hold on

    
end