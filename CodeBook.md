# Code Book

## Overview
This codebook describes the data, variables and intermediate work products used in this project. Also, the codebook describes the processing required to create the resulting tidy_data.csv data set.

### Original Overview [Excerpt]
The experiments have been carried out with a group of 30 volunteers... Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope... The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


### Original Features Explaination [Excerpt]
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter ... Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)...

### NOTE:
Please see README.txt and feature_info.txt from original data set for further infomation on that data set.


## Analysis


### Processing Algorithm
The run_analysis.R does the following:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Variables, Intermediate products and Transformations
These variables are those created and used by run_analysis.R to process the orginal data set and create the tidy_data.csv data set.

`dataset_url` - Contains the URL for the data set.

`dest_file` -  Names the downloaded file for later reference.

`dataset_topdir` - Identifies the top-level directory of the original data set.

`subject_train` - A single column data.frame of integers containing the ID of the volunteer.

`X_train` - A data.frame containing the "70%" of observations of the features from the orginal data set.

`y_train` - A single column data.frame containing the true label of the activies for each observation in X_train.

`subject_test` - A single column data.frame of integers containing the ID of the volunteer.

`X_test` - A data.frame containing the "30%" of observations of the features from the orginal data set.

`y_test` - A single column data.frame containing the true label of the activies for each observation in X_test.

`features` - Names of the 561 features selected by the orignal data authors.

`activity_labels` - Names and IDs for the 6 activities.

`merged_data` - A data.frame containing the merger of all training and test obeservations. Also, features are removed from this data frame.

`merged_activity` - A data.frame containing the merger of all training and test labels.

`merged_subject` - All subjects merged into a single list.


`activity.f` - Activity labels as a factor varible(s)

`melted_data` - The transformation of the original data set by subject and activity.

`tidy_data` - The transformation of melted_data to give the mean of each feature remaining in the data set.


## Feature name modifications
In `merged_data` and `melted_data` the column names were modified such that the column name "tBodyAcc-mean()-X" would become "tBodyAccmeanX". This was completed through a couple gsub commands in R.


In `tidy_data` the mean was appled to the observation and a new column name was assigned to each feature. Therefore, a column which might have been previously rename from "tBodyAcc-mean()-X" to "tBodyAccmeanX" would now represent the average and thus need and name reflecting that. The column name "Average[tBodyAccmeanX]" was choosen.

This was repeated for all features. The complete set of feature names can be retreived by calling names() on the `merged_data` and `tidy_data` data frames.
