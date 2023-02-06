## 1. 결측치 정제
# 결측치 생성
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df
# 결측치 확인
is.na(df) 
table(is.na(df)) # 결측치 빈도 출력
table(is.na(df$sex)) # sex 결측치 빈도 출력
table(is.na(df$score)) # score 결측치 빈도 출력

# 결측치 포함된 상태로 분석
mean(df$score) # 평균 산출 - na값이 존재하면 산출x
sum(df$score) # 합계 산출 - na값이 존재하면 산출x

# 결측치 제거
# 결측치 있는 행 제거
library(dplyr) # dplyr 패키지 로드
df %>% filter(is.na(score)) # score가 NA인 데이터만 출력
df %>% filter(!is.na(score)) # score 결측치 제거

# 결측치 제외한 데이터로 분석
df_nomiss <- df %>% filter(!is.na(score)) # score 결측치 제거
mean(df_nomiss$score) # score 평균
sum(df_nomiss$score) # score 합계

# 여러 변수에서 동시에 결측치 없는 데이터 추출 - 결측치가 하나라도 있으면 제거 : na.omit(df)
df_nomiss2 <- df %>% filter(!is.na(score) & !is.na(sex)) # score, sex 결측치 제거
df_nomiss2 # na.omit(df)와 같은결과

# 함수의 결측치 제외 기능 이용 - na.rm = T
mean(df$score, na.rm = T) # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T) # 결측치 제외하고 합계 산출

# summarise()에서 na.rm = T 사용
# 결측치 생성
exam <- read.csv('data/csv_exam.csv')
exam %>% filter(is.na(math))
exam[c(3,8,15), 'math'] <- NA
exam %>% filter(is.na(math))
# 평균 구하기
exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T))
# 다른 함수들에 적용
exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

# 평균으로 대체하기
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))


#=============================================================================
# 혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg) # mpg데이터 로드
mpg[c(65,124,131,153,212), 'hwy'] <- NA # NA할달
# Q1.
table(is.na(mpg$drv)) # drv 결측치 빈도표
table(is.na(mpg$hwy)) # hwy 결측치 빈도표

# Q2.
mpg %>% 
  filter(!is.na(hwy)) %>% # 결측치 제외
  group_by(drv) %>% # dry별 분리
  summarise(mean_hwy = mean(hwy)) # hwy평균 산출
#=============================================================================


## 2. 이상치 정제
rm(mpg)
mpg <- as.data.frame(ggplot2::mpg) # mpg데이터 로드
# 상자그림 생성
boxplot(mpg$hwy)

# 상자그림 통계치 출력
boxplot(mpg$hwy)$stats

# 이상치를 결측치로 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치를 제외하고 분석
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))


#=============================================================================
# 혼자서 해보기
rm(mpg)
mpg <- as.data.frame(ggplot2::mpg) # mpg데이터 로드
mpg[c(10,14,58,93), 'drv'] <- 'k' # drv 이상치 할당
mpg[c(29,43,129,203), 'cty'] <- c(3,4,39,42) # cty 이상치 할당
# Q1.
table(mpg$drv) # 이상치 확인
# drv가 4, f, r이면 기존 값 유지, 아니면 NA할당
mpg$drv <- ifelse(mpg$drv %in% c('4', 'f', 'r'), mpg$drv, NA)
table(mpg$drv) # 이상치 확인

# Q2.
boxplot(mpg$cty) # 상자그림
boxplot(mpg$cty)$stats # 상자그림 통계치
# 9~26을 벗어나면 NA할당
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty) # 상자그림

# Q3.
mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% # 결측치 제외
  group_by(drv) %>% # drv별 분리
  summarise(mean_cty = mean(cty)) # cty 평균
#=============================================================================