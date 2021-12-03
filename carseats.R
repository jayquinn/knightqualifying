library(ISLR)
library(dplyr)
#(1) 매출의 이상값을 제외한 데이터를 훈련데이터로 선정할 때 age의 표준편차를 구하시오
# - 이상값은 평균보다 1.5 표준편차 이상이하값으로 선정한다
dat = Carseats

summary(dat)
colSums(is.na(dat))

crit = sd(dat$Sales) 

dat %>% filter(Sales <= 1.5*crit & Sales >= -1.5*crit) -> dat

sd(dat$Age)