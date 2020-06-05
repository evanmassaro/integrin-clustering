function found = binarySearch(array, target)

    left = 1;
    right = length(array);
    index = 1;

    while left <= right
        mid = floor((left + right)/2);

        if array(mid) == target
            index = mid;
            break;
        elseif array(mid) > target
            
            right = mid - 1;
        else
            left = mid + 1;
        end
    end

    if target == array(index)
        found = true;
    else
        found = false;
    end
    
end

