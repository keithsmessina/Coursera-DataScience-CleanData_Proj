runAnalysis <- function(){
  # Read raw accelerometer data into temporary variables
  rawDataTrainData <- read.table("./data/train/X_train.txt", header = FALSE,
                                 stringsAsFactors = FALSE)
  rawDataTestData <- read.table("./data/test/X_test.txt", header = FALSE,
                                 stringsAsFactors = FALSE)
  
  # Read accelerometer data column labels into temporary variables
  rawDataColumnLabels <- read.table("./data/features.txt", header = FALSE,
                                 stringsAsFactors = FALSE)
  rawDataColumnLabels <- t(rawDataColumnLabels[,2])
  
  # Combine the Test and Train data data frames into a single data frame
  rawDataCombinedData <- rbind(rawDataTrainData, rawDataTestData)
  
  # Add Column Names to combined data
  colnames(rawDataCombinedData) <- rawDataColumnLabels
  
  # Extract only the mean and standard deviation measurements from the data
  findMean <- grep("mean()", colnames(rawDataCombinedData), fixed = TRUE)
  findSTD <- grep("std()", colnames(rawDataCombinedData), fixed = TRUE)
  findAll <- c(findMean, findSTD)
  extractedData <- rawDataCombinedData[,c(findAll)]
 
  # Read raw label data into temporary variables
  rawDataTrainLabels <- read.table("./data/train/Y_train.txt",
                                   header = FALSE, stringsAsFactors = FALSE)
  rawDataTestLabels <- read.table("./data/test/Y_test.txt",
                                   header = FALSE, stringsAsFactors = FALSE)
  
  # Read raw Subject data into temporary variables
  rawDataTrainSubjects <- read.table("./data/train/subject_train.txt",
                                   header = FALSE, stringsAsFactors = FALSE)
  rawDataTestSubjects <- read.table("./data/test/subject_test.txt",
                                  header = FALSE, stringsAsFactors = FALSE)
  
  # Combine the Test and Train label data frames into a single data frame
  # and name the column as "Activity"
  rawDataCombinedLabels <- rbind(rawDataTrainLabels, rawDataTestLabels)
  colnames(rawDataCombinedLabels) <- c("Activity")
  
  # Combine the Test and Train Subject data frames into a single data frame
  rawDataCombinedSubjects <- rbind(rawDataTrainSubjects, rawDataTestSubjects)
  colnames(rawDataCombinedSubjects) <- c("Subject")
  
  # Combine all data into one large data frame
  tidyFitData <- cbind(rawDataCombinedSubjects, rawDataCombinedLabels,
                           extractedData)
  
  # Create a vector containing the activity labels with position in vector
  # based on the number representing those labels
  activitiesLabelVector <- c("WALKING", "WALKING_UPSTAIRS",
                             "WALKING_DOWNSTAIRS", "SITTING", "STANDING",
                             "LAYING")
  
  # Convert label temporary data frames into tidy data by converting
  # numbers into the categories that they represent
  for(i in 1:length(activitiesLabelVector)){
    tidyFitData$Activity[tidyFitData$Activity==i] <- activitiesLabelVector[i]
  }
  
  # Create a new data frame to hold the averages of the data and name the
  # columns the same as our original tidy data columns
  tidyAveragedData <- matrix(nrow = (max(tidyFitData$Subject) *
                                       length(activitiesLabelVector)),
                             ncol = length(tidyFitData))
  tidyAveragedData <- as.data.frame(tidyAveragedData)
  colnames(tidyAveragedData) <- colnames(tidyFitData)
                                 
  # Start a counter for the rows of the new data frame so that we always move to
  # the next observation row when we loop
  counter <- 1
  
  # Loop over each subject in the data
  for(i in 1:max(tidyFitData$Subject)){
    # Loop over each activity within each subject
    for(j in 1:length(activitiesLabelVector)){
      # Loop over each measurement within each activity within each subject.
      for(k in 3:length(tidyFitData)){
        # Add the subject ID to the "Subject" column of the new row
        tidyAveragedData$Subject[counter] <- i
        # Add the Activity description to the "Activity" column of the new row
        tidyAveragedData$Activity[counter] <- activitiesLabelVector[j]
        # Take the average of the measurement for the selected Subject and
        # Activityand save it to the new row
        tidyAveragedData[counter, k] <- mean(tidyFitData[tidyFitData$Subject == i &
                                                           tidyFitData$Activity
                                                         == activitiesLabelVector[j], k],
                                             na.rm = TRUE)
      }
      # Increment the counter so that we start a new row
      counter <- counter + 1
    }
  }
  
  # Loop over the column names to rename them to more meaningfully match the
  # data that they hold, since they now hold averages of their measurements
  # rather than the raw measurements
  tidyColumnNames <- c(1:length(tidyAveragedData))
  tidyColumnNames[1] <- "Subject"
  tidyColumnNames[2] <- "Activity"
  tempNames <- colnames(tidyAveragedData)
  for(i in 3:length(tidyAveragedData)){
    tidyColumnNames[i] <- paste("mean-",tempNames[i], sep = "")
  }
  colnames(tidyAveragedData) <- tidyColumnNames
  str(tidyFitData)
  str(tidyAveragedData)
  write.table(tidyAveragedData, file = "./data.txt", row.name=FALSE)
}