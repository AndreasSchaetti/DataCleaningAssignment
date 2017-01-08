# Code book

The goal of the project is to retrieve and clean the data of motion sensors. The original dataset is from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The actual dataset used was obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Description of dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
  
## Dataset files

The dataset includes the following files:

* `README.txt`
* `features_info.txt`: Shows information about the variables used on the feature vector.
* `features.txt`: List of all features.
* `activity_labels.txt`: Links the class labels with their activity name.
* `train/X_train.txt`: Training set.
* `train/y_train.txt`: Training labels.
* `test/X_test.txt`: Test set.
* `test/y_test.txt`: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the `total_acc_x_train.txt` and `total_acc_z_train.txt` files for the Y and Z axis. 
* `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Description of data features

The following features are provided for each record of the dataset:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
* Triaxial angular velocity from the gyroscope
* 561-feature vector with time and frequency domain variables
* Activity label
* Identifier of the subject who carried out the experiment

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of statistics that were estimated from these measurements are: 

* mean: Mean value
* std: Standard deviation

Several other features were not considered in this exercise because they were not provided as mean and standard deviation. The complete list of features is available in `features.txt`.

Notes:

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row in the text file.

## Activity labels

The manually tagged activity labels are codes for activities as follows:

Label | Activity
----- | --------
1 | WALKING
2 | WALKING_UPSTAIRS
3 | WALKING_DOWNSTAIRS
4 | SITTING
5 | STANDING
6 | LAYING

## Data cleaning

First the feature and activity names were loaded to annotate the data. The raw data contains no headers and only integer activity labels. After loading the training and test raw data, the column names were set to the feature names.

The column names of the features associated with band energy are not unique and cause problems in the `select` function of the library `dplyr`. The band energy features are not of interest in this exercise and are discarded. Subsequently all columns containing the strings `mean` or `std` are selected. 

For this exercise, the train and test data were merged by binding the rows. Then the activity code table was merged with the dataset by the activity label. The activity label was then discarded. Effectively only the activity name column was merged with the dataset.

For each activity and subject, column means were calculated. This grouped dataset was then tidied. The feature names in the form `variable-statistic()-axis` were separated by variable, statistic and axis of measurement and put together as `variable.statistic.axis`. Note that not all feature names contain an axis string. These feature names were cleaned in an additional step.

As a result we get a CSV file with 180 rows (6 activities times 30 subjects) and 68 variables.

## Features of tidy dataset

The 68 features left after tidying the dataset are the following (note that all features are normalized and therefore without units):

* activity: string
* subject.id: integer
* fBodyAccJerk.mean.X, fBodyAccJerk.mean.Y, fBodyAccJerk.mean.Z
* fBodyAccJerk.std.X, fBodyAccJerk.std.Y, fBodyAccJerk.std.Z
* fBodyAccMag.mean
* fBodyAccMag.std
* fBodyAcc.mean.X, fBodyAcc.mean.Y,	fBodyAcc.mean.Z
* fBodyAcc.std.X,	fBodyAcc.std.Y,	fBodyAcc.std.Z
* fBodyBodyAccJerkMag.mean
* fBodyBodyAccJerkMag.std
* fBodyBodyGyroJerkMag.mean
* fBodyBodyGyroJerkMag.std
* fBodyBodyGyroMag.mean
* fBodyBodyGyroMag.std
* fBodyGyro.mean.X,	fBodyGyro.mean.Y,	fBodyGyro.mean.Z
* fBodyGyro.std.X, fBodyGyro.std.Y,	fBodyGyro.std.Z
* tBodyAccJerkMag.mean
* tBodyAccJerkMag.std
* tBodyAccJerk.mean.X, tBodyAccJerk.mean.Y, tBodyAccJerk.mean.Z
* tBodyAccJerk.std.X,	tBodyAccJerk.std.Y,	tBodyAccJerk.std.Z
* tBodyAccMag.mean
* tBodyAccMag.std
* tBodyAcc.mean.X, tBodyAcc.mean.Y,	tBodyAcc.mean.Z
* tBodyAcc.std.X,	tBodyAcc.std.Y,	tBodyAcc.std.Z
* tBodyGyroJerkMag.mean
* tBodyGyroJerkMag.std
* tBodyGyroJerk.mean.X,	tBodyGyroJerk.mean.Y,	tBodyGyroJerk.mean.Z
* tBodyGyroJerk.std.X, tBodyGyroJerk.std.Y,	tBodyGyroJerk.std.Z
* tBodyGyroMag.mean
* tBodyGyroMag.std
* tBodyGyro.mean.X, tBodyGyro.mean.Y, tBodyGyro.mean.Z
* tBodyGyro.std.X, tBodyGyro.std.Y, tBodyGyro.std.Z
* tGravityAccMag.mean
* tGravityAccMag.std
* tGravityAcc.mean.X, tGravityAcc.mean.Y, tGravityAcc.mean.Z
* tGravityAcc.std.X, tGravityAcc.std.Y, tGravityAcc.std.Z

## Steps in R script

The following steps are performed when executing the R script `run_analysis.R`:

1. Download the data to the working directory
2. Unzip the data to the subfolder `data`
3. Load meta-data
    + Feature names
    + Activity names
4. Load training data
    + Assign feature names to columns
    + Load subject ID of rows
5. Load test data
    + Assign feature names to columns
    + Load subject ID of rows
6. Select relevant columns
    + Means of measurements
    + Standard deviations of measurements
7. Merge train and test data
8. Add column: subject ID
9. Add column: activity name (by merging on activity label)
10. Calculate column means for each combination of activity and subject
11. Tidy up column names
12. Save tidy dataset to file `tidy.csv`
