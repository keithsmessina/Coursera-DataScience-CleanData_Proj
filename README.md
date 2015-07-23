# Coursera-DataScience-CleanData_Proj
The script in this repository is used to assemble the data in the "data" folder into tidy data useful for analysis. The script "run_analysis.R" is initiated when loaded up by using the runAnalysis() command to run the function in the script.

When run from the same directory as the data folder, this function loads the data and shapes it into two tidy datasets:
1. tidyFitData
2. tidyAveragedData

To shape the data, first the train and test datasets are loaded into data frames. These two data frames were then combined together into one. Next the labels and subjects of each of the test and train sets of data were loaded into their own data frames. The subjects were added to the datasets data frame but the labels were first converted into descriptive labels from numbers before they were added to the datasets data frame. Next, I deleted all of the columns that were not means or standard deviations for the data. With this, I arrived at the first dataset.

Next, I looped over each subject for each activity and took the average of each columnn to arrive at the second data frame, the averages of the tidy data. This data frame is then saved to a text file.

When the function call is complete, it prints the structure of the two tidy datasets using the str() function so that they are easily assessed.

You can access the code book for the tidy data set created with the runAnalysis() function in this repository i either the Code_book.txt or Code_book.md files.
