## The Program meets the following intent: It: 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Programmers Notes:

# 1. To aid the peer review only one file was created with complete data sourcing and cleaning.
# 2. All means and standard deviations were extracted. No programmer's judgement was applied to arrive at the inclusion or exclusion of means.
# 3. The descriptive column names were applied before the extraction of required measurements. 
#    The reason is to keep the file future ready when other columns may also be required for separate analysis. 
# 4. The column names were processed for comma, hyphen only. The hyphens were replaced with "_" (underscore) for easy reference to column names.
# 5. The mix of cases (upper and lower) in column names were not disturbed as they do not hinder readability.

#----------------------- Part 1: Sourcing and File Consolidation-------------------------


## 1. download file 

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "~/RPractice/Assignment/GetAndCleanData/data/getdata-projectfiles-UCI-HAR-Dataset.zip", method="auto")

## 2. unzip the file

unzip("~/RPractice/Assignment/GetAndCleanData/data/getdata-projectfiles-UCI-HAR-Dataset.zip")


## Read data into tables

## Read all common data 
feature_all <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/features.txt")
act_label <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/activity_labels.txt")

## read all train data
X_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/subject_train.txt")

body_acc_x_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/body_acc_z_train.txt")

body_gyro_x_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/body_gyro_z_train.txt")

total_acc_x_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/train/inertial Signals/total_acc_x_train.txt")


## read all test data
X_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/subject_test.txt")

body_acc_x_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/body_acc_z_test.txt")

body_gyro_x_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/body_gyro_z_test.txt")

total_acc_x_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("~/RPractice/Assignment/GetAndCleanData/data/UCI HAR Dataset/test/inertial Signals/total_acc_x_test.txt")


## combine ALL TRAIN Data starting with subject (from sub_train), label (from Y_train), and finally feature vectors from X_train.

consolidated_train <- data.frame(c(sub_train, Y_train, X_train))

## combine ALL TEST Data starting with subject (from sub_train), label (from Y_train), and finally feature vectors from X_train.

consolidated_test <- data.frame(c(sub_test, Y_test, X_test))

## Now combine all data : combined_train and combined_test. Here we need to append the data in the final data frame.

consolidated_all <- data.frame(rbind(consolidated_train ,consolidated_test))
#Part 1 completed---------------------------------------------------------------------------------------

#----------------------- Part 2 & 4: Extract Mean & Std. Deviation; Assign Column Names-----------------

## The steps taken to asssign variable names from dataframe "feature_all" that contains 561 variable names.

## Step 1. consolidated_all has 563 columns as we have added "Subject" and "Activity".  So we create a data frame with two 
## additional labels - "Subject" and "Activity"

dummy_label <- data.frame(-1:0, c("Subject", "Activity")) # to maintain the column list order, -1 and 0 are introduced.
colnames(dummy_label) <- c("V1", "V2")

## Step 2: Add dummy_label to a new data frame f_all <- feature_all 
f_all <- feature_all
f_all_m <- data.frame(rbind(dummy_label, f_all))

##Step3. Clean up the measurement names in f_am_m (V2)
#----------------------------------------------------------------------------------------------------

f_all_m[, 2] <- gsub("\\(|\\)", "", f_all_m$V2) # removes parenthesis
f_all_m[, 2] <- gsub("-", "_", f_all_m$V2)        # replace "-" with "_"
f_all_m[, 2] <- gsub(",", "_", f_all_m$V2)



## Step 3: Finally, assign column names to consolidated_all from f_all_m (having 563 entries)
colnames(consolidated_all) <- f_all_m[, 2]



# Create a subset only with columns, Subject, Activity and measurements for mean and std.
# Extract only those columns that have mean and std embedded into column names

consolidated_mean_std <- subset(consolidated_all, select=grep("Subject|Activity|mean|std", colnames(consolidated_all)))
# Part 2 Completed.

#-------------------------Part 3, 4 & 5 -----------------------------------------------------------

# merge consolidated_data and act_label (Activity Label)
consolidated_data_merged <- merge(consolidated_mean_std, act_label, by.x="Activity", by.y="V1") 
consolidated_data_merged$Activity <- NULL

# replace Activity from numeric to values from activity label (act_label)
n <- length(1:(ncol(consolidated_data_merged)-1)) # length excluding the last colummn (that was merged)
consolidated_data_merged <- consolidated_data_merged[c(1, n+1,2:n)]  # reorder the columns: Subject, Activity, measurements....
colnames(consolidated_data_merged)[2] <- "Activity"   # Rename the column to its original.
# Part 3 & 4 completed. 


# Find the mean of all measurements
tidy_data <- aggregate(consolidated_data_merged[,3:81], consolidated_data_merged[,1:2], FUN = mean)

# Write the tide_data text output.
write.table(tidy_data,"tidy_data.txt")
# Part  5 Completed.


#-----------------------------------------End of Analysis-----------------------------------------------












