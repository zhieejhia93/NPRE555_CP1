function [flag] = checkloc(a,loc,prevloc)

% Check location of neutron and change the material properties according to the region
% Determine if a neutron born in a region stays in that region

if loc >= 0 && loc <= a/2
    if prevloc >= 0 && prevloc <= a/2 
        flag = 1;  % A neutron born in a region stays in that region
    elseif prevloc >= a/2 && prevloc <= a 
        flag = 2;  % A neutron born in a region leaves that region
    end
end

if loc >= a/2 && loc <= a
    if prevloc >= a/2 && prevloc <= a 
        flag = 1;
    elseif prevloc >= 0 && prevloc <= a/2 
        flag = 2;
    end
end

if loc < 0 || loc > a
    flag =0;
end


