%Exercise 17, Andrew Banman
%Constructs the homology of the Klein Bottle from LazyWitness complexes
%with Zmod3 and Zmod2 coefficients.
dist = ex5_kleinDistances(1000);
file_name = 'lazyKlein-Zmod3';
coeff_dim = 3;
lazyWitness(dist,coeff_dim,file_name);
file_name = 'lazyKlein-Zmod2';
coeff_dim = 2;
lazyWitness(dist,coeff_dim,file_name);