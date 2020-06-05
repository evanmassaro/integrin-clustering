function [mu, i] = sampleReaction(reactionVector)

    numReactions = 6;      
    rec_1 = reactionVector(1:numReactions:end);
    rec_2 = reactionVector(2:numReactions:end);
    rec_3 = reactionVector(3:numReactions:end);
    rec_4 = reactionVector(4:numReactions:end);
    rec_5 = reactionVector(5:numReactions:end);
    rec_6 = reactionVector(6:numReactions:end);
    
    totals = [sum(rec_1), sum(rec_2), sum(rec_3), sum(rec_4), sum(rec_5), sum(rec_6)];
    
    % Determine likely ordering of vector
    [sorted_totals, order] = sort(totals, 'descend');
    cum_totals = cumsum(sorted_totals);
    
    total = sum(totals);
    partialSum = rand*total;
    
    first_ind = find(cum_totals > partialSum, 1);
    
    if first_ind == 1
        num = 0;
    else
        num = cum_totals(first_ind-1);
    end
    
    for q = order(first_ind:end)
        i = q;
        %%Instead of while loop, check if greater than each total
        while num < partialSum && i <= length(reactionVector)
            num = num + reactionVector(i);
            i = i + numReactions;
        end
        if num > partialSum
            break
        end
    end
    
    i = i-numReactions;
    
    mu = mod(i,numReactions);
    if mu == 0
        mu = numReactions;
    end

end