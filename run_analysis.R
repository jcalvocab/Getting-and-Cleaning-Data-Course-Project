################################################################################
# R script that does the following:
# 
#       1. Merges the training and the test sets to create one data set.
#       2. Extracts only the measurements on the mean and standard deviation 
#          for each measurement. 
#       3. Uses descriptive activity names to name the activities in the data
#          set.
#       4. Appropriately labels the data set with descriptive variable names. 
#       5. From the data set in step 4, creates a second, independent tidy data 
#          set with the average of each variable for each activity and each 
#          subject.
################################################################################
run.analysis <- function () {
        # Chek if "data.table" package is available. If not, install it
        if (!require("data.table")) {
                install.packages("data.table")
        }
        # Chek if "data.table" package is available. If not, install it
        if (!require("reshape2")) {
                install.packages("reshape2")
        }
        # Chek if "dplyr" package is available. If not, install it
        if (!require("plyr")) {
                install.packages("plyr")
        }
        # Load packages "data.table" and "reshape2"
        require("data.table")
        require("reshape2")
        require("plyr")
        # Set base data dir
        basedirName<-"UCI HAR Dataset"
        
        # Load activity labels
        activity_labels <- read.table(file.path(basedirName, "activity_labels.txt"))[,2]
        # Load features column names
        features <- read.table(file.path(basedirName, "features.txt"))[,2]
        # In features column names, extracts only the columns on the mean and standard 
        # deviation for each measurement
        mean_std_features <- grepl("mean|std", features)
        
        ## Function to bind test/train data sets
        ## Data sets "test" and "train" have the same structure. So we can reuse 
        ## the code to bind this data sets using the following function.
        ## Usage: train_data <- bindData("train")
        ## Arguments: Name of the data set ("train"|"test")
        ## Value: 'bindData' return a 'data.table' object binding data form 
        ## 'subject_XXX.txt', 'X_xxx.txt' and 'y_XXX.txt' files
        bindData <- function(datasetname){
                ## Check if 'datasetname' is valid
                namesV<-c("test", "train")
                if (!is.element(datasetname,namesV)){
                        stop("invalid data set name")  
                }
                # Load and process X_xxx & y_xxx data.
                X <- read.table(file.path(basedirName,datasetname,paste("X_",datasetname,".txt",sep="")))
                y <- read.table(file.path(basedirName,datasetname,paste("y_",datasetname,".txt",sep="")))
                subject <- read.table(file.path(basedirName,datasetname,paste("subject_",datasetname,".txt",sep="")))
                names(X) = features
                # Extract only the mean and standard deviation columns for each measurement.
                X = X[,mean_std_features]
                # Replace values of column "Activity_ID" with descriptive activity names
                y[[1]]<-activity_labels[y[,1]]
                
                names(y) = "Activity_Label"
                names(subject) = "subject"
                # Bind data
                dataset <- cbind(as.data.table(subject), y, X)
                dataset
        }
        
        ## Use 'bindData()' custom function to bind data sets 'train' and 'test'
        test_data<-bindData("test")
        train_data<-bindData("train")
        
        # Merge test and train data
        tidy_data = rbind(test_data, train_data)
        
        ################################################################################
        # From the tidy data set, creates a second, independent tidy data set with the 
        # average of each variable for each activity and each subject.
        ################################################################################
        
        # Step 1 for second tidy data: Melt data. 
        # melt() function treats column names as a variable as it collapses data into 
        # long format. We want to convert all features columns into a new measure var 
        id_vars = c("subject", "Activity_Label")
        measure_vars = setdiff(colnames(data), id_vars)
        melt_data = melt(tidy_data, id.vars = id_vars, measure.vars = measure_vars)
        
        # Step 2 for second tidy data:Split data frame, apply function, and return 
        # results in a data frame.
        # With ddply() function of 'dplyr' package we are to split data frame by 
        # subject, activity and variable, apply the 'mean' function and return the 
        # result in a new 'data.frame' object
        tidy_mean <- ddply(melt_data, .(subject, Activity_Label,variable), summarise, variableMean=mean(value))
        
        # Step 3 for second tidy data: write result of second tidy data to filesystem
        write.table(tidy_mean, file = "tidy_mean.txt",row.names = FALSE, sep='\t')
}
