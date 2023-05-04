flour <- c( 3, -2, -1, 0, 1, -2)
diet <- c(-4, 1, -3, -5, -2, -8)
total <- c(flour, diet)
hist(total)
plot(density(flour), xlim=c(-8,8), ylim=c(0,0.2), lty=1, ann=F) #ann: 축의 라벨표시
par(new=T) #2개의 그래프를 하나에 출력
plot(density(diet), xlim=c(-8,8), ylim=c(0,0.2), lty=2)
legend(4,0.2,c("flour", "diet"), lty=1:2, ncol=1)

#히스토그램 위에 밀도그래프를 선으로 표시
plot(density(iris$Sepal.Width))
hist(iris$Sepal.Width, freq=F)
lines(density(iris$Sepal.Width))

#밀도 그래프에 rug함수를 이용해서 실제 데이터 위치를 x축 위에 표시
plot(density(iris$Sepal.Width))
rug(jitter(iris$Sepal.Width))

#같은 값을 가지는 데이터가 같은좌표에 겹쳐서 표시되지 않도록 약간의 노이즈 추가하는 방법
iris$Sepal.Width
jitter(iris$Sepal.Width) 

#상자수염그림
boxplot(flour, diet, names=c("flour", "diet"))

#기초통계량 계산
sum(total) #합계
quantile(total) #분위수
fivenum(total) #min, 1Q, median, 3Q, max
cor(flour, diet) #상관계수
summary(total)

#커피 판매량 데이터
cafe <- read.csv("c:/data/cafe/data.csv")

#자료 정렬
sort(cafe$Coffees)
#정렬된 값 중 첫번째 값
sort(cafe$Coffees)[1]

#내림차순 정렬
sort(cafe$Coffees, decreasing=TRUE)
#내림차순 정렬된 값 중 첫번째 값
sort(cafe$Coffees, decreasing=TRUE)[1]

#최소값
min(cafe$Coffees)
#최대값
max(cafe$Coffees)

#seq(시작, 끝, 간격), right=F : 마지막 값은 선택하지 않음
table(cut(cafe$Coffees, breaks=seq(0, 50, by=10), right=F))

#줄기-잎 그림
ca <- cafe$Coffees
stem(ca)

#각 잔별 빈도수
table(ca)
max(table(ca)) #최빈값

#평균값 계산
mean(ca)

#ca변수에 결측값 결합
ca <- c(ca, NA)
tail(ca, n=5)

#결측값이 있을 때 평균계산
mean(ca) #NA 출력
mean(ca, na.rm=T)

#중앙값
ca <- cafe$Coffees
median(ca)

#임의의 키 데이터 생성
height <- c(164, 166, 168, 170, 172, 174, 176)

#평균값
mean(height)

#중앙값
median(height)

#편차: 관찰값과 평균의 차이
height.dev <- height - mean(height)
height.dev
sum(height.dev) #모든 편차값의 합: 0

#분산: 편차 제곱의 평균
var(height)

#표준편차
sd(height)

#변동계수(커피와 주스의 판매량 변동폭 비교)
coffee <- cafe$Coffees
juice <- cafe$Juices

#커피 판매량 평균값
(coffee.m <- mean(coffee))

#커피 판매량 표준편차
(coffee.sd <- sd(coffee))

#주스 판매량 평균값
(juice.m <- mean(juice))

#주스 판매량 표준편차
(juice.sd <- sd(juice))

#커피 판매량의 변동계수: 표준편차를 평균으로 나눈 값
(coffee.cv <- round(coffee.sd / coffee.m, 3))

#주스 판매량의 변동계수
(juice.cv <- round(juice.sd / juice.m, 3))

#사분위수 범위: Q3 - Q1
IQR(coffee)
boxplot(coffee, main="커피 판매량에 대한 상자도표")

d <- matrix(c(coffee, juice), 47, 2)
d
boxplot(d, names=c('coffee', 'juice'))
boxplot(coffee, juice, names=c('커피판매량','주스판매량')) #x축의 라벨
