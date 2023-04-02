/* PL/SQL�� ����
declare -�����(����, ���, CURSOR ��)
begin -�����(SQL ��ɾ�, �ݺ���, ���ǹ� ��)
exception -����ó����
end;
*/

/* PL/SQL ��ɾ��� ����
-Anonymous Block(�͸� ���): �̸��� ���� ���
-Procedure(���ν���): DB�� ����Ǿ� �ݺ������� ����� �� �ִ� ���, �Ű����� ����� ����
-Function(�Լ�): �Է¸Ű������� ��밡��, ����Ÿ���� �ݵ�� ����
*/

/* ���� ���ν��� */
-- �޿� �λ� ���� ���ν��� �ǽ�
create or replace procedure sal_p(p_empno number)
is
begin
    update emp
    set sal=sal*1.1
    where empno=p_empno;
end;
/
select * from emp;
execute sal_p(7499); -- ���ν��� ����: 7499�� �޿��� 10% ���
select * from emp;
select * from user_source where name='SAL_P';

-- ���ٸ޸��� ���� ���ν��� �ǽ�
create table memo (
    idx number primary key,
    writer varchar2(50) not null,
    memo varchar2(500) not null,
    post_date date default sysdate
);

create sequence memo_seq
    start with 1
    increment by 1;
    
insert into memo(idx, writer, memo) values(memo_seq.nextval, 'kim', 'memo');
insert into memo(idx, writer, memo) values(memo_seq.nextval, 'park', 'memo2');

alter table memo add ip varchar2(50);
desc memo;

create or replace procedure memo_insert_p(p_writer varchar, p_memo varchar, p_ip varchar)
is
begin
    insert into memo(idx, writer, memo, ip) values(memo_seq.nextval, p_writer, p_memo, p_ip);
end;
/

execute memo_insert_p('��ö��', '�޸�...', '192.168.0.10');
select * from memo;

select * from user_source where name='MEMO_INSERT_P';

/* �Լ� */
create or replace function sal_f (p_empno number)
return number
is
    v_sal number;
begin
    update emp set sal=sal*1.1 where empno=p_empno; -- ó�� ������ ������ �ּ�ó��
    
    select sal into v_sal from emp
    where empno=p_empno;
    return v_sal;
end;
/
select sal from emp where empno=7499; 

-- update �ּ�ó�� �� ����
select sal_f(7499) from dual;
select empno, ename, sal, sal*1.1, sal_f(empno) from emp;

-- update �ּ�ó�� Ǯ�� �ٽ� ����
var salary number;
execute :salary := sal_f(7499);
print salary;

/* IF�� */
create or replace procedure dept_p(p_empno number)
is
    v_deptno number;
begin
    select deptno into v_deptno from emp
    where empno=p_empno;
    dbms_output.put_line('�μ��ڵ�:'||v_deptno);
    if v_deptno = 10 then
        dbms_output.put_line('������ �����Դϴ�');
    elsif v_deptno = 20 then
        dbms_output.put_line('ȫ���� �����Դϴ�');
    elsif v_deptno = 30 then
        dbms_output.put_line('��ȹ�� �����Դϴ�');
    else
        dbms_output.put_line('��Ÿ�μ� �����Դϴ�');
    end if;
end;
/
select * from dept;
set serveroutput on -- �ܼ� ��� Ȱ��ȭ
select * from emp;
execute dept_p(7782);
execute dept_p(7788);
execute dept_p(7844);

/* FOR LOOP�� */
set serveroutput on
delete from emp where empno <= 100;
begin
    for cnt in 1 .. 100 loop
        insert into emp(empno, ename, hiredate) values(cnt, 'test'||cnt, sysdate);
    end loop;
    dbms_output.put_line('100���� ���ڵ尡 �ԷµǾ����ϴ�.');
end;
/
select * from emp where empno <= 100;

/* LOOP�� */
set serveroutput on
delete from emp where empno <= 100;
declare -- ���� �����
    cnt number := 1;
begin -- �����
    loop
        insert into emp(empno, ename, hiredate) values(cnt, 'test'||cnt, sysdate);
    exit when cnt >= 100;
    cnt := cnt + 1;
    end loop;
    dbms_output.put_line('100���� ���ڵ尡 �ԷµǾ����ϴ�.');
end;
/
select * from emp where empno <= 100;

/* WHILE LOOP */
delete from emp where empno <= 100;
declare -- ���� �����
    cnt number := 1;
begin -- �����
    while cnt <= 100 loop
        insert into emp(empno, ename, hiredate) values(cnt, 'test'||cnt, sysdate);
        cnt := cnt + 1;
    end loop;
    dbms_output.put_line('100���� ���ڵ尡 �ԷµǾ����ϴ�.');
end;
/
select * from emp where empno <= 100;

/* Ŀ��(Cursor) */
-- �ϳ��� �μ��� ���� ���� ��������
create or replace procedure cursor_p(p_deptno number)
is
    cursor cursor_avg is
        select dname, count(empno) cnt, round(avg(sal),1) sal
        from emp e, dept d
        where e.deptno=d.deptno
        and e.deptno = p_deptno
        group by dname;
        
    dname varchar(50);
    cnt number;
    sal_avg number;
begin
    open cursor_avg; -- Ŀ�� ����: select��ɾ� ����
    
    fetch cursor_avg into dname, cnt, sal_avg; -- ���ڵ� �� ���� ����
    dbms_output.put_line('�μ���:'|| dname);
    dbms_output.put_line('�����:'|| cnt);
    dbms_output.put_line('��ձ޿�:'|| sal_avg);
    
    close cursor_avg;
end;
/
execute cursor_p(10);

-- ��� �μ��� ���� ���� ��������
create or replace procedure cursor2_p -- ��ȣ ����(���޵Ǵ� ���� ����)
is
    cursor cursor_avg is
        select dname, count(empno) cnt, round(avg(sal),1) sal
        from emp e, dept d
        where e.deptno=d.deptno
        group by dname;
begin
    for row in cursor_avg loop
        dbms_output.put_line('�μ���:'|| row.dname);
        dbms_output.put_line('�����:'|| row.cnt);
        dbms_output.put_line('��ձ޿�:'|| row.sal);
    end loop;
end;
/
execute cursor2_p;

/* Ʈ���� */
-- before: ���ڵ� ���� ���� ����/ after: ���ڵ� ���� �Ŀ� ����
create or replace trigger sum_t
after
    insert or update or delete on emp
declare
    avg_sal number;
begin
    select avg(sal) into avg_sal from emp;
    dbms_output.put_line('�޿����:'|| avg_sal);
end;
/
set serveroutput on;
select avg(sal) from emp;
insert into emp(empno, ename,  hiredate, sal) values (1000, '��ö��', sysdate, 500);
update emp set sal=600 where empno=1000;
delete from emp where empno=1000;