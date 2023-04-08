#C5.0모형
df<-read.csv("c:/data/ozone/ozone2.csv")
head(df)

#필드제거
library(dplyr)
df<-df %>% select(-Ozone, -Month, -Day)

#불균형 데이터셋
tbl <- table(df$Result)
win.graph()
barplot(tbl, beside=T, legend=T, col=rainbow(2))

#언더샘플링
library(ROSE)
df_samp <- ovun.sample(Result ~ ., data=df, seed=1, method='under', N=72*2)$data
tbl <- table(df_samp$Result)

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df_samp$Result, p=0.8, list=F)

#학습용
train <- df_samp[idx_train, ]
X_train <- train[, -1]
y_train <- train[, 1]

#검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -1]
y_test <- test[, 1]

head(X_train)
head(y_train)

#install.packages('C50')
library(C50)
y_train <- as.factor(y_train)
model <- C5.0(y_train ~ ., data=X_train, trials=10) # trials: 생성 모형의 최대 개수
summary(model)

#트리 그래프
win.graph()
plot(model, uniform=T, main='Tree')
text(model, use.n=T, all=T, cex=.8)

#예측값
pred <- predict(model, newdata=X_test)
pred

#오분류표
table(y_test, pred)
mean(y_test == pred)

y_test_f <- as.factor(y_test)
confusionMatrix(y_test_f, pred)

