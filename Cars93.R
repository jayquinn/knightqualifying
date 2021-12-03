library(MASS)
library(dplyr)

# luggage.room의 결측값을 중앙값으로 변환한 후 변환 전, 후 평균의 차이를 구하시오


dat = Cars93

summary(Cars93)
colSums(is.na(dat))

mean(dat$Luggage.room,na.rm=T) -> bef

dat$Luggage.room[is.na(dat$Luggage.room)] <- median(dat$Luggage.room,na.rm=T)

mean(dat$Luggage.room) -> aft

abs(bef-aft)