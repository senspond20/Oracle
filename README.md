# Oracle Study

## ▶목차

+ [연습문제](https://github.com/senspond20/Oracle/tree/master/연습문제)

-------------------------------------------

+ 데이터베이스 개요

+ [오라클시작하기](https://github.com/senspond20/Oracle/tree/master/1_오라클시작하기)



+ [O1_DML/DQL(SELECT)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)#dclselect)
  + [함수(FUNCTION)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)/%ED%95%A8%EC%88%98(FUNCTION)#%ED%95%A8%EC%88%98-function))
  + [GROUP BY_HAVING](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/3_GroupByHaving.md#groupbyhaving)
  + [JOIN]
  + [SUBQUERY](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/5_%EC%84%9C%EB%B8%8C%EC%BF%BC%EB%A6%AC.md#subquery%EC%84%9C%EB%B8%8C-%EC%BF%BC%EB%A6%AC)
+ 02

--------------------------------

DQL (질의어) 
 - SELECT : 테이블에 저장된 데이터를 조회하는 데 사용되는 가장 기본적인 문법이고 가장 많이 사용됨
 - DML 에 속하기도 한다.

DML (데이터 조작어) 
 데이터를 삽입, 변경 삭제 즉 조작하는 역할을 하는 명령어 INSERT, UPDATE, DELETE
- INSERT : 새로운 데이터를 삽입함
- UPDATE : 기존의 데이터를 변경함
- DELETE : 기존의 데이터를 삭제함


DDL (데이터정의어) 
데이터베이스 객체들을 생성, 변경, 제거시 사용 CREATE, ALTER, DROP, RENAME, TRUNCATE
- CREATE : 새로운 테이블을 생성함
- ALTER : 기존의 테이블을 변경함 (컬럼을 추가하거나 변경)
- RENAME : 테이블의 이름을 변경함
- TRUNCATE : 테이블을 잘라냄(테이블 내의 저장된 내용 삭제)
- DROP : 기존의 테이블을 삭제함 (테이블의 구조 자체를 제거)
TCL (트랜잭션 제어언어)
데이터의 일관성을 유지하면서 안정적으로 데이터를 복구시키기 위해서 사용 
Transaction은 여러개의 DML(데이터조작어) 명령문들을 하나의 작업단위로 묶어놓은 집합이다.
실수 없이 완벽하게 입력한 명령어만 영구 저장하기 위해 TCL을 사용한다. 

- COMMIT : 변경된 내용을 영구 저장

- ROLLBACK : 변경되기 이전 상태로 되돌림

- SAVAPOINT : 특정 위치까지를 영구 저장 혹은 이전 상태로 돌리기 위해 저장점을 만듬


 
DCL (데이터 제어어)
- 특정 사용자에게 권한을 부여하거나 제거하기 위해 사용됨

          - GRANT : 사용자에게 특정 권한을 부여
- REVOKE : 부여했던 권한 제거
