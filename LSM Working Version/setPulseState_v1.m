function e_direction = setPulseState_v1(simTime, polarity, k_E)

    global period pulse_width burst_width k_electric

    if polarity > 0
        if mod(simTime, 1) > burst_width
            k_electric = 0;
        else
            if mod(simTime, period) > pulse_width
                k_electric = 0;
            else
                k_electric = k_E;
            end
        end
    end
    e_direction = 1; % positive x direction
        
    if polarity == 2
        if mod(simTime, 2*period) > pulse_width
            e_direction = 2; % negative x direction
        end
    end
end