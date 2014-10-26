library(dplyr); library(tidyr); library(data.table)

# Read in features and labels to obtain data columns and 
# activity labels
features <- read.table("UCI HAR Dataset/features.txt")
actyLabel <- read.table("UCI HAR Dataset/activity_labels.txt")

#read test Data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
xTest<- read.table("UCI HAR Dataset/test/x_test.txt")
yTest<- read.table("UCI HAR Dataset/test/y_test.txt")    

#read train Data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xTrain<- read.table("UCI HAR Dataset/train/x_train.txt")
yTrain<- read.table("UCI HAR Dataset/train/y_train.txt") 

##Tidy Test data##
#rename xTest Columns to those found in features.txt (features)
names(xTest) <- features[,2]

#rename the column for subjectTest to Subject
names(subjectTest) <- "Subject"

#form Test parameter data and set proper column names in the dataset
yTestParaFile <- merge(actyLabel,yTest)
names(yTestParaFile) <- c("activityCode", "activityLabel")

#combine subject , activities and variables to form TestData Set
TestData <- 
  data.table(subjectTest, yTestParaFile, xTest) %>%
  select(Subject:activityLabel,matches("-mean()"),matches("-std()"))

## End Tidy Test Data ##

##Tidy Train data##
#rename xTrain Columns to those found in features.txt (features)
names(xTrain) <- features[,2]

#rename the column for subjectTest to Subject
names(subjectTrain) <- "Subject"

#form Train parameter data and set proper column names in the dataset
yTrainParaFile <- merge(actyLabel,yTrain)
names(yTrainParaFile) <- c("activityCode", "activityLabel")

#combine subject , activities and variables to form TrainData Set
TrainData <- 
  data.table(subjectTrain, yTrainParaFile, xTrain) %>%
  select(Subject:activityLabel,matches("-mean()"),matches("-std()"))
## End Tidy Train Data ##

##Merge test and train data into 1 Dataset called DataSet1.
DataSet1 <-
  rbind_list(TestData,TrainData) %>%
  arrange(Subject,activityCode,activityLabel) 
## End Merge to create DataSet1

## Create Average activity measure by Subject and activity code.
#Split data by Subject/activitycode/activitylabel 
SplitSet <- split(DataSet1,list(DataSet1$Subject,DataSet1$activityCode,DataSet1$activityLabel),drop=TRUE)
#get average for rest of columns
AverageSet <- data.frame(t(sapply(SplitSet,function(x) colMeans(x[,4:82],na.rm=TRUE))))
#get row.names and remove from resulting data set.
subject.activity.activityL <- sub("_","",row.names(AverageSet)) 
row.names(AverageSet) <- NULL
#add rows into AverageSet and write to file
AverageSet<- cbind(subject.activity.activityL, AverageSet) 
FinalAverageSet<-
  separate(data=AverageSet,col=subject.activity.activityL,into=c("Subject","activityCode","activityLabel")) %>%
  mutate(activityLabel=sub("WALKINGDOWNSTAIRS","WALKING DOWNSTAIRS",activityLabel)) %>%
  mutate(activityLabel=sub("WALKINGUPSTAIRS","WALKING UPSTAIRS",activityLabel)) %>%
  write.table(file="UCI HAR Dataset/AverageSet.txt",sep=",",row.names=FALSE)
## End Create Average activity measure by Subject and activity code

# backup DataSet1
  write.csv(DataSet1,file="UCI HAR Dataset/DataSet1.csv",row.names=FALSE)
