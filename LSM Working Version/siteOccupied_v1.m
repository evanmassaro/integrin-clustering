function occupied = siteOccupied_v1(searchSpace, target)
    
    occupied = false;

    occupiedVector = (searchSpace == target);
    
    if sum(occupiedVector) ~=0
        occupied = true;
    end
    
end