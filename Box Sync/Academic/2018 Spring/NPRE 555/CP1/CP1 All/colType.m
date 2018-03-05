function [mark] = colType(loc,a,disX) 

% Determine collision type

s_a1 = 12; 
s_s1 = 5;
nuf_1 = 15;
s_a2 = 10;
s_s2 = 5;
nuf_2 = 12;

if loc >= 0 && loc <= a/2
    s_a = s_a1; s_s = s_s1; nuf = nuf_1;
elseif loc >= a/2 && loc <= a
    s_a = s_a2; s_s = s_s2; nuf = nuf_2;
end

ratio = s_a./(s_a+s_s); % Thershold for type of reaction

if rand <= ratio        % Absorption
    mark =1;
else                    % Scatter
    mark=2;
end