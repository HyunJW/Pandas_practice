use market_db;
/* 내부 조인 - 두 테이블에 모두 있는 내용만 조인*/
select * 
	from buy
		inner join member
		on buy.mem_id = member.mem_id;

select * 
	from buy
		inner join member
		on buy.mem_id = member.mem_id
	where buy.mem_id = 'GRL';

/* mem_id가 두개이기 때문에 오류 발생, Error:Column 'mem_id' in field list is ambiguous    
select mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처' from buy
	inner join member
    on buy.mem_id = member.mem_id;
*/
-- 해결법 : 문제가 되는 column명을 명확하게 작성(mem_id => buy.mem_id)
select buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처' 
	from buy
		inner join member
		on buy.mem_id = member.mem_id;

-- 모든 column명을 별칭으로 명확하게 작성
select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처' 
	from buy B -- buy => B
		inner join member M -- member => M
		on B.mem_id = M.mem_id;
    
-- 구매한 기록이 있는 회원 아이디/이름/구매한 제품/주소를 아이디 순서로 정렬
select M.mem_id, M.mem_name, B.prod_name, M.addr 
	from buy B
		inner join member M
		on B.mem_id = M.mem_id
    order by M.mem_id;
    
-- 구매한 기록이 있는 회원 아이디/이름/주소를 중복 제외한 후 출력
select distinct M.mem_id, M.mem_name, M.addr 
	from buy B
		inner join member M
		on B.mem_id = M.mem_id
    order by M.mem_id;

/* 외부 조인 - 한쪽 테이블에만 내용이 있어도 조인 */
-- 전체 회원 아이디/이름/구매한 제품/주소를 아이디 순서로 정렬(left outer join)
select M.mem_id, M.mem_name, B.prod_name, M.addr 
	from member M
		left outer join buy B
        on M.mem_id = B.mem_id
	order by M.mem_id;

-- right outer join
select M.mem_id, M.mem_name, B.prod_name, M.addr 
	from buy B
		right outer join member M
        on M.mem_id = B.mem_id
	order by M.mem_id;
    
-- 구매한 기록이 없는 회원 아이디/이름/주소를 중복 제외한 후 출력
select distinct M.mem_id, M.mem_name, B.prod_name, M.addr 
	from buy B
		right outer join member M
        on M.mem_id = B.mem_id
	where B.prod_name is null
	order by M.mem_id;
    
/* 기타 조인 */
-- 상호 조인 : 테스트용 대용량 데이터 생성 시 사용
select *
	from buy
		cross join member;
        
-- sakila.inventory와 world.city의 상호 조인 했을 때 데이터의 개수 : 18685899
select count(*) '데이터 개수'
	from sakila.inventory
		cross join world.city;
        
-- sakila.actor와 world.country의 상호 조인 했을 때 데이터의 개수 : 47800
select count(*) '데이터 개수'
	from sakila.actor
		cross join world.country;

-- sakila.actor와 world.country의 상호 조인 테이블 생성
create table cross_table
	select * 
		from sakila.actor
			cross join world.country;
select * from cross_table limit 5;

-- 생성한 cross_table 테이블 삭제
drop table cross_table;

-- 자체 조인 : 자기 자신과 조인, 회사의 조직 관계를 살피는 경우 사용
create table emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));

insert into emp_table values('대표',NULL ,'0000' );
insert into emp_table values('영업이사', '대표', '1111');
insert into emp_table values('관리이사', '대표', '2222');
insert into emp_table values('정보이사', '대표', '3333');
insert into emp_table values('영업과장', '영업이사', '1111-1');
insert into emp_table values('경리부장', '관리이사', '2222-1');
insert into emp_table values('인사부장', '관리이사', '2222-2');
insert into emp_table values('개발팀장', '정보이사', '3333-1');
insert into emp_table values('개발주임', '정보이사', '3333-1-1');

select * from emp_table;

select A.emp '직원', B.emp '직속상관', B.phone '직송상관연락처'
	from emp_table A
		inner join emp_table B
        on A.manager = B.emp