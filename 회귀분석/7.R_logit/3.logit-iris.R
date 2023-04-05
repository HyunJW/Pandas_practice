df <- read.csv('c:/data/iris/iris.csv')
head(df)
tail(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Name)
head(df)
dim(df)
summary(df)

#상관계수 행렬
(corrmatrix <- cor(df))

library(corrplot)
corrplot(cor(df), method="circle")

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 8:2 구분
idx_train <- createDataPartition(y=df$Species, p=0.8, list=F)

#학습용
train <- df[idx_train, ]
X_train <- train[, -5]
y_train <- train[, 5]

#검증용
test <- df[-idx_train, ]
X_test <- test[, -5]
y_test <- test[, 5]

head(X_train)
head(y_train)

#로지스틱 회귀모델 생성(3개 이상의 class인 경우 multinom 함수 사용)
#install.packages("nnet")
library(nnet)
model <- multinom(Species ~ ., data=train)

#모델정보 요약
summary(model)

#회귀계수 확인
(coef1 <- coef(model))

#클래스로 출력
pred <- predict(model, newdata=X_test)
pred

#정확도
mean(y_test == pred)
table(y_test, pred)

#확률로 출력
pred <- predict(model, newdata=X_test, type='probs')
pred
head(pred)

#0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)
head(result)
head(y_test)

#클래스로 변환
new_result <- c()
for (i in 1:nrow(result)){
	for (j in 1:ncol(result)){
		if (result[i,j] == 1){
			new_result[i] <- j-1 # 품종이 0,1,2이므로 1을 빼야 함
		}
	}
}
y_test == new_result

#정확도
mean(y_test == new_result)
table(y_test, new_result)

