# Data source:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# QuickStart--
#   Unzip data source in same directory as 'run_analysis.R' script
#   Execute 'run_analysis.R' script

# Check for presence of original data set
dataDir <- "./UCI HAR Dataset"

if(!file.exists(dataDir)) {
    stop(paste0("Dataset directory '", dataDir, "' not found."))
}

# Import activity labels
actLabels <- read.table(paste(dataDir, "activity_labels.txt", sep="/"), header=F)

# Import feature names
featNames <- read.table(paste(dataDir, "features.txt", sep="/"), header=F)

# Import test data set
subDir <- "test"
testX <- read.table(paste(dataDir, subDir, "X_test.txt", sep="/"), header=F)
testY <- read.table(paste(dataDir, subDir, "y_test.txt", sep="/"), header=F)
testSub <- read.table(paste(dataDir, subDir, "subject_test.txt", sep="/"), header=F)

# Import training data set
subDir <- "train"
trainX <- read.table(paste(dataDir, subDir, "X_train.txt", sep="/"), header=F)
trainY <- read.table(paste(dataDir, subDir, "y_train.txt", sep="/"), header=F)
trainSub <- read.table(paste(dataDir, subDir, "subject_train.txt", sep="/"), header=F)

# Merge test and training data sets
allX <- rbind(testX, trainX)
names(allX) <- featNames[[2]]
allY <- rbind(testY, trainY)
names(allY) <- c("activity")
allSub <- rbind(testSub, trainSub)
names(allSub) <- c("subject")

# Create data set of all data
# -[project task #1]-
outMerge <- TRUE
if (outMerge) {
	dataAll <- cbind(allSub, allY, allX)

	# Export the data set of all data
	write.table(dataAll, "./mergedData.txt", row.names=F)
}

# Extract the mean- and SD-related columns
# -[project task #2]-
tidyX <- allX[, grep('(-mean|-std)\\(', names(allX))]

# Apply descriptive names to activities
# -[project task #3]-
tidyY <- allY
tidyY$activity <- actLabels[tidyY$activity,][[2]]

# Revise variable names to be more descriptive
# -[project task #4]-
names(tidyX) <- gsub("^t", "time", names(tidyX))
names(tidyX) <- gsub("^f", "freq", names(tidyX))
names(tidyX) <- gsub("Acc", "Accelerometer", names(tidyX))
names(tidyX) <- gsub("Gyro", "Gyroscope", names(tidyX))
names(tidyX) <- gsub("Mag", "Magnitude", names(tidyX))
names(tidyX) <- gsub("(mean)", "Mean", names(tidyX))
names(tidyX) <- gsub("std", "Std", names(tidyX))
names(tidyX) <- gsub("(X|Y|Z)$", "In\\1Dir", names(tidyX), perl=T)
names(tidyX) <- gsub("(-|\\(|\\))", "", names(tidyX))

# Create tidy data set of mean & SD data
outMeanSd <- FALSE
if (outMeanSd) {
	dataMeanSd <- cbind(allSub, tidyY, tidyX)

	# Export the tidy data set of mean & SD data
	write.table(dataMeanSd, "./tidyMeanSdData.txt", row.names=F)
}

# Calculate the average of each variable for each activity and each subject
# and create a second, independent tidy data set
# -[project task #5]-
outAvg <- TRUE
if (outAvg) {
	useAvgMethA <- FALSE
	if (useAvgMethA) {
		## Averaging Method A...this method groups subjects by activity
		dataTidy <- aggregate(tidyX, list(allSub$subject, tidyY$activity), mean)
		names(dataTidy)[1:2] <- c("subject", "activity")
	} else {
		## Averaging Method B...this method groups activities by subject
		# 
		dataTidy <- aggregate(tidyX, list(tidyY$activity, allSub$subject), mean)
		names(dataTidy)[1:2] <- c("activity", "subject")
		# swap the first and second columns
		dataTidy <- dataTidy[, c(2,1,3:ncol(dataTidy))]
	}

	# Export the tidy dataset of 'averaged' data
	write.table(dataTidy, "./tidyAveragedData.txt", row.names=F)
}
