function LSMmodel_v4_3(stop, d_separation, ligDen, k_E, kmem, polarity, p_width, version)

%% Constants, Geometry, and Parameters. All units in standard SI.
    global nm2m
    nm2m = 10^(-9);
    global k_forward k_reverse
    % Spring Constants
    global k_mem k_gly k_sub k_bond
    k_gly = 0.02*10^(-3);
    k_mem =  kmem*10^(-3);
    k_sub = 1000*10^(-3);
    k_bond = 2.0*10^(-3);

    %Equilibrium node spacings
    global del_sub del_gly del_bond del_hop 
    del_sub = 20;
    del_bond = 27;
    del_gly = del_bond + d_separation;
    del_hop = 5;
    
    %Equilibrium lengths for glycocalyx plus bond on one node. Assumes the integrin displaces a negligable amount of fluid. 
    %Note this parallel spring model is probably not needed, given the 2 orders of magnitude difference in spring constants.
    global del_equilibrium k_equilibrium
    del_equilibrium = (k_bond*del_bond+k_gly*del_gly)/(k_bond+k_gly);
    k_equilibrium = k_bond + k_gly;

    % Dimensions of the substrate
    global numHeight numWidth numDepth numPlane numPlate numSub
    global virtualBuffer
    
    virtualBuffer = 1; % Copies a layer of nodes to enforce periodic boundary conditions
    % Allows a layer of nodes for periodic boundary conditions
    numHeight = 1; % Number of vertical elements in substrate.
    numWidth = 70 + 2*virtualBuffer; % Number of elements in each row       
    numDepth = 70 + 2*virtualBuffer; % Number of elements into the page     
    numSub = numHeight*numWidth*numDepth;
    numPlane = numWidth*numDepth;

    global lengthX lengthY
    lengthX = del_sub*(numWidth-1-virtualBuffer);
    lengthY = del_sub*(numDepth-1-virtualBuffer);

    % Dimensions of the membrane and total system
    global numMem cellThickness totalHeight numTot
    cellThickness = 3; %number of vertical nodes in cell membrane
    totalHeight = numHeight + cellThickness;
    numPlate = numPlane*cellThickness; % 2 two spacings thick
    numMem = cellThickness*numPlane; 
    numTot = numMem + numSub; % Total number of nodes

    % Helpful naming convention when selecting ligand or integrin
    global endFirstLayer startSecondLayer
    endFirstLayer = numHeight;
    startSecondLayer = numHeight + 1; 
    
    global realNodes virtualNodes virtualMap  % Virtual nodes are duplicated nodes that enforce periodic boundaries.
    [realNodes, virtualNodes, virtualMap] = getRealNodes_v1();

%% Lattice Structure

    % Set up the initial substrate and cell membrane
    global positions
    positions = setLattice_v1();

    global allNeighbors allSprings allDistances 
    % Grab all neighbors, spring constants, and equilibrium distances
    allNeighbors = getNeighbors_v3();
    allSprings = getSprings_v2();
    allDistances = getDistances_v3();

%% Integrin Ligand components

    % Initiliaze ligand positions 
    ligandDensity = ligDen/10^6; % Maximum 2500
    global ligSites
    ligSites = initializeLigands(ligandDensity);

    % Initialize integrin positions
    global integrinPositions
    integrinDensity = 100/10^6;
    integrinPositions = initializeIntegrins(integrinDensity);
    

    %Initial reaction rates
    global ka kd k_reverse_Init k_forward_Init k_hop compliance k_electric
    kd = 5; ka = 0.5;
    D = 5*10^4;
    k_hop = 4*D/(del_hop^2);
    k_electric = k_E;
    k_reverse_Init = 10^(-2);
    k_forward_Init = 10^5;
    compliance = 0.4*10^(-9);

    global activeSites inactiveSites bondedSites bondedPSIndices activePSIndices
    bondedSites = [];
    bondedPSIndices = [];
    integrinActivation_v1();
    activePSIndices = getIntegrinPSIndices_v2();
    % bondedPSIndices activePSIndices (PS = PSuedo) track the nearest element that an active/bonded integrin is
    % and assigns it to that node position if bond forms

    global savedStates kBT
    savedStates = false;
    kBT = 4.28*10^(-12)*10^(-9);
    
    % Get first version of precomputed distance versus force and energy data to compute curve fits.
    [forceC, energyC] = new_getFits_v1(del_gly,k_gly,k_mem,'1',0);
    global maxForce
    maxd = del_gly-del_bond;
    maxForce = polyval(forceC,maxd);
    
    % Display the fraction of initial active integrins.
    disp(['Active frac: ',num2str(length(activeSites)/length(integrinPositions))])
    
    % Given integrins and distance fits, compute forward and reverse rates of bond formation.
    updateBondRates_v4(forceC, energyC, 1:length(activeSites), 1:length(bondedSites))
    
    % Store all reaction rates for each integrin into a new array
    global reactionVector
    reactionVector = calculateReactionVector_v1();
    
%%  Pulsed electric field parameters
    global period pulse_width burst_width
    pulse_width = p_width; %seconds
    interdelay = 100*10^(-6);
    max_pulses = 80;
    period = pulse_width + interdelay;
    
    burst_width = max_pulses*period;
    
    e_direction = 1; % Default electrophoretic diffusion in positive x direction. 2 = negative x direction.

%% Simulation parameters 

    simTime = 0; % Current simulated time (s)
    precision = 2; % Check time to two decimal places
    oldRoundedTime = 0; % Temporary variable
    stopTime = stop; % Cutoff time for simulations
    
%% Start clustering statistics
    stepSize = 2; % discrete sampling step size for Ripley K
    S = 1:stepSize:lengthX/2;
    countL = 1; % counter for all temporal statistics
    LMatrix = zeros(1,length(S));
    [~,L] = ripleyK(integrinPositions(:,1:2), S, lengthX, lengthY);
            
    LMatrix(countL,:) = L;  
    bondFrac(countL) = length(bondedSites)/length(integrinPositions);
    
    countL = countL + 1;
    
%% Determine format of directories
    
    %Prepare folder to hold data
    folderName = ['d ',num2str(d_separation),', E ',num2str(k_E), ...
                 ', L ',num2str(ligDen), ', k_mem ',num2str(kmem), ...
                 ', polarity ', num2str(polarity), ', pulse_width ', num2str(p_width*10^6),...
                 ', version ', num2str(version)];
    [~, ~, ~] = mkdir(folderName); %This formats removes errors or warnings if folder already exists
    addpath(folderName)
    disp(folderName)
    
    % specify file name for .mat file
    pathName = fullfile(folderName,[folderName,', time_0.mat']);
    save(pathName)

    c = 1; % timestep counter for debugging

%% Start of Simulation
    while simTime < stopTime %Seconds
    
        % Determine most probable reaction
        [index, state, mu, tau, e_direction] = determineReaction_v4(simTime, polarity, k_E);
        % Perform reaction update
        transitionStates_v4(index,state,mu, e_direction, forceC, energyC)
%% For debug and timing purposes
%         if (length(activeSites) ~= length(activePSIndices)) || (length(bondedSites) ~= length(bondedPSIndices))
%             disp('There has been a terrible error')
%             assert(0 == 1)
%         end
%         if mod(c, 10000) == 1
%             tic
%         end
%         if mod(c, 1) == 0
% %             toc
%             disp([state, ', ', num2str(mu), ', ', num2str(k_electric), ' ', ...
%                   ', direction ', num2str(e_direction), ', ', num2str(simTime,'%.8f'), ...
%                   ' ', num2str(tau,'%.2g'), ', N_bonds ', num2str(length(bondedSites))])
%         end
          
        simTime = simTime + tau;
        
        % Determine when to update statistics, can also be used to save rendered graphics.
        newRoundedTime = round(simTime, precision);
        if newRoundedTime - oldRoundedTime ~= 0
            newImage = true;
            oldRoundedTime = newRoundedTime;
        else
            newImage = false;
        end
        
        % Compute statistics every `1' second, and save all data to directory.
        if mod(newRoundedTime,1) == 0 && newImage == true
            [~,L] = ripleyK(integrinPositions(:,1:2), S, lengthX, lengthY);
            
            LMatrix(countL,:) = L; % matrix of Ripley L statistics
            bondFrac(countL) = length(bondedSites)/length(integrinPositions); % array of bond fractions

            pathName = fullfile(folderName,[folderName,', time_',num2str(newRoundedTime),'.mat']);
            save(pathName)
            
            countL = countL + 1;
        end   
        c = c + 1;
    end

end
