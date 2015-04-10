% GOAL: 
% 1. Read data in from file -> point cloud
% 2. prep data for stream (distance matrix?)
% 3. Compute intervals (check results are consistent)
% 4. use Lori's code to get complex verticies
% 5. cross-reference indexes w/ country num to find the distinct groups. 
load_javaplex;

%%% Read data from csv
soc = csvread('./../data/data_IL.csv', 1, 2); %gets just the numbers, index corresponds to country index
socGeo = csvread('./../data/data_ILG.csv', 1,2);
latlong = csvread('./../data/latlong.csv',1,2 );
points = table2array(soc(:,3:7));

C = getComponents(socGeo, 0.1, 0.1, 3);

%%% Compute persistent homology
% set parameters
max_dimension = 2;
num_divisions = 100;
max_filtration_value = 1.0;
% compute stream from data
mSpace = metric.impl.EuclideanMetricSpace(soc);
stream = api.Plex4.createVietorisRipsStream(points, max_dimension, max_filtration_value, num_divisions);
% get intervals
persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);
intervals = persistence.computeAnnotatedIntervals(stream);


num_samples = 6;
deltaF = 0.1;
min_filtration_value = 0.3;
component_data = zeros(198, num_samples*2);

options.filename = 'test';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(intervals, options);






%%% Get country components
for k = 1 : num_samples
    max_dimension = 3;
    max_filtration_value = (k-1) * deltaF + min_filtration_value;
    num_divisions = 100;
    stream = api.Plex4.createVietorisRipsStream(points, max_dimension, max_filtration_value, num_divisions);

    componentVertexIndices = verticesInEachComponent(stream, max_filtration_value);

    components = zeros(198,2);
    components(:,1) = [1:198];

    %fprintf('\nBelow are the indices of the vertices in each component.\n')
    for i = 1 : size(componentVertexIndices, 1)
        %fprintf(['Component ', int2str(i), ':\n'])
        indices = componentVertexIndices{i};
        for j = 1 : size(indices, 2) 
            %fprintf([int2str(indices(j)), ', ']);
            components(indices(j),1:2) = [max_filtration_value,i];
        end
        %fprintf('\n')
    end

    component_data(:,(2*k-1):(2*k)) = components(:,1:2);
end

format = '%1.1f, %2.0f, %1.0f, %2.0f, %1.1f, %2.0f, %1.1f, %2.0f, %1.1f, %2.0f, %1.1f, %2.0f\n';
fileID = fopen('component_data.txt','w');
fprintf(fileID,format,component_data.');
fclose(fileID);
