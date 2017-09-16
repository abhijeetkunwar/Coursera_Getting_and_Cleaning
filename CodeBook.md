The script run_analysis.Rperforms the 5 steps described in the course project's definition.

*Reading all data files(train and test) and create data tables for each.In the first setp all the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.
*Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
*As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
*Unwanted characters or substrings removed from the column names using grepl and gsub methods.
*Finally, we apply grouping on subject and activityon the existing dataset to generate a new dataset with all the average measures for each subject and activity type. The output file is called tidy_data.txt, and uploaded to this repository.
