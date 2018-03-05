function [loc_dis,k]=scatter(loc,a,disX,k)

global j final_loc_dis loc_dis loc_dis_abs loc_dis_leak

k = k+1;
loc_dis(k,:)=tallyloc(loc,disX);    % Scatter happens here. Neutron location is tallied before moving to new location
[theta,azi] = dirGen();
[disX] = disGen(a,loc,theta,azi);
prevloc = loc;                      % Store previous location of neutron
loc = loc + disX;                   % New location of neutron in x direction MUST STORE THIS LOCATION

flag = checkloc(a,loc,prevloc);     % Check location of neutron

if flag == 1                        % Neutron stay in the region and collision happens
    mark = colType(loc,a,disX);
    if mark == 1                    % Neutron is absorbed
        k = k+1;
        loc_dis(k,:) = tallyabsorption(loc,disX);
        [loc_dis_abs(:,j)] = tallyabsorption(loc,disX);
        final_loc_dis{1,j} = loc_dis(:,:);
    elseif mark == 2
       [loc_dis,k] = scatter(loc,a,disX,k); 
    end    
    
elseif flag == 2                    % Neutron crosses into the other region without leaving the medium
    mark = colType(loc,a,disX);
    if mark == 1                    % Neutron is absorbed
        k = k+1;
        loc_dis(k,:) = tallyabsorption(loc,disX);
        [loc_dis_abs(:,j)] = tallyabsorption(loc,disX);        
        final_loc_dis{1,j} = loc_dis(:,:);
    elseif mark == 2                % Neutron is scattered
        [loc_dis,k] = scatter(loc,a,disX,k);
    end
    
elseif flag ==0                     % Neutron leaks from the medium completely
    loc_dis(k,:)=tallyloc(loc,disX);
    [loc_dis_leak(:,j)] = tallyloc(loc,disX);
    final_loc_dis{1,j} = loc_dis(:,:);
end




