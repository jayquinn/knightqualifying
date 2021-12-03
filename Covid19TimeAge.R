dat = read.csv("TimeAGe.csv",header=T)

#20대 확진자 confirmed의 평균과 50대 확진자 confirmed의 평균 차를 구하시오

summary(dat)
colSums(is.na(dat))
head(dat)
dat %>% group_by(age) %>% summarise(mean = mean(confirmed)) -> dat
dat$mean[3] - dat$mean[6]