use market_db;
/* IF문 */
drop procedure if exists ifproc1;
delimiter $$
-- 스토어드 프로시저 입력
create procedure ifproc1()
begin
	-- 이 부분에 SQL 프로그래밍 코딩
	if 100 = 100 then
		select '100은 100과 같습니다.';
	end if;
end $$
delimiter ; 
call ifproc1();

/* IF~ELSE문 */
drop procedure if exists ifproc2;
delimiter $$
create procedure ifproc2()
begin
	declare myNum INT; -- 함수 안에서는 DECLARE myNum으로 변수 선언
    set myNum = 200; -- 함수 밖에서는 set @myNum으로 변수 선언
    if myNum = 100 then
		select '100입니다.';
	else
		select '100이 아닙니다.';
	end if;
end $$
delimiter ;
call ifproc2();

-- 에이핑크가 데뷔한지 5년 이상이면 축하 메시지, 5년 미만이면 격려 메시지를 출력(데뷔한지 000일이 지났습니다. 축하합니다./ 화이팅.)
drop procedure if exists ifproc3;
delimiter $$
create procedure ifproc3()
begin
	declare debutdate DATE;
    declare today DATE;
    declare days INT;

    select debut_date into debutdate -- into 변수 : 결과를 변수에 저장
		from market_db.member
        where mem_id = 'APN';
	
	set today = current_date(); -- 현재 날짜
    set days = datediff(today, debutdate); -- 날짜 차이(일 단위)
    
    if (days/365) >= 5 then
		select concat('데뷔한지', days, '일이나 지났습니다. 축하합니다!');
	else
		select '데뷔한지' + days + '일밖에 안되었네요. 화이팅~!';
	end if;
end $$
delimiter ;
call ifproc3();

/* CASE문 - 파이썬에서의 elif와 유사 */
-- 시험점수에 따른 학점 출력
drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
	declare point INT;
    declare credit CHAR(1);
    set point = 88;
    
    case
		when point >= 90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		else
			set credit = 'F';
	end case;
    select concat('취득점수 ==>', point), concat('학점 ==>', credit);
end $$
delimiter ;
call caseProc();

-- 회원들의 총 구매액을 계산해서 회원의 등급을 나누어 출력
select M.mem_id, M.mem_name, sum(B.price * B.amount) '총 구매액',
		case
			when (sum(B.price * B.amount) >= 1500) then '최우수고객'
			when (sum(B.price * B.amount) >= 1000) then '우수고객'
			when (sum(B.price * B.amount) > 0) then '일반고객'
			else '유령고객'
		end '회원등급'
	from buy B
		right outer join member M
        on B.mem_id = M.mem_id
	group by mem_id
    order by sum(B.price * B.amount) desc;
    
/* WHILE문 */
drop procedure if exists whileproc;
delimiter $$
create procedure whileproc()
begin
	declare i INT; -- 1씩 증가하는 변수
    declare total INT; -- 더한값을 누적하는 변수
    set i = 1;
    set total = 0;
    
    while (i <= 100) do
		set total = total + i;
		set i = i + 1;
	end while;
    select '1부터 100까지의 합 ==>', total;
end $$
delimiter ;
call whileproc();

-- 1부터 100까지 4를 제외한 합, 그 합이 1000을 넘는 순간 중단하고 그 값을 출력
drop procedure if exists whileproc2;
delimiter $$
create procedure whileproc2()
begin
	declare i INT;
    declare total INT;
    set i = 1;
    set total = 0;
    
    myWhile: -- 레이블 지정
    while (i <= 100) do
		if (i % 4 = 0) then
			set i = i + 1;
            iterate myWhile; -- 지정한 레이블문으로 가서 계속 진행, 파이썬에서 continue와 같음
		end if;
        set total = total + i;
        if (total > 1000) then
			leave myWhile; -- 지정한 레이블문을 떠남. while문 종료
		end if;
        set i = i + 1;
	end while;
    
    select '1부터 4를 제외한 합이 처음으로 1000을 넘긴 값 ==>', total;
end $$
delimiter ;
call whileproc2();

/* 동적 SQL */
prepare myQuery from 'select * from member where mem_id = "BLK"';
execute myQuery;
deallocate prepare myQuery;

-- 동적 SQL활용 : 출입문에서 출입한 내역을 테이블에 기록
drop table if exists gate_table;
create table gate_table (
	id INT auto_increment primary key,
	entry_time DATETIME
);

-- 3번 실행
set @curDate = current_timestamp();

prepare myQuery from 'insert into gate_table values(NULL, ?)';
execute myQuery using @curDate;
deallocate prepare myQuery;

select * from gate_table;