df <- read.csv("c:/data/iris/iris.csv")
head(df)
tail(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Name)

#Species 변수 타입 변경(int => Factor)
str(df)
df$Species <- as.factor(df$Species)
str(df)
head(df)
dim(df)
summary(df)

#상관계수 행렬
(corrmatrix <- cor(df[1:4]))
library(corrplot)
corrplot(cor(df[1:4]), method="circle")

#스케일링 전 박스플롯
library(reshape)
meltData <- melt(df[, -5])
boxplot(data=meltData, value~variable)

#데이터셋에서 특성별 최소값 계산
min_on_train = min(df[, -5])

#데이터셋에서 특성별 (최대값 - 최소값) 범위 계산
range_on_train = max(df[, -5] - min_on_train)

#min-max스케일링
X = (df[, -5] - min_on_train) / range_on_train
df_scaled = cbind(X, Species=df[, 5])
head(df_scaled)
meltData <- melt(df_scaled[, -5])
boxplot(data=meltData, value~variable)

#1. 최적의 군집수(k)를 설정하는 방법(엘보우 포인트)
result <- NULL
for (k in 1:10){
	result[[k]] <- kmeans(df_scaled[, -5], k)
}

#클러스터 내 총 제곱합
wss <- numeric(10)
for (k in 1:10){
	wss[k] <- result[[k]]$tot.withinss
}
plot(wss,type="l")

#2. 최적의 군집수(k)를 설정하는 방법(실루엣 포인트)
library("cluster")
avgsil <- numeric(10)
for (k in 2:10){
	si <- summary(silhouette(result[[k]]$cluster, dist(df_scaled[, -5])))
	avgsil[k] <- si$avg.width
}
max(avgsil)
plot(avgsil,type="l")

#factoextra 패키지를 이용하여 적절한 클러스터 개수를 결정하고 시각화
library(factoextra)
fviz_nbclust(df_scaled[, -5], FUN=kmeans, method="wss")
fviz_nbclust(df_scaled[, -5], FUN=kmeans, method="silhouette")
# 최적의 클러스터 수: 2, 하지만 실제 데이터가 3종류이므로 3개로 이후 실습

#산점도 행렬(클러스터가 3개일 경우)
plot(df_scaled[, -5], pch=result[[3]]$cluster, col=result[[3]]$cluster)

set.seed(123)

#모델 생성(군집수: 3)
model <- kmeans(df[, -5], centers=3)
model
model$centers # 중심좌표

#integer를 factor로 변환
df$cluster <- as.factor(model$cluster - 1)
df$cluster

#2,1,0을 0,1,2로 변경하는 함수
df
convert <- function(i){
	if (i == 0){
		return("2")
	} else if (i == 1){
		return("1")
 	} else if (i == 2){
		return("0")
	}
}
#각 샘플에 convert() 함수를 적용
result <- sapply(df$cluster, convert)
result

#오분류표
table(df$Species, result)

#예측정확도
mean(result == df$Species)