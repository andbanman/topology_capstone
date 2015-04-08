%Exercise 2, Andrew Banman
%Compute the homology of the Klein Bottle from a triangulation. 
stream = api.Plex4.createExplicitSimplexStream();
a = 0;
b = 1;
c = 2;
d = 3;
e = 4;
f = 5;
h = 6;
g = 7;
i = 8; 

stream.addElement([a,b,d]);
stream.addElement([b,e,d]);
stream.addElement([b,c,e]);
stream.addElement([c,f,e]);
stream.addElement([c,a,f]);
stream.addElement([a,g,f]);
stream.addElement([d,e,g]);
stream.addElement([e,h,g]);
stream.addElement([e,f,h]);
stream.addElement([f,i,h]);
stream.addElement([f,g,i]);
stream.addElement([g,d,i]);
stream.addElement([g,h,a]);
stream.addElement([h,b,a]);
stream.addElement([h,i,b]);
stream.addElement([i,c,b]);
stream.addElement([i,d,c]);
stream.addElement([d,a,c]);

stream.ensureAllFaces();

stream.finalizeStream();
persistence = api.Plex4.getModularSimplicialAlgorithm(3,3);

intervals = persistence.computeAnnotatedIntervals(stream)
