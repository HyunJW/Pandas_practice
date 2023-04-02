df <- read.csv("c:/data/rides/rides.csv")
head(df)

#범주형 변수 -> 팩터자료형으로 변환
df$weekend <- as.factor(df$weekend)
df$weekend

#install.packages("reshape")
library(reshape)
meltData <- melt(df[2:7]) #melt: 필드 1개를 여러행으로 만드는 함수(차원변경)
win.graph()
boxplot(data=meltData, value~variable)

#스케일링 - 평균 0, 표준편차 1
df_scaled <- as.data.frame(scale(df[2:7]))
df_scaled

meltData <- melt(df_scaled)
win.graph()
boxplot(data=meltData, value~variable)

#install.packages('caret')
library(caret)
meltData <- melt(df[2:7])
win.graph()
boxplot(data=meltData, value~variable)

#스케일링 - 평균 0, 표준편차 1
prep <- preProcess(df[2:7], c("center", "scale"))
df_scaled2 <- predict(prep, df[2:7])
head(df_scaled2)
meltData <- melt(df_scaled2)
win.graph()
boxplot(data=meltData, value~variable)

#range - 0~1 정규화
prep <- preProcess(df[2:7], c("range"))
df_scaled3 <- predict(prep, df[2:7])
head(df_scaled3)
meltData <- melt(df_scaled3)
win.graph()
boxplot(data=meltData, value~variable)


