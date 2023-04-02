/* group by */
-- emp테이블에서 부서코드별로 급여정보 출력
select deptno, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp
group by deptno
order by deptno;

select e.deptno, dname, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp e, dept d
where e.deptno=d.deptno
group by e.deptno, dname
order by deptno;

-- 전공코드별 교수들의 평균 급여
SELECT majorno, AVG(pay)
FROM prof
GROUP BY majorno 
ORDER BY majorno;

SELECT p.majorno, mname, AVG(pay)
FROM prof p, major m
WHERE p.majorno= m.majorno
GROUP BY p.majorno, mname
ORDER BY p.majorno;

-- 전공코드별, 직급별 평균 급여
select majorno, position, avg(pay) 
from prof
group by majorno, position
order by majorno, position;

/* having */
-- 교수들의 평균 급여가 450이상인 전공과 평균급여 출력
select mname, avg(pay)
from prof p, major m
where p.majorno= m.majorno
group by mname
having avg(pay) > = 450;

/* 실습문제 */
-- 1. stud테이블과 prof테이블을 조인하여 전공코드별로 집계
select s.majorno, mname, count(*)
from stud s , major m
where s.majorno = m.majorno
group by s.majorno, mname;

-- 2. stud테이블과 prof테이블을 조인하여 지도교수 사번별로 집계
select p.profno, pname, count(*)
from prof p, stud s 
where p.profno=s.profno
group by p.profno, pname;

-- 3. 교수 중 급여총액이 가장 높은 교수, 가장 낮은 교수, 급여총액의 평균금액 출력(전공코드별 집계)
select majorno, max(pay+bonus), min(pay+bonus), round(avg(pay+bonus),1)
from prof
group by majorno;

-- 3-1. bonus가 null인경우 대체값 지정
select majorno, max(pay+nvl(bonus,0)), min(pay+nvl(bonus,0)), round(avg(pay+nvl(bonus,0)),1)
from prof
group by majorno;