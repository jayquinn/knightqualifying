library(caret)
library(dplyr)
library(randomForest)

ds = iris
idx = sample(x = c(1:nrow(ds)),size = nrow(ds)*0.7)
X_train = ds[idx,][-5]
y_train = ds[idx,][5]
X_test = ds[-idx,][-5]
y_test = ds[-idx,][5]

train = cbind(X_train,y_train) 
test = cbind(X_test,y_test)

mod = randomForest(Species ~., data = train)
answer = predict(mod, newdata=test[-5])

confusionMatrix(y_test$Species,answer)
