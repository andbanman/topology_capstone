%Exercise 3, Andrew Banman
%Compute the homology of RP2 from a triangulation.
stream = api.Plex4.createExplicitSimplexStream();
a = 0;
b = 1;
c = 2;
d = 3;
e = 4;
f = 5;


stream.addElement([a,b,d]);
stream.addElement([b,e,d]);
stream.addElement([b,c,e]);
stream.addElement([a,e,c]);
stream.addElement([d,e,f]);
stream.addElement([a,f,e]);
stream.addElement([a,b,f]);
stream.addElement([b,c,f]);
stream.addElement([c,d,f]);
stream.addElement([c,a,d]);


stream.ensureAllFaces();

stream.finalizeStream();
persistence = api.Plex4.getModularSimplicialAlgorithm(3,3);

intervals = persistence.computeAnnotatedIntervals(stream)
