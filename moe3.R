
# Q13 
library(mlbench)
library(dplyr)
dat  = PimaIndiansDiabetes2
head(dat)
# glucose, pressure, mass 열의 결측값이 있는 행 제거
dat %>% filter(!is.na(glucose),!is.na(pressure),!is.na(mass)) -> dat
# 나이를 조건에 맞게 그룹화 1: 20~40, 2: 41~60, 3: 60 
dat %>% mutate(agegroup = case_when(age >= 20 & age <=40 ~ 1,
                         age >=41 & age <= 60 ~ 2,
                         age >= 60 ~ 3)) -> dat
# 발병률이 가장 높은 나이 그룹의 발병률을 구하시오.
dat %>% group_by(agegroup) %>% summarise(total_num = n(),
                                         diab_num = sum(diabetes =="pos"),
                                         ill_rate = diab_num/total_num) %>% arrange(desc(ill_rate)) -> dat
