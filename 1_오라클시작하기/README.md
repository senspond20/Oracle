# ▶ 1-1 오라클 시작하기 

### [◀목차로 돌아가기](https://github.com/senspond20/Oracle)

+ [O1_DML/DQL(SELECT)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)#dclselect)
  + [함수(FUNCTION)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)/함수(FUNCTION))
  + [GROUP BY_HAVING](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/3_GroupByHaving.md#groupbyhaving)
  + JOIN
  + SUBQUERY
  
--------------------------

+ 오라클/개발도구 설치

1. 오라클 다운로드 홈페이지(https://www.oracle.com/downloads/) 접속 
2. Downloads – Oracle Database 11g Express Edition 다운로드 
3.  설치 및 관리자 계정 암호 설정 
4. DB 접속 확인 및 SQLPlus 실행 
5. 관리자 계정 로그인

* SQL Developer 다운로드 


+ CMD -> sqlplus
+ Developer Tool -> 컨트롤 엔터 :
    + 마지막 세미콜론부터 현재 세미콜론까지 실행

-----------------
+ ### 관리자 계정 : 

    + 데이터베이스의 생성과 관리를 담당하는 슈퍼 유저 계정
    + 오브젝트의 생성, 변경, 삭제 등의 작업이 가능하며
      데이터 베이스에 대한 모든 권한과 책임을 가지는 계정

+ ### 사용자 계정 : 

    + 데이터 베이스에 대하여 질의(Query), 갱신, 보고서 작성 등의 작업을 수행 할 수 있는 계정
    + 일반 계정은 보안을 위해 최소한의 필요한 권한만 가지는 것을 원칙으로 함

------------

+ ## 관리자 계정 만들기

![admin](https://user-images.githubusercontent.com/60596128/73768255-09ad5680-47bc-11ea-96a7-55cd73e88cde.png)
+ ## 사용자 계정 만들기

```sql
    -- 계정 생성      -- 계정 이름
CREATE USER KH  IDENTIFIED BY KH; 

 --  권한 부여     계정 비밀번호                
GRANT RESOURCE, CONNECT TO KH; 
```

---------------------

![table](url)

```
▶ 테이블에는 기본적으로 기본키의 역할을 하는 컬럼이 필요.
```

+ 행(Row), 튜플
+ 컬럼, 도메인
+ 기본키(Primary Key)
    + 각 행(튜플)을 구분할 수 있는 ID와 같은 역할
+ 외래키(Foreign Key)
    + 다른 테이블의 기본키가 내안에 들어오는것
    +  A    B

```
▶ SQL(Stuctured Query Language)
```
- DQL 데이터 검색 SELECT
- DML 데이터 조작 INSERT,UPDATE,DELETE
- DDL 데이터 정의 CREATE,DROP,ALTER
- TCL 트랙잭션 제어 COMMIT, ROLLBACK
    
    (데이터 베이스 상태를 변경해주는것)
-------------------------------

### [◀목차로 돌아가기](https://github.com/senspond20/Oracle)
