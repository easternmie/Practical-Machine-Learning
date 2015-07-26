
download.data <- function(){

# make sure the sources data folder exists
if (!file.exists('source data')) {
  dir.create('source data')
}

files.to.download<-c('https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv',
                     'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv')

downloaded.names<-c('source data/training set.csv',
                    'source data/testing set.csv')

# check to see if the training set is there
if (!file.exists(downloaded.names[1])) {
  
  # download the csv
  download.file(files.to.download[1],downloaded.names[1])
  
}

# check to see if the testing set is there
if (!file.exists(downloaded.names[2])) {
  
  # download the csv
  download.file(files.to.download[2],downloaded.names[2])

}

}