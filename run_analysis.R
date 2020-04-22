##### Coursera project

############################################ - START STEP 1 - ######################################

URLfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

temp_file <- tempfile()
temp_dir <- tempdir()
download.file(URLfile,temp_file)
files.names <- unzip(temp_file , exdir = temp_dir)
print(files.names) # to visualize the directory of each file content in the variables.

# files.names content all the directory of each file in the zip documents


# downloading activities names and features

activities <- read.table(files.names[1]) # ids and labels of activities
features <- read.table(files.names[2])  # ids and labels of features


# Downloading the training data set

X_training <- read.table(files.names[27])     # loading the X_train dataset (the 27th element of the files.names vector)
colnames(X_training) <- features$V2           # renaming X_training column names with feature label
y_training <- read.table(files.names[28])     # loading the y_train dataset (the 28th element of the files.names vector)
X_training$activity <- y_training$V1          # adding a y_training to the X_training datat set 
subject_training <- read.table(files.names[26])   # loading the subject_train dataset (the 26th element of the files.names vector)
X_training$subject <- factor(subject_training$V1) # adding a subject to the X_training datat set



# downloading the test data set

X_test <- read.table(files.names[15])         # loading the X_test dataset (the 15th element of the files.names vector)
colnames(X_test) <- features$V2               # renaming X_ttest column names with feature label
y_test <- read.table(files.names[16])         # loading the y_test dataset (the 16th element of the files.names vector)
X_test$activity <- y_test$V1                  # adding a y_test to the X_test datat set 
subject_test <- read.table(files.names[14])   # loading the subject_test dataset (the 14th element of the files.names vector)
X_test$subject <- factor(subject_test$V1)     # adding a subject (test) to the X_test datat set


# Merging the training and test data sets

data <- rbind(X_training, X_test)

############################################## - END STEP 1 - ######################################

############################################ - START STEP 2 - ######################################

# Extracting measurments on the mean and standard deviation

names_column <- colnames(data)
id.column <- grep("std\\(\\)|mean\\(\\)|activity|subject", names_column) # selecting the colmun ID where the characters (mean, std) appear
data_step_3 <- data[, id.column] 


############################################## - END STEP 2 - ######################################

############################################ - START STEP 3 - ######################################

# adding descriptive values

activities_names <- as.character(activities[,2])      # transforms activity labels into a vector of characters
data_step_3$activitylabel <- factor(x = data_step_3$activity, labels = activities_names) # adding activity labels in the data frame


############################################## - END STEP 3 - ######################################

############################################ - START STEP 4 - ######################################

library(reshape2)
features_names = grep("std\\(\\)|mean\\(\\)", names_column, value=TRUE)     # selecting just features labels with mean and std
data_melt <- melt(data_step_3, id = c('activitylabel', 'subject'), measure.vars = features_names) # melting data_step_3 with activity and subject as key ids
data_tidy <- dcast(data_melt, activitylabel + subject ~ variable, mean)     # decasting our data to create the final tidy data

############################################## - END STEP 4 - ######################################


############################################ - START STEP 5 - ######################################

# saving the tidy data set (have to specified the directory where you're willing to save the data)

write.table(data_tidy, file = "tidydata.txt", row.names = FALSE)

# close the temporary file and directory

file.remove(temp_file)

############################################## - END STEP 5 - ######################################
