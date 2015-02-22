# Cleaning-Data-Project
Cleaning the data of a Samsung portable device.

The script included here should be saved in the same folder that contains the unzipped folder "UCI HAR Dataset". 

The script opens the file, "X_test.txt" from the "test" folder and saves it into the variable dataTest. It then adds the names of the columes which are taken from the "features.txt" file. To save working memory space, we immediately remove all columns that do not include "mean" or "std" somewhere in their name. Next, we load the data in "Y_test" and recode the numerical values to the activity names that they represent and column bind this to data frame in dataTest. Then we column bind the data that gives the subject number ID for each row with the data in dataTest, taken from the file "subject_test". This process is then repeated for all of the files in "train" folder and the resulting data is saved into the "dataTrain" variable.

We then row bind the two data sets together to create complete- a new data set that holds all of the data. (NB: This does take more memory than combining all of the data into one of the variables that we already have, but this preserves both of the original data sets, depending on their usefulness for future investigations.) The data in complete is then melted by "activity" and "V1" (the subject id number). We then find the means of the values created by grouping V1, activity, and variable. This data is then output to a table saved in a file called "summary.txt" that is saved in the working directory.
