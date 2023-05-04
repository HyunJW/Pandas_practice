#앙상블 모형(부스팅): 개별 모형의 출력에 가중치를 조합한 값을 판별함수로 사용
#install.packages('gbm')
library(MASS)
library(gbm)
set.seed(1)
train <- sample(1:nrow(Boston), nrow(Boston)/2)

#모델링(최대 100개의 모델)
boost.boston <- gbm(medv ~ ., data=Boston[train, ], n.trees=100) # n.trees: 모델의 최대 개수

#변수의 영향력 그래프
win.graph()
summary(boost.boston)

#가장 영향력이 큰 변수 2개 확인
win.graph()
plot(boost.boston, i="rm") # rm: 방의 수, 양의 상관관계
win.graph()
plot(boost.boston,i="lstat") # lstat: 인구 중 하위 계층 비율, 음의 상관관계

#검증용 주택가격
boston.test <- Boston[-train, "medv"]

#예측값
pred <- predict(boost.boston, newdata=Boston[-train, ], n.trees=100)

#평균제곱오차
mean((pred - boston.test)^2) # 오차: 약 23(단위 1000달러)
