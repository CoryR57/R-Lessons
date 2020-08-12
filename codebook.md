## Getting and Cleaning Data. Final Assignment

## The original data was manipulated by the following steps:

1. Merging all data sets which including training and test data sets to create one data set
2. Isolating only columns relating to the mean and standard deviation
3. labeling activities using descriptive names
4. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

## R script
File with code "run_analysis.R" performed the 4 steps in accordance with assignment requirements

## About variables:
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, 