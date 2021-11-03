# Charges 항목에서 이상값을 구하시오
# 평균에서 1.5 표준편차 이상 값

dat = read.csv("C:/git/knightqualifying/insurance.csv")

dat$charges
crit = sd(dat$charges) * 1.5
mn = mean(dat$charges)

dat %>% filter(charges >= (crit + mn) | charges <= (mn - crit) ) %>% summarise(sum = sum(charges)) -> view

head(view)
