#당뇨 데이터
df<-read.csv("c:/data/diabetes/data.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-target2)
dim(df)
X <- df[, -11]
y <- df[, 11]

#최적의 sigma(gamma)와 Cost
svm.Grid <- expand.grid(.sigma=c(0.0001, 0.001, 0.01, 0.1), # sigma(gamma): 샘플의 영향력
	.C=c(0.001, 0.01, 0.1, 1, 10, 100)) # Cost: 패널티
model <- train(X, y, 
	method="svmRadial", 
	preProcess=c("center", "scale"), # 스케일링
	tuneGrid=svm.Grid, 
	tuneLength=3, 
	trControl=trainControl(method="cv"))
model # RMSE기준 sigma = 0.01, C = 1

#예측값
pred <- predict(model, X)
pred

#오차
d <- y - pred
d

#MSE
mse<-mean(d^2)
mse

#MAE
mae<-mean(abs(d))
mae

#RMSE
rmse<-sqrt(mse)
rmse

#R2
rsquared<- 1-(sum(d^2)/sum((y-mean(y))^2))
rsquared

#기본함수(MAE)
MAE(pred, y) 

#caret 패키지의 함수(RMSE, R2)
library(caret)
RMSE(pred, y) # RMSE
R2(pred, y) # R2