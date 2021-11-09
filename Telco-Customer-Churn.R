dat = read.csv("C:/git/knightqualifying/tcc.csv")
dat = na.omit(dat)
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
