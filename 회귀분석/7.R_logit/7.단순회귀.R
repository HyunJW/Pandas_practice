regression <- read.csv('c:/data/regression/regression.csv', fileEncoding='utf-8')
head(regression)
tail(regression)

summary(regression)
hist(regression$height)
hist(regression$weight)
plot(regression$weight ~ regression$height, main="평균키와 몸무게", xlab="Height", ylab="Weight")

#상관계수
cor(regression$height, regression$weight)

#키와 몸무게의 관계(독립변수: 신장, 종속변수: 체중, 귀무가설: 신장은 체중에 영향을 주지 않을 것이다.)
r <- lm(regression$weight ~ regression$height)
plot(regression$weight ~ regression$height, main="평균키와 몸무게", xlab="Height", ylab="Weight")
abline(r, col='red')

#키가 180인 사람의 체중 예측
r$coefficients[[2]]*180 + r$coefficients[[1]]

#분석결과 요약: 키와 몸무게는 상관관계가 있다.
summary(r)

