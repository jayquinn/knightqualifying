library(MASS)



# weight를 민스 스케일링 변환한 후 0.5 이상인 레코드 수를 구하시오

dat = ChickWeight
with(dat,scale(weight,center = min(weight),scale = c(max(weight)-min(weight)))) -> dat
dat[0.5<=dat] %>% length()