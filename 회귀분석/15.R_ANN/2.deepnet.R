#install.packages('deepnet')
library(deepnet) # 은닉층을 2개 이상 만들 수 있음

#and 문제
input <- matrix(c(0, 0, 1, 1, 0, 1, 0, 1), ncol=2) # 4행 2열의 행렬
input
output <- matrix(c(0, 0, 0, 1), ncol=1) # 4행 1열의 행렬

#신경망 학습(input - hidden1 - hidden2 - output)
nn <- nn.train(input, output, hidden=c(2))
nn.predict(nn, input)

#학습 횟수를 증가시켜 다시 학습
nn <- nn.train(input, output, hidden=c(2), numepochs=1000)
nn.predict(nn, input)

#학습률을 높여서 다시 학습(학습률 기본값: 0.8)
nn <- nn.train(input, output, hidden=c(2), learningrate=10, numepochs=10000)
nn.predict(nn, input)

#or 문제
input <- matrix(c(0, 0, 1, 1, 0, 1, 0, 1), ncol=2)
input
output <- matrix(c(0, 1, 1, 1), ncol=1)

#학습
nn <- nn.train(input, output, hidden=c(2), learningrate=10, numepochs=1000)
nn.predict(nn, input)

#xor 문제
input <- matrix(c(0, 0, 1, 1, 0, 1, 0, 1), ncol=2)
input
output <- matrix(c(0, 1, 1, 0), ncol=1)

#학습
nn <- nn.train(input, output, hidden=c(2), learningrate=10, numepochs=10000)
nn.predict(nn, input)