## Assignment Submission
Dataset for Assignment Details :

Human Activity Recognition Using Smartphones Dataset Version 1.0

Authors :
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

License :
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

###############################
## run_analysis.R Explanation #
###############################
Summary :
Human Activity Recognition Using Smartphones Dataset used in the assignment are as follows.
Descriptions are taken off the Dataset's README.txt :
- features.txt: List of all features. aka Column names for data.
- activity_labels.txt: Links the class labels with their activity name. aka the Subject's activities (code / names).
- train/X_train.txt: Training set. Measurements.
- train/y_train.txt: Training labels. Related to the measurements - activity codes.
- train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- test/X_test.txt: Test set. Measurements.
- test/y_test.txt: Test labels. Related to the measurements - activity codes.
- test/subject_test.txt: Each row identifies thee subject who performed the activity for each window sample. Its range is from 1 to 30. 

The script uses dplyr, tidyr and data.table to clean and tidy the 2 sets of data into a single Dataset (DataSet1.csv) and
creates a dataset that shows the averages (Mean) of the different columns for every Subject and every activity of each Subject.

Script Flow :
1. Read all the required files into data.frames. 

2. Tidy Test Set 

   a) Rename the x_test data columns using the values found in features.txt.

   b) Rename the x_test_subject data column to "Subject".

   c) merge the y_test and activity_label data to form an set of activities and related descriptive activity labels.

   d) combine subject , activities and variables to form TestData Set using data.table.

3. Tidy Train Set 

   a) Rename the x_train data columns using the values found in features.txt.   
   
   b) Rename the x_train_subject data column to "Subject".
   
   c) merge the y_train and activity_label data to form an set of activities and related descriptive activity labels.
   
   d) combine subject , activities and variables to form TrainData Set using data.table.

4. Merge test and train data into 1 Dataset called DataSet1. 

5. Arrange the data by Subject,activityCode,activityLabel

6. Create Average activity measure by Subject and activity code to form the data.frame AverageSet :
   
   a) split DataSet1 into groups by Subject , activityCode and activityLabel.
   
   b) Obtain the average of each measurement column in DataSet1 using colMeans, transpose subject/activity column to rows.
   
   c) Get the row.names of the resulting average dataset and save it into a variable subject.acvitity.activityL, replacing 
      the activityLabel values that has "_" to "". this is for separating the columns later.
   
   d) remove the row.names in AverageSet by setting it as NULL.
   
   e) combine the column subject.acvitity.activityL into the AverageSet
   
   f) finally separate the subject.acvitity.activityL back into Subject, activityCode, and activityLabel as found in 
      DataSet1.
   
   g) update the activityLabels WALKINGDOWNSTAIRS and WALKINGUPSTAIRS to include a space between WALKING and DOWNSTAIRS/UPSTAIRS.
   
   h) Write the final result into a text file called AverageSet.txt, comma separated.
   
   i) backup the actual dataset DataSet1 for future analysis and use.
