/* ������: �Ϸù�ȣ ���� */
-- ������ ����
delete from c_emp;
create sequence c_emp_seq
    start with 1
    increment by 1;
    
-- nextval: ������ȣ
select c_emp_seq.nextval from dual;

-- currval: �����ȣ
select c_emp_seq.currval from dual;

-- ����
insert into c_emp values (c_emp_seq.nextval, 'kim', 1000, '02-123-4567', 10);
select * from c_emp;

/* mysql�� ��� AUTO_INCREMENT�� �̿��ؼ� ������ ����
USE ontime; -- db����

CREATE TABLE emp (
empno INT PRIMARY KEY AUTO_INCREMENT,
ename VARCHAR(500)
);
INSERT INTO emp (ename) VALUES ('kim');
INSERT INTO emp (ename) VALUES ('park');
INSERT INTO emp (ename) VALUES ('hong');
SELECT * FROM emp;
*/

/* ���������� �̿��ϴ� ��� */
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

/* ������ ���� */
-- 1. c_emp���̺��� id�� �Է��ϱ� ���� ������ ����(300~999)
delete from c_emp;
create sequence emp_seq
    start with 300
    increment by 1
    maxvalue 999;

-- 2. c_emp���̺� ���ο� ���ڵ� �Է�(���: �������� �Է�, �̸�: ��ö��, �μ���ȣ: 10��)
insert into c_emp(id, name, dept_id) values (c_emp_seq.nextval, '��ö��', 10);
