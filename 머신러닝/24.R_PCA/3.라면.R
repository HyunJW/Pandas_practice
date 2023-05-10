#라면 데이터 로드
data <- read.table("c:/data/noodle/noodle.txt" ,header=T, fileEncoding='euc-kr')
data

summary(data)

#상관계수
cor(data)

#주성분분석
p1 <- prcomp(data, scale=T) # scale=T: 데이터 표준화 처리 포함
p1 # PC1기준으로 가장 큰 영향을 미치는 변수: 국물

#주성분 개수 파악
plot(p1, type="l")
summary(p1)

#주성분점수
predict(p1)

#시각화
biplot(p1)