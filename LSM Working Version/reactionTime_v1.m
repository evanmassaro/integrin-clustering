function tau = reactionTime_v1(t, reactionVector)

    global k_electric pulse_width period inactiveSites activeSites
    
    r = rand;
    D = 0;
    d = 0;
    
    A = k_electric*(length(inactiveSites)+length(activeSites));
    M = sum(reactionVector) - A;
    
    
    mod_t = mod(t, period);
    
    solved = false;
    
    while ~solved
        if mod_t < pulse_width
            X = pulse_width - mod_t;
            
            if (D+X)*M + (d+X)*A > -log(r)
                X = -(log(r) + D*M + d*A)/(M+A);
                solved = true;
                tau = D + X;
                continue
            end
            d = d + X;
            D = D + X;
            mod_t = pulse_width;
            
        end
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