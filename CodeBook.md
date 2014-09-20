About the data set
===================
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
[Here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) are the data for the project.

### Data Set Information


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned **into two sets**, where 70% of the volunteers was selected for generating the **training data** and 30% the **test data**.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

*Check the README.txt into the zip file for further details about this dataset.*

### Attribute Information

For each record in the dataset it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.  

### More information

A full description is available [at the site where the data was obtained](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

*Check the README.txt file into the zip file for further details about this dataset.*

Goals of the script
====================
R script called run_analysis.R that does the following: 

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
### Steps of the script

1. Check whether the required packages are installed. If they are not, install
2. Load the required packages
3. Load the activity and features labels.
4. From features labels, select only the mean a standard deviation
5. For each data set (train/test) there are tree files that contain the data to bind (where 'xxx' represent 'train' or 'test'):

  * X_xxx.txt file
  * y_xxx.txt file
  * subject_xxx.txt file
6. Create a function to bind this three data files to obtain the data frames of train and test data sets.

  + This function extract only the mean and std columns
  + This function set descriptive variable names
  + This data sets use descriptive activity names instead of activity id
7. Merge the train and test data frames objects into a 'tidy_data' data frame object
8. From the tidy data frame object (tidy_data), creates a second, independent tidy data set with the average of each variable for each activity and each subject:

  * Step 1 for second tidy data: Melt data. _melt()_ function treats column names as a variable as it collapses data into long format. We want to convert all features columns into a new measure var
        
  * Step 2 for second tidy data:Split data frame, apply function, and return results in a data frame. With ddply() function of 'dplyr' package we are to split data frame by subject, activity and variable, apply the 'mean' function and return the result in a new 'data.frame' object
  * Step 3 for second tidy data: write result of second tidy data to filesystem on 'tidy_mean.txt' file
       
### Tidy data description

Columns description:

* subject: 'ID' of the subject
* Activity_Label: Name of the activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* variable: Name of the measurement variable
* variableMean: The mean of the variable value by subject and activity

Table head example:

subject | Activity_Label | variable             | variableMean
--------|----------------|----------------------|-------------
1	|LAYING	         |tBodyAcc-mean()-X     |0.22159824394
1	|LAYING 	 |tBodyAcc-mean()-Y 	|-0.0405139534294
1	|LAYING 	 |tBodyAcc-mean()-Z     |-0.11320355358


 
 
