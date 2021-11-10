# (1) Solar.R에결측값이 있는 행을 제거하고,
# (2) Ozone 항목의 결측값을 중앙값을 대체 한 후,
# 중앙값으로 대체하기 이전과 이후의 Ozone의 표준편차 차이를 구하시오.
dat = airquality
dat1 = dat[-which(is.na(dat$Solar.R)),]
nrow(dat)
nrow(dat1)
sd(dat1$Ozone,na.rm = T) # 33.27597 대체 이전
dat1[which(is.na(dat1$Ozone)),]<- median(dat1$Ozone,na.rm=T) 
aft = dat1
sd(aft$Ozone) # 29.3704 대체 이후


# 데이터의 순서대로 90%의 데이터를 훈련 데이터로 추출하고,
# Ozone 항목의 결측값을 평균으로 변경한 후
# 변경 전 , 후의 중앙값 차이를 구하시오
dat = airquality
trainbef = dat[1:nrow(dat),]
trainaft = dat[1:nrow(dat),]
trainaft$Ozone[which(is.na(trainaft$Ozone))] = mean(trainaft$Ozone,na.rm=T)
median(trainbef$Ozone,na.rm=T) - median(trainaft$Ozone)


# Solar.R에 결측값이 있는 행을 제거하고, 
# Ozone 항목의 결측값을 중앙값으로 대체한 후,
# 중앙값으로 대체하기 이전과 이후의 Ozone의 표준편차 차이를 구하시오
dat = airquality
nrow(dat)
dat = dat[-which(is.na(dat$Solar.R)),]
nrow(dat)
bef = sd(dat$Ozone,na.rm=T)
dat$Ozone[which(is.na(dat$Ozone))] = median(dat$Ozone,na.rm=T)
aft = sd(dat$Ozone)
abs(bef - aft)
bef
aft
