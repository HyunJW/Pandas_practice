# 1단계 데이터 불러오기
setwd("C:/workspace/R/shiny")
load("./04_pre_process/04_pre_process.rdata") # 주소 정보 불러오기
load("./05_geocoding/05_geocoding.rdata") # 좌표 불러오기

# 2단계 주소와 좌표 결합
library(dplyr)
apt_price <- left_join(apt_price, juso_geocoding, 
                       by = c("juso_jibun" = "apt_juso")) # 결합
apt_price <- na.omit(apt_price) # 결측치 제거

# 3단계 Geo Dataframe 생성
library(sp)
library(sf)
coordinates(apt_price) <- ~coord_x + coord_y # 좌표값 할당
proj4string(apt_price) <- "+proj=longlat +datum=WGS84 +no_defs" # 좌표계(CRS) 정의
apt_price <- st_as_sf(apt_price) # sp형에서 sf형으로 변환

# 3-1. Geo Dataframe 시각화
plot(apt_price$geometry, axes = T, pch = 1) # plot 그리기
library(leaflet) # 지도그리기 라이브러리
leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(data = apt_price[1:1000, ], label = ~apt_nm) # 1000개 그리기

# 3-2. Geo Dataframe 저장
dir.create("06_geodataframe") # 새로운 폴더 생성
save(apt_price, file = "./06_geodataframe/06_apt_price.rdata") # rdata 저장
write.csv(apt_price, "./06_geodataframe/06_apt_price.csv") # csv 저장
