global positions integrinPositions inactiveSites activeSites bondedSites 
global numWidth numDepth numPlane startSecondLayer endFirstLayer
global del_bond del_gly del_sub 

i = 3;
positions = storedData.nodePositions{i};
integrinPositions = storedData.intPositions{i};
inactiveSites = storedData.inactive{i};
activeSites = storedData.active{i};
bondedSites = storedData.bonded{i};
simTime = storedData.time{i};

updateDisplay_v1()
title(['Time: ',num2str(simTime,['%.',num2str(2),'f']), ' s'])