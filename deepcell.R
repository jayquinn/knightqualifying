
# 2021.05.14 작업형: 제1유형
# mtcars 데이터셋(mtcars.csv)의 qsec 컬럼을 최소최대 척도(Min-Max Scale)로 변환한 후 
# 0.5보다 큰 값을 가지는 레코드 수를 구하시오.

head(mtcars)
min = min(mtcars$qsec)
max = max(mtcars$qsec)
scaled = scale(mtcars$qsec,center=min, scale = max - min)
answer = scaled[scaled > 0.5,]
length(answer)

# 2021.05.17 작업형: 제2유형
# 고객 3,500명에 대한 학습용 데이터(y_train.csv, X_train.csv)를 이용하여 성별예측 모형을 만든 후, 
# 이를 평가용 데이터(X_test.csv)에 적용하여 얻은 2,482명 고객의 성별 예측값(남자일 확률)을 
# 다음과 같은 형식의 CSV 파일로 생성하시오.(제출한 모델의 성능은 ROC-AUC 평가지표에 따라채점)
y_train = read.csv("c://git/knightqualifying/y_train.csv",header=T)
x_train = read.csv("c://git/knightqualifying/x_train.csv",header=T)
x_test = read.csv("c://git/knightqualifying/x_test.csv",header=T)

y_train = read.csv('https://raw.githubusercontent.com/Datamanim/dataq/main/y_train.csv',header=T)
x_train = read.csv('https://raw.githubusercontent.com/Datamanim/dataq/main/X_train.csv',header=T)
x_test = read.csv('https://raw.githubusercontent.com/Datamanim/dataq/main/X_test.csv',header=T)


#데이터 살펴보기
summary(x_train)
table(x_train$주구매상품)
table(x_train$주구매지점)
# 총구매액, 최대구매액에서 마이너스값 제거
# 환불금액 NA값 0으로 대체

#전처리 - 이상값 바꿔주기
library(dplyr)
gender = y_train[,2]
x_train = cbind(x_train, gender)
x_train = filter(x_train, 총구매액 > 0 & 최대구매액 > 0)

x_train$환불금액 = ifelse(is.na(x_train$환불금액),0,x_train$환불금액) #NA 0으로 대체
#값에 특수문자 바꾸기
table(x_train$주구매상품)
x_train$주구매상품 = gsub(" ","",x_train$주구매상품)
x_train$주구매상품 = gsub("/","",x_train$주구매상품)
table(x_train$주구매지점)
x_train$주구매지점 = gsub("  ","",x_train$주구매상품)
#전처리 - min-max 스케일링
#2,3,4,7,8,9,10
mm = function(x){
  return( (x-min(x)) / (max(x)-min(x)) )  
}
n = c(2,3,4,7,8,9,10)
for(i in n){
x_train[,i] = mm(x_train[,i])}
summary(x_train)

#전처리 - one-hot encoding 
library(caret)
x_train$주구매상품 %>% as.factor()-> x_train$주구매상품
x_train$주구매지점 %>% as.factor()-> x_train$주구매지점
dmy = dummyVars(~., data = x_train)
x_train= predict(dmy,newdata=x_train)

x_train = as.data.frame(x_train[,-1])
mod1 = glm(gender ~ . , family=binomial(), data = x_train)
summary(mod1)

########## x_test도 위와 동일한 전처리 #############
x_test = read.csv('https://raw.githubusercontent.com/Datamanim/dataq/main/X_test.csv',header=T)
x_test = filter(x_test, 총구매액 > 0 & 최대구매액 > 0)
x_test$환불금액 = ifelse(is.na(x_test$환불금액),0,x_test$환불금액) 
x_test$주구매상품 = gsub(" ","",x_test$주구매상품)
x_test$주구매상품 = gsub("/","",x_test$주구매상품)
x_test$주구매지점 = gsub("  ","",x_test$주구매상품)
#test 전처리 - min-max 스케일링
mm = function(x){
  return( (x-min(x)) / (max(x)-min(x)) )  
}
n = c(2,3,4,7,8,9,10)
for(i in n){
  x_test[,i] = mm(x_test[,i])}
summary(x_test)
#test 전처리 - one-hot encoding
library(caret)
x_test$주구매상품 %>% as.factor()-> x_test$주구매상품
x_test$주구매지점 %>% as.factor()-> x_test$주구매지점
dmy = dummyVars(~., data = x_test)
x_test= predict(dmy,newdata=x_test)
##################################################### 
x_test = as.data.frame(x_test[,-1])

yhat = predict(mod1,x_test)
