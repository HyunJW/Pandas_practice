#앙상블 모형(배깅): 회귀문제는 평균으로, 분류문제는 다수결로 판단
#install.packages('adabag')
library(adabag)

#학습용 데이터(무작위로 150개 중 100개 추출)
train <- sample(1:150, 100)

#모델링
# mfinal: 모형의 개수
# maxdepth: 최대 깊이
# minsplit: 분기를 위한 최소 샘플수
iris.bagging <- bagging(Species ~ ., data=iris[train, ], mfinal=5, control=rpart.control(maxdepth=5, minsplit=5))

#개별 모형의 결과
iris.bagging$trees

#모든 모형의 트리 그래프
library(rpart.plot)
win.graph() 
rpart.plot(iris.bagging$trees[[1]])
win.graph() 
rpart.plot(iris.bagging$trees[[2]])
win.graph() 
rpart.plot(iris.bagging$trees[[3]])
win.graph() 
rpart.plot(iris.bagging$trees[[4]])
win.graph() 
rpart.plot(iris.bagging$trees[[5]])

#검증용 데이터셋을 입력하여 분류
predict(iris.bagging, iris[-train, ])$class

#오분류표
tbl <- table(iris$Species[-train], predict(iris.bagging, iris[-train, ])$class)
tbl

#정분류율, 오분류율 계산
rate1 <- sum(tbl[row(tbl) == col(tbl)]) / sum(tbl) # 정분류율
rate2 <- 1-rate1 # 오분류율
rate1
rate2