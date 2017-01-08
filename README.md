# Getting and Cleaning Data Course Project

This repository contains the R code and the code book for the course project of the Getting and Cleaning Data course (part of the Data Science specialization on Coursera).

The goal of the project is to retrieve and clean the data of motion sensors. The original dataset is from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The actual dataset used was obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The code uses the libraries `dplyr`, `stringr` and `tidyr`.

## Files

`CodeBook.md` describes the features of the dataset including their units and the steps that were performed to clean them and to create the tidy dataset.

`run_analysis.R` is the R script that generates the tidy dataset.

## Analysis steps

The R script executes the following steps:

1. Merge the training and the test sets to create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to run the analysis in R

* Change the working directory to where the R script is located
* Source the script: `source(run_analysis.R)`
* The working directory should now contain the tidy dataset in the file `tidy.csv`