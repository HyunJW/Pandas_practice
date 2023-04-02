/* 메인쿼리와 독립적인 서브쿼리 */
-- 월급을 가장 적게 받는 사원
select min(sal) from emp;

select * from emp 
where sal = 300;

select * from emp 
where sal = (select min(sal) from emp);

-- 사원들의 평균 월급보다 많은 급여를 받는 사원
select avg(sal) from emp; 

select ename, dname, sal
from emp e, dept d
where e.deptno = d.deptno
and sal > (select avg(sal) from emp);

-- 기획팀 직원들(부서코드 30)의 최고급여보다 높은 월급을 받는 사원
select max(sal) from emp 
where deptno = 30;

select ename, dname
from emp e, dept d
where e.deptno = d.deptno
and sal > (select max(sal) from emp where deptno = 30);

/* 메인쿼리와 연관성이 있는 서브쿼리 */
-- 사원이름, 부서코드, 부서명(join으로 처리)
select ename, e.deptno, dname
from emp e , dept d
where e.deptno = d.deptno;

-- 서브쿼리로 처리
select ename, deptno, 
    (select dname from dept where deptno = e.deptno) dname 
from emp e;

-- 사원이 근무하는 부서의 평균급여보다 적은 급여를 받는 직원
select ename, sal, deptno 
from emp e
where sal< (select avg(sal) from emp where deptno=e.deptno);

/* 인라인 뷰 */
-- 평균금액보다는 높고 최고금액보다는 낮은 월급을 받는 직원
select empno, ename, sal, round(e2.avgs),e2.maxs 
from emp , (select avg(sal) avgs, max(sal) maxs from emp) e2
where sal > e2.avgs and sal < e2.maxs
order by sal desc;

/* scalar 서브쿼리 */
-- 사원이름, 급여, 소속  부서의 평균급여
SELECT ename, sal, 
    (select AVG(sal) FROM emp) avg_sal,
    (select AVG(sal) FROM emp 
    WHERE deptno=e.deptno) dept_avg_sal 
FROM emp e;

/* 실습문제 */
-- 1. 조재철교수보다 나중에 입사한 교수
select pname, hiredate, mname 
from prof p, major m
where p.majorno=m.majorno 
and hiredate > (select hiredate from prof where pname='조재철');

-- 2. 심상수 교수보다 나중에 입사한 교수중 박철호 교수보다 월급을 적게 받는 교수
select pname, pay, hiredate
from prof
where hiredate > (select hiredate from prof where pname='심상수')
and pay < (select pay from prof where pname='박철호');