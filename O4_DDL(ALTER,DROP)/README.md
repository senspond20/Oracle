# DDR(ALTER,DROP)

## **ALTER**

+ ALTER - 테이블에 정의된 내용을 수정할 때 사용하는 데이터 정의어
+ ALTER : 객체 수정 구문

### **컬럼 추가, 삭제, 수정**

+ **테이블 칼럼 추가하기**
    + **ALTER TABLE** 테이블명 **ADD**(컬럼명 데이타타입(사이즈));

        ```SQL
        -- USER라는 테이블에 USER_NAME이라는 컬럼을 VARCHAR2(13) 타입으로 추가할 때
        -> ALTER TABLE USER ADD(USER_NAME VARCAHR2(13));  
        ```

+ **테이블 칼럼 수정하기**
    + **ALTER TABLE** 테이블명 **MODIFY**(컬럼명 테이타타입(사이즈));

        ```SQL
        -- USER라는 테이블에 USER_AGE 라는 컬럼을 NUNBER(3) 타입으로 수정할 때
        -> ALTER TABLE USER MODIFY(USER_AGE NUMBER(3));
        ```

+ **테이블 칼럼 삭제하기** 
    + **ALTER TABLE** 테이블명 **DROP COLUMN** 컬럼명

        ```SQL
        -- USER라는 테이블에 USER_NAME 이라는 컬럼을 삭제할 때
        -> ALTER TABLE USER DROP COLUMN USER_NAME;
        ```

+ **테이블 컬럼 이름 변경하기**
    + **ALTER TABLE** 테이블명 **RENAME COLUMN** 원래컬럼명 **TO** 바꿀컬럼명;

        ```SQL
        -- USER라는 테이블에 USER_NAME 이라는 컬럼을 USER_FIRST_NAME으로 변경할 때
        -> ALTER TABLE USER RENAME COLUMN USER_NAME TO USER_FIRST_NAME;
        ```


### **제약조건 추가,변경,삭제**

+
    ```sql
    CREATE TABLE USER_FOREIGNKEY4(
        USER_NO NUMBER PRIMARY KEY,
        USER_ID VARCHAR2(20), -- UNIQUE
        USER_PWD VARCHAR2(30), -- NOT NULL
        USER_NAME VARCHAR2(30),
        GENDER VARCHAR2(10), -- CHECK
        PHONE VARCHAR2(30),
        EMAIL VARCHAR2(50),
        GRADE_CODE NUMBER -- FOREIGN KEY
    );
    ```

+ **테이블 칼럼에 제약조건 추가하기**
    + **ALTER TABLE** 테이블명 **ADD|MODIFY** 제약조건(컬럼명);

    ``` SQL
    ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);
    ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('남','여'));
    ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4;
    ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;
    -- NOT NULL은 MODIFY 키워드 사용
    ```

+ **테이블의 컬럼 제약조건 이름 변경하기**
    + **ALTER TABLE** 테이블명 **RENAME CONSTRAINT** 원래제약조건명 **TO** 바꿀제약조건명;

+ 제약조건이 설정되어 있는 컬럼 삭제






## DROP

