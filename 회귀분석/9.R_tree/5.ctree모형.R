#CTREE모형
df<-read.csv("c:/data/ozone/ozone2.csv")
head(df)

#필드제거
library(dplyr)
df <- df %>% select(-Ozone, -Month, -Day)

head(df)
dim(df)
summary(df)

#상관계수 행렬
(corrmatrix <- cor(df))
library(corrplot)
corrplot(cor(df), method='circle')

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

#install.packages('party')
library(party)

#기계학습 모델 생성
model <- ctree(Result ~ ., data=train)
model
plot(model)

plot(model,type='simple') # 화씨 82기준/ 풍량 10.3 기준

#예측값(검증용데이터셋)
pred <- predict(model, X_test)

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)

head(pred)
head(y_test)

#오분류표
table(y_test, pred)
mean(y_test == pred)

#랜덤포레스트 모형
#install.packages('randomForest')
library(randomForest)
set.seed(1)
# mtry: 변수의 개수
# ntree: 트리의 개수
# importance=T: 변수의 중요도로 모델 생성
model <- randomForest(Result ~ . , data=train, mtry=3, ntree=5, importance=T)
model

#결과값(학습용데이터셋)
result <- predict(model, X_train)

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)

head(result)
head(y_train)

#오분류표
table(y_train, result)
mean(y_train == result)

#예측값(검증용데이터셋)
pred <- predict(model, X_test)

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)

head(pred)
head(y_test)

#오분류표
table(y_test, result)
mean(y_test == result)

#특성중요도
importance(model)

#특성중요도 그래프
varImpPlot(model) # %IncMSE 정확도, IncNodePurity 중요도
