use bookstore;
-- 주문고객목록 cust_id의 중복제거
select distinct cust_id from orders;

-- 판매가격 목록 saleprice 중복제거
select distinct saleprice from orders;

select cust_id, sum(saleprice) from orders
	group by cust_id;

-- case 다중 조건 활용 : 총구매액 > 50000 최우수고객, 총구매액 > 30000 우수고객, 총구매액 > 10000 일반고객, 그 이하는 유령고객
select cust_id, sum(saleprice) "총 구매액", 
		case
			when (sum(saleprice) > 50000) then '최우수고객'
			when (sum(saleprice) > 30000) then '우수고객'
			when (sum(saleprice) > 10000) then '일반고객'
			else '유령고객'
		end '회원등급'
	from orders
	group by cust_id