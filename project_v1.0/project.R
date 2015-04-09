########################################################################
#---------------------  DATA PROCESSING  ------------------------------#
########################################################################

### Load packages
require(devtools)
require(plyr)
require(DCF)
require(phom)
require(plot3D)
require(fpc)
source(file="funcSource.R")
source(file="geoPointsSource.R")

### Load in Data
dir <- getwd();
dataDir <- paste(dir, "/data/", sep= "");
gdp <- read.csv(paste(dataDir, "gapm_gdp.csv", sep=""));
geo <- getGeoPoints();
infmort <- read.csv(paste(dataDir, "gapm_infmort.csv", sep=""));
lexp <- read.csv(paste(dataDir, "gapm_lexp.csv", sep=""));

### Pre-process data (scale each var to -1 to 1)
gdpP <- preProcess(gdp);
colnames(gdpP) <- c("country","gdp");
gdpP[,"gdp"] <- scaleData(gdpP[,"gdp"], quality=TRUE, saturation_level=3)
lexpP <- preProcess(lexp);
colnames(lexpP) <- c("country", "lifeExp");
lexpP[,"lifeExp"] <- scaleData(lexpP[,"lifeExp"], quality=TRUE, saturation_level=3)

### Join data sets
soc = merge(gdpP, lexpP, by="country", all=FALSE);
socGeo = merge(soc, geo, by="country", all=FALSE);

### write the data
soc[,"country"] = sapply(soc[,"country"], function(country) gsub(",","-", country)) ;
write.csv(soc, file = paste(dataDir, "data_IL.csv", sep=""))

socGeo[,"country"] = sapply(socGeo[,"country"], function(country) gsub(",","-", country)) ;
write.csv(socGeo, file = paste(dataDir, "data_ILG.csv", sep=""))


########################################################################
#--------------------- COMPUTE HOMOLOGY  ------------------------------#
########################################################################

#Now we do the homology
data = data4
doHomology(data[,2:ncol(data)], maxfilt = 2, maxdim = 3, path = "~/Documents/Capstone/results/", name="Income-LifeExp-2")

#Clustering by ONLY Geography
data = data4
x <-as.matrix(data4[,4:6])
pam = pamk(x, krange=2:7)
clusters <- matrix(pam$pamobject$clustering, ncol=1, )
data[,"Cluster"] <- clusters
filename = "~/Documents/Capstone/results/geo_Clusters.png"

###Clustering by the ONLY social indicators
data = data4
x <-as.matrix(data4[,2:3])
pam = pamk(x, krange=2:4)
clusters <- matrix(pam$pamobject$clustering, ncol=1, )
data[,"Cluster"] <- clusters
filename = "~/Documents/Capstone/results/inc-lifeExp_Clusters.png"

###Clustering by both geo and social
data = data4
x <-as.matrix(data4[,2:6])
pam = pamk(x, krange=2:7)
clusters <- matrix(pam$pamobject$clustering, ncol=1, )
data[,"Cluster"] <- clusters
filename = "~/Documents/Capstone/results/inc-lifeExp-geo_Clusters.png"

png(filename=filename)
scatter3D(data[,4],data[,5],data[,6], phi =25, theta=45, colvar = data[,7], colkey=FALSE)
dev.off()

d1 = data[which(data[,7]==1),1]
d2 = data[which(data[,7]==2),1]
d3 = data[which(data[,7]==3),1]
d4 = data[which(data[,7]==4),1]

write.table(x=d1, file = "~/Documents/Capstone/results/region1")
write.table(x=d2, file = "~/Documents/Capstone/results/region2")
write.table(x=d3, file = "~/Documents/Capstone/results/region3")
write.table(x=d4, file = "~/Documents/Capstone/results/region4")



d5 = data[which(data[,7]==5),2:3]
d6 = data[which(data[,7]==6),2:3]
d7 = data[which(data[,7]==7),2:3]
m1 = c(mean(d1[,1],na.rm =TRUE), mean(d1[,2],na.rm =TRUE))
m2 = c(mean(d2[,1],na.rm =TRUE), mean(d2[,2],na.rm =TRUE))
m3 = c(mean(d3[,1],na.rm =TRUE), mean(d3[,2],na.rm =TRUE))
m4 = c(mean(d4[,1],na.rm =TRUE), mean(d4[,2],na.rm =TRUE))
m5 = c(mean(d5[,1],na.rm =TRUE), mean(d5[,2],na.rm =TRUE))
m6 = c(mean(d6[,1],na.rm =TRUE), mean(d6[,2],na.rm =TRUE))
m7 = c(mean(d7[,1],na.rm =TRUE), mean(d7[,2],na.rm =TRUE))
means = matrix(rbind(m1,m2,m3,m4,m5,m6,m7), nrow = 7)


