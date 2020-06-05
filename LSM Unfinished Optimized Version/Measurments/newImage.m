function [oldRoundedTime, newRoundedTime, NEW_IMAGE] = newImage(simTime,precision,oldRoundedTime)

    % Determine when to update image
    newRoundedTime = round(simTime,precision);
    if newRoundedTime - oldRoundedTime ~= 0
        NEW_IMAGE = true;
        oldRoundedTime = newRoundedTime;
    else
        NEW_IMAGE = false;
    end

end