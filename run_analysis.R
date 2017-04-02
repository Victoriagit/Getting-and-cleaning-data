# Getting-and-cleaning-data

## Download and unzip the file
dataset <- dataset.zip
if(!file.exists(dataset)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(url, dataset, method = "curl")
  }
if(!file.exists("UCI HAR Dataset")){
  unzip(dataset)
}
  
## Setting directory
setwd("UCI HAR Dataset")

## Read/load the content of the files in the directory to create a new dataset from
## merging the 'train' and 'test' sets.
### Reading/loading train set
xTrain <- read.table("train/X_train.txt")
yTrain <- read.table("train/y_train.txt")
subTrain <- read.table("train/subject_train")

### Reading/loading test set
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt")
subTest <- read.table("test/subject_test.txt")

## Bind/create first observation x-values as 'x'
x <- rbind(xTrain, xTest)

## Bind/create second observation y-values as 'y'
x <- rbind(yTrain, yTest)

## Bind/create third observation subject-values as 'sub'
sub <- rbind(subTrain, subTest)

#Step 2
## Extract only measurements on the mean and standard deviation for each measurement 
features <- read.table("features.txt")

## Get the mean and std from features
mean_std <- grep("-(mean|std)\\(\\)", features[, 2])

### Subsetting mean and std for 'x' 
x <- x[, mean_and_std_features]


#Step 3
## Load 'activity labels.txt' to use to name activities
activities <- read.table("activity_labels.txt")

### Assign the values to its certain activity names
y[,1] <- activities[y[,1], 2]

## Label datasets with descriptive variable names
### Naming columns
names(x) <- features[mean_and_std_features, 2]
names(y) <- "activity"
names(sub) <- "subject"

runAnalysis <- cbind(x, y, sub)

# Step 5
## Create new dataset for the average of its variable to both 'activity' and 'subject'

average <- ddply(runAnalysis, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)


