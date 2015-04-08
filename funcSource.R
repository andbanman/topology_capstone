######################### Functions  ###############################


addRecent <- function(data){
    #Pick out only the most recent data, e.g rightmost non-NA value for each row
    mostRecentVals = matrix(c(NA),nrow=nrow(data),ncol=1)
    for (i in 1:nrow(data)){
        if (any(which(!is.na(data[i,])))){
            rightmostIndex <- max(which(!is.na(data[i,])), na.rm=TRUE)
            mostRecentVals[i,1] <- data[i,rightmostIndex]
        }
        else {mostRecentVals[i,1]=NA}
    }
    data = cbind(data, mostRecentVals)
    return(data)
}


scaleData <- function(data,  quality = TRUE, saturation_level=0){
    #takes data as a vector and rescales it from -1 to 1
    mean <- mean(data, na.rm=TRUE)
    stdev <- sd(data, na.rm=TRUE)
    if (saturation_level > 0){
        data[data >= mean+stdev*saturation_level] <- mean + stdev*saturation_level
        data[data <= mean-stdev*saturation_level] <- mean - stdev*saturation_level
    }
    minimum <- min(data, na.rm=TRUE)
    maximum <- max(data, na.rm=TRUE)
    if (quality == FALSE){
        data <-1 - (data - minimum)/(maximum - minimum)
    }
    else {
        data <-(data - minimum)/(maximum - minimum)
    }
    return(2*data-1)
}

preenData <- function(data, factor, bycol = TRUE, byrow =TRUE){
    #takes data as a matrix or data frame and removes rows w/ less than factor
    #percent of filled data points
    emptycols <- c()
    if (bycol){
        for (i in 1:ncol(data)){n
            perNotNA <- length(which(!is.na(data[,i])))/nrow(data)
            if (perNotNA <= factor){
                emptycols <- c(emptycols, i)
            }
        }
        if (!is.null(emptycols)) {data <- data[,-emptycols]}
    }
    emptyrows <-c()
    if (byrow){
        for (i in 1:nrow(data)){
           perNotNA <- length(which(!is.na(data[i,])))/ncol(data)
           if (perNotNA <= factor) {
               emptyrows <- c(emptyrows, i)
           }
       }
        if (!is.null(emptyrows)) {data <- data[-emptyrows,]}
    }
    
    return(data) 
}


prepMyData <- function(i){
    path <- as.character(keys[i,3])
    quality <- keys[i,2]
    indicator <- keys[i,1]
    data <-read.csv(path, header=TRUE)
    data = cbind(data[,1], addRecent(data[,2:ncol(data)]))
    #Remove data on years, leaving most recent.
    years <--c(2:(ncol(data)-1))
    data <-data[,years]
    colnames(data) <-c("Country", as.character(indicator))
    #data[,2] <-scaleData(data[,2], quality)
    
    return(data)
}

doHomology <- function(data, maxfilt, maxdim, mode="lw",metric="euclidean", path, name = NULL){
    if (is.null(name)){
        name = names(data)[1]
        for (i in 2:length(names(data))){
            name = paste(name, names(data)[i], sep = "-")
        }
    }
    filename = paste(path, name, sep="")
    intervals = pHom(X = as.matrix(data), max_filtration_value = maxfilt, dimension = maxdim, mode = mode, metric = metric)
    write.table(intervals, file = paste(filename,  "Intervals", sep = "_"))
    png(filename = paste(filename, "PersistenceDiagram.png", sep="_"))
    plotPersistenceDiagram(intervals, maxdim, maxfilt, title <- name)
    dev.off()
}
