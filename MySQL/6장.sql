use market_db;
/* 인덱스의 종류 */
-- 클러스터형 인덱스(Clustered Index) : 기본 키 지정시 자동으로 클러스터형 인덱스 생성, 유일
create table table1(
	col1 INT primary key,
    col2 INT,
    col3 INT
);
show index from table1; -- 인덱스 정보 확인

-- 보조 인덱스(Secondary Index) : 고유 키 지정시 자동으로 보조 인덱스 생성, 유일x
create table table2(
	col1 INT primary key,
    col2 INT unique,
    col3 INT unique
);
show index from table2;

-- 자동으로 정렬되는 클러스터형 인덱스 --
drop table if exists buy, member;
create table member(
	mem_id 		CHAR(8),
	mem_name 	VARCHAR(10),
	mem_number 	INT,
	addr 		CHAR(2)
);
insert into member values('TWC', '트와이스', 9, '서울');
insert into member values('BLK', '블랙핑크', 4, '경남');
insert into member values('WMN', '여자친구', 6, '경기');
insert into member values('OMY', '오마이걸', 7, '서울');
select * from member;

alter table member
	add constraint
    primary key(mem_id); -- 클러스터형 인덱스 생성
select * from member; -- 자동으로 정렬 됨

-- 데이터를 추가 하는 경우
alter table member drop primary key; -- 기본 키 제거
alter table member
	add constraint
    primary key(mem_name); -- 클러스터형 인덱스 생성
select * from member;

insert into member values('GRL', '소녀시대', 8, '서울');
select * from member; -- 자동으로 정렬 됨

-- 정렬되지 않는 보조 인덱스 --
drop table if exists member;
create table member(
	mem_id 		CHAR(8),
	mem_name 	VARCHAR(10),
	mem_number 	INT,
	addr 		CHAR(2)
);
insert into member values('TWC', '트와이스', 9, '서울');
insert into member values('BLK', '블랙핑크', 4, '경남');
insert into member values('WMN', '여자친구', 6, '경기');
insert into member values('OMY', '오마이걸', 7, '서울');
select * from member;

alter table member
	add constraint
    unique(mem_id); -- 보조 인덱스 생성
select * from member; -- 정렬되지 않음

alter table member
	add constraint
    unique(mem_name); -- 보조 인덱스 생성
select * from member; -- 정렬되지 않음

-- 데이터를 추가 하는 경우
insert into member values('GRL', '소녀시대', 8, '서울');
select * from member; -- 정렬되지 않음


/* 인덱스의 구조 */
-- 클러스터형 인덱스 구성 --
use market_db;
create table cluster( -- 클러스터형 인덱스를 테스트하기 위한 테이블
	mem_id 	 CHAR(8),
    mem_name VARCHAR(10)
);
insert into cluster values('TWC', '트와이스');
insert into cluster values('BLK', '블랙핑크');
insert into cluster values('WMN', '여자친구');
insert into cluster values('OMY', '오마이걸');
insert into cluster values('GRL', '소녀시대');
insert into cluster values('ITZ', '잇지');
insert into cluster values('RED', '레드벨벳');
insert into cluster values('APN', '에이핑크');
insert into cluster values('SPC', '우주소녀');
insert into cluster values('MMU', '마마무');
select * from cluster;

alter table cluster
	add constraint
    primary key(mem_id); -- 클러스터형 인덱스 생성
select * from cluster; -- 자동 정렬, 루트페이지에는 인덱스로 지정된 첫번째 값으로 형성

-- 보조 인덱스 구성 --
use market_db;
create table second( -- 보조 인덱스를 테스트하기 위한 테이블
	mem_id 	 CHAR(8),
    mem_name VARCHAR(10)
);
insert into second values('TWC', '트와이스');
insert into second values('BLK', '블랙핑크');
insert into second values('WMN', '여자친구');
insert into second values('OMY', '오마이걸');
insert into second values('GRL', '소녀시대');
insert into second values('ITZ', '잇지');
insert into second values('RED', '레드벨벳');
insert into second values('APN', '에이핑크');
insert into second values('SPC', '우주소녀');
insert into second values('MMU', '마마무');
select * from second;

alter table second
	add constraint
    unique(mem_id); -- 보조 인덱스 생성
select * from second; -- 자동 정렬x, 별도의 데이터 페이지 형성


/* 6장 3절 */
/* 인덱스의 생성과 제거 문법 */
-- 인덱스 생성 문법 --
use market_db;
select * from member;
show index from member; -- 테이블에 생성된 인덱스 정보
show table status like 'member'; -- 테이블에 생성된 인덱스의 크기 확인, like 'member' : member라는 글자가 들어간 테이블 정보 확인을 의미

-- 단순 보조 인덱스 생성 : 중복을 허용한 보조 인덱스
create index idx_member_addr
	on member(addr); 
show index from member; -- 단순 보조 인덱스가 생성됨을 확인
show table status like 'member'; -- 생성된 보조 인덱스가 적용되지 않음

-- 해결법 : 우선 ANALYZE TABLE문으로 분석/처리 필요
analyze table member;
show table status like 'member'; -- 생성된 보조 인덱스가 적용됨을 확인

-- 고유 보조 인덱스 생성 : 중복 허용x
create unique index idx_member_mem_number
	on member(mem_number); -- Error 발생 : 중복된 값이 존재하기 때문에 고유 보조 인덱스는 생성 불가
    
create unique index idx_member_mem_name
	on member(mem_name); -- 중복 값이 없기 때문에 고유 보조 인덱스가 생성
show index from member; -- 고유 보조 인덱스가 생성됨을 확인

-- 동일한 이름의 회원을 추가
insert into member values('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10'); -- Error 발생 : 고유 보조 인덱스로 인해서 중복 값을 허용할 수 없음.

-- 인덱스 활용 --
analyze table member; -- 지금까지 만든 모든 인덱스 적용
show index from member;

select * from member; -- Execution Plan창으로 검색방법 확인 : Full Table Scan
select mem_id, mem_name, addr from member; -- Execution Plan창으로 검색방법 확인 : Full Table Scan
select mem_id, mem_name, addr
	from member
	where mem_name = '에이핑크'; -- Execution Plan창으로 검색방법 확인 : Single Row(constant) -> 인덱스 사용 확인
    
-- 숫자의 범위로 조회
create index idx_member_mem_number
	on member(mem_number); -- 인원수로 단순 보조 인덱스 생성
analyze table member;
select mem_id, mem_name, addr
	from member
	where mem_number >= 7; -- Execution Plan창으로 검색방법 확인 : Index Range Scan -> 인덱스 사용 확인

-- 인덱스를 사용하지 않는 경우 --
select mem_id, mem_name, addr
	from member
	where mem_number >= 1; -- Execution Plan창으로 검색방법 확인 : Full Table Scan -> 전체 조회이므로 인덱스를 사용하지 않음
    
select mem_id, mem_name, addr
	from member
	where mem_number*2 >= 14; -- Execution Plan창으로 검색방법 확인 : Full Table Scan -> WHERE문에 열에 연산이 가해지면 인덱스를 사용하지 않음

-- 위의 결과를 인덱스 사용하게 바꾸기
select mem_id, mem_name, addr
	from member
	where mem_number >= 14/2; -- Execution Plan창으로 검색방법 확인 : Index Range Scan -> 인덱스 사용 확인
    
-- 인덱스 제거 --
show index from member; -- 보조 인덱스 이름 확인

-- 보조 인덱스 제거 : 클러스터형 인덱스와 보조 인덱스 중 보조 인덱스를 우선적으로 제거
drop index idx_member_mem_name on member;
drop index idx_member_addr on member;
drop index idx_member_mem_number on member;

-- 클러스터형 인덱스 제거 : Primary Key의 경우 DROP INDEX문으로 제거 되지 않고 ALTER TABLE문으로만 제거 됨.
alter table member
	drop primary key; -- Error 발생 : 기본 키를 제거하기 전에 외래 키 부터 제거해야 함
    
-- 외래 키 이름 확인 : information_schema 데이트 베이스에서 referential_constraints 테이블을 조회
select table_name, constraint_name
	from information_schema.referential_constraints
    where constraint_schema = 'market_db';
    
alter table buy
	drop foreign key buy_ibfk_1; -- 외래 키 제거
alter table member
	drop primary key; -- 기본 키 제거
