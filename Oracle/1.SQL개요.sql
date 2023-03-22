/* �⺻���� */
select * from tab;

select * from emp order by empno;

/* distinct, all */
select job from emp;

select all job from emp; 

select DISTINCT job from emp; 

/* order by: asc, desc */
select * from emp order by sal desc; 

select * from emp order by job, sal desc; 

/* alias: ��Ī */
select ename �̸�, job ����, sal �޿�
from emp
order by job, sal desc;

select deptno �μ���ȣ, round(avg(sal),1) ��ձ޿�
from emp
group by deptno
order by deptno;

/* where */
select * from emp
where sal > 100 and sal < 400
order by sal desc;

/* ��Ÿ������ */
select ename from emp where ename like '��%';

select ename from emp where ename like '%��%';

select ename from emp where comm = null;
select ename from emp where comm is null;

select ename, comm from emp where comm != null;
select ename, comm from emp where comm is not null;

/* �������� �켱���� */
select empno, sal from emp
where not(sal > 200 and sal < 300)
order by sal;

select empno, sal from emp
where sal <= 200 or sal >= 300
order by sal;

select empno, sal from emp
where not sal > 200 and sal < 300
order by sal;

/* �ǽ����� */
-- 1.
select ename, hiredate, deptno from emp
where hiredate < '2015-01-01';

-- 2.
select ename, job, deptno from emp
--where deptno = 20 or deptno = 30;
where deptno in (20, 30);
