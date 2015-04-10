function intervals = persistentHomology(points)
    %%% Compute persistent homology
    % set parameters
    max_dimension = 2;
    num_divisions = 100;
    max_filtration_value = 1.0;
    % compute stream from data
    stream = api.Plex4.createVietorisRipsStream(points, max_dimension, max_filtration_value, num_divisions);
    % get intervals
    persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);
    intervals = persistence.computeAnnotatedIntervals(stream);
end

