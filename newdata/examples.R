require(devtools)
require(plyr)
require(DCF)
require(phom)
require(plot3D)


#Generate random phi, theta

n = 500
phi = matrix(pi*c(runif(n,0,1)), nrow = n, ncol=1)
theta = matrix(2*pi*c(runif(n,0,1)), nrow = n, ncol=1)

#Convert to cartesian coords

x = sin(phi)*cos(theta)
y = sin(phi)*sin(theta)
z = cos(phi)

png(filename = "~/Documents/Capstone/results/spherePoints.png")
scatter3D(x=x,y=y,z=z, colvar=NULL)
dev.off()


#Compute homology

source(file = "funcSource.R")

doHomology(cbind(x,y,z), maxfilt = 1, maxdim = 2, path = "~/Documents/Capstone/results/", name="sphere")
