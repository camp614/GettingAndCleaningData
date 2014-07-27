# Getting and Cleaning Data Course Project #
---

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Original Data Set ###

Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Tasks performed by the R script `run_analysis.R` ###

1. Merge the training and test sets to create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

### Executing the script ###

1. Download the original data set[1] from the Source website above and unzip
  - `README.txt` and `features_info.txt` provide additional info regarding the experiments and the resulting data
2. Download `run_analysis.R` and place it in the same directory as the unzipped data set
  - i.e. `UCI HAR Dataset\` and `run_analysys.R` must be in the same directory
3. Execute `run_analysis.R`
  - Two  files will be produced: `mergedData.txt` and `tidyAveragedData.txt`

##### Notes about the script #####

- The script will validate that the `UCI HAR Dataset` directory is present
- Test and training data sets are combined into a single data set
  - `mergedData.txt` is created as a space-delimited file from this combined data set 
- Variable names are applied using the names in the `features.txt` file
- The data set is reduced to only Mean and Standard Deviation values for time and frequency measurements
- Activity names from `activity_labels.txt` are applied to the activities in the data set
- Variable names are revised to be more descriptive
  - `CodeBook.md` contains descriptions of the variables in this new data set
- Each variable is averaged and grouped according to activity by subject
- This new data set is created as `tidyAveragedData.txt` and adheres to rules for tidy data
  - This is also a space-delimited file

### Reference ###

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012