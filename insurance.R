# Charges 항목에서 이상값을 구하시오
# 평균에서 1.5 표준편차 이상 값

dat = read.csv("C:/git/knightqualifying/insurance.csv")

dat$charges
crit = sd(dat$charges) * 1.5
mn = mean(dat$charges)

dat %>% filter(charges >= (crit + mn) | charges <= (mn - crit) ) %>% summarise(sum = sum(charges)) -> view

head(view)




########################

########## 데이터의 charge 가격을 예측하시오. 채점기준은 RMSE

library(caret)
library(dplyr)
library(randomForest)
#데이터 분리
ds = read.csv("C:/git/knightqualifying/insurance.csv")
idx = sample(x = c(1:nrow(ds)),size = nrow(ds)*0.8)
X_train = ds[idx,][-7]
y_train = ds[idx,][7]
X_test = ds[-idx,][-7]
y_test = ds[-idx,][7]

cbind(X_train,y_train) -> train
cbind(X_test,y_test) -> test 
colSums(is.na(train)) 
colSums(is.na(test)) 



model.matrix(~-1+sex + smoker + region, data=test) -> dummytest
model.matrix(~-1+sex + smoker + region, data=train) -> dummytrain

test %>% select(age,bmi,children,charges) -> testa
train %>% select(age,bmi,children,charges) -> traina
test = cbind(testa,dummytest)
train = cbind(traina,dummytrain)


mod = randomForest(charges ~., data=train)
answer = predict(mod,newdata = test[,-4])

RMSE(test$charges,answer)#5179