#CodeBook

- The script starts by loading the package plyr. This will be used later to obtain the tidy data.

- Generates data sets for the test and train data. This is, merging X_test (data) + y_test (activity id) + subject_test (subject id) in one data.frame for test and another for train.

- Removes the temporal data.frames created.

- Merges the training and test data to a data.frame called "df" using the cbind function.

- Adds headers for the data frame, being the first column "subject", the second one "activity" and the corresponding features names from the features.txt file.

- Extracts the measurements on the mean and standard deviation for each measurement. We use the grep function to match the terms "mean" and "std".

- Replaces the activities ids for the activities labels found in the activity_labels.txt file.

- Creates a second tidy data set with the average of each variable for each activity and subject. We use the ddply function from the plyr package to calculate the mean of each column grouped by subject and activity.

- Writes the resulting data in a file called "tidy data.txt" in the current working directory.
