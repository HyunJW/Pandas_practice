/* 테이블 */
-- 테이블 생성
create table t_emp(
    id number not null,
    name varchar2(25),
    salary number(7,2),
    phone varchar2(15),
    dept_name varchar2(25)
    );
    
-- 테이블명 수정
rename t_emp to s_emp;

-- 데이터 입력
insert into s_emp values(100, '이정민', 3000,'010-222-3333', '개발팀');
insert into s_emp values(101, '최순철', 3600,'010-333-4444', '연구팀');
insert into s_emp values(102, '장혜숙', 4500,'010-444-5555', '영업팀');

-- 컬럼 추가
alter table s_emp add hire_date date;

-- 컬럼 수정
alter table s_emp modify phone varchar2(50);

-- 컬럼명 변경
alter table s_emp rename column id to t_id;

-- 컬럼 삭제
alter table s_emp drop column dept_name;

/* insert, update, delete */
-- 기존 레코드의 hire_date 수정
update s_emp set hire_date= sysdate where t_id = 100;
update s_emp set hire_date= sysdate where t_id = 101;
update s_emp set hire_date= sysdate where t_id = 102;

-- 새로운 레코드 추가
insert into s_emp (t_id,hire_date) values(40,sysdate );

-- 레코드 삭제
delete from s_emp where t_id=102;

-- email mailid 20byte 을 관리하기 위한 컬럼을 로 추가
alter table s_emp add mailid varchar2(20);

-- mailid 30byte 컬럼을 로 수정
alter table s_emp modify mailid varchar2(30);

-- mailid e_mail 컬럼명을 로 수정
alter table s_emp rename column mailid to e_mail;

-- s_emp t_emp 테이블명을 로 변경
rename s_emp to t_emp;

/* 제약조건 실습 */
-- 테이블 생성
create table c_emp(
    id number,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number
    );

-- 레코드 삽입(중복된 아이디)
insert into c_emp (id,name) values (1,'김철수');
insert into c_emp (id,name) values (1,'김기철'); 

select * from c_emp;

-- 레코드 삭제
delete from c_emp;
select * from c_emp;

-- primary key 제약조건 추가
alter table c_emp add primary key(id);

-- primary key 제약조건 삭제
alter table c_emp drop primary key;

-- 제약조건 이름 지정해서 추가
alter table c_emp add constraint c_emp_id_pk primary key(id);

-- 사용자가 만든 제약조건 조회
select * from user_constraints where table_name='C_EMP';

-- 무결성 제약조건 위배 
insert into c_emp (id,name) values (1,'김철수');
insert into c_emp (id,name) values (1,'김기철'); 

-- 제약조건을 추가해서 테이블 생성
drop table c_emp;
create table c_emp (
    id number primary key,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number
    );
    
select * from user_constraints where table_name='C_EMP';

insert into c_emp (id,name) values (1,'김철수');
-- 무결성 제약조건 위배 
insert into c_emp (id,name) values (1,'김기철'); 

-- check 제약조건
drop table c_emp;
create table c_emp (
    id number(5),
    name varchar2(25),
    salary number(7,2) constraint c_emp_salary_ck check(salary between 100 and 1000),
    phone varchar2(15),
    dept_id number(7)
    );

insert into c_emp (id,name,salary) values (1,'kim',500);
-- check 제약조건 위배
insert into c_emp (id,name,salary) values (2,'park',1500);

-- Foreign key 제약조건
drop table c_emp;
create table c_emp (
    id number primary key,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number,
    foreign key(dept_id) references dept(deptno)
    );
    
insert into c_emp (id,name,dept_id) values (1,'kim',10);
insert into c_emp (id,name,dept_id) values (2,'park',20);
-- 무결성 제약조건 위배(부모 키가 없음)
insert into c_emp (id,name,dept_id) values (3,'park',50);

-- unique 제약조건
drop table c_emp;
create table c_emp (
    id number,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number,
    constraint c_emp_name_un unique(name)
    );

insert into c_emp (id,name) values (1,'kim');
-- 무결성 제약조건 위배(unique)
insert into c_emp (id,name) values (2,'kim');

-- null 입력 가능
insert into c_emp (id) values (3);
insert into c_emp (id) values (4);

-- 제약조건 삭제
alter table c_emp drop constraint c_emp_name_un;

insert into c_emp (name) values ('kim');
insert into c_emp (name) values ('kim');
insert into c_emp (name) values ('kim');
select * from c_emp;