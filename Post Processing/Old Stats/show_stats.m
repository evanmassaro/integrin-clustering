function show_stats(data)
    
    data_mean = reshape(mean(data,2),[2,2])';
    data_std = reshape(std(data,0,2),[2,2])';

    b = [51, 51, 255]/255;
    r = [255, 51, 51]/255;

    ctrs = 1:2;
    figure(1)
    hBar = bar(ctrs, data_mean,'linewidth',1.5);
    hBar(1).FaceColor = b;
    hBar(2).FaceColor = r;

    for k1 = 1:size(data_mean,1)
        ctr(k1,:) = bsxfun(@plus, hBar(1).XData, [hBar(k1).XOffset]');
        ydt(k1,:) = hBar(k1).YData;
    end
    hold on
    errorbar(ctr, ydt, zeros(size(data_std)),data_std','marker','none','linestyle','none','linewidth',1.5,'color','k')
    hold off

    set(gca, 'XTickLabel', {'\rho = 500 #/\mum^2','\rho = 1000 #/\mum^2'})
    set(gca,'fontsize',18)

    ylim([0 1.05*max(data_mean + data_std,[],'all')])
%     fig = gcf;
%     fig.PaperUnits = 'inches';
%     fig.PaperPosition = [1 1 5 4];
%     print('max_D','-dpng','-r0')
end