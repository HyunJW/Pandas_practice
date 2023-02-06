# 1단계 데이터 불러오기
setwd("C:/workspace/R/shiny")
load("./06_geodataframe/06_apt_price.rdata") # 실거래 자료
load("./07_map/07_kde_high.rdata") # 최고가 래스터 이미지
load("./07_map/07_kde_hot.rdata") # 급등지 래스터 이미지

library(sf)
bnd <- st_read("./01_code/sigun_bnd/seoul.shp") # 서울시 경계선
grid <- st_read("./01_code/sigun_grid/seoul.shp") # 서울시 그리드 파일

# 2단계 마커 클러스터링 옵션 설정
# 2-1. 이상치 설정
pcnt_10 <- as.numeric(quantile(apt_price$py, 
                               probs = seq(.1, .9, by = .1))[1]) # 하위 10%
pcnt_90 <- as.numeric(quantile(apt_price$py, 
                               probs = seq(.1, .9, by = .1))[9]) # 상위 10%

# 2-2. 마커 클러스터링 함수
load("./01_code/circle_marker/circle_marker.rdata") # 마커 클러스터링 함수 등록
circle.colors <- sample(x=c("red", "green", "blue"), 
                        size = 1000, replace = TRUE) # 마커 클러스터링 생상 설정

# 3단계 마커 클러스터링 시각화
library(purrr)
library(leaflet)
leaflet() %>% 
  # 오픈 스트리트 맵 로드
  addTiles() %>% 
  # 서울시 경계선
  addPolygons(data = bnd, weight = 2, color = "red", fill = NA) %>% 
  # 최고가 레스터 이미지
  addRasterImage(raster_high,
                 colors = colorNumeric(c("blue", "green", "yellow", "red"),
                                       values(raster_high), na.color = "transparent"),
                 opacity = 0.4, group = "2021 최고가") %>% 
  # 급등지 레스터 이미지
  addRasterImage(raster_hot,
                 colors = colorNumeric(c("blue", "green", "yellow", "red"),
                                       values(raster_hot), na.color = "transparent"),
                 opacity = 0.4, group = "2021 급등지") %>% 
  # 최고가/급등지 선택 옵션 추가
  addLayersControl(baseGroups = c("2021 최고가", "2021 급등지"),
                   options = layersControlOptions(collapse = F)) %>% 
  # 마커 클러스터링
  addCircleMarkers(data = apt_price, 
                   lng = unlist(map(apt_price$geometry, 1)),
                   lat = unlist(map(apt_price$geometry, 2)),
                   radius = 10, stroke = F, 
                   fillOpacity = 0.6, fillColor = circle.colors,
                   weight = apt_price$py,
                   clusterOptions = markerClusterOptions(iconCreateFunction=JS(avg.formula)))

rm(list = ls()) # 메모리 정리
