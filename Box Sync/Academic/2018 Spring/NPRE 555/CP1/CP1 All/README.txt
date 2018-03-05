Title: NPRE 555 - CP1
Subject: Monte Carlo code for neutron transport in a 1D slab

#######################################################################################################################################################################

This is a readme file for NPRE 555 - CP1. The purpose of this document is to explain and describe the application and purpose of each function of the code.
The main script of this code is 'CP1_main.m' and other functions with different purposes.

IMPORTANT NOTE: The code is written using MATLAB 2017b. Please be aware that earlier versions of MATLAB might not be able to execute the code correctly as 
		some built-in MATLAB functions might not be available in the earlier versions. Also, some earlier versions of MATLAB do not allow certain forms of  
		vector - matrix multiplication/division that are allowed in this version.

#######################################################################################################################################################################

# CP1_main.m: 
CP1_main is the main script of the code. No user input is required to execute this script. Constants such as number of neutrons, slab thickness, and grid sizes are
defined here. Be aware that slab thickness is described in the unit of meters. 

The first for-loop of the script uses other functions to generate the birth locations of neutrons, the distance and direction to the next event (leak or collision). 
After the next location is determined, a 'flag' is used to represent the 'fate' of the neutron with 1 being the neutron stays in the medium and collision happens, 
2 being the neutron crosses the boundary into another medium, and 3 being the neutron leaks from the slab. If the neutron remains in the boundary (flag = 1), 
the function 'colType' is executed to determine the type of collision that the neutron undergoes. It returns a value of 1 or 2 to 'mark', which represents the type 
of collision, with 1 being the neutron is absorbed and 2 being the neutron is scattered. If the value of flag is 2, similar procedures are carried out but different 
material properties are used. If the value of flag is 0, the neutron leaks from the slab and its location is tallied. The final locations of the neutrons are stored 
in 'final_loc_dis', which is a cell-type data structure. It contains cells of various sizes where the first column records the location of neutron for leak, 
absorption, and scatter while the second column records the distance traveled by the neutron from the previous location to its current location.

The second for-loop converts the values of 'final_loc_dis' into a single vector. This allows the built-in 'hiscounts' function to determine the number of events that 
take place in a bin of a particular size.

The third for-loop calculates the scalar neutron flux in the slab using the definition of scalar flux provided in Eq - 9.279 in Stacey. The number of neutrons 
absorbed and fissioned are determined here by multiplying the scalar flux by the respective cross sections.

Finally, the flux in the slab is plotted and the effective multiplication factor is determined by dividing the number of fission by the total number of neutrons 
absorbed and leaked.


# locGen.m:
locGen is a function that determines the location of birth of neutron through random number generation. The first region (left) has a higher nu-sigma-f than the second 
(right) region. A threshold of 5/9 is set where if a random number lower than or equal to 5/9 is generated, then a neutron is born in the first region. Conversely, if 
a random number larger than 5/9 is generated the neutron is born in the second region. The distances to the left and right boundaries are also determined in this 
function. When called, the function returns the location, leftward, and rightward distances of the neutron from the boundaries.


# dirGen.m:
dirGen is a function that determines the direction of travel of neutron through random number generation. It generates two random number to determine the elevation and
azimuthal angles of the path of neutron. When called, it returns theta (elevation angle) and azi(azimuthal angle).

# disGen.m:
disGen is a function that determines the distance of the neutron's new location from its previous location. A random number is generated and the distance is determined 
based on the CDF as described in Eq. 9.254 os Stacey. The total macroscopic cross section is determined based on the previous location of neutron. With the distance 
and the angles from dirGen, a built in function known as sph2cart is used to convert the new neutron location from spherical to Cartesian coordinates. Since this is a 
1D problem, only the x-coordinate output is returned as disX. With the knowledge of how far the neutron has traveled and its previous location, the new locatin of 
neutron can be determined by summing these quantities.

# checkloc.m:
checkloc is a function that checks the  new location of neutron and changes the material properties accordingly. It also determines if the neutron born in a region 
stays in that region by comparing the new and previous locations of the neutron. It returns a variable 'flag' of values 1,2, or 0. If flag is 1 the neutron stays in 
the medium and collision happens, if flag is 2 the neutron crosses the boundary into another medium, and if flag is 3 the neutron leaks from the slab.

# colType.m:
colType is a function that determines the type of collision (absorption or scatter) that occus when flag is equal to 1. The material properties are determined based on
the location of the neutron. A threshold is set based on the ratio of absorption cross section to total cross section. A random number is generated and if it has a value
lower than or equal to the threshold absorption happens and the opposite when its value is greater than the threshold. The function returns a variable 'mark' of value
1 or 2 where 1 being absorption and 2 being scatter.

# scatter.m
scatter is a function that determines the new location of neutron after it is scattered. Once called, the function will first tally the location of the neutron. Then, 
using the dirGen and disGen functions, it generates the new location after the neutron is scattered. It then uses the checkloc function to determine whether the neutron
stays in or leak from the slab. If the scattered neutron remains in the region, using the colType functions, it determines the type of collision that the scattered neutron
undergoes. If the neutron is absorbed, its location is tallied and returned. If the neutron is scattered, the scatter function calls itself and the steps described above
are repeated until the neutron leaks from the slab or is absorbed, afterwhich the locations of all previous scattering that the neutron has undergone and its final location
are tallied and returned.

# tallyloc.m
tallyloc is a function that tallies and returns the location at which any event happens as well as the distance that the neutron travels from its previous to its final location.

# tallyabsorption.m
tallyabsorption is a function that tallies and returns the location at which absorption happens as well as the distance that the neutron travels from its previous to 
its final location. The tallyloc function is used for this purpose.

# SortInt.m
SortIn is a function that sorts the interactions undergone by the neutrons according to their locations. This is done using the built-in 'histcount' function.

# CalFlux.m
CalFlux is a function that calculates the flux of each bin. This is done according to the definition of scalar flux provided in Eq - 9.279 in Stacey. The flux of 
a bin is determined by dividing the number of interactions that take place within that bin by the total macroscopic cross section. The effective multiplcation 
factor is also calculated here. This is done by finding the ratio of the number of neutrons born by the number of neutrons absored and leaked. The number of neutrons
fissioned and absorbed are determined bu multiplying the scalar flux by the the fission cross section (nu-sigma_f) and the absorption cross section, respectively.
The number of neutrons leaked is determined through the 'length' of variable 'loc_dis_leak', which stores the last locations of all leaked neutrons.

# plotFlux.m
plotFlux is a function that plots the scalar flux profile in the slab.

 

 



   
		