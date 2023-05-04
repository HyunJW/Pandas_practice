df<-read.csv('c:/data/rides/rides2.csv')
head(df)

#0,1 카운트
tbl <- table(df$overall)
tbl

#카운트 플롯 - beside: 옆으로 나란히
win.graph()
barplot(tbl, beside=T, legend=T, col=rainbow(2))

#Under Sampling
library(ROSE)
df_samp <- ovun.sample(overall ~ ., data=df, seed=1, method='under', N=245*2)$data
tbl <- table(df_samp$overall)
tbl

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검정용 8:2로 구분
idx_train <- createDataPartition(y=df_samp$overall, p=0.8, list=F)

#학습용
train <- df_samp[idx_train, ]
X_train <- train[, -8]
y_train <- train[, 8]

#검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -8]
y_test <- test[, 8]

#스케일링
library(reshape)
meltData <- melt(X_train)
win.graph()
boxplot(data=meltData, value ~ variable)

X_train_scaled <- as.data.frame(scale(X_train))
meltData <- melt(X_train_scaled)
win.graph()
boxplot(data=meltData, value ~ variable)

X_test_scaled <- as.data.frame(scale(X_test))
meltData <- melt(X_test_scaled)
win.graph()
boxplot(data=meltData, value ~ variable)

train_scaled <- cbind(X_train_scaled, overall=y_train)
test_scaled <- cbind(X_test_scaled, overall=y_test)

#로지스틱 회귀분석 모형
model <- glm(overall ~ ., data=train_scaled, family=binomial)
summary(model)

#회귀계수 출력
(coef1 <- coef(model))

#후진제거법
reduced <- step(model, direction='backward')
summary(reduced)

#회귀계수 출력
(coef1 <- coef(reduced))

#결과값이 0~1 사이로 출력
pred <- predict(model, newdata=X_test_scaled, type='response')

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)

#예측정확도
mean(y_test == result)

#오분류표
table(y_test, result)

#ROC Curve
library(ROCR)
pr <- prediction(pred, y_test)
prf <- performance(pr, measure='tpr', x.measure='fpr')
win.graph()
plot(prf, main='ROC Curve')

#ROC Curve의 면적
auc <- performance(pr, measure='auc')
auc <- auc@y.values[[1]]
auc

#회귀계수
coef(reduced)

#오즈비
exp(coef(reduced))


