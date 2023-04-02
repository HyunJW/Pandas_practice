/* �ε��� �ǽ� */
-- �����ȹ ����(F10)
select empno, ename from emp where empno=7900; 
-- by index rowid 
-- unique scan: ������ ��

select empno, ename from emp where ename='�ڹ�ö'; 
-- full scan
-- cost: 3

-- �ε��� �߰�
create index emp_ename_idx on emp(ename);

-- �ε����� ����ؼ� �˻�
select empno, ename from emp where ename='�ڹ�ö'; 
-- by index rowid batched
-- range scan: �������� ���� ��
-- cost: 2

-- �ε��� ����
drop index emp_ename_idx;

-- �ε��� �׽�Ʈ�� ���� ���̺� ����
create table emp3 (
    no number,
    name varchar2(10),
    sal number
    );
    
-- PL/SQL (Procedural Language)
declare
    i number := 1;
    name varchar(20) := 'kim';
    sal number := 0;
begin
    while i <= 100000 loop
        if i mod 2 = 0 then
            name := 'kim' || to_char(i);
            sal := 300;
        elsif i mod 3 = 0 then
            name := 'park' || to_char(i);
            sal := 400;
        elsif i mod 5 = 0 then
            name := 'hong' || to_char(i);
            sal := 500;
        else
            name := 'shin' || to_char(i);
            sal := 250;
        end if;
        insert into emp3 values (i, name, sal);
        i := i + 1;
    end loop;
end;
/
select count(*) from emp3;

-- �ε����� ������� ���� ���
select * from emp3 where name='shin691' and sal > 200;
-- full scan
-- cost: 104

-- �ε��� �߰�
create index emp_name_idx on emp3(name, sal);

-- �ε����� ����� ���
select * from emp3 where name='shin691' and sal > 200;
-- by index rowid batched
-- range scan
-- cost: 3

-- �ε��� ���� Ȯ��
select * from user_indexes where table_name='EMP3';

-- �����ε����� and���꿡�� ��� ����, or���꿡���� ������� ����
select * from emp3 where name like 'park1111%' and sal > 300;
-- by index rowid batched
-- range scan
-- cost: 3

select * from emp3 where name like 'park1111%' or sal > 300;
-- full scan
-- cost: 105

-- primary key�� �ε����� �ڵ����� ����
create table emp4 (
    no number primary key,
    name varchar2(10),
    sal number
    );
select * from user_indexes where table_name='EMP4';

-- noĮ���� primary key ����
alter table emp3 add constraint emp3_no_pk primary key(no);
select * from user_indexes where table_name='EMP3';

-- �ε����� ����� ��� �ڵ������� �̷����
select * from emp3 where no>90000;

-- primary key �������� ����(�ε��� ����)
alter table emp3 drop constraint emp3_no_pk;
select * from user_indexes where table_name='EMP3';

-- �ε����� ������� ���� ��� �ڵ� ������ �̷����� ����
select * from emp3 where no>90000;