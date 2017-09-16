library(plyr)
library(dplyr)

filename <- "getdata_dataset.zip"
if(!file.exists(filename)) {

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = filename, method = "curl")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Merging of train and test data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_data_merged <- rbind(x_train, x_test);
y_data_merged <- rbind(y_train, y_test);
subject_data_merged <- rbind(subject_train, subject_test);
merged_data <- cbind(subject_data_merged, x_data_merged, y_data_merged )

rm(x_train, y_train, subject_train, x_test, y_test, subject_test, x_data_merged, y_data_merged,
   subject_data_merged)

features <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("activityId", "activityLabel")


##Using descriptive activity names to name the activities in the data set
colnames(merged_data) <- c("subject", features[, 2], "activity")
##Extracting only the measurements on the mean and standard deviation for each measurement.
reqColumns <- grep("subject|activity|mean|std", colnames(merged_data), value = TRUE)
filtered_merged_data <- merged_data[,reqColumns]
rm(merged_data)

## Appropriately labeling of the data set with descriptive variable names

filtered_merged_data$activity <- factor(filtered_merged_data$activity, 
                                 levels = activities[, 1], labels = activities[, 2])
columns <- colnames(filtered_merged_data)
columns <- gsub("[-()]", "", columns)
colnames(filtered_merged_data) <- columns

## taking mean and writing the data to the file
averages_data <- filtered_merged_data %>%
        group_by(subject, activity) %>%
        summarise_each(funs(mean))

write.table(averages_data, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
