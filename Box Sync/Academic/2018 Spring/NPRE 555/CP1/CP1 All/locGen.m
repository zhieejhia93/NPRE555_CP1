function [locN,dx_left,dx_right] = locGen()

% To determine the location of neutron birth

% Generate random number to determine the region of birth of neutron
% If random number is less than or equal to 5/9 the neutron is born in region 1 and the opposite if the number is greater than 5/9
% A second random number is generated and is weighted to determine the actual location of neutron birth

RandNo = rand;

if RandNo <= 5/9   
    region = 1;
    locN = rand()/2;
    dx_left = locN;
    dx_right = 0.5 - locN;
else
    region = 2;
    locN = rand()/2 + 0.5;
    dx_left = locN - 0.5;
    dx_right = 1 - locN;
end