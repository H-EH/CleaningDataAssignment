## CODE BOOK for AverageSet.txt and DataSet1.csv

DataSet1.csv 

- it is a combination of all the data files from Human Activity Recognition Using Smartphones Dataset.

- data files used :

  - features.txt: List of all features. aka Column names for data.

  - activity_labels.txt: Links the class labels with their activity name. aka the Subject's activities (code / names).

  - train/X_train.txt: Training set. Measurements.

  - train/y_train.txt: Training labels. Related to the measurements - activity codes.

  - train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

  - test/X_test.txt: Test set. Measurements.

  - test/y_test.txt: Test labels. Related to the measurements - activity codes.

  - test/subject_test.txt: Each row identifies thee subject who performed the activity for each window sample. Its range is from 1 to 30. 

  - only all the columns or measures for Mean() and std() were extracted.

- the measurements are stored by Subject, activityCode and activityLabel.

AverageSet.txt 

- this set contains the average figures of each column extracted in DataSet1 by Subject and Activity.

- the average measurements are stored by Subject, activityCode and activityLabel. 

Reference : 

- actual dataset : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

- website : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
