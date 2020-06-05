function distances = getDistances_v3(System, Coordinates, Del)

%% System variables
    NUMZ = System.NUMZ;
    NUMY = System.NUMY;
    NUMX = System.NUMX;
    TOTAL = System.TOTAL;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
    MAX_NEIGHBORS = Coordinates.MAX_NEIGHBORS;
    xCoordinate = Coordinates.xCoordinate;
    yCoordinate = Coordinates.yCoordinate;
    zCoordinate = Coordinates.zCoordinate;
    
    % Six primary directions
    posX = Coordinates.posX;
    negX = Coordinates.negX;
    posY = Coordinates.posY;
    negY = Coordinates.negY;
    posZ = Coordinates.posZ;
    negZ = Coordinates.negZ;
    
    % Next 4 directions in xy-plane 
    posX_posY = Coordinates.posXposY;
    negX_posY = Coordinates.negXposY;
    negX_negY = Coordinates.negXnegY;
    posX_negY = Coordinates.posXnegY;
    
    % Next 4 directions in yz-plane 
    posY_posZ = Coordinates.posYposZ;
    posY_negZ = Coordinates.posYnegZ;
    negY_negZ = Coordinates.negYnegZ;
    negY_posZ = Coordinates.negYposZ;
    
    % Next 4 directions in xz-plane 
    posX_posZ = Coordinates.posXposZ;
    posX_negZ = Coordinates.posXnegZ;
    negX_negZ = Coordinates.negXnegZ;
    negX_posZ = Coordinates.negXposZ;
    
    Del_SUB = Del.SUB;
    Del_GLY = Del.GLY;
    
%% Initialize equalibrium distances for all spring connections
    distances = zeros(MAX_NEIGHBORS,3,TOTAL); % 3 spatial coordinates
  
    k = 1;
    for z = 1:NUMZ
        for y = 1:NUMY
            for x = 1:NUMX
                %% Six directions in xyz [1 0 0] directions
                
                % Positive X direction
                if x ~= NUMX
                    distances(posX,xCoordinate,k) = Del_SUB;  
                else
                    distances(posX,xCoordinate,k) = (NUMX-1)*Del_SUB;
                end
                
                % Negative X direction
                if x ~= 1
                    distances(negX,xCoordinate,k) = Del_SUB;
                else
                    distances(negX,xCoordinate,k) = (NUMX-1)*Del_SUB;
                end
                
                % pos Y direction
                if y ~= NUMY
                    distances(posY,yCoordinate,k) = Del_SUB;
                else
                    distances(posY,yCoordinate,k) = (NUMY-1)*Del_SUB;
                end
                
                % Negative Y direction
                if y ~= 1
                    distances(negY,yCoordinate,k) = Del_SUB;
                else
                    distances(negY,yCoordinate,k) = (NUMX-1)*Del_SUB;
                end
                
                % pos Z direction
                if z ~= END_FIRST_LAYER
                    distances(posZ,zCoordinate,k) = Del_SUB;
                else
                    distances(posZ,zCoordinate,k) = Del_GLY;
                end
                
                % neg Z direction
                if z ~= START_SECOND_LAYER
                    distances(negZ,zCoordinate,k) = Del_SUB;
                else
                    distances(negZ,zCoordinate,k) = Del_GLY;
                end
                
        %% Four directions in xy-plane 
                
                % posXposY direction
                distances(posX_posY,xCoordinate,k) = ...
                    distances(posX,xCoordinate,k);
                
                distances(posX_posY,yCoordinate,k) = ...
                    distances(posY,yCoordinate,k);
                
                % negXposY direction
                distances(negX_posY,xCoordinate,k) = ...
                    distances(negX,xCoordinate,k);
                
                distances(negX_posY,yCoordinate,k) = ...
                    distances(posY,yCoordinate,k);
                
                % negXnegY direction
                distances(negX_negY,xCoordinate,k) = ...
                    distances(negX,xCoordinate,k);
                
                distances(negX_negY,yCoordinate,k) = ...
                    distances(negY,yCoordinate,k);
                
                % posXnegY direction
                distances(posX_negY,xCoordinate,k) = ...
                    distances(posX,xCoordinate,k);
                
                distances(posX_negY,yCoordinate,k) = ...
                    distances(negY,yCoordinate,k);                
                
                
        %% Four directions in yz-plane 
                
                % posYposZ direction
                distances(posY_posZ,yCoordinate,k) = ...
                    distances(posY,yCoordinate,k);
                
                distances(posY_posZ,zCoordinate,k) = ...
                    distances(posZ,zCoordinate,k);
                
                % posYnegZ direction
                distances(posY_negZ,yCoordinate,k) = ...
                    distances(posY,yCoordinate,k);
                
                distances(posY_negZ,zCoordinate,k) = ...
                    distances(negZ,zCoordinate,k);
                
                % negYnegZ direction
                distances(negY_negZ,yCoordinate,k) = ...
                    distances(negY,yCoordinate,k);
                
                distances(negY_negZ,zCoordinate,k) = ...
                    distances(negZ,zCoordinate,k);
                
                % negYposZ direction
                distances(negY_posZ,yCoordinate,k) = ...
                    distances(negY,yCoordinate,k);
                
                distances(negY_posZ,zCoordinate,k) = ...
                    distances(posZ,zCoordinate,k);
                
        %%  Four directions in xz-plane 
                
                % posXposZ direction
                distances(posX_posZ,xCoordinate,k) = ...
                    distances(posX,xCoordinate,k);
                
                distances(posX_posZ,zCoordinate,k) = ...
                    distances(posZ,zCoordinate,k);
                
                % posXnegZ direction
                distances(posX_negZ,xCoordinate,k) = ...
                    distances(posX,xCoordinate,k);
                
                distances(posX_negZ,zCoordinate,k) = ...
                    distances(negZ,zCoordinate,k);
                
                % negXnegZ direction
                distances(negX_negZ,xCoordinate,k) = ...
                    distances(negX,xCoordinate,k);
                
                distances(negX_negZ,zCoordinate,k) = ...
                    distances(negZ,zCoordinate,k);
                
                % negXposZ direction
                distances(negX_posZ,xCoordinate,k) = ...
                    distances(negX,xCoordinate,k);
                
                distances(negX_posZ,zCoordinate,k) = ...
                    distances(posZ,zCoordinate,k);    
                
                k = k + 1;
            end
        end
    end
    
end