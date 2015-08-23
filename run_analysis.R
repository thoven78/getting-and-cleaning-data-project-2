## Hold the zip file name
compressFileName <- 'UCI HAR Dataset.zip'

## Download the dataset needed to run the analysis in the data sub-directory
downloadData <- function() {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', paste('data/', compressFileName, sep = ''), method = 'curl')
}

## Unzip a given compress file name
unzipFile <- function(zipFile) {
  unzip (paste('data/', zipFile, sep = ''), exdir = './data/')
}

## Run the analysis of the dataset
runAnalysis <- function() {
  ## Step 1
  ## If the zip file is not available
  ## download the file and then unzip it
  if (!file.exists(paste('data/', compressFileName, sep = ''))) {
    downloadData()
    unzipFile(compressFileName)
  }

  ## Step 2
  ## Read all the tests and train data
  test.labels <- read.table('data/UCI HAR Dataset/test/y_test.txt', col.names = 'label')
  test.subjects <- read.table('data/UCI HAR Dataset/test/subject_test.txt', col.names = 'subject')
  test.data <- read.table('data/UCI HAR Dataset/test/X_test.txt')
  train.labels <- read.table('data/UCI HAR Dataset/train/y_train.txt', col.names = 'label')
  train.subjects <- read.table('data/UCI HAR Dataset/train/subject_train.txt', col.names = 'subject')
  train.data <- read.table('data/UCI HAR Dataset/train/X_train.txt')

  # Merge the data in the format of: subjects, labels
  data <- rbind(cbind(test.subjects, test.labels, test.data), cbind(train.subjects, train.labels, train.data))

  ## Step 3
  ## Read the features
  features <- read.table('data/UCI HAR Dataset/features.txt', strip.white = TRUE, stringsAsFactors = FALSE)
  ## Only retain features of mean and standard deviation
  features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

  ## Get only the means and standard deviations from data
  ## increment by 2 because data has subjects and labels in the beginning
  data.mean.std <- data[, c(1, 2, features.mean.std$V1 + 2)]

  ## Step 4
  ## Read the activities labels
  labels <- read.table('data/UCI HAR Dataset/activity_labels.txt', stringsAsFactors = FALSE)
  ## Replace labels in dataset with label names
  data.mean.std$label <- labels[data.mean.std$label, 2]

  ## Step 5
  ## First make a list of the current column names and feature names
  wanted.colnames <- c('subject', 'label', features.mean.std$V2)
  ## Tidy the list created above
  ## Remove all non-alphabetic character and converting to lowercase
  wanted.colnames <- tolower(gsub("[^[:alpha:]]", "", wanted.colnames))
  ## Use the created list as column names for data
  colnames(data.mean.std) <- wanted.colnames

  ## Step 6
  ## Get the mean for each combination of subject and label
  aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)], by = list(subject = data.mean.std$subject, label = data.mean.std$label), mean)

  ## Step 7
  ## Write the data for the course
  write.table(format(aggr.data, scientific=T), "tidy_data.txt", row.names = F, col.names = F, quote = 2)

}

## Run the code onload
runAnalysis()
