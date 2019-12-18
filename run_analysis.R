#### run_analysis.R ####

# Include reshape2 library for part 5 of assignment.
if(! "reshape2" %in% rownames(installed.packages())){
    install.packages("reshape2")
}

library("reshape2")

# Get dataset
dataset_url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest_file <-"original_dataset.zip"
if(!file.exists(dest_file)){
    download.file(dataset_url, dest_file, "curl")
}

# Extract zip file
dataset_topdir <-"./UCI HAR Dataset"
if(!file.exists(dataset_topdir)){
    unzip(dest_file)
}

# change directory
setwd(dataset_topdir)

# Read training data
subject_train <-read.table("train/subject_train.txt", header=FALSE)
X_train <-read.table("train/X_train.txt", header=FALSE, sep="")
y_train <-read.table("train/y_train.txt", header=FALSE)
# Read testing data
subject_test <-read.table("test/subject_test.txt", header=FALSE)
X_test <-read.table("test/X_test.txt", header=FALSE, sep="")
y_test <-read.table("test/y_test.txt", header=FALSE)
# Read features and activity labels
features <-read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)
activity_labels <-read.table("activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)

# Added column names to X_[test, train]
names(X_test) <- features[, 2]
names(X_train) <- features[, 2]

# [1] Merges the training and the test sets to create one data set
merged_data <-rbind(X_train, X_test)
merged_activity <-rbind(y_train, y_test)
merged_subject <-rbind(subject_train, subject_test)

# [2] Extracts only the measurements on the mean and standard deviation for each measurement.
merged_data <-merged_data[grep("mean\\(\\)|std\\(\\)", names(X_train))]
merged_data[c("activity", "subject")] <-c(merged_activity[, 1], merged_subject[, 1])
merged_data <-merged_data[, c(ncol(merged_data), (1:ncol(merged_data)-1))]

# [3] Uses descriptive activity names to name the activities in the data set
activity.f <-factor(merged_data[, "activity"], labels=activity_labels[[2]])
# Replace numeric activity with factor activity
merged_data$activity <- activity.f

# [4] Appropriately labels the data set with descriptive variable names
names(merged_data) <- gsub("[()]", "",names(merged_data))
names(merged_data) <- gsub("-", "", names(merged_data))
# names(merged_data) <- gsub("(.*)-", "\\1", names(merged_data))

# [5] From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
melted_data <- melt(merged_data,(id.vars=c("subject","activity")))
tidy_data <- dcast(melted_data, subject + activity ~ variable, mean)
names(tidy_data)[-c(1,2)] <- paste("Average[", names(tidy_data)[-c(1,ncol(tidy_data))], "]", sep="")

setwd("..")
write.csv(tidy_data, file="tidy_data.csv")
