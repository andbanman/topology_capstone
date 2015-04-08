%Part of exercise 6 and 18, Andrew Banman
%Generates the distance matrix for an arbitrary number of points on the unit sphere S2 with antipodals points indentified, 
%e.g. real projective space. 
function dist = ex6_RP2Distances(numPoints)

%Generate random set of phi,theta that represent the random points on the sphere. Initialize the distance matrix.
angles = [2*pi*rand(numPoints,1), pi*rand(numPoints,1)];
dist = zeros(numPoints);

for i = 1 : numPoints
	for j = 1 : numPoints
		%Make the two points and one of the antipodes in cartesian space
		p1 = makePoint(angles(i,1),angles(i,2));
		p1_anti = makePoint(2*pi - angles(i,1), pi - angles(i,2));				
		p2 = makePoint(angles(j,1),angles(j,2));
		%Path either direct or through one of the antipodes. Note d(x,y)=d(-x,-y) and d(x,-y)=d(-x,y). 
        %Distance calculated as the central angle between the two points on the unit sphere. 		
		d1 = acos(dot(p1,p2));
		d2 = acos(dot(p1_anti,p2));
		dist(i,j) = min([d1,d2]);		
	end
end

%Nested function to create a point in cartesian space from angles theta,phi.
	function point = makePoint(theta,phi) 
		point = [sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta)];
	end

	
end
