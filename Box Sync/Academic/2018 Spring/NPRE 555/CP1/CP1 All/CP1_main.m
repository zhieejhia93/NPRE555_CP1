% NPRE 555 CP1
% By Zhiee Jhia Ooi
% Monte Carlo simulation for neutron transport in a 1D slab

close all
clear all
clc
global loc_dis j final_loc_dis loc_dis_leak loc_dis_abs 

%% Define constants and geometry
Nn = 1000000;        % Number of neutrons
a = 1;               % Width of slab in [m]
nx = 201;            % Number of grid in x direction
x = linspace(0,a,nx); 
dx = a./nx;
final_loc_dis={};

%% Start for loop

for j=1:Nn
        k=0;   
        [loc,dx_left,dx_right] = locGen;    % Determine the location of neutron birth and distances to the left, right boundaries
        [theta,azi] = dirGen;               % Generate direction of neutron path       
        disX = disGen(a,loc,theta,azi);     % Determine scalar distance to next collision
        prevloc = loc;                      % Store previous location of neutron
        loc = loc + disX;                   % New location of neutron in x direction
        path = abs(disX);                   % Path length traveled by neutron,might be wrong check this

        [flag] = checkloc(a,loc,prevloc);   % Check location of neutrons 

        if flag == 1                        % Neutron stay in the region and collision happens
            mark = colType(loc,a,disX);
            if mark == 1                    % Neutron is absorbed
                [loc_dis] = tallyabsorption(loc,disX);
                final_loc_dis{1,j} = loc_dis;
                [loc_dis_abs(:,j)] = tallyabsorption(loc,disX);
            elseif mark == 2                % Neutron is scattered
                scatter(loc,a,disX,k);
            end
            
        elseif flag == 2                    % Neutron crosses into the other region without leaving the medium
            mark = colType(loc,a,disX);
            if mark == 1                    % Neutron is absorbed
                [loc_dis_abs(:,j)] = tallyabsorption(loc,disX);
                final_loc_dis{1,j}(1,:) = loc_dis_abs(:,j);
            elseif mark == 2                % Neutron is scattered
                 scatter(loc,a,disX,k);
            end
            
        elseif flag == 0                    % Neutron leaks from the medium completely
            [loc_dis_leak(:,j)] = tallyloc(loc,disX);
            final_loc_dis{1,j}(1,:) = loc_dis_leak(:,j);
        end
end

%% Calculate flux profile and k_eff 
[N] = SortInt(final_loc_dis,nx);            % Sort interactions according to respective bins   
[flux,k_eff] = CalFlux(N,nx,loc_dis_leak);  % Calculate flux and k_eff
plotFlux(flux,x,Nn)                         % Plot flux profile






