#pima indian 당뇨병 데이터셋
df<-read.csv("c:/data/pima/data.csv")
head(df)
dim(df)

#불균형 데이터셋
tbl<-table(df$outcome)
win.graph()
barplot(tbl, beside=TRUE, legend=TRUE, col=rainbow(2))

#언더샘플링
library(ROSE)
df_samp <- ovun.sample(outcome ~ ., data=df, seed=1, method="under", N=268*2)$data
tbl<-table(df_samp$outcome)
tbl

X<-df_samp[, -9]
y<-df_samp[, 9]

#랜덤포레스트 모형
#install.packages('superml')
library(superml)

rf <- RFTrainer$new() # 클래스이름$new(): 인스턴스 생성하는 문법
gst <-GridSearchCV$new(trainer = rf, 
	parameters=list(n_estimators=c(10,50,100), max_depth=c(2,5,10)), 
		n_folds = 3, scoring=c('accuracy','auc'))
gst$fit(df_samp,'outcome')
gst$best_iteration() # 트리개수:100, max_depth: 5, 정확도: 75%, acu: 0.75

