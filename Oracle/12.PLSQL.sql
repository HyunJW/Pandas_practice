/* PL/SQL의 형식
declare -선언부(변수, 상수, CURSOR 등)
begin -실행부(SQL 명령어, 반복문, 조건문 등)
exception -예외처리부
end;
*/

/* PL/SQL 명령어의 종류
-Anonymous Block(익명 블록): 이름이 없는 블록
-Procedure(프로시저): DB에 저장되어 반복적으로 사용할 수 있는 블록, 매개변수 입출력 가능
-Function(함수): 입력매개변수만 사용가능, 리턴타입을 반드시 지정
*/

/* 저장 프로시저 */
-- 급여 인상 저장 프로시저 실습
create or replace procedure sal_p(p_empno number)
is
begin
    update emp
    set sal=sal*1.1
    where empno=p_empno;
end;
/
select * from emp;
execute sal_p(7499); -- 프로시저 실행: 7499의 급여가 10% 상승
select * from emp;
select * from user_source where name='SAL_P';

-- 한줄메모장 저장 프로시저 실습
create table memo (
    idx number primary key,
    writer varchar2(50) not null,
    memo varchar2(500) not null,
    post_date date default sysdate
);

create sequence memo_seq
    start with 1
    increment by 1;
    
insert into memo(idx, writer, memo) values(memo_seq.nextval, 'kim', 'memo');
insert into memo(idx, writer, memo) values(memo_seq.nextval, 'park', 'memo2');

alter table memo add ip varchar2(50);
desc memo;

create or replace procedure memo_insert_p(p_writer varchar, p_memo varchar, p_ip varchar)
is
begin
    insert into memo(idx, writer, memo, ip) values(memo_seq.nextval, p_writer, p_memo, p_ip);
end;
/

execute memo_insert_p('김철수', '메모...', '192.168.0.10');
select * from memo;

select * from user_source where name='MEMO_INSERT_P';

/* 함수 */
create or replace function sal_f (p_empno number)
return number
is
    v_sal number;
begin
    update emp set sal=sal*1.1 where empno=p_empno; -- 처음 실행할 때에는 주석처리
    
    select sal into v_sal from emp
    where empno=p_empno;
    return v_sal;
end;
/
select sal from emp where empno=7499; 

-- update 주석처리 후 실행
select sal_f(7499) from dual;
select empno, ename, sal, sal*1.1, sal_f(empno) from emp;

-- update 주석처리 풀고 다시 실행
var salary number;
execute :salary := sal_f(7499);
print salary;

/* IF문 */
create or replace procedure dept_p(p_empno number)
is
    v_deptno number;
begin
    select deptno into v_deptno from emp
    where empno=p_empno;
    dbms_output.put_line('부서코드:'||v_deptno);
    if v_deptno = 10 then
        dbms_output.put_line('교육팀 직원입니다');
    elsif v_deptno = 20 then
        dbms_output.put_line('홍보팀 직원입니다');
    elsif v_deptno = 30 then
        dbms_output.put_line('기획팀 직원입니다');
    else
        dbms_output.put_line('기타부서 직원입니다');
    end if;
end;
/
select * from dept;
set serveroutput on -- 콘솔 출력 활성화
select * from emp;
execute dept_p(7782);
execute dept_p(7788);
execute dept_p(7844);

/* FOR LOOP문 */
set serveroutput on
delete from emp where empno <= 100;
begin
    for cnt in 1 .. 100 loop
        insert into emp(empno, ename, hiredate) values(cnt, 'test'||cnt, sysdate);
    end loop;
    dbms_output.put_line('100개의 레코드가 입력되었습니다.');
end;
/
select * from emp where empno <= 100;

/* LOOP문 */
set serveroutput on
delete from emp where empno <= 100;
declare -- 변수 선언부
    cnt number := 1;
begin -- 실행부
    loop
        insert into emp(empno, ename, hiredate) values(cnt, 'test'||cnt, sysdate);
    exit when cnt >= 100;
    cnt := cnt + 1;
    end loop;
    dbms_output.put_line('100개의 레코드가 입력되었습니다.');
end;
/
select * from emp where empno <= 100;

/* WHILE LOOP */
delete from emp where empno <= 100;
declare -- 변수 선언부
    cnt number := 1;
begin -- 실행부
    while cnt <= 100 loop
        insert into emp(empno, ename, hiredate) values(cnt, 'test'||cnt, sysdate);
        cnt := cnt + 1;
    end loop;
    dbms_output.put_line('100개의 레코드가 입력되었습니다.');
end;
/
select * from emp where empno <= 100;

/* 커서(Cursor) */
-- 하나의 부서에 대한 정보 가져오기
create or replace procedure cursor_p(p_deptno number)
is
    cursor cursor_avg is
        select dname, count(empno) cnt, round(avg(sal),1) sal
        from emp e, dept d
        where e.deptno=d.deptno
        and e.deptno = p_deptno
        group by dname;
        
    dname varchar(50);
    cnt number;
    sal_avg number;
begin
    open cursor_avg; -- 커서 오픈: select명령어 실행
    
    fetch cursor_avg into dname, cnt, sal_avg; -- 레코드 한 개를 읽음
    dbms_output.put_line('부서명:'|| dname);
    dbms_output.put_line('사원수:'|| cnt);
    dbms_output.put_line('평균급여:'|| sal_avg);
    
    close cursor_avg;
end;
/
execute cursor_p(10);

-- 모든 부서에 대한 정보 가져오기
create or replace procedure cursor2_p -- 괄호 주의(전달되는 값이 없음)
is
    cursor cursor_avg is
        select dname, count(empno) cnt, round(avg(sal),1) sal
        from emp e, dept d
        where e.deptno=d.deptno
        group by dname;
begin
    for row in cursor_avg loop
        dbms_output.put_line('부서명:'|| row.dname);
        dbms_output.put_line('사원수:'|| row.cnt);
        dbms_output.put_line('평균급여:'|| row.sal);
    end loop;
end;
/
execute cursor2_p;

/* 트리거 */
-- before: 레코드 변경 전에 실행/ after: 레코드 변경 후에 실행
create or replace trigger sum_t
after
    insert or update or delete on emp
declare
    avg_sal number;
begin
    select avg(sal) into avg_sal from emp;
    dbms_output.put_line('급여평균:'|| avg_sal);
end;
/
set serveroutput on;
select avg(sal) from emp;
insert into emp(empno, ename,  hiredate, sal) values (1000, '박철수', sysdate, 500);
update emp set sal=600 where empno=1000;
delete from emp where empno=1000;