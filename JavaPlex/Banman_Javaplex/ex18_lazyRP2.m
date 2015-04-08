%Exercise 18, Andrew Banman
%Constructs the homology of RP2 from LazyWitness complexes
%with Zmod3 and Zmod2 coefficients.
dist = ex6_RP2Distances(1000);
file_name = 'lazyRP2-Zmod3';
coeff_dim = 3;
lazyWitness(dist,coeff_dim,file_name);
file_name = 'lazyRP2-Zmod2';
coeff_dim = 2;
lazyWitness(dist,coeff_dim, file_name);

