/* nvl(A, B): A���� null�̸� B, �ƴϸ� A */
-- ����̸�, ��å, Ŀ�̼�(Ŀ�̼��� null�̸� sal�� 3% ����)
select ename, job, sal, comm, sal*0.03 Ŀ�̼�
from emp
where comm is null;

select ename, job, sal, comm, nvl(comm, sal*0.03) Ŀ�̼�
from emp;

-- ����̸�, ��å, ����
select ename, job, sal, comm, sal*12 + comm ����
from emp;

select ename, job, sal, comm, sal*12 + nvl(comm,0) ����
from emp;

/* decode(A, B, C, D): A,B�� ������ C, �ٸ��� D */
-- Ŀ�̼��� �ִ� ������ 5%�� ����, null�� ������ 3%�� �����ؼ� ���ʽ� ���
select ename, deptno, comm, sal*decode(comm, null, 0.03, 0.05)
from emp;

-- �޿��� ���� A,B,C,D,E������� ����
select ename, sal, decode(trunc(sal/100), 0, 'E', 1, 'D', 2, 'C', 3, 'B', 'A') �޿���� -- trunc: ����
from emp;

-- score���̺��� ��������� ���� ��ޱ���
create table score (
    student_no varchar2(20) primary key,
    name varchar2(20) not null,
    kor number default 0,
    eng number default 0,
    mat number default 0
);

insert into score values ('1', 'kim', 90, 80, 70);    
insert into score values ('2', 'park', 78, 75, 74);
insert into score values ('3', 'hong', 99, 89, 79);
insert into score values ('4', 'choi', 100, 100, 100);
insert into score values ('5', 'choi', 100, 100, 99);

select name, kor, eng, mat, (kor+eng+mat) ����, round((kor+eng+mat)/3, 2) ���,
    decode( trunc(((kor+eng+mat)/3)/10), 10, 'A', 9, 'A', 8, 'B', 7, 'C', 6, 'D', 'F') ���
from score;

/* case */
-- �����̸�, ����, �޿��Ѿ�(pay+bonus) ���(������: 10%, �α���: 7%, ������: 5%)
select pname, position,
    case when position='������' then (pay+nvl(bonus,0))*1.1
            when position='�α���' then (pay+nvl(bonus,0))*1.07
            when position='������' then (pay+nvl(bonus,0))*1.05
            else pay+nvl(bonus,0)
    end �޿�
from prof
order by �޿� desc;

-- score���̺��� ��������� ���� ��ޱ���
select name, kor, eng, mat, kor+eng+mat ����,
    round((kor+eng+mat)/3, 2) ���,
    case
        when (kor+eng+mat)/3 >= 90 then 'A'
        when (kor+eng+mat)/3 >= 80 then 'B'
        when (kor+eng+mat)/3 >= 70 then 'C'
        when (kor+eng+mat)/3 >= 60 then 'D'
        else 'F'
    end ���
from score;

/* rank */
-- rank() over
select deptno, ename, sal, rank() over(order by sal desc) ����
from emp;

-- dense_rank(): ���� ������ ����
select deptno, ename, sal, dense_rank() over(order by sal desc) ����
from emp;

-- partition by: �׷쿡 ���� ����
select deptno, ename, sal, rank() over(partition by deptno order by sal desc) ����
from emp;