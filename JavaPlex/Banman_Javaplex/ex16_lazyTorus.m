%Exercise 16, Andrew Banman
%Constructs the homology of the Torus from a LazyWitness complexe
%with Zmod2 coefficients.
dist = ex4_torusDistances(1000);
file_name = 'lazyTorus';
coeff_dim = 2;
lazyWitness(dist,coeff_dim,file_name);