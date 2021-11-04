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


