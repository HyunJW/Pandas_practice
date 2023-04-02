/* ���̺� */
-- ���̺� ����
create table t_emp(
    id number not null,
    name varchar2(25),
    salary number(7,2),
    phone varchar2(15),
    dept_name varchar2(25)
    );
    
-- ���̺�� ����
rename t_emp to s_emp;

-- ������ �Է�
insert into s_emp values(100, '������', 3000,'010-222-3333', '������');
insert into s_emp values(101, '�ּ�ö', 3600,'010-333-4444', '������');
insert into s_emp values(102, '������', 4500,'010-444-5555', '������');

-- �÷� �߰�
alter table s_emp add hire_date date;

-- �÷� ����
alter table s_emp modify phone varchar2(50);

-- �÷��� ����
alter table s_emp rename column id to t_id;

-- �÷� ����
alter table s_emp drop column dept_name;

/* insert, update, delete */
-- ���� ���ڵ��� hire_date ����
update s_emp set hire_date= sysdate where t_id = 100;
update s_emp set hire_date= sysdate where t_id = 101;
update s_emp set hire_date= sysdate where t_id = 102;

-- ���ο� ���ڵ� �߰�
insert into s_emp (t_id,hire_date) values(40,sysdate );

-- ���ڵ� ����
delete from s_emp where t_id=102;

-- email mailid 20byte �� �����ϱ� ���� �÷��� �� �߰�
alter table s_emp add mailid varchar2(20);

-- mailid 30byte �÷��� �� ����
alter table s_emp modify mailid varchar2(30);

-- mailid e_mail �÷����� �� ����
alter table s_emp rename column mailid to e_mail;

-- s_emp t_emp ���̺���� �� ����
rename s_emp to t_emp;

/* �������� �ǽ� */
-- ���̺� ����
create table c_emp(
    id number,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number
    );

-- ���ڵ� ����(�ߺ��� ���̵�)
insert into c_emp (id,name) values (1,'��ö��');
insert into c_emp (id,name) values (1,'���ö'); 

select * from c_emp;

-- ���ڵ� ����
delete from c_emp;
select * from c_emp;

-- primary key �������� �߰�
alter table c_emp add primary key(id);

-- primary key �������� ����
alter table c_emp drop primary key;

-- �������� �̸� �����ؼ� �߰�
alter table c_emp add constraint c_emp_id_pk primary key(id);

-- ����ڰ� ���� �������� ��ȸ
select * from user_constraints where table_name='C_EMP';

-- ���Ἲ �������� ���� 
insert into c_emp (id,name) values (1,'��ö��');
insert into c_emp (id,name) values (1,'���ö'); 

-- ���������� �߰��ؼ� ���̺� ����
drop table c_emp;
create table c_emp (
    id number primary key,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number
    );
    
select * from user_constraints where table_name='C_EMP';

insert into c_emp (id,name) values (1,'��ö��');
-- ���Ἲ �������� ���� 
insert into c_emp (id,name) values (1,'���ö'); 

-- check ��������
drop table c_emp;
create table c_emp (
    id number(5),
    name varchar2(25),
    salary number(7,2) constraint c_emp_salary_ck check(salary between 100 and 1000),
    phone varchar2(15),
    dept_id number(7)
    );

insert into c_emp (id,name,salary) values (1,'kim',500);
-- check �������� ����
insert into c_emp (id,name,salary) values (2,'park',1500);

-- Foreign key ��������
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
-- ���Ἲ �������� ����(�θ� Ű�� ����)
insert into c_emp (id,name,dept_id) values (3,'park',50);

-- unique ��������
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
-- ���Ἲ �������� ����(unique)
insert into c_emp (id,name) values (2,'kim');

-- null �Է� ����
insert into c_emp (id) values (3);
insert into c_emp (id) values (4);

-- �������� ����
alter table c_emp drop constraint c_emp_name_un;

insert into c_emp (name) values ('kim');
insert into c_emp (name) values ('kim');
insert into c_emp (name) values ('kim');
select * from c_emp;