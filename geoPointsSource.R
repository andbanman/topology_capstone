######################### Persistent Homology of Geography###############################



### From lat/long, generate a point on the globe for each country
latlong = read.csv("~/Documents/Capstone/data/country_centroids_all.csv", sep="\t")[,c(10,1,2)]
latlong[,3] <- 180 - latlong[,3] #rescale to conventional angular ranges - not sure if necessary
latlong[,2] <- 90 - latlong[,2]
latlong[,"X"] <- sin(latlong[,2]*pi/180)*cos(latlong[,3]*pi/180) #convert to cartesian
latlong[,"Y"] <- sin(latlong[,2]*pi/180)*sin(latlong[,3]*pi/180)
latlong[,"Z"] <- cos(latlong[,2]*pi/180)
levels(latlong[,1])[levels(latlong[,1])=="Central African Republic"] <- "Central African Rep."
levels(latlong[,1])[levels(latlong[,1])=="Democratic Republic of the Congo"] <- "Congo, Dem. Rep."
levels(latlong[,1])[levels(latlong[,1])=="Republic of the Congo"] <- "Congo, Rep."
levels(latlong[,1])[levels(latlong[,1])=="South Korea"] <- "Korea, Rep."
levels(latlong[,1])[levels(latlong[,1])=="Czech Republic"] <- "Czech Rep."
levels(latlong[,1])[levels(latlong[,1])=="Dominican Republic"] <- "Dominican Rep."
levels(latlong[,1])[levels(latlong[,1])=="Faroe Islands"] <- "Faeroe Islands"
levels(latlong[,1])[levels(latlong[,1])=="Falkland Islands"] <- "Falkland Islands (Malvinas)"
levels(latlong[,1])[levels(latlong[,1])=="Hong Kong"] <- "Hong Kong, China"
levels(latlong[,1])[levels(latlong[,1])=="North Korea"] <- "Korea, Dem. Rep."
levels(latlong[,1])[levels(latlong[,1])=="Macau"] <- "Macao, China"
levels(latlong[,1])[levels(latlong[,1])=="Macedonia"] <- "Macedonia, FYR"
levels(latlong[,1])[levels(latlong[,1])=="Yemen"] <- "Yemen, Rep."
levels(latlong[,1])[levels(latlong[,1])=="Slovakia"] <- "Slovak Republic"
levels(latlong[,1])[levels(latlong[,1])=="Saint Pierre and Miqeulon"] <- "Saint-Pierre-et-Miquelon"
levels(latlong[,1])[levels(latlong[,1])=="Gaza Strip"] <- "West Bank and Gaza"
names(latlong)[1] <- "Country"

geoPoints <- as.matrix(latlong[,4:6])

#Two different options for graphing the scatter plot of data
png(filename = "~/Documents/Capstone/results/geoPoints.png")
scatter3D(geoPoints[,1],geoPoints[,2],geoPoints[,3], phi = 30, theta=45, colvar = geoPoints[,3], colkey=FALSE)
dev.off()
#scatterplot3d(geoPoints[,1],geoPoints[,2],geoPoints[,3])

#Compute the persistance intervals for lazy witness stream
#maxfilt <- 1.5 
#maxdim <- 2
#intervals <- pHom(geoPoints, dimension <- maxdim, max_filtration_value <- maxfilt, metric = "euclidean", mode = "lw")
#write.table(intervals, file = "results/GeoIntervals")

#png(filename="results/GeopointsPersistence.png")
#plotPersistenceDiagram(intervals, maxdim, maxfilt, title <- "GeoPoints Persistence Diagram")
#dev.off()
