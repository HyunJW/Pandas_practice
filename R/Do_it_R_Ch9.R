# 한국복지패널 데이터 분석
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file = 'data/Koweps_hpc10_2015_beta1.sav',
                         to.data.frame = T)
welfare <- raw_welfare


head(welfare,5)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

# 변수가 많고 코드형태로 되어 있어 분석에 용이한 변수명으로 변경
welfare <- rename(welfare,
                  sex = h10_g3, # 성별
                  birth = h10_g4, # 태어난 연도
                  marriage = h10_g10, # 혼인 상태
                  religion = h10_g11, # 종교
                  income = p1002_8aq1, # 월급
                  code_job = h10_eco9, # 직종 코드
                  code_region = h10_reg7) # 지역코드

# 1단계 : 변수 검토 및 전처리
# Q. 성별에 따른 월급의 차이가 있을까?
class(welfare$sex) # 변수의 데이터 타입 확인
table(welfare$sex) # 성별 빈도수 집계, 이상치 확인

# 이상치가 있다면 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)
table(welfare$sex)

welfare$sex <- ifelse(welfare$sex == 1, 'male', 'female')
table(welfare$sex)
qplot(welfare$sex)

# 월급 변수 검토 및 처리
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)

qplot(welfare$income) + xlim(0, 1000)

# 월급의 이상치 확인
summary(welfare$income)
# 월급이 0이거나 9999인 데이터를 NA로 대체
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
table(is.na(welfare$income))

# 성별, 월급 평균표 만들기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))
sex_income
ggplot(data=sex_income, aes(x = sex, y = mean_income)) + geom_col()
# A.남성이 여성보다 월급을 2배 가까이 많이 받음.

# Q.몇살에 월급을 가장 많이 받을까?
# birth 데이터 확인
class(welfare$birth)
qplot(welfare$birth)

# birth의 이상치 확인
summary(welfare$birth)

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)

# birth의 결측치 확인
table(is.na(welfare$birth)) # 결측치 없음

# 파생변수 만들기 - 나이
welfare$age <- 2015 - welfare$birth + 1 # 2015기준 데이터
summary(welfare$age)
qplot(welfare$age)

# 나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
head(age_income, 5)

# 시각화
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()
# A.40대까지는 임금이 상승하다가 50대에 정점을 찍고 중반부터 점점 줄어듦

# Q. 어떤 연령대의 월급이 가장 많을까?
# 파생변수 만들기 - 연령대(young:30세 미만, middle:60세 미만, old:60세 이상)
welfare <- welfare %>% 
  mutate(age_group = ifelse(age < 30, 'young',
                       ifelse(age < 60, 'middle', 'old')))
table(welfare$age_group)
qplot(welfare$age_group)

# 연령대에 따른 월급 차이 분석
age_group_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age_group) %>% 
  summarise(mean_income = mean(income))

# 시각화
ggplot(data = age_group_income, aes(x = age_group, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c('young', 'middle', 'old')) # 막대순서 정렬
# A.middle(30~59)인 연령대에 가장 많은 월급을 받는다.

# Q. 성별 월급 차이는 연령대별로 다를까?
# 연령대 및 성별에 대한 월급표 생성 
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age_group, sex) %>% 
  summarise(mean_income = mean(income))
sex_income

# 시각화
ggplot(data = sex_income, 
       aes(x = age_group, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c('young', 'middle', 'old')) # 막대순서 정렬

# 성별 막대 분리
ggplot(data = sex_income, 
       aes(x = age_group, y = mean_income, fill = sex)) +
  geom_col(position = 'dodge') + # 막대 분리
  scale_x_discrete(limits = c('young', 'middle', 'old')) # 막대순서 정렬
# A.일하지 않는 여성들도 데이터에 집계 되었을 수도 있기때문에 여성이 적다라고 단정하기는 힘들 것 같음.

# 나이 및 성별에 대한 월급표 생성
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))
head(sex_age)

# 시각화
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) +
  geom_line()
# A.30대까지는 비슷하나 예측하기로는 결혼과 육아로 휴직하는 여성이 많아져 임금차이가 발생한다고 생각함.

# Q. 어떤 직업이 월급을 가장 많이 받을까?
# 변수 검토
class(welfare$code_job)
table(welfare$code_job)

# 전처리 - 직업분류코드 목록 불러오기
list_job <- read_excel('data/Koweps_Codebook.xlsx', col_names = T, sheet=2)
head(list_job)
dim(list_job)

# welfare에 직업명 결합
welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

# 직업별 평균 월급표 생성
job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))
head(job_income)

# 상위 10개 추출
top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)
top10

# 시각화
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() # barh로 바꾸기

# 하위 10개 추출
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)
bottom10

# 시각화
ggplot(data = bottom10, aes(x = reorder(job, -mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() + # barh로 바꾸기
  ylim(0, 850)
# A.의료인으로 예상했으나 의외로 금속 재료 공학 기술자 및 시험원이 가장 많은 월급을 받는다.

# Q. 성별로 어떤 직업이 가장 많을까?
# 성별 직업 빈도표 생성 - 남성직업빈도 상위 10위
job_male <- welfare %>% 
  filter(!is.na(job) & sex == 'male') %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_male

# 성별 직업 빈도표 생성 - 여성직업빈도 상위 10위
job_female <- welfare %>% 
  filter(!is.na(job) & sex == 'female') %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_female

# 시각화
# 남성 직업 빈도 상위 10개 직업
ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

# 여성 직업 빈도 상위 10개 직업
ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()
# A.남성과 여성 모두 작물재배 종사자가 가장 많았고 남성은 그 다음으로 자동차 운전원, 여성은 청소원 및 환경미화원이 많았다.

# Q. 종교 유무에 따라 이혼율이 다를까?
# 변수 검토 - 종교
class(welfare$religion)
table(welfare$religion)

# 전처리 - 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, 'Yes', 'No')
table(welfare$religion)
qplot(welfare$religion)

# 변수 검토 - 혼인여부
class(welfare$marriage)
table(welfare$marriage)

# 전처리 - 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, 'marriage',
                                 ifelse(welfare$marriage == 3, 'divorce',
                                        NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

# 종교 유무에 따른 이혼율 표 생성
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(total_group = sum(n),
         percent = round(n / total_group * 100, 1))
religion_marriage

# 이혼율 표 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == 'divorce') %>% 
  select(religion, percent)
divorce

# 시각화
ggplot(data = divorce, aes(x = religion, y = percent)) + geom_col()
# A.데이터 상 종교가 없으면 조금더 이혼율이 높긴하나 차이는 미비하다. 종교가 이혼율에 미치는 영향은 거의 없는듯하다.

# 연령대에 따른 이혼율 분석
# 연령대별 이혼율 표 만들기
age_group_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  count(age_group, group_marriage) %>% 
  group_by(age_group) %>% 
  mutate(percent = round(n / sum(n) * 100, 1))
age_group_marriage

# 시각화 - 초년 제외 이혼율
age_group_divorce <- age_group_marriage %>% 
  filter(age_group != 'young' & group_marriage == 'divorce') %>% 
  select(age_group, percent)
age_group_divorce
ggplot(data = age_group_divorce, aes(x = age_group, y = percent)) +
  geom_col()
# 연령대가 middle인 사람들이 old인 사람들보다 이혼율은 조금 더 높다.

# 연령대 및 종교유무에 따른 이혼율 분석
# 연령대, 종교유무, 결혼상태별 비율표 만들기
age_group_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & age_group != 'young') %>% 
  count(age_group, religion, group_marriage) %>% 
  group_by(age_group, religion) %>% 
  mutate(percent = round(n / sum(n) * 100, 1))
age_group_religion_marriage

# 연령대 및 종교 유무별 이혼율 표 생성
df_divorce <-  age_group_religion_marriage %>% 
  filter(group_marriage == 'divorce') %>% 
  select(age_group, religion, percent)
df_divorce

# 시각화
ggplot(data = df_divorce, 
       aes(x = age_group, y = percent, fill = religion)) + 
  geom_col(position = 'dodge')
# A.연령대가 middle인 사람들은 종교와 이혼율의 관계가 조금은 있지만 old인 사람들은 종교의 영향이 거의 없었다.

# Q. 노년층이 많은 지역은 어디일까?
# 변수 검토
class(welfare$code_region)
table(welfare$code_region)

# 전처리 - 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c('서울',
                                     '수도권(인천/경기)',
                                     '부산/경남/울산',
                                     '대구/경북',
                                     '대전/충남',
                                     '강원/충북',
                                     '광주/전남/전북/제주도'))
list_region

# welfare에 지역명 변수 추가
welfare <- left_join(welfare, list_region, id = "code_region")
welfare %>% 
  select(code_region, region) %>% 
  tail

# 지역별 연령대 분석
# 지역별 연령대 비율표 만들기
region_age_group <- welfare %>% 
  count(region, age_group) %>% 
  group_by(region) %>% 
  mutate(percent = round(n / sum(n) * 100, 2))
region_age_group

# 시각화
ggplot(data = region_age_group, 
       aes(x = region, y = percent, fill = age_group)) +
  geom_col() +
  coord_flip()

# 노년층 비율 내림차순
list_order_old <- region_age_group %>% 
  filter(age_group == 'old') %>% 
  arrange(percent)
list_order_old
# 지역명 순서 변수 만들기
order <- list_order_old$region
order
# 시각화
ggplot(data = region_age_group, 
       aes(x = region, y = percent, fill = age_group)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order) # 받은 x리스트의 순서를 역순으로 정렬
