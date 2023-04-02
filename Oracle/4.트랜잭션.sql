/* 실수로 삭제한 자료의 복구 방법 */
delete from emp;
select * from emp;
commit;
-- cmd에서 sqlplus python/1234로 sqlplus 접속
-- SELECT * FROM emp AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '15' MINUTE);
-- INSERT INTO emp SELECT * FROM emp AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '15' MINUTE);
-- commit;

select * from emp;

