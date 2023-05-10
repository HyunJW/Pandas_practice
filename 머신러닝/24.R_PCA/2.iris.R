head(iris)

#다중공선성을 보기 위해 상관계수 확인
cor(iris[1:4])

#표준화 작업을 위한 로그 변환
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]

#주성분 분석
ir.pca <- prcomp(log.ir, center=T, scale=T)
ir.pca

#그래프를 통한 주성분 개수 파악
plot(ir.pca, type="l")

#summary를 통한 주성분 개수 파악
summary(ir.pca)

#행렬연산
PRC <- as.matrix(log.ir) %*% ir.pca$rotation # %*%: 행렬 곱셈, ir.pca$rotaion: 선형계수
head(PRC)

#회귀분석을 하기 위해 y변수를 합치고 factor 처리 후 label 추가
train1 <- cbind(ir.species, as.data.frame(PRC))
train1[, 1] <- as.factor(train1[, 1])
colnames(train1)[1] <- "label"
head(train1)

#주성분 분석을 통해 선택한 PC1과 PC2 2개의 변수를 사용하여 회귀분석
fit1 <- lm(label ~ PC1 + PC2, data=train1)

#회귀 모델의 예측력 확인
fit1_pred <- predict(fit1, newdata=train1)

#실제값과 비교
b <- round(fit1_pred)
b[b == 0 | b == 1] <- "setosa"
b[b == 2]<-"versicolor"
b[b == 3]<-"virginica"
a <- ir.species
table(b, a)
mean(b == a)
