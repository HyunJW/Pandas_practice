## 확률 밀도 함수 : 이 지역의 아파트는 비싼 편인가?
# 1단계 확률 밀도 분포로 변환
setwd("C:/workspace/R/shiny")
load("./08_chart/all.rdata") # 전체 지역
load("./08_chart/sel.rdata") # 관심 지역

# 1-1. 최대값 찾기
max_all <- density(all$py) ; max_all <- max(max_all$y)
max_sel <- density(sel$py) ; max_sel <- max(max_sel$y)
plot_high <- max(max_all, max_sel)
rm(list = c("max_all", "max_sel")) # 메모리 정리

# 1-2. 평균가 계산
avg_all <- mean(all$py) # 전체 지역 평당 평균가
avg_sel <- mean(sel$py) # 관심 지역 평당 평균가
# 전체 지역/관심 지역 평균 가격과 y축 최대값 확인
avg_all ; avg_sel ; plot_high 

# 2단계 그래프 그리기
plot(stats::density(all$py), ylim = c(0, plot_high),
     col= "blue", lwd = 3, main = NA) # 전체 지역 밀도 함수
abline(v = avg_all, lwd = 2, col = "blue", lty = 3) # 전체 지역 평균 수직선
text(avg_all + (avg_all) * 0.15, plot_high * 0.1,
     sprintf("%.0f", avg_all), srt = 0.2, col = "blue") # 전체 지역 평균 텍스트 입력
lines(stats::density(sel$py), col = "red", lwd = 3) # 관심 지역 확률 밀도 함수
abline(v = avg_sel, lwd = 2, col = "red", lty = 3) # 관심 지역 평균 수직선
text(avg_sel + (avg_sel) * 0.15, plot_high * 0.1,
     sprintf("%.0f", avg_sel), srt = 0.2, col = "red") # 관심 지역 평균 텍스트 입력


## 회귀분석 : 이 지역은 일년에 얼마나 오를까?
# 1단계 월별 평당 거래가 요약
library(dplyr)
library(lubridate)
all <- all %>% 
  group_by(month=floor_date(ymd, "month")) %>% 
  summarise(all_py = mean(py)) # 전체 지역 월별 거래가
sel <- sel %>% 
  group_by(month=floor_date(ymd, "month")) %>% 
  summarise(sel_py = mean(py)) # 관심 지역 월별 거래가

# 2단계 회귀식 모델링
fit_all <- lm(all$all_py ~ all$month) # 전체 지역 회귀식
fit_sel <- lm(sel$sel_py ~ sel$month) # 관심 지역 회귀식
coef_all <- round(summary(fit_all)$coefficients[2], 1) * 365 # 전체 지역 회귀 계수
coef_sel <- round(summary(fit_sel)$coefficients[2], 1) * 365 # 관심 지역 회귀 계수

# 3단계 회귀 분석 그리기
# 3-1. 분기별 평당 가격 변화 주석 만들기
library(grid)
grob_1 <- grobTree(textGrob(paste0("전체 지역: ", coef_all, "만원(평당)"),
                            x = 0.05, y = 0.88, hjust = 0, 
                            gp = gpar(col = "blue", fontsize = 13, fontface = "italic")))
grob_2 <- grobTree(textGrob(paste0("관심 지역: ", coef_sel, "만원(평당)"),
                            x = 0.05, y = 0.95, hjust = 0, 
                            gp = gpar(col = "red", fontsize = 16, fontface = "bold")))

# 3-2. 관심 지역 회귀선 그리기
library(ggpmisc)
gg <- ggplot(sel, aes(x = month, y = sel_py)) + 
  geom_line() + xlab("월") + ylab("가격") + 
  theme(axis.text.x = element_text(angle = 90)) +
  stat_smooth(method = "lm", colour = "dark grey", linetype = "dashed") + 
  theme_bw()

# 3-3. 전체 지역 회귀선 그리기
gg + geom_line(color = "red", size = 1) +
  geom_line(data = all, aes(x = month, y = all_py), color = "blue", size = 1) +
  # 주석 추가
  annotation_custom(grob_1) +
  annotation_custom(grob_2)

rm(list = ls()) # 메모리 정리


## 주성분 분석 : 이 지역의 단지별 특징은 무엇일까?
# 1단계 주성분 분석
load("./08_chart/sel.rdata") # 관심지역 데이터
pca_01 <- aggregate(list(sel$con_year, sel$floor, sel$py, sel$area),
                    by = list(sel$apt_nm), mean) # 아파트별 평균값
colnames(pca_01) <- c("apt_nm", "신축", "층수", "가격", "면적")
m <- prcomp(~ 신축 + 층수 + 가격 + 면적, data = pca_01, scale = T) # 주성분 분석
summary(m)

# 2단계 그래프 그리기
library(ggfortify)
autoplot(m, loadings.label = T, loadings.label.size = 6) +
  geom_label(aes(label = pca_01$apt_nm), size = 4)
