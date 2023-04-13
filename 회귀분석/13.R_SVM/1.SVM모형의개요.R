#실습용 데이터 생성
set.seed(100)
x <- matrix(rnorm(40), 20, 2) # rnorm(n): 정규분포 난수 n개 생성
y <- rep(c(-1, 1), c(10, 10)) # rep: 반복함수

x[y == 1, ] <- x[y == 1, ] + 1 

win.graph()
plot(x, col = y + 3, pch = 19)

#SVM 모형
library(e1071)
dat <- data.frame(x, y=as.factor(y))
# kernel='linear'/'poly': 선형/비선형 판별함수  scale=F: 스케일링을 하지 않음
svmfit <- svm(y ~ ., data=dat, kernel='linear', cost=10, scale=F)
svmfit
win.graph()
plot(svmfit, dat) # 분류 그래프

make.grid <- function(x, n=75){
	grange <- apply(x, 2, range) # 1/2: x값의 가로/세로 방향 범위
	x1 <- seq(from=grange[1, 1], to=grange[2, 1], length=n)
	x2 <- seq(from=grange[1, 2], to=grange[2, 2], length=n)
	expand.grid(X1=x1, X2=x2) # x1, x2의 모든 조합
}
xgrid <- make.grid(x)
xgrid[1:10, ]

ygrid <- predict(svmfit, xgrid)
ygrid

win.graph()
plot(xgrid, col=c('red', 'blue')[as.numeric(ygrid)], pch=20, cex=.2)
points(x, col=y + 3, pch=19) # 샘플
points(x[svmfit$index, ], pch=5, cex=2) # 서포트 벡터
