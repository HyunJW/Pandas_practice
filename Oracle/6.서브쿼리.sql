/* ���������� �������� �������� */
-- ������ ���� ���� �޴� ���
select min(sal) from emp;

select * from emp 
where sal = 300;

select * from emp 
where sal = (select min(sal) from emp);

-- ������� ��� ���޺��� ���� �޿��� �޴� ���
select avg(sal) from emp; 

select ename, dname, sal
from emp e, dept d
where e.deptno = d.deptno
and sal > (select avg(sal) from emp);

-- ��ȹ�� ������(�μ��ڵ� 30)�� �ְ�޿����� ���� ������ �޴� ���
select max(sal) from emp 
where deptno = 30;

select ename, dname
from emp e, dept d
where e.deptno = d.deptno
and sal > (select max(sal) from emp where deptno = 30);

/* ���������� �������� �ִ� �������� */
-- ����̸�, �μ��ڵ�, �μ���(join���� ó��)
select ename, e.deptno, dname
from emp e , dept d
where e.deptno = d.deptno;

-- ���������� ó��
select ename, deptno, 
    (select dname from dept where deptno = e.deptno) dname 
from emp e;

-- ����� �ٹ��ϴ� �μ��� ��ձ޿����� ���� �޿��� �޴� ����
select ename, sal, deptno 
from emp e
where sal< (select avg(sal) from emp where deptno=e.deptno);

/* �ζ��� �� */
-- ��ձݾ׺��ٴ� ���� �ְ�ݾ׺��ٴ� ���� ������ �޴� ����
select empno, ename, sal, round(e2.avgs),e2.maxs 
from emp , (select avg(sal) avgs, max(sal) maxs from emp) e2
where sal > e2.avgs and sal < e2.maxs
order by sal desc;

/* scalar �������� */
-- ����̸�, �޿�, �Ҽ�  �μ��� ��ձ޿�
SELECT ename, sal, 
    (select AVG(sal) FROM emp) avg_sal,
    (select AVG(sal) FROM emp 
    WHERE deptno=e.deptno) dept_avg_sal 
FROM emp e;

/* �ǽ����� */
-- 1. ����ö�������� ���߿� �Ի��� ����
select pname, hiredate, mname 
from prof p, major m
where p.majorno=m.majorno 
and hiredate > (select hiredate from prof where pname='����ö');

-- 2. �ɻ�� �������� ���߿� �Ի��� ������ ��öȣ �������� ������ ���� �޴� ����
select pname, pay, hiredate
from prof
where hiredate > (select hiredate from prof where pname='�ɻ��')
and pay < (select pay from prof where pname='��öȣ');