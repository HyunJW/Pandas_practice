/* inner join */
select sname, s.majorno, mname
from stud s, major m
where s.majorno = m.majorno;

select empno, ename, dname
from emp e, dept d
where e.deptno = d.deptno;

select sname, mname, pname
from stud s, major m, prof p
where s.majorno = m.majorno and s.profno = p.profno;

/* outer join */
select sname, pname
from stud s, prof p
where s.profno = p.profno;

select sname, pname
from stud s left outer join prof p
    on s.profno = p.profno;
    
-- (+)가 있는 테이블에 부족한 행만큼 빈값을 더함
select sname, s.majorno, pname
from stud s, prof p
where s.profno = p.profno(+);

-- full outer join: Oracle에서는 존재하지 않음. 그렇기 때문에 union all을 이용
select sname, s.majorno, pname
from stud s left outer join prof p
    on s.profno = p.profno
union all
select sname, s.majorno, pname
from stud s right outer join prof p
    on s.profno = p.profno;
    
/* 실습예제 */
-- 상품테이블 생성
drop table product;
create table product (
    product_code varchar2(20) not null primary key,
    product_name varchar2(50) not null,
    price number default 0,
    company varchar2(50),
    make_date date default sysdate
    );
insert into product values ('A1', '아이폰', 900000, '애플', '2017-03-01');
insert into product values ('A2', '갤럭시노트', 1000000, '삼성', '2017-08-01');
insert into product values ('A3', '갤럭시탭', 1200000, '삼성', '2017-10-01');

select * from product;

-- 판매테이블 생성
create table product_sales (
    product_code varchar2(20) not null,
    amount number default 0
    );
insert into product_sales values('A1', 100);
insert into product_sales values('A2', 200);
insert into product_sales values('A3', 300);

select * from product_sales;

-- 상품테이블과 판매테이블 조인
select product.product_code, product_name, company, price, amount, price*amount money, make_date
from product, product_sales
where product.product_code = product_sales.product_code;

-- 별칭사용
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p, product_sales s
where p.product_code = s.product_code;

-- ANSI join
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p inner join product_sales s
    on p.product_code = s.product_code;
    
-- View
create or replace view product_sales_v
as
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p, product_sales s
where p.product_code = s.product_code;

-- view를 테이블처럼 활용
select * from product_sales_v
where company = '삼성';

/* 실습문제 */
-- 1.
select ename, dname, sal
from emp e, dept d
where e.deptno = d.deptno;

-- 2.
select ename, dname
from emp e inner join dept d
    on e.deptno = d.deptno
where job = '사원';

select ename, dname
from emp e, dept d
where e.deptno = d.deptno
and job = '사원';

-- 3.
select ename, dname
from emp e, dept d
where e.deptno = d.deptno
and ename = '손기철';

-- 4.
select a.ename || '의 매니저는 ' ||  b.ename || '이다.'
from emp a, emp b
where a.mgr = b.empno
and a.ename = '박종수';
