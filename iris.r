library(caret)
library(dplyr)
library(randomForest)

ds = iris
idx = sample(x = c(1:nrow(ds)),size = nrow(ds)*0.7)
X_train = ds[idx,][-5]
y_train = ds[idx,][5]
X_test = ds[-idx,][-5]
y_test = ds[-idx,][5]
