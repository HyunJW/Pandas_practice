-- ����ð� ������ ���� ���ڵ尡 ���� ���̺� ����
drop table ontime;
drop table emp3;

/* exp.exe�� �̿��� ���
- cmdâ���� ����
- exp userid=������/�н����� file=��������̸�
*/

-- ������ ���� emp ���̺� ����
drop table emp;

/* imp.exe�� �̿��� ����
- cmdâ���� ����
- imp userid=������/�н����� file=��������̸� full=y/n ignore=y/n
- full=y: Ǯ�ɼ� ����
- ignore=y �����޽��� ����
*/
-- ���� Ȯ��
select * from emp;
commit;

/* SQL Developer�� �̿��� ���
���� - �����ͺ��̽� �ͽ���Ʈ - ����: ����, csv, insert script �� ����
*/