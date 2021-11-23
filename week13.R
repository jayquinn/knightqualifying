data = read.csv("https://raw.githubusercontent.com/Datamanim/datarepo/main/bicycle/seoul_bi.csv",fileEncoding = "utf-8",sep=",",header=F)
dat = data
colnames(dat) = as.vector(dat[1,])
dat = dat[-1,]
library(dplyr)

#Q1 대여일자별 데이터의 수를 데이터프레임으로 출력하고, 가장 많은 데이터가 있는 날짜를 출력하라.
dat %>% group_by(대여일자) %>% summarise(n = n()) %>% arrange(desc(n)) %>% slice_max(1) %>% select(2) %>% print()

#Q2. 각 일자의 요일을 표기하고, 이를 이용하여 각 요일별 이용건수의 총합을 출력하라
dat$대여일자 %>% as.Date() %>% weekdays() -> dat$대여일자
dat %>% group_by(대여일자) %>% summarise(n = sum(as.integer(이용건수))) %>% print()
