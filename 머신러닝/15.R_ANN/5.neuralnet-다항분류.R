df<-read.csv("c:/data/iris/iris.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Name)
head(df)

#데이터 불균형 확인
tbl <- table(df$Species)
tbl

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df$Species, p=0.8, list=FALSE)

#학습용
train <- df[idx_train, ]
X_train <- train[, -5]
y_train <- train[, 5]

#검증용
test <- df[-idx_train, ]
X_test <- test[, -5]
y_test <- test[, 5]

#분류 신경망모델 생성
library(neuralnet)
set.seed(123) # 랜덤 시드 고정
model <- neuralnet(as.factor(Species) ~ ., data=train, hidden=10, threshold=0.01, linear.output=F)
plot(model)

#가중치 정보
model$result.matrix

#모형 평가
pred <- predict(model, X_test, type='prob')
pred # 예측한 확률
# apply(x, direction, function) - direction(1: 행방향, 2: 열방향)
result <- apply(pred, 1, function(x) which.max(x) - 1)
result # 예측값
table(y_test , result) # 오분류표
mean(y_test == result) # 검증용 정확도
