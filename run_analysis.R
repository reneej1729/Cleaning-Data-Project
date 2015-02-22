#Data Cleaning Project

library(dplyr)
library(car)

## Setup of commonly used information: features
fileName = "./UCI HAR Dataset/features.txt"
features <- read.table(fileName)


## Taking the data from X_test, renaming columns, then taking only columns containing mean or std
fileName = "./UCI HAR Dataset/test/X_test.txt"
dataTest <- read.table(fileName) 
names(dataTest) <- features$V2
mnstd <- sort(c(grep("mean", names(dataTest)), grep("std", names(dataTest))))
dataTest <- dataTest[,mnstd]

## Taking the data from Y_test, recoding the data to be descriptive, appending it to dataTest
fileName = "./UCI HAR Dataset/test/Y_test.txt"
labelsTest <- read.table(fileName)
activity <- recode(labelsTest$V1, "1 = 'Walking'; 2 = 'Walking Upstairs'; 3 = 'Walking Downstairs'; 4 = 'Sitting'; 5 = 'Standing'; 6 = 'Laying' ")
dataTest <- cbind(dataTest, activity)

## Taking the data from subject_test, appending it to dataTest
fileName = "./UCI HAR Dataset/test/subject_test.txt"
subjectTest <- read.table(fileName)
dataTest <- cbind(dataTest, subjectTest)


## Taking the data from X_train, renaming columns, then taking only columns containing mean or std
fileName = "./UCI HAR Dataset/train/X_train.txt"
dataTrain <- read.table(fileName) 
names(dataTrain) <- features$V2
dataTrain <- dataTrain[,mnstd]

## Taking the data from Y_train, recoding the data to be descriptive, appending it to dataTrain
fileName = "./UCI HAR Dataset/train/Y_train.txt"
labelsTrain <- read.table(fileName)
activity <- recode(labelsTrain$V1, "1 = 'Walking'; 2 = 'Walking Upstairs'; 3 = 'Walking Downstairs'; 4 = 'Sitting'; 5 = 'Standing'; 6 = 'Laying' ")
dataTrain <- cbind(dataTrain, activity)

## Taking the data from subject_test, appending it to dataTrain
fileName = "./UCI HAR Dataset/train/subject_train.txt"
subjectTrain <- read.table(fileName)
dataTrain <- cbind(dataTrain, subjectTrain)


## Merging the two datasets together
complete <-rbind(dataTest, dataTrain)

meltd <- melt(complete, id = c("V1", "activity"))
summary <- ddply(meltd, .(V1, activity, variable), summarize, mean = mean(value))
write.table(summary, file = "./summary.txt", row.names = FALSE)
