%Exercise 7, Andrew Banman
%Computes the VR complex for a random point cloud

% create the set of points and initialize parameters.
load pointsTorusGrid.mat
point_cloud = pointsTorusGrid;
max_dim = 3;
filtration = 0.9;
num_divisions = 100;
results = zeros(5,3); %matrix of computation time/size results

for i = 1 : 5
tic
% create a Vietoris-Rips stream 
stream = api.Plex4.createVietorisRipsStream(point_cloud, max_dim, filtration, num_divisions);
% Record the elapsed time and size of the complex with respect to the growing
% filtration time:
results(i,3) = toc; 
results(i,1) = filtration;
results(i,2) = stream.getSize();
filtration = filtration + i*0.02; 
end

disp('Max filtration time, size of VR, computation time')
disp('For d_max = 3, we have the following:')
format shortEng
format compact
disp(results)

%Create the VR stream for max_dim = 4
max_dim = 4;
filtration = 0.9;
tic
stream = api.Plex4.createVietorisRipsStream(point_cloud, max_dim, filtration, num_divisions);
time = toc;
num_simplices = stream.getSize();
disp('For d_max = 4, we have the following:')
disp([filtration, num_simplices, time])
