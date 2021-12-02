library(mlbench)
dat = PimaIndiansDiabetes2


# (1) glucose pressure mass 칼럼 결측값이 있는 행을 제거하고

# (2) age를 조건에 맞게 그룹화한 후

# (3) 발병률이 가장 높은 나이 그룹의 발병률을 구하시오 (발병률 = pos/인원수)

dat = PimaIndiansDiabetes2

dat %>% filter(!is.na(glucose) & !is.na(pressure) & !is.na(mass))

dat %>% group_by(age) %>% mutate(ag = case_when(age>19 & age<41 ~ '1', age>40 & age<61 ~ '2', age>60 ~ '3')) -> dat


dat %>% group_by(ag) %>% summarise(n = n(), npos = sum(diabetes=="pos"), rate = npos/n)
