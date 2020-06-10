function getRelationships_v2(numBonds, d_separation, k_factor, version)
    % Create distance depedent force and change in energy data points for each integrin-ligand bond. 
    % Save output after each new bond formation.
    global positiveZ negativeZ 
    
    %% Constants, Geometry, and Parameters

    global nm2m
    nm2m = 10^(-9);

    % Spring Constants
    global k_mem k_gly k_sub k_bond
    k_gly = 0.02*10^(-3);
    k_mem = k_factor*k_gly;
    k_sub = 1000*10^(-3);
    k_bond = 2.0*10^(-3);

    %Equilibrium node spacings
    global del_sub del_gly del_bond del_hop 
    del_sub = 20;
    del_bond = 27;
    del_gly = del_bond + d_separation;
    del_hop = 5;
    
    %Equilibrium lengths for glycocalyx plus bond on one node. Assumes the integrin displaces anegligable amount of fluid. 
    %Note this parallel spring model is probably not needed, given the 2 orders of magnitude difference in spring constants.
    global del_equilibrium k_equilibrium
    del_equilibrium = (k_bond*del_bond+k_gly*del_gly)/(k_bond+k_gly);
    k_equilibrium = k_bond + k_gly;

    % Dimensions of the substrate
    global numHeight numWidth numDepth numPlane numPlate numSub
    global virtualBuffer
    
    % Create a small computational domain
    virtualBuffer = 1; % Copies a layer of nodes to enforce periodic boundary conditions
    numHeight = 5; % Number of elements in each column 
    numWidth = 12 + 2*virtualBuffer; % Number of elements in each row       %12 for curve fits
    numDepth = 12 + 2*virtualBuffer; % Number of elements into the page     %12 for curve fits
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

    % Hhelpful naming convention when selecting ligand or integrin
    global endFirstLayer startSecondLayer
    endFirstLayer = numHeight;
    startSecondLayer = numHeight + 1; 
    
    global realNodes virtualNodes virtualMap % Virtual nodes are duplicated nodes that enforce periodic boundaries.
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
    
    
    zCordinate = 3;
    
    firstLayer = length(realNodes)/totalHeight;
    moveableNodes = realNodes(firstLayer+1:end); % The substrate was not modeled to deform for large spring constant such as glass.
    numIter = length(realNodes)*10^2; % Change number of MCS steps here
    
    numNodesInPlane = realNodes(1:length(realNodes)/totalHeight);
    ranSites = randsample(numNodesInPlane,numBonds);
    % Create random sequence of bonds to form, to measure distance-dependent change in force and energy.
    bondSites = ranSites + numPlane*(startSecondLayer-1); 
    
    d = zeros(1,numBonds); % deformation in integrin-ligand bond after formation
    force = zeros(1,numBonds);
    deltaEnergy = zeros(1,numBonds);
    
    fore_str = ['del_gly ', num2str(del_gly) ' k_gly ', num2str(k_gly*10^(3)), ' k_mem ', num2str(k_mem*10^(3))];
    full_str = [fore_str,'_', version,'.mat'];
    
    for i = 1:numBonds
        integrin = bondSites(i);
        ligand = bondSites(i) - numPlane;  

        oldEnergy = getSystemEnergy_v2(moveableNodes);
        d(i) = positions(integrin,3) - positions(ligand,3)-del_equilibrium;
        
        % 'create bond' by changing spring properties
        allSprings(ligand,positiveZ) =  k_equilibrium;
        allSprings(integrin,negativeZ) =  k_equilibrium;
        allDistances(ligand,positiveZ,zCordinate) =  del_equilibrium;
        allDistances(integrin,negativeZ,zCordinate) =  del_equilibrium;

        [newEnergy, stdE] = minimizeSystemEnergy_v4(moveableNodes, numIter);
        deltaEnergy(i) = (newEnergy - oldEnergy)*nm2m^2;
        
        displacement = positions(integrin,3) - positions(ligand,3);
        force(i) = k_equilibrium*abs(displacement - del_equilibrium)*nm2m;

        % SAVE DATA
        full = fullfile(fore_str,full_str);
        [~,~,~] = mkdir(fore_str);
        save(full,'d','force','deltaEnergy','stdE', 'bondSites','fore_str')
        disp([fore_str, ': ',num2str(i), '/' num2str(numBonds)])
%         displayNodes_v6(positions);
%         pause(0)
    end
end
