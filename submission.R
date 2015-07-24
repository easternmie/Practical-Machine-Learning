
library(caret)
library(Hmisc)
library(AppliedPredictiveModeling)
setwd('C:/Users/mickf/OneDrive/Source Code/GitHub/Practical-Machine-Learning')

## call external module get
source('download data set.R')
source('submit files.R')

## load and remove columns that have empty values
training.set <- read.csv('source data/training set.csv',na.strings=c('NA','DIV/0!',''))[,7:160]
testing.set <- read.csv('source data/testing set.csv',na.strings=c('NA','DIV/0!',''))[,7:160]

## split the training set for working purposes
set.seed(19801104)
inTrain = createDataPartition(training.set$classe,p=0.75,list = FALSE)

## 
probe.set = training.set [-inTrain, ]
dim(probe.set)
training.set = training.set [inTrain, ]
dim(training.set)

## instead of trying to impute data, lets simple remove variables that are incomplete
complete.vector <- apply(!is.na(training.set),2,sum) >= nrow(training.set)
training.set <- training.set[,complete.vector]
probe.set <- probe.set[,complete.vector]
testing.set <- testing.set[,complete.vector]

## Calculate the number of principal components needed to capture 80% of the variance. How many are there?
pc <- preProcess(training.set[,-54],method='pca',thres=0.80)

#  
training.pc <- predict(pc,training.set[,-54])
probe.pc <- predict(pc,probe.set[,-54])
testing.pc <- predict(pc,testing.set[,-54])

#
if (!file.exists('fittings')) {
  dir.create('fittings')
}

# check to see if the training set is there
if (!file.exists('fittings/solution fit.rds')) {
  
  tc <- trainControl(method = 'cv', number = 3)
  fit <- train(training.set$classe ~ ., method='rf', data=training.pc, allowParallel=TRUE, prox=TRUE, tcControl=tc)

  saveRDS(fit, 'fittings/solution fit.rds')

} else {
  
  fit <- readRDS('fittings/solution fit.rds')
  
}

#
prediction <- predict(fit, newdata=probe.pc)

confusionMatrix(prediction,probe.set$classe)

# conclusion
submission <- predict(fit, newdata=testing.pc)
submission


# appendix
#pc$rotation


