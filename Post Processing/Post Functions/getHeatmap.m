function getHeatmap(txt, M,X,Y, xlab, ylab, ti, CT, latex)
    x = 1:size(M,2);
    y = 1:size(M,1);
    
    if nargin == 8
        latex = 0;
    end

    pcolor([M, zeros(size(M,1), 1); zeros(1, size(M,2)+1)])
    [XX,YY] = meshgrid(x+0.5, y+0.5);
    text(XX(:), YY(:), txt, 'horizontalalignment','center','verticalalignment','middle','fontsize',18)

    colormap(CT);
%     cbh = colorbar('location','eastoutside');
    cbh.Label.String = 'Percentage Increase (%)';
    caxis([-100, 350])
    %axis equal
    set(gca, 'xtick',x+0.5)
    set(gca, 'xticklabels',X)

    xlim([min(XX,[],'all')-0.5, max(XX,[],'all')+0.5])
    set(gca,'fontsize',18)
    ylim([min(YY,[],'all')-0.5, max(YY,[],'all')+0.5])

    set(gca, 'ytick',y+0.5)
    set(gca, 'yticklabels',Y)

    xlabel(xlab)
    ylabel(ylab)
    
%     set(cbh,'rotation',270,'VerticalAlignment','middle')
    
%     cbh.Label.Interpreter = 'latex';
%     if latex
%         title(cbh, ti, 'interpreter','latex', 'FontWeight','Bold', 'fontsize', 18)
%     else
%         title(cbh, ti, 'fontsize', 18, 'FontWeight','Normal')
%     end
    set(gca,'fontsize',18)
    pause(0)
end