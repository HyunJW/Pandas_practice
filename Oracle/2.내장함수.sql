/* �����Լ� */
--null ���� ī��Ʈ
select count(*) from emp;

--null �����ϰ� ī��Ʈ
select count(empno) form emp;
select count(comm) from emp;
select sum(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select avg(sal) form emp;
select round(avg(sal), 1) from emp;
select count(*) ������, sum(sal) �޿��հ�, max(sal) �ְ�޿�, min(sal) �����޿�, avg(sal) ��ձ޿�
from emp;

/* ��¥�Լ� */
select sysdate from dual;

/* months_between(��¥1, ��¥2): (��¥1 - ��¥2)���� */
select months_between('2021/05/25', '2021/01/05') from dual;
select ename, hiredate, round(months_between(sysdate, hiredate),1) �ٹ������� from emp;

/* to_char(��¥�÷� or ��¥������, '�������'): ��¥�� ���ڿ��� ��ȯ */
select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;

/* �����Լ� */
-- trunc(����, �ڸ���): �ڸ��� ������ �Ҽ� ����
select ename, trunc((sysdate-hiredate)/365) �ټӿ��� from emp;

-- round(����, �ڸ���)
select round(10.555555, 2) from dual;

-- ceil(����): ������ �ø�
select ceil(10.1) from dual;

/* ���ǰ˻� �Լ� */
-- nvl(�÷�, ��ü��): null���̸� ��ü������ ����
select pname, pay, bonus, pay*12 + bonus ����
from prof
where majorno = 101;

select pname, pay, bonus, pay*12 + nvl(bonus,0) ����
from prof
where majorno = 101;

-- decode(A, B, A==B�϶� ��, A!=B�϶� ��)
select pname, majorno, decode(majorno, 101, '��ǻ�Ͱ���') ������ from prof;
select pname, majorno, decode(majorno, 101, '��ǻ�Ͱ���', 102, '�����ͻ��̾�', 103, '����Ʈ�������') ������ 
from prof;

/* �ǽ����� */
-- 1.
select ename, job, sal 
from emp
where sal >= 300;

-- 2.
select ename, round(months_between(sysdate, hiredate)) �ٹ������� 
from emp
where months_between(sysdate, hiredate) >= 100;

-- 3.
select ename, job, round((sysdate - hiredate)/7) �ٹ��ּ� 
from emp
order by �ٹ��ּ� desc, ename;

