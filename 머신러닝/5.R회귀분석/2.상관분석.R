x <- c(0,1,4,9)
y <- c(1,2,3,4)
z <- c(0,5,7,9)
mean(x)
mean(y)
mean(z)

cor(x, y, method="pearson") #기본값
cor(x, y, method="spearman")

cor(y, z, method="pearson")
cor(y, z, method="spearman")

cor(x, z, method="pearson")
cor(x, z, method="spearman")

#담배값 인상이 흡연에 미치는 영향
x<-c(70,72,62,64,71,76,0,65,74,72)
y<-c(70,74,65,68,72,74,61,66,76,75)
cor.test(x, y, method="pearson")


df <- read.csv("c:/data/rides/rides.csv")
head(df)

#산점도
plot(df$overall~df$rides) # y~X

#공분산
cov(df$overall, df$rides)

cov(1:5, 2:6) #x, y가 같은 방향으로 증가하므로 양수
cov(1:5, rep(3,5)) #x의 변화에 y가 영향을 받지 않으므로 0
cov(1:5, 5:1) #x, y의 증가방향이 다르므로 음수
cov(c(10,20,30,40,50), 5:1) #변수의 단위에 영향을 크게 받음

#상관분석
cor(1:5, 5:1) 
cor(c(10,20,30,40,50), 5:1)

#피어슨 상관계수
cor(df$overall, df$rides, method='pearson')
#결측값 제외 후 계산 옵션추가
cor(df$overall, df$rides, use='complete.obs', method='pearson')

#상관계수 검정
cor.test(df$overall, df$rides, method='pearson', conf.level = 0.95)

#산점도 행렬
head(df[,4:8])
plot(df[,4:8])

#추세선(회귀선)
pairs(df[,4:8], panel=panel.smooth)

#산점도, 히스토그램, 상관계수 모두 출력
#install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(df[,4:8], histogram=TRUE, pch=19)

#결측값이 있는 경우(결측값이 있는 행 모두 삭제)
#df <- na.omit(df)

#상관계수 행렬
cor(df[,4:8])

#상관계수 플롯
#install.packages('corrplot')
library(corrplot)
X <- cor(df[,4:8])
corrplot(X)

#숫자로 출력
corrplot(X, method="number") 
#method: circle,square,ellipse,number,shade,color,pie
corrplot.mixed(X, lower='ellipse',upper='circle')

#계층적 군집의 결과에 따라 사각형 표시, addrect 군집개수
corrplot(X,order="hclust",addrect=3) #hclust: 계층적 군집순서로 정렬