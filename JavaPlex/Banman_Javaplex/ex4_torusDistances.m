%Part of exercise 4 and 16, Andrew Banman
%Computes the distance matrix for an arbitrary number of points drawn from
%the flat Torus.
function distances = ex4_torusDistances(numPoints)

%Initialize points and distance matrix.
point_cloud = rand(numPoints,2);
distances = zeros(numPoints);

for i = 1 : numPoints
    for j = 1 : numPoints
        %get points
        x_1 = point_cloud(i,1);
        y_1 = point_cloud(i,2);
        x_2 = point_cloud(j,1);
        y_2 = point_cloud(j,2);
        %d1 corresponds to the 'direct' distance. d2 thru d5 correspond to
        %the distance passing through one of the identified edges. 
        d1 = (x_1 - x_2)^2   + (y_1 - y_2)^2;
        d2 = (x_1 - (x_2+1))^2 + (y_1 - y_2)^2;
        d3 = (x_1 - (x_2-1))^2 + (y_1 - y_2)^2;
        d4 = (x_1 - x_2)^2     + (y_1 - (y_2+1))^2;
        d5 = (x_1 - x_2)^2     + (y_1 - (y_2-1))^2;
        d_min = min([d1,d2,d3,d4,d5]);
        distances(i,j) = sqrt(d_min);
    end 
end

end

