# 훈련 7, 핑까3
# 연비(mpg) 예측하는 최적 모델링
# RMSE로 핑까
library(dplyr)
library(caret)
dat = mtcars
dat = na.omit(dat)
idx = createDataPartition(dat$mpg,p = 0.7)
d_train = dat[idx$Resample1,]
d_test= dat[-idx$Resample1,]

mod = lm(mpg ~.,data=d_train)

step(mod,direction = "backward")

modstp = lm(mpg ~ cyl + wt, d_train)
pred = predict(modstp, newdata=d_test,type = 'response')
pred
rmse = sqrt(mean(d_train$mpg - pred)^2)
rmse
