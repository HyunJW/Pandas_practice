/* view �ǽ����� */
-- view ���� �� ����
create or replace view test_v
as
    select empno, ename, e.deptno, dname
    from emp e, dept d
    where e.deptno = d.deptno;
    
-- ������ ��� ���̺� ó�� ��� ����
select * from test_v;

-- ���̺�, �� ���Ȯ��
select * from tab;

-- ���� ���� ���� Ȯ��(������ ����)
select * from user_views;
