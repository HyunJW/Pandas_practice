# 1단계 데이터 준비
setwd("C:/workspace/R/shiny")
library(sf)
load("./06_geodataframe/06_apt_price.rdata") # 실거래 자료
load("./07_map/07_kde_high.rdata") # 최고가 래스터 이미지
grid <- st_read("./01_code/sigun_grid/seoul.shp") # 서울시 그리드 파일

# 2단계 관심지역 그리드 찾기
library(tmap)
tmap_mode('view')
tm_shape(grid) + tm_borders() + tm_text("ID", col = "red") +
  # 래스터 이미지 그리기
  tm_shape(raster_high) + 
  # 래스터 이미지 색상 패턴 설정
  tm_raster(palette = c("blue", "green", "yellow", "red"), alpha = .4) +
  # 기본지도 설정
  tm_basemap(server = c("OpenStreetMap"))

# 3단계 전체 지역/관심 지역 저장
library(dplyr)
apt_price <- st_join(apt_price, grid, join = st_intersects) # 실거래 + 그리드 결합
apt_price <- apt_price %>% st_drop_geometry() # 실거래 데이터에서 공간 속성 지우기
all <- apt_price # 전체 지역 추출
sel <- apt_price %>% filter(ID == 81016) # 관심 지역 추출

# 저장
dir.create("08_chart") # 새로운 폴더 생성
save(all, file = "./08_chart/all.rdata")
save(sel, file = "./08_chart/sel.rdata")
rm(list = ls()) # 메모리 정리
