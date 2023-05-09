#시계열관련 라이브러리
library(TTR)
library(forecast)

#1946년 1월부터 1959년 12월까지의 뉴욕의 월별 출생자수
data <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
data

#숫자형 자료를 시계열자료로 변환
birth <- ts(data, frequency=12, start=c(1946, 1)) # start: 1946년 1월부터 시작
birth

#안정적인 시계열인지 확인
plot.ts(birth, main="뉴욕 월별 출생자 수")

#데이터 분해 - trend, seasonal, random 데이터 추세 확인
birth_comp <- decompose(birth)
plot(birth_comp) # trend(증가추세), seasonal(계절성 요인)이 존재

birth_comp$trend
birth_comp$seasonal

#시계열 데이터에서 계절성 요인을 제거한 데이터
birth_adjusted <- birth - birth_comp$seasonal
plot.ts(birth_adjusted, main="birth - seasonal factor")

#차분을 통해 정상성 확인
birth_diff1 <- diff(birth_adjusted, differences=1)
plot.ts(birth_diff1, main="1차 차분") 
# 1차 차분 후에도 분산의 변동성이 큰 상태

# acf(자기상관함수)
acf(birth_diff1, lag.max = 20)

# pacf(부분자기상관함수)
pacf(birth_diff1, lag.max = 20)
# 절단값이 명확하지 않아 ARIMA 모형 확정이 어려운 상태

#auto.arima 함수 사용
auto.arima(birth) # ARIMA(2,1,2)(1,1,1)[12]
birth_arima <- arima(birth, order=c(2,1,2), seasonal=list(order=c(1,1,1), period=12))
birth_arima

#미래예측
birth_fcast <- forecast(birth_arima)
birth_fcast
plot(birth_fcast, main="Forecasts 1960 & 1961")