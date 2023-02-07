-- bookstore 스키마 설정 > book, customer, order 테이블 생성
drop database if exists bookstore;
create database bookstore;
use bookstore;

create table Book(
	book_id INT NOT NULL PRIMARY KEY,
	book_name VARCHAR(40),
    publisher VARCHAR(40),
    price INT
);

create table Customer(
	cust_id INT NOT NULL PRIMARY KEY,
	user_name VARCHAR(20),
    address VARCHAR(50),
    phone VARCHAR(20)
);

create table Orders(
	order_id INT NOT NULL PRIMARY KEY ,
	cust_id INT, 
    book_id INT,
    saleprice INT,
    orderdate DATE,
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);
    
insert into Book values(1, '철학의 역사', '정론사', 7500);
insert into Book values(2, '3D 모델링 시작하기', '한비사', 15000);
insert into Book values(3, 'SQL 이해', '새미디어', 22000);
insert into Book values(4, '텐서플로우 시작', '새미디어', 35000);
insert into Book values(5, '인공지능 개론', '정론사', 8000);
insert into Book values(6, '파이썬 고급', '정론사', 8000);
insert into Book values(7, '객체지향 Java', '튜링사', 20000);
insert into Book values(8, 'C++ 중급', '튜링사', 18000);
insert into Book values(9, 'Secure 코딩', '정보사', 7500);
insert into Book values(10, 'Machine learning 이해', '새미디어', 32000);
select * from Book;

insert into Customer values(1, '박지성', '영국 맨체스터', '010-1234-1010');
insert into Customer values(2, '김연아', '대한민국 서울', '010-1223-3456');
insert into Customer values(3, '장미란', '대한민국 강원도', '010-4878-1901');
insert into Customer values(4, '추신수', '대한민국 부산', '010-8000-8765');
insert into Customer values(5, '박세리', '대한민국 대전', NULL);
select * from Customer;

insert into Orders values(1, 1, 1, 7500, STR_TO_DATE('2021-02-01','%Y-%m-%d')); 
insert into Orders values(2, 1, 3, 44000, STR_TO_DATE('2021-02-03','%Y-%m-%d'));
insert into Orders values(3, 2, 5, 8000, STR_TO_DATE('2021-02-03','%Y-%m-%d')); 
insert into Orders values(4, 3, 6, 8000, STR_TO_DATE('2021-02-04','%Y-%m-%d')); 
insert into Orders values(5, 4, 7, 20000, STR_TO_DATE('2021-02-05','%Y-%m-%d'));
insert into Orders values(6, 1, 2, 15000, STR_TO_DATE('2021-02-07','%Y-%m-%d'));
insert into Orders values(7, 4, 8, 18000, STR_TO_DATE( '2021-02-07','%Y-%m-%d'));
insert into Orders values(8, 3, 10, 32000, STR_TO_DATE('2021-02-08','%Y-%m-%d')); 
insert into Orders values(9, 2, 10, 32000, STR_TO_DATE('2021-02-09','%Y-%m-%d')); 
insert into Orders values(10, 3, 8, 18000, STR_TO_DATE('2021-02-10','%Y-%m-%d'));
select * from Orders;

-- BookLibrary 생성
create table BookLibrary(
	book_id INT,
    book_name VARCHAR(20),
    publisher VARCHAR(20),
    price INT,
    PRIMARY KEY (book_name, publisher)
);

-- 1. 테이블 요약
desc BookLibrary;

-- 2. 집계(Orders)
-- 도서판매건수를 구하는 쿼리
select count(order_id) from Orders;

-- 고객이 주문한 도서의 총 판매액을 구하는 쿼리
select sum(saleprice) from Orders;

-- 고객이 주문한 도서의 총 판매액을 '총매출'로 구하는 쿼리(as 총매출)
select sum(saleprice) as 총매출 from Orders;

-- 고객이 주문한 도서의 총 판매액 평균을 구하고 '매출평균'으로 구하는 쿼리
select avg(saleprice) as 매출평균 from Orders;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하는 쿼리(Total, Average, Minimum, Maximum)
select sum(saleprice) as Total, avg(saleprice) as Average, min(saleprice) as Minimum, max(saleprice) as Maximum from Orders;

-- 책 가격이 22,000미만인 도서 검색
select * from book 
	where price < 22000;

-- 가격이 10,000보다 크고 20,000 이하인 도서 검색(and)
select * from book 
	where price > 10000 and price < 20000;

-- 가격이 10,000보다 크고 20,000 이하인 도서 검색(between)
select * from book 
	where price between 10000 and 20000;
 
-- 주문일자가 2021-02-01에서 2021-02-07인 주문내역 출력
select * from Orders 
	where orderdate between '2021-02-01' and '2021-02-07';

-- 도서번호가 3, 4, 5, 6인 주문 목록을 출력
select * from Orders 
	where book_id between 3 and 6;

-- 위 결과를 or 조건절
select * from Orders 
	where book_id = 3 or book_id = 4 or book_id = 5 or book_id = 6;

-- 위 결과를 and 조건절
select * from Orders 
	where book_id >= 3 and book_id <= 6;
    
-- 위 5번 결과를 in 조건절
select * from Orders 
	where book_id in(3,4,5,6);
    
-- book price가 null인 레코드를 추가
insert into Book values(11, 'SQL 기본 다지기', 'MS출판사', NULL);

-- 11번에 price를 1000원 올려서 출력
select price + 1000 from Book where book_id = 11; -- NULL 값은 계산이 되지 않음

-- price 컬럼의 집계함수를 실행 sum, avg, count(*), count(price)
select sum(price), avg(price), count(*), count(price) from Book;

select sum(price), avg(price), count(*), count(price) from Book 
where book_id < 11; -- NULL값은 계산이 되지 않음을 확인

-- book에서 null인 레코드를 출력하는 쿼리
select * from Book where price is NULL;

-- Customer에서 이름, 전화번호가 포함된 고객목록을 조회, 전화번호가 없으면 연락처 없음으로 표시(검색 후 적용)
select user_name 이름, ifnull(phone,'연락처 없음') 전화번호 from Customer;

-- 박씨성을 가진 고객을 출력
select * from Customer 
	where user_name like '박%';

-- 2번째 글자가 '지'인 고객을 출력
select * from Customer 
	where user_name like '_지%';
    
-- '철학의 역사'를 출간한 출판사 검색
select publisher from Book
	where book_name like '철학의 역사';
    
-- 도서이름에 '파이썬'이 포함된 도서의 출판사 검색
select book_name, publisher from book
	where book_name like '%파이썬%';

-- '썬'으로 일치하는 도서 중 가격이 20,000원 이상인 도서 검색
select * from book
	where book_name like '%썬%' and price >= 20000;
    
-- 출판사 이름이 '정론사' 또는 '새미디어'인 도서 검색
select * from Book 
	where publisher in ('정론사', '새미디어');
    
/* order by */
-- 도서 이름 순으로 검색
select * from Book
	order by book_name;

-- 도서 가격으로 검색하고 가격이 같으면 이름순으로 검색
select * from Book
	order by price, book_name;

-- 도서 가격의 내림차순으로 검색하고 가격이 같다면 출판사 이름으로 오름차순 검색
select * from Book
	order by price desc, publisher;

-- 주문일자 내림차순으로 정렬
select * from Orders
	order by orderdate desc;
    
-- 책 이름 중 '썬'을 포함하면서 20,000원 미만인 책들을 출판사 이름으로 오름차순 검색
select * from Book
	where book_name like '%썬%' and price < 20000
    order by publisher;
    
-- 판매가격이 1,000원 초과인 book_id를 내림차순으로 출력
select * from Book
	where price > 1000
    order by book_id desc;


drop database if exists lecture;
create database lecture;
use lecture;
create table product(
	code INT,
    name VARCHAR(20),
    price INT);
insert into product values(1, '녹차', 2300);
insert into product values(2, '홍차', 3000);
insert into product values(3, '유자차', 1800);
insert into product values(4, '보리차', 2500);    
select * from product;

-- 평균 구하고 평균 이상의 차를 출력
select * from product
	where avg(price) > 1000; -- Error 발생

-- 해결법 : 서브쿼리
select * from product
	where price >= (select avg(price) from product);
    
-- inline view : 서브쿼리 결과를 FROM에 사용
select min(price)
	from (select * from product where price >= 2000) as c_price;
-- 동일한 결과    
select min(price) from product
	where price >= 2000;
    

use bookstore;
-- 출판사별로 출판사의 평균 도서가격보다 비싼 도서 구하기
select * from book B1
	where B1.price > (select avg(B2.price) from book B2
                        where B2.publisher = B1.publisher);

-- 주문한 내용에서 도서의 가격과 판매 가격의 차이가 가장 많은 주문
select max(saleprice - price) 
	from book B, orders O
	where B.book_id = O.book_id;
    
select distinct B.book_name, B.price, O.saleprice
	from book B, orders O
    where B.book_id = O.book_id 
    and O.saleprice - B.price = (select max(saleprice - price) 
									from book, orders
									where book.book_id = orders.book_id);