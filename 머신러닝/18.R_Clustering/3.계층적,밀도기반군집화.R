## 계층적 군집화
#임의의 벡터 생성
v1 <- c(1,3,6,10,18)

#거리행렬
d1 <- dist(v1)
d1

#거리행렬 모델(average: 평균기준, complete: 최장거리기준, single: 최단거리기준, median: 중앙값기준)
m1 <- hclust(d1, method='average')
m1

#덴드로그램 - 2개의 클러스터로 구분
plot(m1); rect.hclust(m1, k=2)

#덴드로그램 - 3개의 클러스터로 구분
plot(m1); rect.hclust(m1, k=3)

#붓꽃 데이터 로드
df <- read.csv("c:/data/iris/iris.csv")
head(df)

#필드 제거
library(dplyr)
df <- df %>% select(-Name)
df

#그래프 출력을 위해 40개만 선택
idx <- sample(1:nrow(df), 40)
iris_samp <- df[idx, ]

#스케일링 - 평균: 0, 표준편차: 1
iris.scaled <- scale(iris_samp[, -5])

#계층적 군집화 모델
iris.hclust <- hclust(dist(iris.scaled))
summary(iris.hclust)

#덴드로그램
plot(iris.hclust, hang=-1, labels=iris$Species[idx]) # hang: 라벨을 아래쪽으로 이동시킴
rect.hclust(iris.hclust, k=3)

#클러스터링 결과 확인 - 3개의 군집으로 클러스터링한 결과
groups <- cutree(iris.hclust, k=3)
groups

## 밀도기반 군집화
#밀도기반 군집화 모델 - 클러스터 수를 별도로 지정하지 않음
library(fpc)
iris2 <- df[-5]
ds <- dbscan(iris2, eps=0.42, MinPts=5) # eps: 중심점과의 거리, MinPts: 최소 샘플 개수

#클러스터링 결과값과 실제 라벨과의 비교표
table(ds$cluster, iris$Species)

#시각화 - o: outlier
plot(ds, iris2)

# 4행 1열의 그래프만 출력
plot(ds, iris2[c(1, 4)])

# 1행 2열의 그래프만 출력
plot(ds, iris2[c(2, 1)]) 

#fpc 패키지 시각화
plotcluster(iris2, ds$cluster) # 0: outlier(밀도 조건에 맞지 않는 샘플들)
