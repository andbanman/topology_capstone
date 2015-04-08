%Exercise 1, Andrew Banman
%Compute the homology of the Torus from a triangulation.
stream = api.Plex4.createExplicitSimplexStream();

stream.addElement([0,1,3]);
stream.addElement([1,2,4]);
stream.addElement([2,0,5]);
stream.addElement([3,1,4]);
stream.addElement([4,2,5]);
stream.addElement([5,0,3]);
stream.addElement([3,4,6]);
stream.addElement([4,5,7]);
stream.addElement([5,3,8]);
stream.addElement([6,4,7]);
stream.addElement([7,5,8]);
stream.addElement([8,3,6]);
stream.addElement([0,6,7]);
stream.addElement([0,7,1]);
stream.addElement([1,7,8]);
stream.addElement([1,8,2]);
stream.addElement([2,8,6]);
stream.addElement([2,6,0]);

stream.ensureAllFaces();
stream.finalizeStream();
persistence = api.Plex4.getModularSimplicialAlgorithm(3,2);

intervals = persistence.computeAnnotatedIntervals(stream)
