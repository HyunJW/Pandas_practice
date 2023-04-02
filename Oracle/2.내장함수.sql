/* 집계함수 */
--null 포함 카운트
select count(*) from emp;

--null 제외하고 카운트
select count(empno) form emp;
select count(comm) from emp;
select sum(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select avg(sal) form emp;
select round(avg(sal), 1) from emp;
select count(*) 직원수, sum(sal) 급여합계, max(sal) 최고급여, min(sal) 최저급여, avg(sal) 평균급여
from emp;

/* 날짜함수 */
select sysdate from dual;

/* months_between(날짜1, 날짜2): (날짜1 - 날짜2)개월 */
select months_between('2021/05/25', '2021/01/05') from dual;
select ename, hiredate, round(months_between(sysdate, hiredate),1) 근무개월수 from emp;

/* to_char(날짜컬럼 or 날짜데이터, '출력형식'): 날짜를 문자열로 변환 */
select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;

/* 숫자함수 */
-- trunc(숫자, 자리수): 자리수 이하의 소수 버림
select ename, trunc((sysdate-hiredate)/365) 근속연수 from emp;

-- round(숫자, 자리수)
select round(10.555555, 2) from dual;

-- ceil(숫자): 정수로 올림
select ceil(10.1) from dual;

/* 조건검사 함수 */
-- nvl(컬럼, 대체값): null값이면 대체값으로 변경
select pname, pay, bonus, pay*12 + bonus 연봉
from prof
where majorno = 101;

select pname, pay, bonus, pay*12 + nvl(bonus,0) 연봉
from prof
where majorno = 101;

-- decode(A, B, A==B일때 값, A!=B일때 값)
select pname, majorno, decode(majorno, 101, '컴퓨터공학') 전공명 from prof;
select pname, majorno, decode(majorno, 101, '컴퓨터공학', 102, '데이터사이언스', 103, '소프트웨어공학') 전공명 
from prof;

/* 실습문제 */
-- 1.
select ename, job, sal 
from emp
where sal >= 300;

-- 2.
select ename, round(months_between(sysdate, hiredate)) 근무개월수 
from emp
where months_between(sysdate, hiredate) >= 100;

-- 3.
select ename, job, round((sysdate - hiredate)/7) 근무주수 
from emp
order by 근무주수 desc, ename;

