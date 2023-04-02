/* 시퀀스: 일련번호 생성 */
-- 시퀀스 생성
delete from c_emp;
create sequence c_emp_seq
    start with 1
    increment by 1;
    
-- nextval: 다음번호
select c_emp_seq.nextval from dual;

-- currval: 현재번호
select c_emp_seq.currval from dual;

-- 예시
insert into c_emp values (c_emp_seq.nextval, 'kim', 1000, '02-123-4567', 10);
select * from c_emp;

/* mysql의 경우 AUTO_INCREMENT를 이용해서 시퀀스 생성
USE ontime; -- db선택

CREATE TABLE emp (
empno INT PRIMARY KEY AUTO_INCREMENT,
ename VARCHAR(500)
);
INSERT INTO emp (ename) VALUES ('kim');
INSERT INTO emp (ename) VALUES ('park');
INSERT INTO emp (ename) VALUES ('hong');
SELECT * FROM emp;
*/

/* 서브쿼리를 이용하는 방법 */
delete from c_emp;
select max(id)+1 from c_emp;
select nvl(max(id)+1, 1) from c_emp;
insert into c_emp values 
    ((select nvl(max(id)+1, 1) from c_emp), 'park', 3000, '02-123-4567', 10);
insert into c_emp values 
    ((select nvl(max(id)+1, 1) from c_emp), 'song', 3000, '02-123-4567', 10);
insert into c_emp values 
    ((select nvl(max(id)+1, 1) from c_emp), 'hong', 3000, '02-123-4567', 10);
select * from c_emp;

/* 시퀀스 문제 */
-- 1. c_emp테이블에서 id를 입력하기 위한 시퀀스 생성(300~999)
delete from c_emp;
create sequence emp_seq
    start with 300
    increment by 1
    maxvalue 999;

-- 2. c_emp테이블에 새로운 레코드 입력(사번: 시퀀스로 입력, 이름: 김철수, 부서번호: 10번)
insert into c_emp(id, name, dept_id) values (c_emp_seq.nextval, '김철수', 10);
