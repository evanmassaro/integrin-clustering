function updateDisplay_v1()
    global positions ligSites del_sub numWidth del_gly
    cla
    figure(1)
    displayNodes_v6(positions);
    interpolatedSurface_v2()
    displayIntegrins_v3();
    displayLigands_v2(positions, ligSites);
    set(gca,'fontsize',18)
    pause(0);

    axis([-del_sub, numWidth*del_sub, -del_sub, numWidth*del_sub, 3, del_gly*1.1]);

end