df <- read.csv('c:/data/ozone/ozone2.csv')
head(df)
tail(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Ozone, -Month, -Day)

#상관계수 행렬 - 다중공선성 확인
(corrmatrix <- cor(df))

#강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix >0.5 | corrmatrix < 0.5]

library(corrplot)
corrplot(cor(df), method='circle') # 기온과 오존량이 상관관계가 높아보임

#데이터셋 확인(불균형 데이터셋)
tbl <- table(df$Result)
tbl
barplot(tbl, beside = TRUE, legend = T, col = rainbow(2))

#Under sampling
#install.packages("ROSE")
library(ROSE)
# method: under, over, both 
# N: 샘플링 후의 샘플 개수: (적은데이터수 x 2) 또는 (p=0.5)
df_samp <- ovun.sample(Result ~ . , data=df, seed=1, method='under', N=144)$data
tbl <- table(df_samp$Result)
tbl

library(caret)
set.seed(123) #랜덤 시드 고정

#학습용:검증용 8:2로 구분(list=FALSE: 리스트는 반환하지 않고 인덱스만 반환)
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

#로지스틱 회귀모델 생성
model <- glm(Result ~ ., data=train)

#모델정보 요약
summary(model) # 일조량, 풍량: 유의하지 않음

#회귀계수 확인
(coef1 <- coef(model)) # 일조량, 온도: 양의 상관관계/ 풍량: 음의 상관관계

#예측값을 0~1 사이로 설정
pred <- predict(model, newdata=X_test)
pred

#0.5 < pred: 1, 0.5 >= pred: 0
result <- ifelse(pred > 0.5, 1, 0) # == round(pred)

#예측정확도
mean(y_test == result)

#오분류표
table(y_test, result)

#ROC 커브
library(ROCR)
pr <- prediction(pred, y_test) # predict와 동일
pr@predictions # 출력값
# tpr: 1을 1로 맞춘 경우 / fpr: 0을 1로 틀린 경우
prf <- performance(pr, measure='tpr', x.measure='fpr')
win.graph()
plot(prf, main='ROC Curve')

#AUC(The Area Under an ROC Curve)
auc <- performance(pr, measure='auc')
auc@y.values
auc@y.values[[1]]
