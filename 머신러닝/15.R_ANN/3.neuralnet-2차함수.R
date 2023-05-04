#install.packages('neuralnet')
library(neuralnet)

set.seed(100) # 랜덤 시드 고정

#2차함수 생성
# 50개의 수열을 비복원추출 샘플링을 통해 순서 섞기
X <- as.matrix(sample(seq(-2, 2, length=50), 50, replace=FALSE), ncol=1)
y <- X^2
plot(y~X)
df <- as.data.frame(cbind(X, y))
colnames(df) <- c("X","y")
df

#신경망 모형(input - hidden(노드수: 10) - hidden(노드수: 10) - output)
nn <- neuralnet(y ~ X, data=df, hidden=c(10,10))
plot(nn) # 신경망 그래프

#실제값과 예측값 비교
test <- as.matrix(sample(seq(-2, 2, length=10), 10, replace=FALSE), ncol=1)
pred <- predict(nn, test)

test^2 # 실제값
pred # 예측값

#Mean Squared Error(평균제곱오차)
mean((pred - test^2)^2)
result <- cbind(test, test^2, pred)
colnames(result) <- c("test", "test^2", "pred")
result