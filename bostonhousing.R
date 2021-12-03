
library(mlbench)
# (1) crim 변수의 상위 10번째값으로 상위 10개 값을 변환하고
# age 80 이상의 값에 대하여 crim 평균을 구하시오

data("BostonHousing")
dat = BostonHousing

dat %>% arrange(desc(crim)) -> top10 

top10$crim[1:10] = top10[10,1]

top10 %>% filter(age>=80) -> answer

answer$crim %>% mean()
