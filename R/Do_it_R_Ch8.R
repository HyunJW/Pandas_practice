## 1. 산점도
# 혼자서 해보기
library(ggplot2)
# Q1.
# cty(도시 연비)와 hwy(고속도로 연비)로 된 산점도
ggplot(data=mpg, aes(x = cty, y = hwy)) + geom_point()

# Q2.
# poptotal(전체인구)와 popasian(아시아인 인구)로 된 산점도
midwest <- as.data.frame(ggplot2::midwest)
ggplot(data=midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)


## 2. 막대 그래프
# 혼자서 해보기
# Q1.
# 평균 표 생성
df_mpg <- mpg %>% 
  filter(class == 'suv') %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)
# 그래프 생성
ggplot(data=df_mpg, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + 
  geom_col()

# Q2.
# 그래프 생성
ggplot(data=mpg, aes(x = class)) + geom_bar()


## 3. 선 그래프
economics <- as.data.frame(ggplot2::economics)
head(economics)
# economics - pce : personal concumption expenditure(개인소비지출)
#             psavert : personal saving rate(개인저축률)
#             pop : total population in thousands(인구수)
#             uempmed : median duration of unemployment in weeks(실업기간)
#             unemploy : number of unemployed in thousands(실업자 수)
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# 혼자서 해보기
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()


## 4. 상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

# 혼자서 해보기
# Q1.
mpg <- as.data.frame(ggplot2::mpg)
mpg_CSS <- mpg %>% filter(class %in% c('compact', 'subcompact', 'suv'))
ggplot(data = mpg_CSS, aes(x = class, y = cty)) + geom_boxplot()

