function [flux,k_eff] = CalFlux(N,nx,loc_dis_leak)

for i=1:nx
    if i<nx/2
        flux(i)=N(i)/17;
        nf(i) = flux(i).*15; % Number of neutrons born
        na(i) = flux(i).*12; % Number of neutrons absorbed
    else
        flux(i)=N(i)/15;
        nf(i) = flux(i).*12; 
        na(i) = flux(i).*10;
    end
end
nl = length(find(loc_dis_leak(1,:)~=0)); % Number of neutrons leaked
k_eff = sum(nf)./(nl+sum(na));

disp(['Number of neutrons born: ',num2str(ceil(sum(nf)))]);
disp(['Number of neutrons absorbed: ',num2str(ceil(sum(na)))]);
disp(['Number of neutrons leaked: ',num2str(nl)]);
disp(['Effective multiplication factor: ',num2str(k_eff)]);
