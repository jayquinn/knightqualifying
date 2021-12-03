#이탈 Yes 유지 No 예측하기(Churn variable)
library(randomForest)
dat = read.csv("C:/git/knightqualifying/tcc.csv")
#데이터 분할
tmp = createDataPartition(dat$Churn,p = 0.7)
x_train = dat[tmp$Resample1,]
y_train = dat[tmp$Resample1,]
x_test = dat[-tmp$Resample1,]
y_test = dat[-tmp$Resample1,]

#결과값 factor화
y_train$Churn = as.factor(y_train$Churn)
y_test$Churn = as.factor(y_test$Churn)

#모델 비교를 위한 스케일링
model_prep = preProcess(x_train,method = c("range"))
sx_train = predict(model_prep,x_train)
sx_test = predict(model_prep,x_test)
#랜포 - 비교용 - 스케일링 된 데이터 사용 
mod_rf = randomForest(y_train$Churn ~. -customerID,sx_train,ntree=300,do.trace=T)
pred_rf = predict(mod_rf, newdata=sx_test,type = 'response') 
confusionMatrix(y_test$Churn,pred_rf)
# 서폿벡따머신 - 비교용 - 스케일링 된 데이터 사용 
mod_svm = svm(y_train$Churn ~.-customerID,sx_train)
pred_svm =predict(mod_svm,newdata=sx_test,type='response')
confusionMatrix(y_test$Churn,pred_svm)

#랜포 - 제출용 - 스케일링 하지 않은거 씀
mod_rf = randomForest(y_train$Churn ~.-customerID,x_train,ntree=300)
pred_rf = predict(mod_rf,newdata=x_test)
write.csv(pred_rf,"submit.csv")




###################################################################
dat = read.csv("C:/git/knightqualifying/tcc.csv")
#데이터 분할
tmp = createDataPartition(dat$Churn,p = 0.7)
x_train = dat[tmp$Resample1,]
y_train = dat[tmp$Resample1,]
x_test = dat[-tmp$Resample1,]
y_test = dat[-tmp$Resample1,]
y_train %>% select(customerID,Churn) -> y_train
y_test %>% select(customerID,Churn) -> y_test
inner_join(x_train, y_train) -> train
inner_join(x_test, y_test) ->test

train$TotalCharges[which(is.na(train$TotalCharges))] <- median(train$TotalCharges,na.rm=T)
test$TotalCharges[which(is.na(test$TotalCharges))] <- median(test$TotalCharges,na.rm=T)

train$Churn <- as.factor(train$Churn)
test$Churn <- as.factor(test$Churn)

mod = randomForest(Churn ~. - customerID, data = train,ntree=300)
answer = predict(mod,newdata = test[-21])

answer %>% as.factor() -> answer

confusionMatrix(test$Churn,answer)