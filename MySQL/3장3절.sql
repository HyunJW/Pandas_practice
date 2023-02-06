-- 3장 3절 --
USE market_db;
-- INSERT : INSERT INTO 테이블 [(열1, 열2, ...)] VALUES (값1, 값2, ...)
create table hongong1 (toy_id INT, toy_name CHAR(4), age INT);
insert into hongong1 values (1, '우디', 25);
select * from hongong1;
insert into hongong1 (toy_id, toy_name) values (2, '버즈');
select * from hongong1;
insert into hongong1 (toy_name, age, toy_id) values ('제시', 20, 3);
select * from hongong1;

create table hongong2 (
	toy_id INT AUTO_INCREMENT PRIMARY KEY, 
    toy_name CHAR(4), 
    age INT);
insert into hongong2 values(null, '보핍', 25);
insert into hongong2 values(null, '슬링키', 22);
insert into hongong2 values(null, '렉스', 21);
select * from hongong2;

select last_insert_id(); -- 마지막 id값 확인

-- ALTER TABLE 테이블 AUTO_INCREMENT=시작값
alter table hongong2 auto_increment=100;
insert into hongong2 values(null, '재남', 35);
select * from hongong2;

-- 3번 테이블 : 1000번부터 시작하고 간격이 3씩 증가하며 자동으로 id가 부여
create table hongong3(
	toy_id INT AUTO_INCREMENT PRIMARY KEY, 
    toy_name CHAR(4), 
	age INT);
alter table hongong3 auto_increment=1000; -- 시작값을 1000으로 지정
set @@auto_increment_increment=3; -- 증가값을 3으로 지정
insert into hongong3 values(null, '토마스', 20);
insert into hongong3 values(null, '제임스', 23);
insert into hongong3 values(null, '고든', 25);
select * from hongong3;

-- INSERT INTO ~ SELECT : 다른 테이블의 데이터 가져오기
select count(*) from world.city;
desc world.city;
select * from world.city limit 5;
create table city_popul (city_name CHAR(35), population INT);
insert into city_popul select Name, Population from world.city;
select * from city_popul;

-- UPDATE 테이블 SET 열1=값1, 열2=값2, ... WHERE 조건; : 데이터 수정
use market_db;
update city_popul set city_name = '서울' where city_name = 'Seoul';
select * from city_popul where city_name = '서울';

select * from city_popul where city_name = 'New York';
update city_popul set city_name = '뉴욕' where city_name = 'New York';
select * from city_popul where city_name = '뉴욕';

update city_popul set population = population / 10000;
select * from city_popul limit 5;

-- DELETE FROM 테이블 WHERE 조건; : 행 데이터 삭제
-- city_popul에서 New로 시작하는 11개 도시들을 삭제
delete from city_popul where city_name like 'New%';
select * from city_popul limit 5; -- 5개를 조회

-- city_popul에서 New로 시작하는 상위 5개 도시들을 삭제
delete from city_popul where city_name like 'New%' limit 5;

-- 대용량 테이블 삭제
create table big_table1 (select * from world.city, sakila.country);
create table big_table2 (select * from world.city, sakila.country);
create table big_table3 (select * from world.city, sakila.country);
select count(*) from big_table3;

delete from big_table1; -- 행 단위로 삭제, 조건이 없다면 전체 행 삭제(시간이 오래걸림)
select count(*) from big_table1; -- 빈 테이블이 남음

drop table big_table2; -- 테이블 자체를 삭제(속도가 빠름)
select count(*) from big_table2;

truncate table big_table3; -- delete와 비슷한 효과(전체 행 삭제)를 내지만 속도가 빠름
select count(*) from big_table3; -- 빈 테이블이 남음
