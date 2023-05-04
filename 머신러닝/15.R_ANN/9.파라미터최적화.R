library(nnet)
df <- read.csv("c:/data/ozone/ozone2.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Ozone, -Month, -Day)
head(df)

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df$Result, p=0.8, list=F)

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

#은닉층의 노드 개수를 튜닝하는 함수
test.rate <- function(h.size){
	# size 은닉층의 노드개수
	model <- nnet(as.factor(Result) ~ ., data=train, size=h.size)
	pred <- predict(model, X_test, type='class')
	rate <- mean(y_test == pred)
	c(h.size, rate)
}

#예측값
sapply(1:5, FUN=test.rate)

#행렬전치
out <- t(sapply(10:50, FUN=test.rate))
out

#오차가 최소인 은닉노드의 개수와 정확도 확인
out[which.max(out[, 2]), ]
plot(out, type="b", xlab="hidden nodes", ylab="accuracy")

#파라미터 튜닝-2
library("e1071")
set.seed(123)
tmodel <- tune.nnet(as.factor(Result) ~ ., data=train, size=10:50)
summary(tmodel)

#최적의 파라미터를 적용시킨 모델
bestmodel <- tmodel$best.model
summary(bestmodel)

#예측값
pred <- predict(bestmodel, X_train)
result <- ifelse(pred > 0.5, 1, 0)
tail(result)

#모형 평가
table(y_train, result)
mean(y_train == result)

#파라미터 튜닝-3
# expand.grid: 가능한 모든 파라미터의 조합을 만드는 함수
# decay: 가중치를 조절하기 위한 옵션
my.grid <- expand.grid(.decay=c(0.3), .size=10:50)

#최적 모형 학습
fit <- train(as.factor(Result) ~ ., data=train, method="nnet", tuneGrid=my.grid, trace=F)
fit

#예측값
pred <- predict(fit, newdata=test)
pred

#모형 평가
table(y_test, pred)
mean(y_test == pred)