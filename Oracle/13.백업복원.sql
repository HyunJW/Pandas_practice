-- 백업시간 단축을 위해 레코드가 많은 테이블 삭제
drop table ontime;
drop table emp3;

/* exp.exe를 이용한 백업
- cmd창에서 실행
- exp userid=계정명/패스워드 file=백업파일이름
*/

-- 복원을 위해 emp 테이블 삭제
drop table emp;

/* imp.exe를 이용한 복원
- cmd창에서 실행
- imp userid=계정명/패스워드 file=백업파일이름 full=y/n ignore=y/n
- full=y: 풀옵션 복원
- ignore=y 에러메시지 무시
*/
-- 복원 확인
select * from emp;
commit;

/* SQL Developer를 이용한 백업
도구 - 데이터베이스 익스포트 - 형식: 엑셀, csv, insert script 등 선택
*/