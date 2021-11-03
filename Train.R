#기업에서 생성된 주문데이터이다. 
#80,009건의 데이터에 대하여 정시 도착 가능 여부 예측 모델을 만들고
#평가 데이터에 대하여 정시도착 예측 확률을 기록한 CSV를 생성하시오
dat = read.csv("C:/git/knightqualifying/Train.csv")

partition = sample(x=c("train","test"),size=nrow(dat),replace=T,prob=c(0.7,0.3))

train = dat[partition=="train",]
test = dat[partition=="test",]

summary(train)
str(train)
sum(!complete.cases(train))
sum(!complete.cases(test))
!is.na(train)

train$Reached.on.Time_Y.N = as.factor(train$Reached.on.Time_Y.N)
test$Reached.on.Time_Y.N = as.factor(test$Reached.on.Time_Y.N)

mod = randomForest(Reached.on.Time_Y.N~.,data = train, ntree=300,do.trace=T)
pred = predict(mod, newdata = test,type="response")


confusionMatrix(data = pred, reference = test$Reached.on.Time_Y.N)
