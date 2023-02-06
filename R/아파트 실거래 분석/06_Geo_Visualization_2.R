# 1단계 데이터 불러오기
setwd("C:/workspace/R/shiny")
load("./06_geodataframe/06_apt_price.rdata")
grid <- st_read("./01_code/sigun_grid/seoul.shp")
# 실거래가와 데이터 결합
apt_price <- st_join(apt_price, grid, join = st_intersects)
head(apt_price, 2)

# 2단계 21년 상반기/하반기 데이터 세트 만들기
# 상반기 데이터
kde_before <- subset(apt_price, ymd < "2021-07-01") # 21년 상반기 데이터
kde_before <- aggregate(kde_before$py, by=list(kde_before$ID), mean) # 평균가격
colnames(kde_before) <- c("ID", "before") # 컬럼명 변경

# 하반기 데이터
kde_after <- subset(apt_price, ymd >= "2021-07-01") # 21년 하반기 데이터
kde_after <- aggregate(kde_after$py, by=list(kde_after$ID), mean) # 평균가격
colnames(kde_after) <- c("ID", "after") # 컬럼명 변경

# 상반기, 하반기 데이터 결합
kde_diff <- merge(kde_before, kde_after, by="ID")
kde_diff$diff <- 
  round(((kde_diff$after - kde_diff$before) / kde_diff$before) * 100, 0) # 변화율 계산
head(kde_diff, 2) # 변화율 확인

# 3단계 가격이 오른 지역 찾기
kde_diff <- kde_diff[kde_diff$diff > 0, ] # 사응 지역만 추출
kde_hot <- merge(grid, kde_diff, by="ID") # 그리드에 상승 지역 데이터 결합
library(sf)
library(ggplot2)
library(dplyr)
# 그래프 시각화
kde_hot %>% ggplot(aes(fill = diff)) + 
  geom_sf() + 
  scale_fill_gradient(low = "white", high = "red")

# 4단계 지도 경계 그리기
library(sp)
kde_hot_sp <- as(st_geometry(kde_hot), "Spatial") # sf형을 sp형으로 변환

# 그리드 중심 x, y좌표 추출
x <- coordinates(kde_hot_sp)[, 1]
y <- coordinates(kde_hot_sp)[, 2]

# 4-1. 기준 경계 설정
l1 <- bbox(kde_hot_sp)[1,1] - (bbox(kde_hot_sp)[1,1] * 0.0001)
l2 <- bbox(kde_hot_sp)[1,2] + (bbox(kde_hot_sp)[1,2] * 0.0001)
l3 <- bbox(kde_hot_sp)[2,1] - (bbox(kde_hot_sp)[2,1] * 0.0001)
l4 <- bbox(kde_hot_sp)[2,2] + (bbox(kde_hot_sp)[2,2] * 0.0001)

# 4-2. 지도 경계 그리기
library(spatstat)
win <- owin(xrange = c(l1, l2), yrange = c(l3, l4))
plot(win) # 지도 경계선 확인
rm(list = c("kde_hot_sp", "apt_price", "l1", "l2", "l3", "l4")) # 변수 정리

# 경계 위에 좌표값 표시
p <- ppp(x, y, window = win, marks = kde_hot$diff)

# 커널 밀도 함수로 변환
d <- density.ppp(p, weights = kde_hot$diff,
                 sigma = bw.diggle(p),
                 kernel = "gaussian")
plot(d) # 밀도 그래프 확인
rm(list = c("x", "y", "win", "p")) # 변수 정리

# 5단계 래스터 이미지로 변환
d[d < quantile(d)[4] + (quantile(d)[4] * 0.1)] <- NA # 노이즈 제거
library(raster)
raster_hot <- raster(d) # 래스터 변환
plot(raster_hot) # 노이즈 제거 확인

# 6단계 클리핑
bnd <- st_read("./seoul/seoul.shp") # 서울시 경계선 불러오기
raster_hot <- crop(raster_hot, extent(bnd))
crs(raster_hot) <- sp::CRS("+proj=longlat +datum=WGS84 
                            +no_defs +ellps=WGS84 + towgs84=0,0,0") # 좌표계 정의
plot(raster_hot) # 지도 확인
plot(bnd, col=NA, border = "red", add=T)

# 7단계 지도 그리기
library(leaflet)
leaflet() %>% 
  # 기본지도 불러오기
  addProviderTiles(providers$CartoDB.Positron) %>% 
  # 서울시 경계선 불러오기
  addPolygons(data = bnd, weight = 2, color = "red", fill = NA) %>% 
  # 래스터 이미지 불러오기
  addRasterImage(raster_hot,
                 colors = colorNumeric(c("blue", "green", "yellow", "red"),
                                       values(raster_hot), 
                                       na.color = "transparent"), opacity = 0.4)

# 8단계 저장하기
save(raster_hot, file = "./07_map/07_kde_hot.rdata") # 급등지 래스터 저장
rm(list = ls()) # 메모리 정리
