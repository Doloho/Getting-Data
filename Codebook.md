Codebook.md

Information on the program run_analysis.R

Libraries used are data.table and dplyr

Files are read using read.table and saved as file names:
featureNames
activityLabels

SubjectTrain
XTrain
YTrain

SubjectTest
XTest
YTest

The subjects, x's and Y's are merged using rbind

Columns are given names
And all files are merged with cbind

"Mean" and "std" are searched for to generate only those columns.
There are 88 columns

Activity names are changed into characters so they can be updated.
Names were updated with gsub:
"Acc" was turned into "Accelerometer"
"Gyro" was turned into "Gyroscope"
"BodyBody" was turned into "Body"
"f" was turned into "Frequency"
"tBody" was turned into "TimeBody"

Tidy.text was created 