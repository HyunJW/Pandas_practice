df<-read.csv("c:/data/rides/rides.csv")
head(df)
#install.packages('car')
library(car)
#회귀분석 모형
model <- lm(overall~num.child + distance + rides + games + wait + clean, data=df)
summary(model)

#아웃라이어 확인
outlierTest(model) #184번 샘플 발견

#184번 샘플 제거한 모형
model2 <- lm(overall~num.child + distance + rides + games + wait + clean, data=df[-184,])
model2
summary(model2)

#영향 관측치 확인
win.graph()
influencePlot(model) #184,103,227,367,373번 샘플 발견

#184,103,227,367,373번 샘플 제거한 모형
model3 <- lm(overall~num.child + distance + 
rides + games + wait + clean, data=df[c(-184,-103,-227,-367,-373),])
model3
summary(model3)

