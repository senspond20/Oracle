# DDR(ALTER,DROP)

## **ALTER**

+ ALTER - 테이블에 정의된 내용을 수정할 때 사용하는 데이터 정의어
+ ALTER : 객체 수정 구문


### **컬럼 추가, 삭제, 수정**

+ **테이블 칼럼 추가하기**
    + **ALTER TABLE** 테이블명 **ADD**(컬럼명 데이타타입(사이즈));

        ```SQL
        ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(20));
        ALTER TABLE DEPT_COPY ADD (LNAME VARCHAR2(40) DEFAULT ‘한국’);
        ```

+ **테이블 칼럼 수정하기**
    + **ALTER TABLE** 테이블명 **MODIFY**(컬럼명 테이타타입(사이즈));

        ```SQL
        ALTER TABLE DEPT_COPY
        MODIFY DEPT_ID CHAR(3)
        MODIFY DEPT_TITLE VARCHAR(30)
        MODIFY LOCATION_ID VARCHAR2(2)
        MODIFY CNAME CHAR(20) MODIFY LNAME DEFAULT '미국';
        ---- 이미 들어간 '한국'이 변하지 않고 이제부터 들어가는 값들의 DEFAULT값이 '미국'으로 들어감
        ```

+ **테이블 칼럼 삭제하기** 
    + **ALTER TABLE** 테이블명 **DROP COLUMN** 컬럼명

        ```SQL
        ALTER TABLE DEPT_COPY
        DROP COLUMN DEPT_ID;
        ```

    + **제약조건이 있는 컬럼 삭제시**
    
        ```SQL
        CREATE TABLE TB1( 
            PK NUMBER PRIMARY KEY,
            FK NUMBER REFERENCES TB1, 
            COL1 NUMBER, 
            CHECK(PK > 0 AND COL1 > 0)
         );

        ALTER TABLE TB1 DROP COLUMN FK; -- 성공

        ALTER TABLE TB1 DROP COLUMN PK;  -- 실패
        --* 컬럼 삭제 시 참조하고 있는 추가 제약조건이 있다면 컬럼 삭제 불가능

        -- 해결법 : 제약조건과 함께 삭제
        ALTER TABLE TB1 DROP COLUMN PK CASCADE CONSTRAINTS;
        ```


### **제약조건 추가,변경,삭제**

+ **테이블 칼럼에 제약조건 추가하기**
    + **ALTER TABLE** 테이블명 **ADD|MODIFY** 제약조건(컬럼명);

        ```sql
        CREATE TABLE USER_FOREIGNKEY4(
            USER_NO NUMBER PRIMARY KEY,
            USER_ID VARCHAR2(20), --> UNIQUE
            USER_PWD VARCHAR2(30), --> NOT NULL
            USER_NAME VARCHAR2(30),
            GENDER VARCHAR2(10), --> CHECK
            PHONE VARCHAR2(30),
            EMAIL VARCHAR2(50),
            GRADE_CODE NUMBER --> FOREIGN KEY
        );
        ```
        ``` SQL
        ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);
        ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('남','여'));
        ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4;
        ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;
        -- NOT NULL은 MODIFY 키워드 사용
        ```
+ **테이블 컬럼 제약조건 삭제하기**
    + **ALTER TABLE** 테이블명 **DROP CONSTRAINT** 제약조건명 
        ```SQL
        ALTER TABLE DEPT_COPY
        DROP CONSTRAINT DCOPY_DID_PK
        DROP CONSTRAINT DCOPY_DTITLE_UNQ
        MODIFY LNAME NULL; 
        -- NULL은 MODIFY 키워드 사용
        ```

### **이름 변경**

+ **테이블 이름 변경**
    + **ALTER TABLE** 테이블명 **RENAME TO** 변경테이블명
        ```SQL
        ALTER TABLE DEPT_COPY
        RENAME TO DEPT_TEST;
        
        -- 또는
        ALTER TABLE DEPT_COPY
        RENAME DEPT_COPY TO DEPT_TEST
        ```

+ **테이블 컬럼 이름 변경하기**
    + **ALTER TABLE** 테이블명 **RENAME COLUMN** 원래컬럼명 **TO** 바꿀컬럼명;

        ```SQL
        -- USER라는 테이블에 USER_NAME 이라는 컬럼을 USER_FIRST_NAME으로 변경할 때
        -> ALTER TABLE USER RENAME COLUMN USER_NAME TO USER_FIRST_NAME;
        ```
+ **테이블의 컬럼 제약조건 이름 변경하기**
    + **ALTER TABLE** 테이블명 **RENAME CONSTRAINT** 원래제약조건명 **TO** 바꿀제약조건명;
        ```SQL
        ALTER TABLE USER_FOREIGNKEY
        RENAME CONSTRAINT FK_GRADE_CODE TO UF_GC_FK;
        ```



## DROP
 + **데이터베이스 객체를 삭제하는 구문**

 + DROP TABLE 테이블명 

    ```SQL
    DROP TABLE DEPT_TEST;
    -- 제약 조건 포함해서 삭제시 : CASCADE CONSTRAINTS
    ```

