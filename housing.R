
# 2번 문제 166page 
# (1) 주어진 데이터 첫 번째 행부터 순서대로 80%까지의 데이터를 훈련 데이터로 추출 후
# (2) housing_office 항목에서 total_bedrooms 변수의 결측값을 
# total_bedrooms 변수의 중앙값으로 대체하고
# (3) 대체 전의 total_bedrooms 변수의 표준편차값과 
# (4) 대체 후의 total_bedrooms 변수의 표준 편차값을 산출하려고 한다.
# (5) 결측 값을 중앙값으로 변환한 후, 변환 이전과 이후의 표준편차 차이를 구하시오.
dat = read.csv("C:/git/knightqualifying/housing.csv")


#(1) 
round(nrow(dat)*0.8,0) -> crit
aft = dat[1:crit,]
sd(aft$total_bedrooms,na.rm=T) -> a

#(2) 
aft$total_bedrooms[which(is.na(aft$total_bedrooms))] <- median(aft$total_bedrooms,na.rm=T)

#(3)
abs(a-sd(aft$total_bedrooms))

