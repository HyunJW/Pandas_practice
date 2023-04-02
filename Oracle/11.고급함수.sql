/* nvl(A, B): A값이 null이면 B, 아니면 A */
-- 사원이름, 직책, 커미션(커미션이 null이면 sal의 3% 적용)
select ename, job, sal, comm, sal*0.03 커미션
from emp
where comm is null;

select ename, job, sal, comm, nvl(comm, sal*0.03) 커미션
from emp;

-- 사원이름, 직책, 연봉
select ename, job, sal, comm, sal*12 + comm 연봉
from emp;

select ename, job, sal, comm, sal*12 + nvl(comm,0) 연봉
from emp;

/* decode(A, B, C, D): A,B가 같으면 C, 다르면 D */
-- 커미션이 있는 직원은 5%를 적용, null인 직원은 3%를 적용해서 보너스 계산
select ename, deptno, comm, sal*decode(comm, null, 0.03, 0.05)
from emp;

-- 급여에 따라 A,B,C,D,E등급으로 구분
select ename, sal, decode(trunc(sal/100), 0, 'E', 1, 'D', 2, 'C', 3, 'B', 'A') 급여등급 -- trunc: 버림
from emp;

-- score테이블에서 평균점수에 따른 등급구분
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

select name, kor, eng, mat, (kor+eng+mat) 총점, round((kor+eng+mat)/3, 2) 평균,
    decode( trunc(((kor+eng+mat)/3)/10), 10, 'A', 9, 'A', 8, 'B', 7, 'C', 6, 'D', 'F') 등급
from score;

/* case */
-- 교수이름, 직위, 급여총액(pay+bonus) 계산(정교수: 10%, 부교수: 7%, 조교수: 5%)
select pname, position,
    case when position='정교수' then (pay+nvl(bonus,0))*1.1
            when position='부교수' then (pay+nvl(bonus,0))*1.07
            when position='조교수' then (pay+nvl(bonus,0))*1.05
            else pay+nvl(bonus,0)
    end 급여
from prof
order by 급여 desc;

-- score테이블에서 평균점수에 따른 등급구분
select name, kor, eng, mat, kor+eng+mat 총점,
    round((kor+eng+mat)/3, 2) 평균,
    case
        when (kor+eng+mat)/3 >= 90 then 'A'
        when (kor+eng+mat)/3 >= 80 then 'B'
        when (kor+eng+mat)/3 >= 70 then 'C'
        when (kor+eng+mat)/3 >= 60 then 'D'
        else 'F'
    end 등급
from score;

/* rank */
-- rank() over
select deptno, ename, sal, rank() over(order by sal desc) 순위
from emp;

-- dense_rank(): 동률 순위를 무시
select deptno, ename, sal, dense_rank() over(order by sal desc) 순위
from emp;

-- partition by: 그룹에 대한 순위
select deptno, ename, sal, rank() over(partition by deptno order by sal desc) 순위
from emp;