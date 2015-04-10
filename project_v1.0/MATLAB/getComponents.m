function component_data = getComponents(points, start, delta, num_samples)
    import edu.stanford.math.plex4.*;
    import edu.stanford.math.plex_viewer.*;
    
    n = length(points);
    component_data = zeros(n, num_samples);
    for k = 1 : num_samples
        max_dimension = 1;
        max_filtration_value = (k-1) * delta + start;
        num_divisions = 100;
        stream = api.Plex4.createVietorisRipsStream(points, max_dimension, max_filtration_value, num_divisions);
        componentVertexIndices = verticesInEachComponent(stream, max_filtration_value);
        components = zeros(n,1);
        fprintf(['computing ', num2str(max_filtration_value), ' out of ', num2str((num_samples-1)*delta+start), '\n'])
        for i = 1 : size(componentVertexIndices, 1)           
            indices = componentVertexIndices{i};
            for j = 1 : size(indices, 2) 
                components(indices(j)) = i;
            end
        end
        component_data(:,k) = components;
    end
end