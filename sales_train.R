dat = read.csv("sales_train_v2.csv",header=T)

#가장 많이 판매된 상품(id) 3가지와 전체상품에 대하여

#상품판매가(price)의 표준편차 차이를 구하시오


head(dat)

table(dat$item_id)
summary(dat)

dat %>% group_by(item_id) %>% summarise(cnt = n()) %>% arrange(desc(cnt))
top3[1:3,] -> top3


dat %>% filter(item_id %in% c(top3[1,1],top3[2,1],top3[3,1])) %>% summarise(sd = sd(item_price)) -> a

sd(dat$item_price) ->b 

abs(a-b)
