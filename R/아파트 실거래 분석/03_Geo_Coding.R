setwd("C:/workspace/R/shiny")

# 1단계 중복된 주소 제거
load("./04_pre_process/04_pre_process.rdata") # 실거래 자료 로드
apt_juso <- data.frame(apt_price$juso_jibun) # 주소 컬럼 추출
apt_juso <- data.frame(apt_juso[!duplicated(apt_juso), ]) # 고유한 주소 추출
head(apt_juso, 2)

# 2단계 주소를 좌표로 변환
# 2-1. 지오코딩 준비
add_list <- list()
cnt <- 0
kakao_key <- readLines("C:/workspace/api_key/kakao_key.txt")

library(httr)
library(RJSONIO)
library(data.table)
library(dplyr)

# 2-2. 반복문으로 위도, 경도 값 구하기
for(i in 1:nrow(apt_juso)){ 
  # 예외 처리 구문
  tryCatch(
    {
      # 주소로 좌표값 요청
      lon_lat <- GET(url = 'https://dapi.kakao.com/v2/local/search/address.json',
                     query = list(query = apt_juso[i,]),
                     add_headers(Authorization = paste0("KakaoAK ", kakao_key)))
      
      # 위도, 경도 추출
      coordxy <- lon_lat %>% content(as = 'text') %>% RJSONIO::fromJSON()
      
      # 반복 수 카운트
      cnt = cnt + 1
      
      # 주소, 경도, 위도 정보를 리스트에 저장
      add_list[[cnt]] <- data.table(apt_juso = apt_juso[i,], 
                                    coord_x = coordxy$documents[[1]]$x, 
                                    coord_y = coordxy$documents[[1]]$y)
      
      # 진행상황 알림 메시지
      message <- paste0("[", i,"/",nrow(apt_juso),"] 번째 (", 
                        round(i/nrow(apt_juso)*100,2)," %) [", apt_juso[i,] ,"] 지오코딩 중입니다: 
       X= ", add_list[[cnt]]$coord_x, " / Y= ", add_list[[cnt]]$coord_y)
      cat(message, "\n\n")
      
    }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")}
  )
}

# 3단계 지오코딩 결과 저장
# 리스트를 데이터 프레임으로 변환
juso_geocoding <- rbindlist(add_list)

# 좌표를 숫자형으로 변환
juso_geocoding$coord_x <- as.numeric(juso_geocoding$coord_x)
juso_geocoding$coord_y <- as.numeric(juso_geocoding$coord_y)

# 결측치 제거
juso_geocoding <- na.omit(juso_geocoding)

dir.create("./05_geocoding") # 새로운 폴더 생성
save(juso_geocoding, file = "./05_geocoding/05_geocoding.rdata") # 저장
write.csv(juso_geocoding, "./05_geocoding/05_geocoding.csv")


# 참고 #
# GET()함수로 웹 페이지 자료 가져오기
web_page <- GET('http://www.w3.org/Protocols/rfc2616/rfc2616.html')
web_page <- web_page %>% content(as = 'text') # HTML 페이지 텍스트만 저장
head(web_page) # 자료 확인
