#맥주,빵,콜라,기저귀,달걀,우유 데이터 생성
x <- data.frame(beer=c(0,1,1,1,0), bread=c(1,1,0,1,1), cola=c(0,0,1,0,1), 
	diapers=c(0,1,1,1,1), eggs=c(0,1,0,0,0), milk=c(1,0,1,1,1))
x
class(x)

#transaction 타입으로 변환
library(arules)
trans <- as.matrix(x, "Transaction")
trans
class(trans)

#Apriori 알고리즘
rules1 <- apriori(trans, parameter=list(supp=0.2, conf=0.6, target='rules'))
rules1
summary(rules1)

#상위 3개의 규칙
as(head(sort(rules1, by=c('confidence','support')), n=3), 'data.frame')

#발견된 연관규칙 확인
inspect(sort(rules1))

#물품들 간의 연관성 그래프
library(arulesViz)
plot(rules1, method="graph")
# 원(노드): 규칙
# 원의 크기: support
# 원의 색상: lift - 진한 색상이면 양의 상관관계, 흐린 색상이면 음의 상관관계

#특정 상품[item] 서브셋 작성과 시각화
# 오른쪽 item이 diapers인 규칙만 서브셋으로 작성
rules2 <- subset(rules1, rhs %in% 'diapers')
rules2
inspect(rules2)
plot(rules2, method="graph")

# 왼쪽 item이 beer or cola인 규칙만 서브셋으로 작성
rules3 <- subset(rules1, lhs %in% c('beer', 'cola'))
rules3
inspect(sort(rules3, decreasing=T, by="count"))
plot(rules3, method="graph")