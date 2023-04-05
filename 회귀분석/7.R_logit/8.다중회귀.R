#R에 기본적으로 포함되는 데이터셋 목록
data()
head(attitude)
tail(attitude)

#다중회귀분석 모델 생성
model <- lm(rating ~ ., data=attitude)
model

#분석결과 요약
summary(model)

#후진제거법
reduced <- step(model, direction='backward')

#최종결과 확인
summary(reduced)

