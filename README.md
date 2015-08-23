# Getting and Cleaning Data Project #2

Create a tidy data set of wearable computing data originally from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files in this repo
* README.md -- The describes how to run this program
* CodeBook.md -- Codebook describing the variables, the data and transformations
* run_analysis.R -- The script file that analyzes and create the tidy data file

## run_analysis.R goals
You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The script downloads and extract the dataset if the dataset is not available

The output is created in the working directory with the name of tidy_data.txt

## run_analysis.R walkthrough
It follows the goals step by step.

* Step 1:
  * Check if the Dataset is availble
  * If not then download the dataset
  * Unzip the dataset

* Step 2:
  * Read all the test and training files.
  * Combine the files to a data frame in the form of subjects, labels, and the rest of the data.

* Step 3:
  * Read the features from data/UCI HAR Dataset/features.txt and filters it to only leave features that are either means ("mean()") or standard deviations ("std()"). meanFreq() is left out because the goal for this step is to only include means and standard deviations of measurements.
  * A new data frame is then created that includes subjects, labels and the described features.

* Step 4:
  * Read the activity labels from data/UCI HAR Dataset/activity_labels.txt and replace the numbers with the text.

* Step 5:
  * Make a column list (includig "subjects" and "label" at the start)
  * Tidy-up the list by removing all non-alphanumeric characters and converting the result to lowercase
  * Apply wanted.columnnames to the data frame

* Step 6:
  * Create a new data frame by finding the mean for each combination of subject and label by used of the `aggregate()` function.

* Step 7:
  * Write the new tidy set into a text file called tidy_data.txt, formatted similarly to the original files.
