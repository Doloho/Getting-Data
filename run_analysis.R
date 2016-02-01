library(data.table)
library(dplyr)

featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
YTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
XTrain <- read.table("UCI HAR Dataset/train/x_train.txt", header = FALSE)

SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
YTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
XTest <- read.table("UCI HAR Dataset/test/x_test.txt", header = FALSE)

AllSubject <- rbind(SubjectTrain, SubjectTest)
activity <- rbind(YTrain, YTest)
features <- rbind(XTrain, XTest)

colnames(features) <- t(featureNames[2])

colnames(activity) <- "Activity"
colnames(AllSubject) <- "Subject"
completeData <- cbind(features, activity, AllSubject)
 
ColumnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case = TRUE)

requiredColumns <- c(ColumnsWithMeanSTD, 562, 563)
dim(completeData)

extractedData <- completeData[,requiredColumns] 
dim(extractedData)

extractedData$Activity <- as.character(extractedData$Activity)
for(i in 1:6){
extractedData$Activity <- as.factor(extractedData$Activity)
}

names(extractedData)

names(extractedData) <- gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData) <- gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData) <- gsub("BodyBody", "Body", names(extractedData))
names(extractedData) <- gsub("f", "Frequency", names(extractedData))
names(extractedData) <- gsub("tBody", "TimeBody", names(extractedData))

names(extractedData)

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

                          