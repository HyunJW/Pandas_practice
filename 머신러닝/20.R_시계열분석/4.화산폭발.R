#시계열관련 라이브러리
library(TTR)
library(forecast)

#1500년부터 1969년까지 화산폭발 먼지량 데이터
data <- scan("http://robjhyndman.com/tsdldata/annual/dvi.dat", skip=1)

#숫자형 자료를 시계열자료로 변환
dust <- ts(data, start=c(1500))
dust

#안정적인 시계열인지 확인
plot.ts(dust)
# 평균과 분산이 어느정도 일정 => 차분하지 않음

#acf와 pacf를 통해 적합한 arima 모형 결정
# acf(자기상관함수)
acf(dust, lag.max=20) # lag = 4 => MA(3)

# pacf(부분자기상관함수)
pacf(dust, lag.max=20) # lag 3부터 신뢰구간 안에 존재 => AR(2)

#auto.arima 함수 사용
auto.arima(dust) # ARIMA(1,0,2)

#모델생성
# d = 0 인 경우 AR(2) / MA(3) / ARIMA(1,0,2) 중 선택해서 적용 가능
# 파라미터가 가장 적은 모형을 선택하는 것을 추천 => AR(2) 적용 => c(2,0,0)

# AR(2)
dust_arima <- arima(dust, order=c(2,0,0))
dust_fcast <- forecast(dust_arima, h=30)
plot(dust_fcast)

# MA(3)
dust_arima <- arima(dust, order=c(0,0,3))
dust_fcast <- forecast(dust_arima, h=30)
plot(dust_fcast)

# ARIMA(1,0,2)
# AR(2)
dust_arima <- arima(dust, order=c(1,0,2))
dust_fcast <- forecast(dust_arima, h=30)
plot(dust_fcast)