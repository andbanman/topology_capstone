%Computes a points cloud with non zero Betti_n given a sufficiently large
%number of points, maximun dimension, and maximum filtration value. 
function betti = nonZeroBetti(n,max_dim, max_filtration_value)

import edu.stanford.math.plex4.*;
import edu.stanford.math.plex_viewer.*; 

%Generate n equally spaced points on S1
angles = 2 * pi/n * (1:n)';
points = [cos(angles), sin(angles)];
scatter(points(:,1), points(:,2), '*')

%Compute the Betti numbers for the set of points
stream = api.Plex4.createVietorisRipsStream(points, max_dim, max_filtration_value,100);
persist = api.Plex4.getModularSimplicialAlgorithm(max_dim, 2);
intervals = persist.computeIntervals(stream);
infinite_barcodes = intervals.getInfiniteIntervals();
betti = infinite_barcodes.getBettiSequence();

end
