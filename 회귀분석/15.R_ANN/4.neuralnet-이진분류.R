df <- read.csv("c:/data/diabetes/data.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-target)
head(df)

#불균형 데이터셋
tbl <- table(df$target2)
tbl
barplot(tbl, beside=T, legend=T, col=rainbow(2))

#언더샘플링
library(ROSE)
df_samp <- ovun.sample(target2 ~ .,data=df, seed=1, method="under", N=195*2)$data
tbl <- table(df_samp$target2)
tbl

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df_samp$target2, p=0.8, list=FALSE)

#학습용
train <- df_samp[idx_train, ]
X_train <- train[, -11]
y_train <- train[, 11]

#검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -11]
y_test <- test[, 11]

#모형생성
library(neuralnet)
set.seed(123) # 랜덤 시드 고정
# threshold(학습중지기준): 에러의 감소분이 threshold 값보다 작으면 stop
# linear.output: 회귀분석인 경우 - T, 분류인 경우 - F
# model <- neuralnet(target2 ~ ., data=train, hidden=10, threshold=0.01, linear.output=F)
model <- neuralnet(as.factor(target2) ~ ., data=train, hidden=c(10,10), linear.output=F)
model$result.matrix # 가중치 정보
plot(model)
# # 변수의 중요도 그래프(출력층의 노드가 1개일 때만 출력 가능)
# library(NeuralNetTools)
# garson(model)

#예측값(확률)
pred <- predict(model, X_test, type='prob')
pred

#각 샘플에 대해 0,1로 출력(0: 열방향, 1: 행방향)
result <- apply(pred, 1, function(x) which.max(x) - 1)
result

#모형평가
table(y_test, result)
mean(y_test == result)

#ROC curve
library(Epi)
ROC(test=result, stat=y_test, plot="ROC", AUC=T, main="신경망")