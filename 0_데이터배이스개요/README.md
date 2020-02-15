# 데이터 베이스 개요

## data 와 database


+

+
|분류 |명령어|
|--------------|-----------------|
|데이터 정의어(DDL)|CREATE, ALTER, DROP, RENAME, TRUNCATE|
|데이터 조작어(DML)|SELECT, INSERT, UPDATE, DELETE|
|데이터 제어어(DCL)|GRANT, REVOKE|
|트랜잭션 제어어(TCL)|COMMIT, ROLLBACK, SAVEPOINT|

* **SELECT 는 DQL로 분류하기도 한다.**

+ 트랜잭션의 특성
    + 원자성,일관성,격리성,영속성

+ 스키마(Schema) : 데이터베이스에 저장되는 데이터 구조와 제약조건을 정의한것
+ 인스턴스(Instance) : 스키마에 따라 데이터베이스에 실제로 저장된 값

+ **CREATE / INSERT**

    + CREATE
        + 스키마(테이블 정의)를 생성하는 데이터 정의어(DDL)
    + INSERT
        + (스키마 내의 인스턴스 / 테이블 내의 튜플) 생성하는 데이터 조작어(DML)
        ```SQL
        INSERT INTO 테이블 명 (속성명1,... )
        VALUES(데이터1,...);
        ```
+ **DROP / DELETE**
    + DROP
        + 스키마(테이블 정의)를 삭제하는 데이터 정의어(DDL)
    + DELETE
        + (스키마 내의 인스턴스 / 테이블 내의 튜플)을 삭제하는 데이터 조작어(DML)
        ```SQL
        DELETE FROM 테이블 명
        WHERE 조건;
        ```        

+ **ALTER / UPDATE**
    + ALTER
        + 스키마(테이블 정의)를 변경하는 데이터 정의어(DDL)
    + UPDATE
        + (스키마 내의 인스턴스 / 테이블 내의 튜플)을 변경하는 데이터 조작어(DML)
        ```SQL
        UPDATE 테이블 명 
        SET 속성명 = 데이터,...
        WHERE 조건;
        ```

### 데이터 제어어(DCL)

+ GRANT

    ```SQL
    GRANT 권한 ON 테이블 TO 사용자
    [WITH 권한옵션];
    ```

+ GRANT(권한부여) 명령문으로 부여할 수 있는 권한의 유형
    + 시스템 권한
 
        | 명령어 | 설명
        |----|--------
        |CREATE USER| 계정을 생성할 수 있는 권한
        |

   + 객체 권한(ALTER,INSERT,DELETE,SELECT,UPDATE,EXECUTE)


