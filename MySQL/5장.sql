/* 5장 1절 */
drop database if exists naver_db;
create database naver_db;
use naver_db;

drop table if exists member;
create table member (
	mem_id 		CHAR(8) not null primary key, 
    mem_name 	VARCHAR(10) not null,
    mem_number 	TINYINT not null,
    addr 		CHAR(2) not null,
    phone1 		CHAR(3) null,
    phone2 		CHAR(8) null,
    height 		TINYINT unsigned null,
    debut_date	DATE null
);
drop table if exists buy;
create table buy (
	num 		INT auto_increment not null primary key,
    mem_id 		CHAR(8) not null,
    prod_name 	CHAR(6) not null,
    group_name 	CHAR(4) null,
    price 		INT unsigned not null,
    amount 		SMALLINT unsigned not null,
    foreign key(mem_id) references member(mem_id)
);

insert into member values('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015-10-19');
insert into member values('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016-08-08');
insert into member values('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015-01-15');
select * from member;

insert into buy values(null, 'BLK', '지갑', null, 30, 2);
insert into buy values(null, 'BLK', '맥북프로', '디지털', 1000, 1);
insert into buy values(null, 'APN', '아이폰', '디지털', 200, 1); -- Error 발생 : APN(에이핑크)가 회원 테이블에 존재하지 않음

-- 해결법 : 회원 테이블에 회원정보를 추가
insert into member values('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011-02-10');
insert into buy values(null, 'APN', '아이폰', '디지털', 200, 1);


/* 5장 2절 */
/* 기본키(PRIMARY KEY) 제약조건 */
-- 기본키 설정1 : 처음에 지정
drop table if exists buy, member;
create table member (
	mem_id 	  CHAR(8) not null primary key, 
    mem_name  VARCHAR(10) not null,
	height 	  TINYINT unsigned null
);
desc member;

-- 기본키 설정2 : 예약어로 지정
drop table if exists member;
create table member (
	mem_id	  CHAR(8) not null, 
    mem_name  VARCHAR(10) not null,
    height 	  TINYINT unsigned null,
    primary key (mem_id)
);
desc member;

-- 기본키 설정3 : alter table구문으로 만들어진 테이블에 수정
drop table if exists member;
create table member (
	mem_id	  CHAR(8) not null, 
    mem_name  VARCHAR(10) not null,
    height 	  TINYINT unsigned null
);
alter table member
	add constraint
    primary key (mem_id);
desc member;

/* 외래키(FOREIGN KEY) 제약조건 */
-- 외래키 설정1 : 예약어로 지정
drop table if exists buy, member;
create table member (
	mem_id 	  CHAR(8) not null primary key, 
    mem_name  VARCHAR(10) not null,
	height	  TINYINT unsigned null
);
create table buy (
	num		   INT auto_increment not null primary key,
    mem_id	   CHAR(8) not null,
    prod_name  CHAR(6) not null,
    foreign key(mem_id) references member(mem_id)
);

-- 외래키 설정2 : alter table구문으로 만들어진 테이블에 수정
drop table if exists buy;
create table buy (
	num		   INT auto_increment not null primary key,
    mem_id	   CHAR(8) not null,
    prod_name  CHAR(6) not null
);
alter table buy
	add constraint
    foreign key(mem_id) 
    references member(mem_id);
    
-- 기준 테이블의 열이 변경될 경우 : Error 발생
insert into member values('BLK', '블랙핑크', 163);
insert into buy values(null, 'BLK', '지갑');
insert into buy values(null, 'BLK', '맥북');

select M.mem_id, M.mem_name, B.prod_name
	from buy B
		inner join member M
        on B.mem_id = M.mem_id;

-- Error 확인 : foreign key와 연결되고 나서는 기준 테이블의 열 이름을 변경하거나 삭제 할 수 없음. 참조 테이블의 데이터에 문제가 발생하기 때문.
update member set mem_id = 'PINK' where mem_id = 'BLK';
delete from member where mem_id = 'BLK';

-- 해결법 : ON UPDATE CASCADE, ON DELETE CASCADE문을 이용
drop table if exists buy;
create table buy (
	num		   INT auto_increment not null primary key,
    mem_id	   CHAR(8) not null,
    prod_name  CHAR(6) not null
);
alter table buy
	add constraint
    foreign key(mem_id) references member(mem_id)
    on update cascade
    on delete cascade;
    
insert into buy values(null, 'BLK', '지갑');
insert into buy values(null, 'BLK', '맥북');

update member set mem_id = 'PINK' where mem_id = 'BLK';
select M.mem_id, M.mem_name, B.prod_name
	from buy B
		inner join member M
        on B.mem_id = M.mem_id;
        
delete from member where mem_id = 'PINK';
select * from buy;

/* 기타 제약조건 */
-- 고유키(UNIQUE) 제약조건 : 중복되지 않는 유일한 값(기본키와 유사 하지만 NULL값 허용)
drop table if exists buy, member;
create table member (
	mem_id 	  CHAR(8) not null primary key, 
    mem_name  VARCHAR(10) not null,
	height	  TINYINT unsigned null,
    email 	  CHAR(30) null unique
);
insert into member values('BLK', '블랙핑크', 163, 'pink@gmail.com');
insert into member values('TWC', '트와이스', 167, NULL);
insert into member values('APN', '에이핑크', 164, 'pink@gmail.com'); -- Error 발생 : 이메일 중복

-- 체크(CHECK) 제약조건 : 데이터를 점검하는 기능
drop table if exists member;
create table member (
	mem_id 	  CHAR(8) not null primary key, 
    mem_name  VARCHAR(10) not null,
	height	  TINYINT unsigned null check(height >= 100),
    phone1	  CHAR(3) NULL
);
insert into member values('BLK', '블랙핑크', 163, NULL);
insert into member values('TWC', '트와이스', 99, NULL); -- Error 발생 : height가 설정한 값의 범위에서 벗어남

alter table member
	add constraint
    check(phone1 in ('02', '031', '032', '054', '055', '061'));
insert into member values('TWC', '트와이스', 167, '02');
insert into member values('OMY', '오마이걸', 167, '010'); -- Error 발생 : phone1이 설정한 값 중에 존재하지 않음.

-- 기본값(DEFAULT) 정의 : 값을 입력하지 않았을 때 자동으로 입력될 값 지정
drop table if exists member;
create table member (
	mem_id 	  CHAR(8) not null primary key, 
    mem_name  VARCHAR(10) not null,
	height	  TINYINT unsigned null default 160, -- 키의 기본값으로 160 설정
    phone1	  CHAR(3) NULL
);
alter table member
	alter column phone1 set default '02'; -- 연락처의 기본값을 02로 설정
insert into member values('RED', '레드벨벳', 161, '054');
insert into member values('SPC', '우주소녀', default, default);
select * from member;

-- 널 값(NULL) 허용 : 아무 것도 없음. 공백('')이나 0과는 다름.


/* 5장 3절 */
/* 뷰(VIEW)의 개념 */
use market_db;
-- 단순 뷰(하나의 테이블로 만든 뷰)
select mem_id, mem_name, addr from member;

-- 뷰의 기본 생성
create view v_member
as 
	select mem_id, mem_name, addr from member;

select * from v_member;
select mem_name, addr from v_member
	where addr in ('서울', '경기');

/* 뷰의 실제 작동 */
-- 뷰의 실제 생성
create view v_viewtest1
as 
	select B.mem_id 'Member ID', M.mem_name as 'Member Name', 
		B.prod_name 'Product Name', concat(M.phone1, M.phone2) as 'Office Phone'
		from buy B
			inner join member M
            on B.mem_id = M.mem_id;
select distinct `Member ID`, `Member Name` from v_viewtest1; -- 뷰 조회 시 열 이름에 공백이 있으면 백틱(`)으로 묶어줘야 함.

-- 뷰의 실제 수정
alter view v_viewtest1
as 
	select B.mem_id '회원 아이디', M.mem_name as '회원 이름', -- 한글 사용 가능, 권장x
		B.prod_name '제품 이름', concat(M.phone1, M.phone2) as '연락처'
		from buy B
			inner join member M
            on B.mem_id = M.mem_id;
select distinct `회원 아이디`, `회원 이름` from v_viewtest1;

-- 뷰의 실제 삭제
drop view v_viewtest1;

-- 뷰의 정보 확인
create or replace view v_viewtest2
as
	select mem_id, mem_name, addr from member;
    
describe v_viewtest2; -- key에 대한 정보는 보여주지 않음.
describe member;

-- 뷰의 소스 코드 확인
show create view v_viewtest2;

-- 뷰를 통한 테이블의 데이터 수정/삭제
update v_member set addr = '부산' where mem_id = 'BLK';
select * from v_member;

insert into v_member(mem_id, mem_name, addr) values('BTS', '방탄소년단', '경기'); -- Error 발생 : mem_number가 not null이므로 입력해줘야 함.
-- 해결법 : 회원 테이블에서 alter를 이용해서 mem_number의 속성을 null로 변경하거나 추가할 뷰를 mem_number를 포함하도록 재정의 하면 됨.

-- 지정한 범위로 뷰를 생성
create view v_height167
as
	select * from member where height >= 167;
select * from v_height167;

-- 조건에 해당하는 데이터 삭제
delete from v_height167 where height < 167;

-- 뷰를 통한 데이터 입력
insert into v_height167 values('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');
select * from v_height167; -- '티아라'가 조회되지 않음 : 뷰의 조건(키가 167이상)에 해당되지 않기 때문에 뷰에서는 보이지 않음
select * from member; -- 회원 테이블에서 '티아라'가 조회 됨

-- 뷰의 설정값의 범위를 벗어나는 값을 입력되지 않도록 속성값 수정
alter view v_height167
as
	select * from member where height >= 167
		with check option; -- 범위 체크 후 범위에서 벗어나면 입력되지 않도록 하는 옵션
insert into v_height167 values('TOB', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01'); -- 입력되지 않음을 확인

-- 복합 뷰(두 개 이상의 테이블로 만든 뷰)는 입력/수정/삭제가 불가능한 읽기 전용
create view v_complex
as
	select B.mem_id, M.mem_name, B.prod_name, M.addr
		from buy B
			inner join member M
            on B.mem_id = M.mem_id;
            
-- 뷰가 참조하는 테이블 삭제
drop table if exists buy, member;
select * from v_height167; -- Error 발생 : 참조하는 테이블이 없기 때문에 조회할 수 없음(관련 뷰가 있어도 테이블은 쉽게 삭제 됨)
check table v_height167; -- 뷰의 상태 확인 : 뷰가 참조하는 테이블이 없음을 확인