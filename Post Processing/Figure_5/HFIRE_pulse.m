figure('units','normalized','outerposition',[0 0 0.5 0.3])

plot_HFIRE()

fig = gcf;
print('HFIRE','-dpng','-r1000')


function plot_HFIRE()
    pulse_width = 70;
    interdelay = 40;
    period = pulse_width + interdelay;
    num_pulses = 4;
    burst_width = period*num_pulses;
    repeat_time = 1000;

    amplitude = 1;

    t = -20:0.001:2000-20;

    P.pulse_width = pulse_width;
    P.interdelay = interdelay;
    P.period = period;
    P.amplitude = amplitude;
    P.num_pulses = num_pulses;
    P.burst_width = burst_width;
    P.repeat_time = repeat_time;



    plot(t, unipolar(t, P), 'linewidth', 3, 'color', 'k')
    hold on
    plot(t, bipolar(t, P), 'linewidth',3, 'linestyle', '--', 'color', [1.0,0.2,0.2])

    offset = 50;
    
    plot_interupt([burst_width+offset, burst_width+2*offset])
    plot_interupt([repeat_time-2*offset, repeat_time-offset])

    plot_interupt([repeat_time+burst_width+offset, repeat_time+burst_width+2*offset])
    plot_interupt([2*repeat_time-2*offset, 2*repeat_time-offset])


    % xlabel('time')
    % ylabel('Field Strength')
    legend('Unipolar', 'Bipolar')
    xlabel('time')
    ylabel('strength')

    set(gca, 'fontsize', 18)
    set(gca, 'xtick', [])
    set(gca, 'ytick', [])
    ylim([-1.1, 1.1])
    xlim([min(t), max(t)])
end


function plot_interupt(px)
    plot(px, [0,0], 'linewidth',3, 'color', 'w')
    [x, y] = interupt(px(1));
    plot(x,y, 'linewidth', 3, 'color', 'k')
    [x, y] = interupt(px(2));
    plot(x,y, 'linewidth', 3, 'color', 'k')
end

function [x, y] = interupt(px)
    dt = 20;
    x = -dt:0.001:dt;
    x = x + px;
    y = linspace(-0.1, 0.1, length(x));

end



function y = unipolar(t, P)

    pulse_width = P.pulse_width;
    interdelay = P.interdelay;
    period = P.period;
    amplitude = P.amplitude;
    num_pulses = P.num_pulses;
    repeat_time = P.repeat_time;
    burst_width = P.burst_width;
    
    y = zeros(length(t),1);
    
    t_repeat = mod(t, repeat_time);

    t_period = mod(t_repeat, period);
   
    y(t_period < pulse_width) = amplitude;
    
    y(t_repeat >= burst_width) = 0;
    y(1) = 0;
    
    
 
end

function y = bipolar(t, P)

    pulse_width = P.pulse_width;
    interdelay = P.interdelay;
    period = P.period;
    amplitude = P.amplitude;
    num_pulses = P.num_pulses;
    repeat_time = P.repeat_time;

    t_period = mod(t, period);
    
    y = unipolar(t, P);
    
    t_repeat = mod(t, repeat_time);
    
    t_bipolar = mod(t_repeat, 2*period);
    y(t_bipolar >= period) = -1*y(t_bipolar >= period);
 
end