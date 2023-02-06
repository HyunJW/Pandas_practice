-- 3장 1절 --
use market_db;
select * from member;

use sys;
select * from member;

select * from market_db.member;

use market_db;
select mem_name from member;
select addr, debut_date, mem_name from member;
select addr 주소, debut_date "데뷔 일자", mem_name from member; -- alias(별칭) 지정

-- where 조건절
select * from member where mem_name = '블랙핑크';
select * from member where mem_number = 4; -- 걸그룹 멤버수가 4명인 그룹 검색
select mem_id, mem_name from member where height >= 162; -- 평균키가 162이상인 mem_id, mem_name 검색

-- 평균키가 165이상, 멤버수 6명 초과인 그룹명, 키, 멤버수 검색
select mem_name, height, mem_number from member where height >= 165 and mem_number > 6;

-- 평균키가 165이상 또는 멤버수 6명 초과인 그룹명, 평균키, 멤버수 검색
select mem_name, height, mem_number from member where height >= 165 or mem_number > 6;

-- 평균키가 163이상 165이하인 그룹명, 키, 멤버수 검색
select mem_name, height, mem_number from member where height >= 163 and height <= 165;
select mem_name, height, mem_number from member where height between 163 and 165; -- 숫자의 범위에서 조건식 BETWEEN ~ AND

-- 회원정보 경기/전남/경남 중 한 곳에 사는 횡원을 검색
select mem_name, addr from member where addr = '경기' or addr = '전남' or addr = '경남';
select mem_name, addr from member where addr in('경기', '전남', '경남'); -- 문자의 범위에서 조건식 IN()

-- 문자열의 일부 글자 검색 : LIKE
select * from member where mem_name like '우%'; -- 첫 글자가 '우'로 시작하는 회원 검색
select * from member where mem_name like '__핑크'; -- 앞 두글자에 상관없이 뒤에가 '핑크'인 회원 검색

-- 그룹명이 '에이핑크'인 회원의 평균키보다 큰 회원 검색
select height from member where mem_name = '에이핑크'; -- 에이핑크의 평균키 검색
select mem_name, height from member where height > 164; -- 평균키가 164보다 큰 그룹 조회

-- 서브 쿼리 : 두 SQL을 하나로 합치기
select mem_name, height from member 
	where height > (select height from member where mem_name = '에이핑크');
    

-- 3장 2절 --
-- 데뷔일이 빠른 순서대로 정렬(오름차순)
select mem_id, mem_name, debut_date from member 
	order by debut_date;

-- 데뷔일이 느린 순서대로 정렬(내림차순)
select mem_id, mem_name, debut_date from member 
	order by debut_date desc;
    
-- 평균키가 164이상인 회원들을 데뷔순으로 정렬
select mem_id, mem_name, debut_date, height from member 
	where height >= 164
	order by debut_date; -- 만약 order by를 한 후 where 조건절을 쓰게 되면 error 발생
    
-- 평균키가 164이상인 회원들을 평균키 기준으로 내림차순 정렬
select mem_id, mem_name, debut_date, height from member 
	where height >= 164
	order by height desc;
    
-- 평균키가 164이상인 회원들을 평균키 기준으로 내림차순, 데뷔날짜를 기준으로 오름차순 정렬
select mem_id, mem_name, debut_date, height from member 
	where height >= 164
	order by height desc, debut_date;
    
-- LIMIT : 출력의 개수를 제한
select * from member
	limit 3;
    
-- 평균키가 큰 순서대로 정렬하고 3번째부터 2건 조회
select mem_name, height from member
	order by height desc
	limit 3, 2;
    
-- DISTINCT : 중복된 결과 제거
select addr from member;
select addr from member order by addr;
select distinct addr from member order by addr;

-- GROUP BY
select mem_id, amount from buy order by mem_id;
select mem_id, sum(amount) from buy group by mem_id;

-- 변수명을 바꾸고 회원 ID 순서대로 내림차순 정렬
select mem_id "회원 아이디", sum(amount) "총 구매 개수" from buy
	group by mem_id
    order by mem_id;
    
-- 총 구매 금액
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액" from buy
	group by mem_id;
    
-- 평균 구매 개수
select mem_id "회원 아이디", avg(amount) "평균 구매 개수" from buy
	group by mem_id;

-- HAVING : 집계함수와 관련된 조건문 
-- 총 구매 금액이 1000원 이상 검색
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액" from buy
	group by mem_id
    having sum(price * amount) >= 1000;

-- 총 구매 금액이 1000원 이상인 회원들을 구매금액이 큰 순서대로 정렬    
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액" from buy
	group by mem_id
    having sum(price * amount) >= 1000
	order by sum(price * amount) desc;
    
