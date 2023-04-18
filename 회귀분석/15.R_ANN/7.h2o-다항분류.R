#install.packages('RCurl')
#install.packages('h2o')
#h2o(로컬)에 접속
library(RCurl)
library(h2o)
localH2O = h2o.init()

#데이터 로드
train <- h2o.importFile("c:/data/iris/iris.csv")
test <- h2o.importFile("c:/data/iris/iris.csv")
X <- names(train)[1:4]
y <- names(train)[6]
train[, y] <- as.factor(train[, y])
test[, y] <- as.factor(test[, y])

#h2o 타입으로 변환
iris_h2o <- as.h2o(iris, destination_frame="iris_h2o")
h2o.ls() # h2o에서 사용할 수 있는 변수목록
class(iris_h2o) # 자료형 확인
head(iris_h2o)

n_rows <- nrow(iris_h2o) # 샘플수
n_cols <- ncol(iris_h2o) # 변수
paste("행의 개수:", n_rows)

#샘플링
set.seed(123) # 랜덤 시드 고정
train_idx <- sample(1:nrow(iris), size=0.8 * nrow(iris), replace=FALSE)
train_iris <- iris[train_idx, ]
test_iris <- iris[-train_idx, ]

#품종별 비율
with(train_iris, prop.table(table(Species)))
with(test_iris, prop.table(table(Species)))

#h2o 타입으로 변환
train_iris_h2o <- as.h2o(train_iris, "train_iris_h2o")
test_iris_h2o <- as.h2o(test_iris, "test_iris_h2o")
target <- "Species"

#독립변수들의 이름
features <- names(train_iris)[!names(train_iris) %in% target]
features

#로지스틱 회귀분석(다분류)
glm_model <- h2o.glm(x=features, y=target, training_frame=train_iris_h2o, 
	model_id="glm_model", family="multinomial")
summary(glm_model)
pred_iris_glm <- as.data.frame(h2o.predict(glm_model, newdata=test_iris_h2o))

#예측값
test_iris$pred_glm <- pred_iris_glm$predict

#오분류표
with(test_iris, table(Species, pred_glm, dnn=c("Real", "Predict")))

#랜덤 포레스트 모형
rf_model <- h2o.randomForest(x=features, y=target, training_frame=train_iris_h2o, 
	model_id="rf_model", ntrees=100)
summary(rf_model)
pred_iris_rf <- as.data.frame(h2o.predict(rf_model, newdata=test_iris_h2o))

#예측값
test_iris$pred_rf <- pred_iris_rf$predict

#오분류표
with(test_iris, table(Species, pred_rf, dnn=c("Real", "Predict")))