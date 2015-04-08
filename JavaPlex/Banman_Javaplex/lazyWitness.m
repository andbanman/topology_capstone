%Helper for Ex 16, 17, 18; Andrew Banman
%Function to generate the lazyWitness homology from a distance matrix and a choice of field coefficients
function intervals = lazyWitness(distances, coeff_dim,file_name)
import edu.stanford.math.plex4.*;
import edu.stanford.math.plex_viewer.*;

nu = 1;
num_lpt = 50;
num_div = 100;
max_dim = 3;
m_space = metric.impl.ExplicitMetricSpace(distances);

landmark_selector = api.Plex4.createMaxMinSelector(m_space, num_lpt);
R = landmark_selector.getMaxDistanceFromPointsToLandmarks();
max_filtration_time = 2*R;
stream = streams.impl.LazyWitnessStream(m_space, landmark_selector, max_dim, max_filtration_time, nu, num_div);
stream.finalizeStream();

persistence = api.Plex4.getModularSimplicialAlgorithm(max_dim,coeff_dim);
intervals = persistence.computeIntervals(stream);

options.filename = file_name;
options.max_filtration_value = 2*R;
options.max_dimension = 2;
plot_barcodes(intervals, options); 
end

