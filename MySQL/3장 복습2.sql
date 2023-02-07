use bookstore;
-- orders에서 총 주문량 조회
select count(order_id) '총 주문량' from orders;

-- NULL을 포함한 컬럼과 비교 customer(count함수 이용)
select count(*), count(phone) from customer;

-- orders에서 평균 구매 가격을 조회
select avg(saleprice) '평균 구매 가격' from orders;

-- orders에서 총 주문량과 평균 판매가 조회
select count(O.order_id) '총 주문량', avg(B.price) '평균 판매가' from orders O, book B;

-- 고객이 주문한 도서의 총 판매액, 평균, 최저, 최고가를 구하고 판매된 도서의 종류를 개수로 조회
select sum(saleprice) '총 판매액', avg(ifnull(saleprice, 0)) '평균 판매가', -- 만약 null값이 있으면 0으로 처리
		min(saleprice) '최저가', max(saleprice) '최고가', count(distinct book_id) '판매된 도서의 종류'
    from orders;
    
-- group by를 이용해서 고객별로 주문한 도서의 총 수량과 총 판매액을 조회
select cust_id, count(*) '주문한 도서 수', sum(saleprice) '총 판매액' 
	from orders
    group by cust_id;

-- 고객별로 주문한 도서의 총 판매액, 평균, 최소, 최대 가격과 고객아이디 조회
select cust_id, sum(saleprice) '총 구매액', avg(saleprice) '평균가격', min(saleprice) '최저가', max(saleprice) '최고가'
	from orders
    group by cust_id;

-- cust_id와 book_id를 기준으로 그룹분석을 해서 saleprice의 총합 조회
select cust_id, book_id, sum(saleprice) from orders
	group by cust_id, book_id;

-- 구매 고객 중 가격이 8000원 이상의 도서의 주문 수량을 구하고 2권 이상 주문한 고객의 이름 수량 판매금 조회
select C.user_name 이름, count(O.order_id) 수량, sum(O.saleprice) 판매액 
	from orders O
		inner join customer C 
		on O.cust_id = C.cust_id
	where saleprice >= 8000
	group by O.cust_id
    having count(*) >= 2;

-- 도서 주문에서 고객주소가 서울인 고객의 이름, 전화번호 출력
select user_name 이름, phone 전화번호 from customer
	where address like '%서울%';

-- 도서 주문에서 주소가 대한민국이 있는 고객 이름, 전화번호 출력(전화번호가 없는 경우 '전화없음' 표시)
select user_name 이름, ifnull(phone, '전화없음') 전화번호 from customer
	where address like '대한민국%' or address like '%서울%';

-- 주문테이블에서 40000원 이상 주문한 고객의 이름, 주소와 책 제목을 조회
select C.user_name '이름', C.address '주소', B.book_name '책 제목', O.saleprice '구매가격'
	from customer C 
		right join orders O on C.cust_id = O.cust_id
        left join book B on B.book_id = O.book_id
	where O.saleprice >= 40000;

-- 주문테이블에서 25000원 이상 주문한 고객의 이름, 주소와 책 제목을 조회
select C.user_name '이름', C.address '주소', B.book_name '책 제목', O.saleprice '가격'
	from customer C 
		right join orders O on C.cust_id = O.cust_id
        left join book B on B.book_id = O.book_id
	where O.saleprice >= 25000;
    
-- 숫자 집계 함수
select greatest(29, -100, 34, 8, 25);
select greatest('windows.com', 'microsoft.com', 'apple.com');

-- ceiling
select ceiling(30.75);
select ceiling(40.25);
select ceiling(40);
select round(30.75, 1);

-- 평균 도서 가격
select ceiling(sum(price)/count(price)) 평균, sum(price)/count(price) 평균2 from book;

-- 주문한 연도별 가격과 평균가격
select year(orderdate) '주문한 연도', saleprice 가격, ceiling(sum(saleprice)/count(saleprice)) 
	from orders
	group by year(orderdate);
    
-- '이름'으로 그룹분석 고객의 전체 주문횟수, 합계/평균/최소/최대 구매액 조회    
select C.user_name 이름, count(*) 주문횟수, 
		format(sum(O.saleprice), 0) 합계, 
		format(avg(O.saleprice), 1) 평균, 
		min(O.saleprice) 최소가, 
		max(O.saleprice) 최대가
	from orders O
		left join customer C
		on C.cust_id = O.cust_id
    group by C.user_name;
    
-- 주문금액의 합계, 평균, 최소, 최대, 분산, 표준편차
select sum(saleprice) 합계, 
		format(avg(saleprice), 1) 평균, 
		min(saleprice) 최소, 
		max(saleprice) 최대, 
		format(variance(saleprice), 1) 분산,
		format(std(saleprice), 1) 표준편차 
    from orders;