library(dplyr)

setwd("C:/Users/cory.rasmussen/Desktop/Vendor RA")

# Importing the data set to R
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merging the data
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Subject_table <- rbind(subject_train, subject_test)
Merged_File <- cbind(Subject_table, x, y)



# Extracting only the std and mean measurements
Tidy_Data <- Merged_File %>% select(subject, code, contains("mean"), contains("std"))

# Assigning descriptive activty names
Tidy_Data$code <- activities[Tidy_Data$code, 2]

# labels data set with variable names
names(Tidy_Data)[2] = "activity"
names(Tidy_Data)<-gsub("Acc", "Accelerator", names(Tidy_Data))
names(Tidy_Data)<-gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data)<-gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data)<-gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data)<-gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data)<-gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data)<-gsub("tBody", "TimeBody", names(Tidy_Data))
names(Tidy_Data)<-gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-std()", "Standard Deviation", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data)<-gsub("gravity", "Gravity", names(Tidy_Data))

# Second clean data set with average of each variable
Final_Table <- Tidy_Data %>% 
  group_by(subject, activity) %>% 
  summarise_all(funs(mean))
write.table(Final_Table, "Final_Table.txt", row.name = FALSE)

Final_Table
