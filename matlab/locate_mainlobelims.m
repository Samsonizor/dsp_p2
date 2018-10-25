function [ left_bound, right_bound, center ] = locate_mainlobelims( array )
% given an array that represents a response with main lobes and side lobes,
% find the bounds of the main lobe
    [~, index] = max(array);
    % find the left bound
    i = index;
    while(array(i) > array(i-1))
        i = i-1;
    end
    left_bound = i;
    i = index;
    while(array(i) > array(i+1))
        i = i+1;
    end
    right_bound = i;
    center = index;
end

