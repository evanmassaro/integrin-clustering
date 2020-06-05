function LSMmodel_v5_1(parameter_pairs,stopTime)

%% Initialize entire chemo-mechanical system
    [K,Del,System,Coordinates,Reactions,Fits,Nodes_S,Integrins_S] = setupSystem(parameter_pairs);
    Stats = getStats(System,Nodes_S,Integrins_S,[]);

%% Determine format of directories
    precision = 2;
    formated_time = @(x) num2str(x,['%.',num2str(precision),'f']);
    
    % Prepare folder to hold printed figure
    folderName = ['d_gly ',num2str(Del.GLY),...
                ', k_e ',num2str(Reactions.k_E),...
                ', L ',num2str(Reactions.LIGAND_DENSITY*10^6)];
    [~, ~, ~] = mkdir(folderName);
    [~, ~, ~] = mkdir(fullfile(folderName,'MAT'));
    [~, ~, ~] = mkdir(fullfile(folderName,'PNG'));
    addpath(folderName)
    
    % Save initial variables
    saveFigure(System,Del,Nodes_S,Integrins_S,folderName,formated_time(0))
    
    dataName = fullfile(folderName,'MAT',[folderName,', t ',formated_time(0),'.mat']);
    save(dataName)

%% Start of Simulation
    simTime = 0;
    oldRoundedTime = 0;
    stepTime = 10^(-precision);

    while simTime < stopTime 
        [Nodes_S,Integrins_S,tau] = dynamicModel(K,Del,System,Coordinates,Reactions,Fits,Nodes_S,Integrins_S);

        % Determine if enough time has passed to save new image
        [oldRoundedTime, newRoundedTime, NEW_IMAGE] = newImage(simTime,precision,oldRoundedTime);
        
        % Save workplace and image every at fixed rate
        if mod(newRoundedTime,stepTime) == 0 && NEW_IMAGE == true                     
            saveFigure(System,Del,Nodes_S,Integrins_S,folderName,formated_time(newRoundedTime))
            Stats = getStats(System,Nodes_S,Integrins_S,Stats);
            dataName = fullfile(folderName,'MAT',[folderName,'_t ',formated_time(newRoundedTime),'.mat']);
            save(dataName)
        end 
        simTime = simTime + tau;   
    end
end