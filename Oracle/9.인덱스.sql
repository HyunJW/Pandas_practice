/* 인덱스 실습 */
-- 실행계획 보기(F10)
select empno, ename from emp where empno=7900; 
-- by index rowid 
-- unique scan: 유일한 값

select empno, ename from emp where ename='박민철'; 
-- full scan
-- cost: 3

-- 인덱스 추가
create index emp_ename_idx on emp(ename);

-- 인덱스를 사용해서 검색
select empno, ename from emp where ename='박민철'; 
-- by index rowid batched
-- range scan: 유일하지 않은 값
-- cost: 2

-- 인덱스 제거
drop index emp_ename_idx;

-- 인덱스 테스트를 위한 테이블 생성
create table emp3 (
    no number,
    name varchar2(10),
    sal number
    );
    
-- PL/SQL (Procedural Language)
declare
    i number := 1;
    name varchar(20) := 'kim';
    sal number := 0;
begin
    while i <= 100000 loop
        if i mod 2 = 0 then
            name := 'kim' || to_char(i);
            sal := 300;
        elsif i mod 3 = 0 then
            name := 'park' || to_char(i);
            sal := 400;
        elsif i mod 5 = 0 then
            name := 'hong' || to_char(i);
            sal := 500;
        else
            name := 'shin' || to_char(i);
            sal := 250;
        end if;
        insert into emp3 values (i, name, sal);
        i := i + 1;
    end loop;
end;
/
select count(*) from emp3;

-- 인덱스를 사용하지 않을 경우
select * from emp3 where name='shin691' and sal > 200;
-- full scan
-- cost: 104

-- 인덱스 추가
create index emp_name_idx on emp3(name, sal);

-- 인덱스를 사용한 경우
select * from emp3 where name='shin691' and sal > 200;
-- by index rowid batched
-- range scan
-- cost: 3

-- 인덱스 정보 확인
select * from user_indexes where table_name='EMP3';

-- 복합인덱스는 and연산에서 사용 가능, or연산에서는 사용하지 않음
select * from emp3 where name like 'park1111%' and sal > 300;
-- by index rowid batched
-- range scan
-- cost: 3

select * from emp3 where name like 'park1111%' or sal > 300;
-- full scan
-- cost: 105

-- primary key는 인덱스가 자동으로 생성
create table emp4 (
    no number primary key,
    name varchar2(10),
    sal number
    );
select * from user_indexes where table_name='EMP4';

-- no칼럼에 primary key 설정
alter table emp3 add constraint emp3_no_pk primary key(no);
select * from user_indexes where table_name='EMP3';

-- 인덱스를 사용할 경우 자동정렬이 이루어짐
select * from emp3 where no>90000;

-- primary key 제약조건 제거(인덱스 제거)
alter table emp3 drop constraint emp3_no_pk;
select * from user_indexes where table_name='EMP3';

-- 인덱스를 사용하지 않을 경우 자동 정렬이 이루지지 않음
select * from emp3 where no>90000;