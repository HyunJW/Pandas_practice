/* group by */
-- emp���̺��� �μ��ڵ庰�� �޿����� ���
select deptno, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp
group by deptno
order by deptno;

select e.deptno, dname, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp e, dept d
where e.deptno=d.deptno
group by e.deptno, dname
order by deptno;

-- �����ڵ庰 �������� ��� �޿�
SELECT majorno, AVG(pay)
FROM prof
GROUP BY majorno 
ORDER BY majorno;

SELECT p.majorno, mname, AVG(pay)
FROM prof p, major m
WHERE p.majorno= m.majorno
GROUP BY p.majorno, mname
ORDER BY p.majorno;

-- �����ڵ庰, ���޺� ��� �޿�
select majorno, position, avg(pay) 
from prof
group by majorno, position
order by majorno, position;

/* having */
-- �������� ��� �޿��� 450�̻��� ������ ��ձ޿� ���
select mname, avg(pay)
from prof p, major m
where p.majorno= m.majorno
group by mname
having avg(pay) > = 450;

/* �ǽ����� */
-- 1. stud���̺�� prof���̺��� �����Ͽ� �����ڵ庰�� ����
select s.majorno, mname, count(*)
from stud s , major m
where s.majorno = m.majorno
group by s.majorno, mname;

-- 2. stud���̺�� prof���̺��� �����Ͽ� �������� ������� ����
select p.profno, pname, count(*)
from prof p, stud s 
where p.profno=s.profno
group by p.profno, pname;

-- 3. ���� �� �޿��Ѿ��� ���� ���� ����, ���� ���� ����, �޿��Ѿ��� ��ձݾ� ���(�����ڵ庰 ����)
select majorno, max(pay+bonus), min(pay+bonus), round(avg(pay+bonus),1)
from prof
group by majorno;

-- 3-1. bonus�� null�ΰ�� ��ü�� ����
select majorno, max(pay+nvl(bonus,0)), min(pay+nvl(bonus,0)), round(avg(pay+nvl(bonus,0)),1)
from prof
group by majorno;