# Preconditions: 
#  - Project Data should be downloaded and extracted in your current working directory.
#  - plyr package installed


library(plyr)


# Generating data sets for the test and train data. This is, merging the X_test (data) + y_test (activity id) 
# + subject_test (subject id).

testX<-read.table(file="UCI HAR Dataset\\test\\X_test.txt",stringsAsFactors=F)
testY<-read.table(file="UCI HAR Dataset\\test\\y_test.txt",stringsAsFactors=F)
subjectTest<-read.table(file="UCI HAR Dataset\\test\\subject_test.txt",stringsAsFactors=F)
dfTest<-cbind(subjectTest,testY,testX)

trainX<-read.table(file="UCI HAR Dataset\\train\\X_train.txt",stringsAsFactors=F)
trainY<-read.table(file="UCI HAR Dataset\\train\\y_train.txt",stringsAsFactors=F)
subjectTrain<-read.table(file="UCI HAR Dataset\\train\\subject_train.txt",stringsAsFactors=F)
dfTrain<-cbind(subjectTrain,trainY,trainX)

rm("testX")
rm("testY")
rm("subjectTest")
rm("trainX")
rm("trainY")
rm("subjectTrain")


# 1 Merging the training and test data frames


df<-rbind(dfTest,dfTrain)

rm("dfTest")
rm("dfTrain")


# 4 Adding headers for the data frame.


features <- read.table(file="UCI HAR Dataset\\features.txt",stringsAsFactors=F)
colnames(df)<-c("subject","activity",t(features$V2))


# 2 Extracting the measurements on the mean and standard deviation for each measurement


df <- df[,c(1,2,grep("std", colnames(df)), grep("mean", colnames(df)))]


# 3 Using descriptive activity names to name the activities in the data set


activity_labels <- read.table(file="UCI HAR Dataset\\activity_labels.txt",stringsAsFactors=F)
df$activity <- factor(df$activity, levels=activity_labels$V1, labels=activity_labels$V2)


# 5 Creating a second, independent tidy data set with the average of each variable for each activity and each subject


df2<-ddply(df,.(subject,activity),.fun=function(x){ colMeans(x[,-c(1:2)]) })

write.table(df2,file="tidy data.txt",row.name=FALSE)
