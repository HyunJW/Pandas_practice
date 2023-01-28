setwd("C:/workspace/R/shiny")
loc <- read.csv('./01_code/sigun_code/sigun_code.csv', fileEncoding = 'UTF-8')

# 1단계 수집 대상 지역 설정
loc$code <- as.character(loc$code)
head(loc, 2)

# 2단계 수집 기간 설정
datelist <- seq(from = as.Date('2021-01-01'), 
                to = as.Date('2021-12-31'),
                by = '1 month')
datelist <- format(datelist, format = '%Y%m')
datelist[1:3]

# 3단계 인증키 입력
service_key <- readLines("C:/workspace/api_key/가공공데이터_아파트매매.txt")
service_key

# 4단계 요청목록 생성
# 4-1. 요청목록 만들기
url_list <- list() # 빈 리스트 만들기
cnt <- 0 # 반복문의 제어 변수 초기값 설정

# 4-2. 요청목록 채우기
for (i in 1:nrow(loc)){ # 구
  for (j in 1:length(datelist)){ # 날짜
    cnt <- cnt + 1
    url_list[cnt] <- paste0("http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?",
                            "LAWD_CD=", loc[i,1], # 지역 코드
                            "&DEAL_YMD=", datelist[j], # 수집 월
                            "&numOfRows=", 100, # 가져올 최대 자료 수
                            "&serviceKey=", service_key) # 인증키
  }
  Sys.sleep(0.1) # 0.1초 멈춤
  msg <- paste0("[", i, "/", nrow(loc), "] ", loc[i,3], "의 크롤링 목록이 생성됨 => 총 [", cnt, "] 건") # 알림 메시지
  cat(msg, "\n\n")
}

length(url_list)
browseURL(paste0(url_list[1]))

# 5단계 크롤링 실행
library(XML)
library(data.table)
library(stringr)

raw_data <- list() # XML 임시 저장소
root_Node <- list() # 거래 내역 추출 임시 저장소
total <- list() # 거래 내역 정리 임시 저장소
dir.create("./02_raw_data") # 새로운 폴더 만들기

# 5-1. url요청 xml응답
for (i in 1:length(url_list)){ 
  raw_data[[i]] <- xmlTreeParse(url_list[i], useInternalNodes = T, encoding = "UTF-8") # 결과 저장
  root_Node[[i]] <- xmlRoot(raw_data[[i]]) # xmlRoot로 루트 노드 이하 추출
  
  # 5-2. 전체 거래 건수를 확인
  # 전체 거래내역에서 items 추출
  items <- root_Node[[i]][[2]][['items']]
  # 전체 거래 건수 확인
  size <- xmlSize(items)
  
  # 5-3. 단계 거래내역 추출
  item <- list()
  item_temp_dt <- data.table() # 세부 거래내역 임시 테이블 생성
  Sys.sleep(.1) # 0.1초 멈춤
  for (m in 1:size){
    # 세부 거래내역 분리
    item_temp <- xmlSApply(items[[m]], xmlValue)
    item_temp_dt <- data.table(year = item_temp[4],     # 거래 연도
                               month = item_temp[7],    # 거래 월
                               day = item_temp[8],      # 거래 일
                               price = item_temp[1],    # 거래 금액
                               code = item_temp[12],    # 지역 코드
                               dong_nm = item_temp[5],  # 법정동
                               jibun = item_temp[11],   # 지번
                               con_year = item_temp[3], # 건축 연도
                               apt_nm = item_temp[6],   # 아파트 이름
                               area = item_temp[9],     # 전용면적
                               floor = item_temp[13])   # 층수
    # 분리된 거래내역을 순서대로 저장
    item[[m]] <- item_temp_dt
  }
  apt_bind <- rbindlist(item)
  # 응답내역 저장
  region_nm <- subset(loc, code == str_sub(url_list[i], 115, 119))$addr_1 # 지역명
  month <- str_sub(url_list[i], 130, 135) # 연월(YYYYMM)
  path <- as.character(paste0("./02_raw_data/", region_nm, "_", month, ".csv"))
  write.csv(apt_bind, path) # csv 저장
  msg <- paste0("[", i, "/", length(url_list), "] 수집한 데이터를 [", path, "]에 저장합니다.") # 알림 메시지
  cat(msg, "\n\n")
}

files <- dir('./02_raw_data')
library(plyr)
apt_price <- ldply(as.list(paste0("./02_raw_data/", files)), read.csv, fileEncoding="UTF-8") # 결합
tail(apt_price, 2) # 확인

dir.create('./03_integrated')
save(apt_price, file = "./03_integrated/03_apt_price.rdata") # 저장
write.csv(apt_price, "./03_integrated/03_apt_price.csv")
