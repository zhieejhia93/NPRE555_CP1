function [] = plotFlux(flux,x,Nn)

plot(x,flux./max(flux));
xlabel('Slab Thickness, \itx\rm, [m]')
ylabel('Normalized Scalar Neutron Flux, \it\phi(x)\rm, [-]')
axis square
title(['No. of Neutrons: ',num2str(Nn)])
set(gca, 'fontname','Times New Roman','fontsize',12)