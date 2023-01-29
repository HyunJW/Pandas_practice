# 1단계 데이터 불러오기
setwd("C:/workspace/R/shiny")
load("./06_geodataframe/06_apt_price.rdata")
library(sf)
grid <- st_read("./01_code/sigun_grid/seoul.shp")

# 2단계 지역별 평균가격 구하기
# 실거래가와 데이터 결합
apt_price <- st_join(apt_price, grid, join = st_intersects)

# 그리드별 평균 가격
kde_high <- aggregate(apt_price$py, by=list(apt_price$ID), mean)
colnames(kde_high) <- c("ID", "avg_price") # 컬럼명 변경
head(kde_high, 2)

# 3단계 kde_high와 grid를 합쳐서 지도에 표시
# ID기준으로 결합
kde_high <- merge(grid, kde_high, by = 'ID') 
head(kde_high, 2)
library(ggplot2)
library(dplyr)

# 그래프 시각화
kde_high %>% ggplot(aes(fill = avg_price)) + 
  geom_sf() + 
  scale_fill_gradient(low = "white", high = "red")

# 4단계 지도 경계 그리기
library(sp)
kde_high_sp <- as(st_geometry(kde_high), "Spatial") # sf형을 sp형으로 변환

# 그리드 중심 x, y좌표 추출
x <- coordinates(kde_high_sp)[, 1]
y <- coordinates(kde_high_sp)[, 2]

# 4-1. 기준 경계 설정
l1 <- bbox(kde_high_sp)[1,1] - (bbox(kde_high_sp)[1,1] * 0.0001)
l2 <- bbox(kde_high_sp)[1,2] + (bbox(kde_high_sp)[1,2] * 0.0001)
l3 <- bbox(kde_high_sp)[2,1] - (bbox(kde_high_sp)[2,1] * 0.0001)
l4 <- bbox(kde_high_sp)[2,2] + (bbox(kde_high_sp)[2,2] * 0.0001)

# 4-2. 지도 경계 그리기
#install.packages("spatstat")
library(spatstat)
win <- owin(xrange = c(l1, l2), yrange = c(l3, l4))
plot(win) # 지도 경계선 확인
rm(list = c("kde_high_sp", "apt_price", "l1", "l2", "l3", "l4")) # 변수 정리

# 경계 위에 좌표값 표시
p <- ppp(x, y, window = win)

# 커널 밀도 함수로 변환
d <- density.ppp(p, weights = kde_high$avg_price,
                 sigma = bw.diggle(p),
                 kernel = "gaussian")
plot(d) # 밀도 그래프 확인
rm(list = c("x", "y", "win", "p")) # 변수 정리

# 5단계 래스터 이미지로 변환
d[d < quantile(d)[4] + (quantile(d)[4] * 0.1)] <- NA # 노이즈 제거
library(raster)
raster_high <- raster(d) # 래스터 변환
plot(raster_high) # 노이즈 제거 확인

# 6단계 불필요한 부분 자르기
bnd <- st_read("./01_code/sigun_bnd/seoul.shp") # 서울시 경계선 불러오기
raster_high <- crop(raster_high, extent(bnd))
crs(raster_high) <- sp::CRS("+proj=longlat +datum=WGS84 
                            +no_defs +ellps=WGS84 + towgs84=0,0,0") # 좌표계 정의
plot(raster_high) # 지도 확인
plot(bnd, col=NA, border = "red", add=T)

# 7단계 지도 그리기
library(rgdal)
library(leaflet)
leaflet() %>% 
  # 기본지도 불러오기
  addProviderTiles(providers$CartoDB.Positron) %>% 
  # 서울시 경계선 불러오기
  addPolygons(data = bnd, weight = 2, color = "red", fill = NA) %>% 
  # 래스터 이미지 불러오기
  addRasterImage(raster_high,
                 colors = colorNumeric(c("blue", "green", "yellow", "red"),
                                       values(raster_high), 
                                       na.color = "transparent"), opacity = 0.4)

# 8단계 저장하기
dir.create("07_map") # 새로운 폴더 생성
save(raster_high, file = "./07_map/07_kde_high.rdata") # 최고가 래스터 저장
rm(list = ls()) # 메모리 정리
