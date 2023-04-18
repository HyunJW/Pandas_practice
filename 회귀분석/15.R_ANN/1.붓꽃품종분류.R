df <- read.csv("c:/data/iris/iris.csv")
head(df)
tail(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Name)

#Species 타입변경(int -> Factor)
str(df)
df$Species <- as.factor(df$Species)
str(df)
summary(df)

#상관계수 행렬
(corrmatrix <- cor(df[1:4]))
library(corrplot)
corrplot(cor(df[1:4]), method="circle")

library(caret)
set.seed(123) # 랜덤 시드 고정

#학습용:검증용 데이터 구분
idx_train <- createDataPartition(y=df$Species, p=0.8, list=FALSE)

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

#신경망 모형 생성(size: 은닉노드의 개수)
library(nnet) # 히든레이어의 개수: 1개
model <- nnet(Species ~ ., data=train, size=10) # input - hidden - output 노드수 with 가중치수
summary(model)

#신경망 모형에 대한 정보
names(model)

#최적의 가중치 집합
head(model$wts)

#신경망 모형의 시각화
library(devtools)
source_url('https://gist.githubusercontent.com/Peque/41a9e20d6687f2f3108d/raw/85e14f3a292e126f1454864427e3a189c2fe33f3/nnet_plot_update.r')
plot.nnet(model)

#신경망 모형의 검증(학습용 데이터)
pred <- predict(model, X_train, type="class")
table(y_train, pred)
mean(y_train == pred)

#신경망 모형의 검증(검증용 데이터)
pred <- predict(model, X_test, type="class")
table(y_test, pred)
mean(y_test == pred)