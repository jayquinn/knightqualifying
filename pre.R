library(tidyverse)
library(mlbench) #BostonHousing 데이터
library(randomForest)
library(caret) #confusionMatrix()
library(pROC)
library(e1071)
# 작업 프로세스
# () 결측치 제거 na.omit() 
# () 결과변수 팩터화 as.factor()
# () 데이터 분할 createDataPartition()
# () 모델 비교를 위한 스케일링 preProcess(dat,method=c("range"))
# () 모델 만들기
# () 예측하기 predict()
# () 혼동행렬 보기 confusionMatrix()