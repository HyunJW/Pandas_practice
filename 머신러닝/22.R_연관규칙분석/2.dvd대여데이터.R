#dvd 대여 데이터
dvd <- read.csv("c:/data/basket/dvdtrans.csv")
head(dvd)
class(dvd)
str(dvd)

#거래아이디 1번의 대여 비디오 항목
dvd$Item[dvd$ID == 1]

#DVD별로 하나의 레코드로 기록된 구조를 거래 ID별로 하나의 레코드가 되도록 변환
dvd$Item
dvd$ID
dvd.list <- split(dvd$Item, dvd$ID)
dvd.list

#transaction 타입으로 변환
library(arules)
dvd.trans <- as(dvd.list, "transactions")
dvd.trans

#자세한 정보
summary(dvd.trans)
image(dvd.trans) # y축: 거래횟수, x축: 물품

#연관규칙의 생성
dvd.rules <- apriori(dvd.trans)

#상위 3개의 룰
as(head(sort(dvd.rules, by=c('confidence','support')), n=3), 'data.frame')

#count 기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(dvd.rules, decreasing=T, by="count")))

#연관규칙분석의 요약 정보
summary(dvd.rules)

#발견된 77개의 연관규칙을 확인
inspect(dvd.rules)

#최소 지지도를 0.2, 신뢰도를 0.6으로 설정한 모형
dvd.rules <- apriori(dvd.trans, parameter=list(support=0.2, confidence=0.6))
summary(dvd.rules)
inspect(dvd.rules)

#연관규칙의 시각화
library(arulesViz)
plot(dvd.rules, method = "graph")

#특정 상품[item] 서브셋 작성과 시각화
# 오른쪽 item이 Gladiator인 규칙만 서브셋으로 작성
rule1 <- subset(dvd.rules, rhs %in% 'Gladiator')
rule1
inspect(rule1)
plot(rule1, method="graph")

# 왼쪽 item이 Gladiator or Patriot인 규칙만 서브셋으로 작성
rule2 <- subset(dvd.rules, lhs %in% c('Gladiator', 'Patriot'))
rule2
inspect(rule2)
plot(rule2, method="graph")