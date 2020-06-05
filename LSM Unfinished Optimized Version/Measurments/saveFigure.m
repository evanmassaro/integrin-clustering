function saveFigure(System,Del,Nodes_S,Integrins_S,folderName,formated_time)

    %% Save each figure image update         
    figName = fullfile(folderName,'PNG',[folderName,', t ', formated_time,'.png']);
    title(['time: ',formated_time,' s'])
    updateDisplay_v1(System,Del,Nodes_S,Integrins_S)
    print(gcf,figName,'-dpng','-r600')

end