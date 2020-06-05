function [time, bondFrac] = getBondFraction(bondFrac,countL,color,maxt)
    time = 0:countL-1;
    
    idx = find(bondFrac~=0, 1, 'first')-1;
    time = time(idx:end) - time(idx);
    bondFrac = bondFrac(idx:end);
    
%     plot(time,bondFrac*100,'linewidth',2,'color',color)
%     hold on

end