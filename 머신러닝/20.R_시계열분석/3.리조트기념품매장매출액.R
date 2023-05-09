#시계열관련 라이브러리
library(TTR)
library(forecast)

#1987년 1월부터 1993년 12월까지 리조트 기념품매장 매출액 데이터
data <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
data

#숫자형 자료를 시계열자료로 변환
fancy <- ts(data, frequency=12, start=c(1987, 1))
fancy

#안정적인 시계열인지 확인
plot.ts(fancy)
# 분산이 증가하는 경향이 있음 => log 변환으로 분산 조정

#log변환 후 확인
fancy_log <- log(fancy)
plot.ts(fancy_log)

#1차 차분
fancy_diff <- diff(fancy_log, differences=1)
plot.ts(fancy_diff)
# 평균은 어느정도 일정하지만 특정 시기에 분산이 큼

#acf와 pacf를 통해 적합한 arima 모형 결정
# acf(자기상관함수)
acf(fancy_diff, lag.max = 100)

# pacf(부분자기상관함수)
pacf(fancy_diff, lag.max = 100)

# 절단점이 명확하지 않음 => auto.arima 함수 사용

#auto.arima 함수 사용
auto.arima(fancy) # ARIMA(1,1,1)(0,1,1)[12]
fancy_arima <- arima(fancy, order=c(1,1,1), seasonal=list(order=c(0,1,1), period=12))

#미래예측
fancy_fcast <- forecast(fancy_arima)
plot(fancy_fcast)