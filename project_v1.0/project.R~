########################################################################
#--------------------- Capstone Project  ------------------------------#
########################################################################
### Load packages
require(devtools)
require(plyr)
require(DCF)
require(phom)
require(plot3D)
require(fpc)
source(file="funcSource.R")

######################### SMALL Data set Method - data/smallData.csv ###########################

### Load in Data
keys <- read.csv("~/Documents/Capstone/data/smallData.csv", header=FALSE)
income = prepMyData(1)
recvd = prepMyData(2)
given = prepMyData(3)
infmort = prepMyData(4)
lifeExp = prepMyData(5)
fert = prepMyData(6) 
given[,2:ncol(given)] <- -as.matrix(given[,2:ncol(given)]) #combine aid given and aid received
aidRec = merge(x=recvd,y=given,all.x=TRUE,all.y=TRUE)
source("geoPointsSource.R") #Loads in lat/long data

#LifeExp+Geo
data1 = merge(lifeExp, latlong[,c(1,4,5,6)], by = "Country", all.x = TRUE)
data1 <- preenData(data1, factor=0.9, bycol=FALSE, byrow=TRUE)           
data1[,2] <- scaleData(data1[,2], TRUE)

#Income+Geo
data2 = merge(income, latlong[,c(1,4,5,6)], by = "Country", all.x = TRUE)
data2 <- preenData(data2, factor=0.9, bycol=FALSE, byrow=TRUE)           
data2[,2] <- scaleData(data2[,2], TRUE)

#InfantMortality+Geo
data3 = merge(infmort, latlong[,c(1,4,5,6)], by = "Country", all.x = TRUE)
data3 <- preenData(data3, factor=0.9, bycol=FALSE, byrow=TRUE)           
data3[,2] <- scaleData(data3[,2], FALSE)

#LifeExp+Income+Geo
data4 = join(data1,data2)
data4 = data4[,c(1,2,6,3,4,5)]

write.table(x=data1, file = "~/Documents/Capstone/results/table_LifeExp-Geo")
write.table(x=data2, file = "~/Documents/Capstone/results/table_Income_Geo")
write.table(x=data3, file = "~/Documents/Capstone/results/table_InfMort_Geo")

write.csv(x=as.matrix(data4[,2:6]), file = "~/Documents/Capstone/results/table_LifeExp_Income_Geo2")

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

######################### BIG Data set method - data/fullData.csv  ###############################
Algorithm:
#1. Populate data set by taking most recent entry for each indicator and joining many indicatorsby country.
#2. Trim off any countries that don't fill at least XX% of the indicators.
#3. Fill out data matrix with average value for each indicator.
#4. Compute persistent homology. 

### Load multiple sets of data from key file 
dir <- getwd()
keys <- read.csv(paste(dir,"data/fullData.csv", sep=""), header=FALSE)

aggregate <- prepMyGapminderData(keys[1,1],keys[1,2],keys[1,3])
for (i in 2:nrow(keys)){
    progress <- paste(i/nrow(keys)*100,"% ")
    print(progress)
    data <- prepMyGapminderData(keys[i,1], keys[i,2], keys[i,3])
    aggregate <- join(aggregate, data,  by="Country")
}

data <- preenData(aggregate, 0.8, bycol = FALSE)
dataMatrix <- fillAvg(as.matrix(data[,2:ncol(data)]))


