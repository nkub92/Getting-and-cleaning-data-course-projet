# Getting-and-cleaning-data-course-projet
## The script

The following script is written to transfrom the data from UCI HAR dataset into tidy data. The script directly download data from the url and create tempratories file and directory. It's only required to specified the working derectory when saving the tidy data set at the end.


These are the files used in the script:

* activity_labels.txt - includes the id and labels for the activities measures (**files.names[1]**)
* features.txX_training/X_train.txt - includes the measurements of the features in train set (**files.names[27]**)
* X_test/X_test.txt - includes the measurements of the features in test set (**files.names[15]**)
* subject_train.txt - subject for each measurement from the train set (**files.names[26]**)
* subject_test.txt - subject for each measurement from the test set (**files.names[15]**)
* y_train.txt - activities from the train set (**files.names[28]**)
* y_test.txt - activities from the test set (**files.names[16]**)


**NB**: The directory of each of the above files are located in the variable files.names


## How the script works

To run the script, you need to install R. These are the different stages of the script:

1. Download the URL in a file in R
2. Create a temporary file and a temporary directory to download the zipped database
3. Download the database in the temprary file and unzip the database
4. Store the unzipe file in a variable. you can prind the variable to see the directory of each file in the database

**STEP 1**: (this step requires that you load activities and features first).

a. Load the measurements from X_train.txt
b. Name the columns of the data load using features description
c. Load activity labels and subjects for measurements and add the to the dataframe .

Do the same for the test data set and merge it to the train dataframe built previously (END OF STEP 1).


**STEP 2**: use the function grep to extract measurements that involves only mean and std (and ID columns: activity and subject). Create a data frame with the corresponding measurements. (END OF STEP 2) 

**STEP 3**: Use the activities variable to create a vector of characters with the name of each activity. Added a new column (_activitylabel_) to the dataframe of stage two. (END OF STEP 3) 

**STEPS 4 and 5**: Create a melted data frame using activity and subject as ids. Generate the tidy data by using the dcast funtion and save the tidy data created. (END OF STEPS 4 and 5)

