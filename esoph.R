dat = esoph


# (1) 환자수 ncases와 대조군 수 ncontrols 를 합한 새로운 컬럼인 관측자 수 nsums를 생성하고

# (2) 음주량과 흡연량에 따른 관측자 수(nsums)의 이원 교차표를 생성하여 학인하고

# (3) 음주량과 흡연량에 따른 관측자 수 (nsums)의 카이제곱 값을 구하시오dat = esoph
head(esoph)

dat %>% mutate(nsums = ncases + ncontrols) -> dat

with(dat,xtabs(nsums ~ alcgp + tobgp)) -> ing

chisq.test(ing)
