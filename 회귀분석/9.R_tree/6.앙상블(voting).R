#앙상블 모형(voting)
library(party)

#bootstrap data 생성(순서만 다르고 같은 데이터)
data_boot1 <- iris[sample(1:nrow(iris), replace=T), ] # replace: 복원추출 가능여부
data_boot2 <- iris[sample(1:nrow(iris), replace=T), ]
data_boot3 <- iris[sample(1:nrow(iris), replace=T), ]
data_boot4 <- iris[sample(1:nrow(iris), replace=T), ]
data_boot5 <- iris[sample(1:nrow(iris), replace=T), ]

#모델링(샘플링 과정을 통해 5개의 모델생성)
tree1 <- ctree(Species ~ ., data_boot1)
tree2 <- ctree(Species ~ ., data_boot2)
tree3 <- ctree(Species ~ ., data_boot3)
tree4 <- ctree(Species ~ ., data_boot4)
tree5 <- ctree(Species ~ ., data_boot5)

win.graph()
plot(tree1)

#예측결과
pred1 <- predict(tree1, iris)
pred2 <- predict(tree2, iris)
pred3 <- predict(tree3, iris)
pred4 <- predict(tree4, iris)
pred5 <- predict(tree5, iris)

#실제값과 각 모델의 예측값으로 이루어진 데이터프레임생성
test <- data.frame(Species=iris$Species, pred1, pred2, pred3, pred4, pred5)
head(test, 10)

#각 모형의 결과를 취합해서 최종결과를 voting
myfunc <- function(x){
	result <- NULL
	for (i in 1:nrow(x)){
		xtab <- table(t(x[i, ]))
		print(xtab)
		# versicolr - 1 / virginica - 4 라면 다수결로 virginica로 채택
		rvalue <- names(sort(xtab, decreasing = T)[1])
		result <- c(result, rvalue)
	}
	return(result)
}

#투표확인
test$result <- myfunc(test[ , 2:6])

#오분류표
test$result <- as.factor(test$result)
confusionMatrix(test$result, test$Species)