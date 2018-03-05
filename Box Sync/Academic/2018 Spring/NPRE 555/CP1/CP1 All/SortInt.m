function [N] = SortInt(final_loc_dis,nx)

events = [];

for i = 1:size(final_loc_dis,2)
    temp = final_loc_dis{1,i}(1:end,1);
    events(size(events,1)+1:size(events,1)+length(temp),1) = temp;
end

[N,edges] = histcounts(events,nx);