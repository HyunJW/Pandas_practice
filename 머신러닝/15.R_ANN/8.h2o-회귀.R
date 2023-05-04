df <- read.csv("c:/data/ozone/ozone2.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Result, -Month, -Day)
head(df)

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df$Ozone, p=0.8, list=F)

#학습용
train <- df[idx_train, ]
X_train <- train[, -1]
y_train <- train[, 1]

#검증용
test <- df[-idx_train, ]
X_test <- test[, -1]
y_test <- test[, 1]

head(X_train)
head(y_train)

#h2o 타입으로 변환
library(h2o)
h2o.init() # h2o 접속
set.seed(123) # 랜덤 시드 고정
tr_data <- as.h2o(train)
te_data <- as.h2o(test)
target <- "Ozone"

#독립변수들의 이름
features <- names(train)[2:4]
features

#회귀모델 생성
model <- h2o.deeplearning(x=features, y=target, training_frame=tr_data, ignore_const_cols=FALSE, hidden=c(8,7,5,5))
summary(model)

# 예측값
pred <- h2o.predict(model, te_data)
pred

# MSE 계산
perf <- h2o.performance(model, newdata=te_data)
perf
h2o.mse(perf)