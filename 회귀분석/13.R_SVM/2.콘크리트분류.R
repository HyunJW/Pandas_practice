df<-read.csv("c:/data/concrete/concrete.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-strength)
dim(df)
summary(df)

#상관계수 행렬
head(corrmatrix <- cor(df))
library(corrplot)
corrplot(cor(df), method="circle")

#불균형 데이터셋
tbl=table(df$class)
tbl
barplot(tbl, beside = TRUE, legend = TRUE, col = rainbow(2))

#언더샘플링
library(ROSE)
df_samp <- ovun.sample(class ~ .,data=df, seed=1, method="under", N=507*2)$data
tbl = table(df_samp$class)
tbl

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df_samp$class, p=0.8, list=F)

#학습용
train <- df_samp[idx_train, ]
X_train <- train[, -9]
y_train <- train[, 9]

#검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -9]
y_test <- test[, 9]

head(X_train)
head(y_train)

#스케일링 전 박스플롯
library(reshape)
meltData <- melt(X_train)
boxplot(data=meltData, value~variable)

# 정규화된 데이터를 data.frame형태로 변경
X_train_scaled <- as.data.frame(scale(X_train))
X_test_scaled <- as.data.frame(scale(X_test))

# 데이터프레임 연결(가로방향)
train_scaled <- cbind(X_train_scaled, class=y_train)
test_scaled <- cbind(X_test_scaled, class=y_test)

head(train_scaled)
head(test_scaled)

#스케일링 후 박스플롯
meltData <- melt(X_train_scaled)
boxplot(data=meltData, value~variable)

#가장 에러율이 적은 cost, gamma value확인
library("e1071")
set.seed(123)
tune.out <- tune(svm, class ~ ., data=train_scaled,
	range=list(
		cost=c(0.001, 0.01, 0.1, 1, 10),
		gamma=c(0.0001, 0.001, 0.01, 0.1)))
summary(tune.out)

#가장 성능이 좋은 모델
bestmodel <-tune.out$best.model
summary(bestmodel)

#학습용 정확도
pred <- predict(bestmodel, X_train_scaled)
result <- ifelse(pred > 0.5, 1, 0)
table(y_train, result)
mean(y_train == result)

#검증용 정확도
pred <- predict(bestmodel, X_test_scaled)
result <- ifelse(pred > 0.5, 1, 0)
table(y_test, result)
mean(y_test == result)