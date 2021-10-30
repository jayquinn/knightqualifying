
# 2번 문제 166page 
# (1) 주어진 데이터 첫 번째 행부터 순서대로 80%까지의 데이터를 훈련 데이터로 추출 후
# (2) housing_office 항목에서 total_bedrooms 변수의 결측값을 
# total_bedrooms 변수의 중앙값으로 대체하고
# (3) 대체 전의 total_bedrooms 변수의 표준편차값과 
# (4) 대체 후의 total_bedrooms 변수의 표준 편차값을 산출하려고 한다.
# (5) 결측 값을 중앙값으로 변환한 후, 변환 이전과 이후의 표준편차 차이를 구하시오.
dat = read.csv("C:/git/knightqualifying/housing.csv")
idx = rep(c("train","test"),c(nrow(dat)*0.8,nrow(dat)*0.2)) # (1)
ds_train = dat[idx == "train",]
ds_test = dat[idx == "test",]

med_tb = median(dat$total_bedrooms,na.rm = T)

jun = sd(dat$total_bedrooms,na.rm=T) # (3) 

dat$total_bedrooms[is.na(dat$total_bedrooms)] = med_tb # (2) 
hoo = sd(dat$total_bedrooms,na.rm=T) # (4) 

prin(jun - hoo) #(5) 
