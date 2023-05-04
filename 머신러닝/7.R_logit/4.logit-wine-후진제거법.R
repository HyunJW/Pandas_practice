df <- read.csv('c:/data/wine/wine_new.csv')
head(df)
tail(df)

#필드제거
library(dplyr)
df <- df %>% select(-quality)
head(df)
dim(df)
summary(df)

#상관계수 행렬
(corrmatrix <- cor(df))

library(corrplot)
corrplot(cor(df), method="circle")

#불균형 데이터셋
tbl <- table(df$class)
tbl
barplot(tbl, beside=T, legend=T, col=rainbow(2))

#Under Sampling
library(ROSE)
df_samp <- ovun.sample(class ~ ., data=df, seed=1, method="under", N=744*2)$data
tbl <- table(df_samp$class)
tbl

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2로 구분
idx_train <- createDataPartition(y=df_samp$class, p=0.8, list=F)

#학습용
train <- df_samp[idx_train, ]
X_train <- train[, -12]
y_train <- train[, 12]

#검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -12]
y_test <- test[, 12]

head(X_train)
head(y_train)

#로지스틱 회귀모델 생성
model <- glm(class ~ ., data=train, family=binomial)

#모델정보 요약
summary(model)

#회귀계수 확인
(coef1 <- coef(model))

#예측값을 0~1 사이로 설정
pred <- predict(model, newdata=X_test, type='response') # response: 확률로 출력

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)

#예측정확도
mean(y_test == result)

#오분류표
table(y_test, result)

#후진제거법
reduced <- step(model, direction='backward')
# AIC: Akaike 정보지수(Akaike information criterion)
# Deviance: 이탈도 
# 위의 두 수치가 작을수록 좋은 모형
# 첫 단계에서 pH가 제거 => AIC: 1196.94 > 1195.14로 감소

#최종 결과 확인
summary(reduced)

#회귀계수 확인
coef(reduced)

#예측값을 0~1 사이로 설정
pred <- predict(reduced, newdata=X_test, type='response')

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)

#예측정확도
mean(y_test == result)

#오분류표
table(y_test, result)



