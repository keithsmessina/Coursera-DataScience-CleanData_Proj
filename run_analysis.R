runAnalysis <- function(){

  # Read raw accelerometer data into temporary variables
  rawDataTrainData <- read.table("./data./train/X_train.txt", header = FALSE,
                                 stringsAsFactors = FALSE)
  rawDataTestData <- read.table("./data./test/X_test.txt", header = FALSE,
                                 stringsAsFactors = FALSE)
  print(str(rawDataTestData))
  print(str(rawDataTrainData))
  
  # Combine the Test and Train data data frames into a single data frame
  rawDataCombinedData <- rbind(rawDataTrainData, rawDataTestData)
  
  # Read raw label data into temporary variables
  rawDataTrainLabels <- read.table("./data./train/Y_train.txt",
                                   header = FALSE, stringsAsFactors = FALSE)
  rawDataTestLabels <- read.table("./data./test/Y_test.txt",
                                   header = FALSE, stringsAsFactors = FALSE)
  
  # Combine the Test and Train label data frames into a single data frame
  rawDataCombinedLabels <- rbind(rawDataTrainLabels, rawDataTestLabels)
  
  # Create a vector containing the activity labels with position in vector
  # based on the number representing those labels
  activitiesLabelVector <- c("WALKING", "WALKING_UPSTAIRS",
                             "WALKING_DOWNSTAIRS", "SITTING", "STANDING",
                             "LAYING")
  
  # Convert label temporary data frames into tidy data by converting
  # numbers into the categories that they represent
  for(i in 1:6){
    rawDataCombinedLabels[rawDataCombinedLabels==i] <- activitiesLabelVector[i]
  }
  
}