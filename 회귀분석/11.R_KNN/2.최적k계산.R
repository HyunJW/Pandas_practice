df<-read.csv("c:/data/ozone/ozone2.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Ozone, -Month, -Day)

#불균형 데이터셋
tbl <- table(df$Result)
tbl
barplot(tbl, beside=T, legend=T, col=rainbow(2))

#언더샘플링
library(ROSE)
df_samp <- ovun.sample(Result ~ .,data=df, seed=1, method="under", N=72*2)$data
tbl <- table(df_samp$Result)
tbl

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

#최적의 k값을 찾는 함수, 10회 교차검증(0,1 값을 숫자가 아닌 요인으로 변경)
library(e1071)
tune.out <- tune.knn(x=X_train, y=as.factor(y_train), k=1:10)
tune.out # best k = 3
plot(tune.out) # k = 3일 때, 에러율 최저

library(class)
pred <- knn(X_train, X_test, y_train, k=3)
tbl <- table(real=y_test, predict=pred)
tbl

#정확도
(tbl[1, 1] + tbl[2, 2]) / sum(tbl) 

#정오분류표에 카이제곱검정값을 세부적으로 출력하는 함수
# Cell Contents(셀의 내용)
# N : 셀의 샘플개수
# Chi-square contribution: 각 셀의 값에 카이제곱 기여도 포함
# 	(관측값 - 기대값)^2 / 기대값: 확률변수에 대하여 평균적으로 기대하는 값
# N / Row Total(행의 샘플수)
# N / Col Total(열의 샘플수)
# N / Table Total(전체샘플수)
#install.packages('gmodels')
library(gmodels)
CrossTable(y_test, pred)

#ROC curve
#install.packages('Epi')
library(Epi)
ROC(test=pred, stat=y_test, plot="ROC", AUC=T, main="KNN")
