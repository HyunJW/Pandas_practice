/* �Ǽ��� ������ �ڷ��� ���� ��� */
delete from emp;
select * from emp;
commit;
-- cmd���� sqlplus python/1234�� sqlplus ����
-- SELECT * FROM emp AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '15' MINUTE);
-- INSERT INTO emp SELECT * FROM emp AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '15' MINUTE);
-- commit;

select * from emp;

