#시계열관련 라이브러리
library(TTR)
library(forecast)

#영국왕들의 수명 데이터
kings <- read.csv('c:/data/time/kings.dat', header=F)
kings

#숫자형 자료를 시계열자료로 변환
kings_ts <- ts(kings)
plot.ts(kings_ts)

#시계열 데이터를 이동평균(그래프를 부드럽게 표현하기 위한 방법)한 값을 생성
kings_sma3 <- SMA(kings_ts, n = 3) # 3차 이동평균(3년간의 평균)
kings_sma8 <- SMA(kings_ts, n = 8) # 8차 이동평균
kings_sma12 <- SMA(kings_ts, n = 12) # 12차 이동평균

#시각화
par(mfrow = c(2,2)) # 2행 2열 형식(그래프를 합치는 옵션)
plot.ts(kings_ts)
plot.ts(kings_sma3)
plot.ts(kings_sma8)
plot.ts(kings_sma12)

#1차 차분을 통해 데이터를 정상화
# 정상성(stationary): 모든 시점에 평균이 일정한 특성
# 차분(difference): 현시점 자료에서 전시점 자료를 빼는 것
kings_diff1 <- diff(kings_ts, differences=1)
kings_diff2 <- diff(kings_ts, differences=2)
kings_diff3 <- diff(kings_ts, differences=3)

#시각화
par(mfrow = c(2,2)) # 2행 2열 형식
plot.ts(kings_ts)
plot.ts(kings_diff1)
plot.ts(kings_diff2)
plot.ts(kings_diff3)

#1차 차분한 데이터로 ARIMA 모형 확인(acf와 pacf를 통해 적합한 arima 모형 결정)
# acf(자기상관함수)
acf(kings_diff1, lag.max = 20)

# pacf(부분자기상관함수)
pacf(kings_diff1, lag.max = 20)

#로그 후 차분한 자료가 안정적인 시계열인지 확인
library(tseries)
# k: 테스트 통계를 계산하기위한 지연 순서
adf.test(diff(log(kings_ts)), alternative="stationary", k=0)

#가장 적절한 arima 모델
auto.arima(ts(kings))

#auto.arima에서 확인한 값 적용
kings_arima <- arima(kings_ts, order=c(0,1,1))

#미래예측함수
kings_fcast <- forecast(kings_arima, h=5)
kings_fcast
plot(kings_fcast)

#acf(), pacf() 함수로 얻은 파라미터를 입력한 모형
kings_arima2 <- arima(kings_ts, order=c(3,1,1))
kings_arima2

kings_fcast <- forecast(kings_arima2, h=5)
kings_fcast
win.graph(); plot(kings_fcast)