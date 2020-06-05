function Coordinates = parametersCoordinates(pairs)
    
    Coordinates.MAX_NEIGHBORS  = 18;
    Coordinates.xCoordinate = 1;
    Coordinates.yCoordinate = 2;
    Coordinates.zCoordinate = 3;
    
    
    % Six primary directions
    Coordinates.posX = 1;
    Coordinates.negX = 2;
    Coordinates.posY = 3;
    Coordinates.negY = 4;
    Coordinates.posZ = 5;
    Coordinates.negZ = 6;
    
    % Next 4 directions in xy-plane 
    Coordinates.posXposY = 7;
    Coordinates.negXposY = 8;
    Coordinates.negXnegY = 9;
    Coordinates.posXnegY = 10; 
    
    % Next 4 directions in yz-plane 
    Coordinates.posYposZ = 11;
    Coordinates.posYnegZ = 12;
    Coordinates.negYnegZ = 13;
    Coordinates.negYposZ = 14;
    
    % Next 4 directions in xz-plane 
    Coordinates.posXposZ = 15;
    Coordinates.posXnegZ = 16;
    Coordinates.negXnegZ = 17;
    Coordinates.negXposZ = 18;
    
    Coordinates = addParameters(Coordinates,pairs);
end