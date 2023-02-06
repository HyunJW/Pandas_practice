-- 4장 1절 --
use market_db;
create table hongong4 (
	tinyint_col TINYINT,
    smallint_col SMALLINT,
    int_col INT,
    bigint_col BIGINT);
-- 정수형
insert into hongong4 values(127, 32767, 2147483647, 9000000000000000000);
-- insert into hongong4 values(128, 32768, 2147483648, 90000000000000000000); error:out of range 

drop table if exists buy, member;
create table member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY, -- 회원 아이디(PK)
    mem_name VARCHAR(10) NOT NULL, -- 이름, VARCHAR : 가변으로 들어감.
    mem_number INT NOT NULL, -- 인원수
	addr CHAR(2) NOT NULL, -- 주소(경기, 서울, 경남 식으로 2글자만 입력)
    phone1 CHAR(3), -- 연락처의 국번(02, 031, 055 등)
    phone2 CHAR(8), -- 연락처의 나머지 전화번호(하이픈 제외)
    height SMALLINT, -- 평균키
    debut_date DATE -- 데뷔 일자
);
-- 효율적으로 정수형 범위 지정(TINYINT : -128~127, TINYINT UNSIGNED : 0~255)
drop table if exists buy, member;
create table member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY, -- 회원 아이디(PK)
    mem_name VARCHAR(10) NOT NULL, -- 이름, VARCHAR : 가변으로 들어감.
    mem_number TINYINT NOT NULL, -- 인원수
	addr CHAR(2) NOT NULL, -- 주소(경기, 서울, 경남 식으로 2글자만 입력)
    phone1 CHAR(3), -- 연락처의 국번(02, 031, 055 등)
    phone2 CHAR(8), -- 연락처의 나머지 전화번호(하이픈 제외)
    height TINYINT UNSIGNED, -- 평균키, UNSIGNED : 정수형에 붙이면 범위가 0부터 시작
    debut_date DATE -- 데뷔 일자
);

/* 문자형
- CHAR : 1~255, VARCHAR : 1~16383
- VARCHAR는 가변길이 문자형으로 VARCHAR(10)에 '가나다'를 저장하면 3자리만 사용
- CHAR보다 VARCHAR가 공간을 효율적으로 운영할 수 있지만, 내부 성능면에서는 CHAR이 더 좋음.
*/
/* 데이터 열 길이 초과 (Error:column length too big)
create table big_table(
	data1 CHAR(256),
    data2 VARCHAR(16384));
*/
-- 긴 문자형 처리는 TEXT, BOLB형식을 사용
create database netflix_db;
use netflix_db;
create table movie(
	movie_id INT,
    movie_title VARCHAR(30),
    movie_director VARCHAR(20),
    movie_actor VARCHAR(20),
	movie_script LONGTEXT, -- LONGTEXT : 1~4294967295(약 43억)
    movie_film LONGBLOB -- LONGBLOB : 1~4294967295(약 43억)
);

/* 실수형
- FLOAT : 4 (소수점 아래 7자리까지 표현)
- DOUBLE : 8 (소수점 아래 15자리까지 표현)
*/

/* 날짜형
- DATE : 3 (날짜만 저장, YYYY-MM-DD형식으로 사용)
- TIME : 3 (시간만 저장, HH:MM:SS형식으로 사용)
- DATETIME : 8 (날짜 및 시간 저장, YYYY-MM-DD HH:MM:SS형식으로 사용)
*/

/* 변수의 사용 */
use market_db;
set @myVar1 = 5;
set @myVar2 = 4.25;

select @myVar1;
select @myVar2;
select @myVar3; -- 변수로 선언을 하지 않았더라도 NULL값으로 반환을 해줌
select @myVar1 + @myVar2;

-- 산술연산
select 1;
select 1+1;
select 1-1, 100*20, 5.0/2;
-- 비교연산
select 1 > 100;
select 1 < 100;
select 10 = 10;
select 101 != 10;
select 101 <> 10;
-- 논리연산
select (10 >= 10) and (5 < 10);
select (10 > 10) and (5 < 10);
select (10 > 10) or (5 < 10);
select not (10 > 10);

drop table if exists member;
CREATE TABLE member -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
);

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');
set @txt = '가수이름 ==> ';
set @height = 166;
select @txt, mem_name from member
	where height > @height;
    
set @count = 3;
select mem_name, height from member
	order by heigth limit 3;
/* Error : LIMIT에서는 변수 사용 불가
select mem_name, height from member
	order by heigth limit @count;
*/
-- 해결법
set @count = 3;
prepare mySQL from 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';
execute mySQL using @count;

/* 데이터 형 변환 */
CREATE TABLE buy -- 구매 테이블
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   mem_id  	CHAR(8) NOT NULL, -- 아이디(FK)
   prod_name 	CHAR(6) NOT NULL, --  제품이름
   group_name 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 가격
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);
INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

/* 명시적 형 변환 */
-- 정수형으로 변경
select avg(price) '평균 가격' from buy;
select cast(avg(price) as signed) '평균 가격' from buy; -- signed : 부호가 있는 정수로 형 변환 / unsigned : 부호가 없는 정수
select convert(avg(price), signed) '평균 가격' from buy;

-- 날짜형으로 변경
select cast('2023$01$31' as date);
select cast('2023/01/31' as date);
select cast('2023%01%31' as date);
select cast('2023@01@31' as date);

select num, concat(cast(price as char), 'X', cast(amount as char), '=') '가격X수량', price*amount '구매액' from buy;

/* 암시적 형 변환 */
select '100' + '200'; -- 문자를 숫자로 변환
select concat('100', '200'); -- '100200'
select 100 + '200'; -- 문자를 숫자로 변환
select concat(100, '200'); -- 숫자를 문자로 변환

select 1 > '2mega'; -- 정수인 2로 변환이 됨, result : 0
select 3 > '2mega'; -- 정수인 2로 변환이 됨, result : 1 
select 0 = 'mega2'; -- 문자 0으로 변환이 됨, result : 1 

 