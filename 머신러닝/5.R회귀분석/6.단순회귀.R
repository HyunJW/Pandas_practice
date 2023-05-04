#20명의 신장과 체중 데이터
height <- c(179,166,175,172,173,167,169,172,172,179,161,174,
166,176,182,175,177,167,176,177)
weight <- c(113,84,99,103,102,83,85,113,84,99,51,90,77,112,
150,128,133,85,112,85)
plot(height,weight)

#상관계수
cor(height, weight)

#기울기와 절편
slope <- cor(height, weight) * (sd(weight) / sd(height))
intercept <- mean(weight) - (slope * mean(height))
slope
intercept

#단순회귀분석 모델 생성
df <- data.frame(height, weight)
df
model <- lm(weight~height, data=df)
model

#키가 180인 사람의 체중 예측
model$coefficients[[2]]*180 + model$coefficients[[1]]

summary(model)
plot(height, weight)
abline(model, col='red')

#체중의 실제값과 예측값 비교
weight
pred <- model$coefficients[[2]]*height + model$coefficients[[1]]
pred

sum(weight - pred) #오차의 합계: 0

err <- (weight - pred)^2
sum(err) #오차의 제곱합
sum(err/length(weight)) #평균제곱오차

#최적의 기울기 구하기(여기서는 전체가 아닌 1개의 데이터만 사용)
x <- height[1]
y <- weight[1]
w <- seq(-1,2.3,by=0.0001) #가중치
pred <- x*w #예측값
err <- (y - pred)^2 #제곱오차
plot(err)
min(err) #최소오차
i <- which.min(err) #which.min: np.argmin과 비슷함
paste('최적의 기울기=',w[i])

#최적의 편향 구하기
x<-height[1]
y<-weight[1]
w<-0.6313 #가중치
b<-seq(-3.2,3.2,by=0.0001) #편향
#b<-seq(-1,3.2,by=0.1) #편향
pred<-x*w + b #예측값
err<-(y-pred)^2 #제곱오차
plot(err)
min(err) #최소오차
i<-which.min(err)
paste('최적의 편향=',b[i])

#계산을 통해 얻은 w,b를 적용한 회귀식
x<-height[1]
y<-weight[1]
w<- 0.6313
b<- -0.00269999999999992
pred<-x*w + b
pred
