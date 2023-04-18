df <- read.csv("c:/data/ozone/ozone2.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Month, -Day, -Result)
head(df)

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df$Ozone, p=0.8, list=FALSE)

#학습용
train <- df[idx_train, ]
X_train <- train[, -1]
y_train <- train[, 1]

#검증용
test <- df[-idx_train, ]
X_test <- test[, -1]
y_test <- test[, 1]

#회귀 신경망모델 생성
library(neuralnet)
# 에러가 발생할 경우 stepmax를 증가시켜야 함
model <- neuralnet(Ozone ~ ., data=train, hidden=10, threshold=0.05, stepmax=1e7)
plot(model)

#모형 평가
pred <- predict(model, X_test)
pred # 예측값(확률)
mean((y_test - pred)^2) # 평균제곱오차