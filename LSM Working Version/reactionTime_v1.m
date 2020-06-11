function tau = reactionTime_v1(t, reactionVector)
% Equivalent to the piecewise integration of the Gillespie algorithm for one constant contribution and one time depdendent one
% Solves for the elapsed time until a reaction occurs
    global k_electric pulse_width period inactiveSites activeSites
    
    r = rand;
    D = 0; % stores amount of time that hass passed
    d = 0; % stores the total amount of time the field has been on
    
    A = k_electric*(length(inactiveSites)+length(activeSites)); # total electrophoretic contribution
    M = sum(reactionVector) - A; # total non-electrical contribution (not time dependent on these time scales)
    
    mod_t = mod(t, period);
    
    solved = false;
    
    while ~solved
    % If current time is within a pulse, see if a reaction can possibly occur by the end of the pulse being on
        if mod_t < pulse_width
            X = pulse_width - mod_t;
            
            if (D+X)*M + (d+X)*A > -log(r)
                # If reaction can occur in time frame, determine the time
                X = -(log(r) + D*M + d*A)/(M+A);
                solved = true;
                tau = D + X;
                continue
            end
            d = d + X;
            D = D + X;
            mod_t = pulse_width;
            
        end
    % When the pulse is off, check constant reaction contibution  
        if mod_t >= pulse_width
            X = period - mod_t;
            
            if (D+X)*M + d*A > -log(r)
                X = -(log(r) + D*M + d*A)/M;
                solved = true;
                tau = D + X;
                continue
            end
            D = D + X;
            mod_t = 0;
            
        end
    end

end
