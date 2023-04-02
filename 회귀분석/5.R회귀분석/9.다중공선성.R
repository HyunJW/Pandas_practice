library(car)
#미국 미니애폴리스 지역의 총인구, 백인비율, 흑인비율, 외국태생, 가계소득, 빈곤, 대학졸업비율을 추정한 데이터셋
df <- MplsDemo
head(df)

#그래프
win.graph()
plot(df[,-1])

#독립변수들의 상관계수
cor(df[,2:7])

library(corrplot)
win.graph()
corrplot(cor(df[,2:7]), method='number')

model1 <- lm(collegeGrad ~ . -neighborhood, data=df)
summary(model1)

#white 변수를 제거한 모형
model2 <- lm(collegeGrad ~ . -neighborhood -white, data=df)
summary(model2)

model <- lm(population~.-collegeGrad-neighborhood,data=df)
print(paste('population의 VIF :', (1-summary(model)$r.squared)^{-1}))

#다중공선성이 매우 높은 변수
model <- lm(white ~ . -collegeGrad-neighborhood,data=df)
print(paste('white의 VIF :', (1-summary(model)$r.squared)^{-1}))

model <- lm(black ~ . -collegeGrad-neighborhood,data=df)
print(paste('black의 VIF :', (1-summary(model)$r.squared)^{-1}))

model <- lm(foreignBorn ~ . -collegeGrad-neighborhood,data=df)
print(paste('foreignBorn의 VIF :', (1-summary(model)$r.squared)^{-1}))

model <- lm(hhIncome ~ . -collegeGrad-neighborhood,data=df)
print(paste('hhIncome의 VIF :', (1-summary(model)$r.squared)^{-1}))

model <- lm(poverty ~ . -collegeGrad-neighborhood,data=df)
print(paste('poverty의 VIF :', (1-summary(model)$r.squared)^{-1}))

#다중공선성을 계산해주는 함수
vif(model1)

#다중공선성이 높은 white변수 제거
model2 <- lm(collegeGrad ~ . -neighborhood -white, data=df)
summary(model2)
vif(model2) #vif수치가 많이 낮아졌고, 특히 black의 수치도 많이 낮아짐



