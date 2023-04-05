library(MASS)
head(Boston)
tail(Boston)

dim(Boston)

summary(Boston)

#산점도 행렬
pairs(Boston)

plot(medv ~ crim, data=Boston, main='범죄율과 주택가격의 관계', xlab='범죄율', ylab='주택가격')

#범죄율과 상관계수 행렬
(corrmatrix <- cor(Boston)[1,]) #범죄율이 높으면 주택가격은 떨어짐

#강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix > 0.5 | corrmatrix < -0.5]

#세율과의 상관계수 행렬
(corrmatrix <- cor(Boston)[10,]) #세율이 높으면 주택가격은 떨어짐

#강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix > 0.5 | corrmatrix < -0.5]

#CHAS: 찰스강의 경계에 위치한 경우는 1, 아니면 0
table(Boston$chas)

#최고가로 팔린 주택들
(seltown <- Boston[Boston$medv == max(Boston$medv),])

#최저가로 팔린 주택들
(seltown <- Boston[Boston$medv == min(Boston$medv),])

#다중회귀분석 모델 생성
(model <- lm(medv ~ . , data=Boston))

#분석결과 요약
summary(model)

#후진제거법
reduced <- step(model, direction='backward')

#최종결과 확인
summary(reduced)

#ols패키지의 전진선택법
#install.packages('olsrr')
library(olsrr)
#model2<-ols_step_forward_p(model)
model2<-ols_step_forward_p(model,details=TRUE)
model2

#ols패키지의 후진제거법
model3<-ols_step_backward_p(model,details=TRUE)
model3
