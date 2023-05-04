df <- read.csv('c:/data/rides/rides.csv')
head(df)

#모델 생성
model <- lm(overall ~ num.child + distance + rides + games + wait + clean, data=df)
summary(model)

#모델 저장
save(model, file='c:/data/R/rides_regress.model')

#작업중인 모든 변수 제거
rm(list=ls())

#모델 불러오기
load('c:/data/R/rides_regress.model')
ls() #현재 저장된 변수 목록
summary(model)