
# DDL(Data Definition Language)

### **DDL**
 + **데이터 정의 언어**로 객체(OBJECT)를 만들고(**CREATE**), 수정하고(**ALTER**), 삭제(**DROP**)하는 구문을 말함

### **CREATE**
+ 
    + 테이블이나 인덱스, 뷰 등 데이터베이스 객체를 생성하는 구문
    + CREATE TABLE 테이블명(컬럼명 자료형(크기), 
     컬럼명 자료형(크기), ... );

        ```sql
        CREATE TABLE MEMBER(
            MEMBER_ID VARCHAR2(20),
            MEMBER_PWD VARCHAR2(20),
            MEMBER_NAME VARCHAR2(20)
        );
        ```
+ 오라클 데이터형
  |데이터형|설명|
  |:-----:|--|
  |CHAR(크기)|고정길이 문자 데이터|
  |VARCHAR2(크기)|가변길이 문자 데이터 (최대 4,000Byte)|
  |NUMBER|숫자 데이터 (최대 40자리)|
  |NUMBER(길이)|숫자 데이터로, 길이 지정 가능 (최대 38자리)|
  |DATE|날짜 데이터 (BC 4712년 1월 1일 ~ AD 4712년 12월 31일)|
  |LONG|가변 길이 문자형 데이터 (최대 2GB)|
  |LOB|2GB까지의 가변길이 바이너리 데이터 저장 가능 (이미지, 실행파일 등 저장 가능)|
  |ROWID|DB에 저장되지 않는 행을 식별할 수 있는 고유 값|
  |BFILE|대용량의 바이너리 데이터 저장가능 (최대 4GB)|
  |TIMESTAMP|DATE형의 확장된 형태|
  |INTERVAL YEAR TO MONTH|년과 월을 이용하여 기간 저장|
  |INTERVAL DAY TO SEOCND|일, 시, 분, 초를 이용하여 기간 저장|

+ 컬럼 주석
    + 테이블의 컬럼에 주석을 다는 구문

    + COMMENT ON COLUMN 테이블명.컬럼명 IS '별칭';

    ```SQL
    COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
    COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
    COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
    ```

+ ### **제약조건**(CONSTRAINTS)
    + 테이블 작성 시 각 컬럼에 기록될 데이터에 대해 제약조건을 설정 할 수 있는데 이는 **데이터 무결성 보장**을 주 목적으로 함
    + + 데이터 무결성이란 ? 데이터의 **정확성**, **일관성**, **유효성**이 유지되는것

    + 입력 데이터에 문제가 없는지에 대한 검사와 
    + 데이터 수정/삭제 가능 여부 검사 등을 위해 사용
    + 컬럼이 여러개일때 제약조건이 여러개일 수 있다.
    + 제약조건은 테이블을 처음 만들 때 지정해도 되고 나중에 테이블을 만들고 지정해도 된다.

    ####

    |제약조건| 설명|
    |:-------:|:-----|
    |NOT NULL| 데이터에 NULL을 허용하지 않음|
    |UNIQUE | 중복된 값을 허용하지 않음|
    |PRIMARY KEY | NULL과 중복 값을 허용하지 않음(컬럼의 고유 식별자로 사용하기 위해) |
    |FOREIGN KEY | 참조되는 테이블의 컬럼의 값이 존재하면 허용|
    |CHECK | 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만 허용

    ####

    + 
        + ex) 제약조건 기술하여 테이블 생성

        ```SQL
        CREATE TABLE CONS_NAME (
            TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL, <--컬럼레벨
            TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA1 NOT NULL, <--컬럼레벨
            TEST_DATA3 VARCHAR2(30),
            CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3) <-- 테이블레벨
        );
        ```
        + 제약조건 확인

        ```SQL
        SELECT * FROM USER_CONSTRAINTS
        WHERE TABLE_NAME = 'CONS_NAME';
        ```
        ![CONSTRAINT](https://user-images.githubusercontent.com/60596128/74357303-160c6180-4e03-11ea-94ed-3535f747ee49.png)


    + ### **NOT NULL**
        + 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
        + 특정 컬럼에 값을 저장/수정할 때는 NULL값을 허용하지 않음.  
        + **컬럼 레벨에서만 제한 가능**
        + * NOT NULL 제약조건이 설정된 컬럼에 NULL값이 입력되면, 행 자체를 삽입하지 않음
    + ### **UNIQUE** 
        + 컬럼 입력 값에 대해 **중복을 제한**하는 제약조건
        + **컬럼 레벨과 테이블 레벨에 설정 가능**
        + * 왠만하면 테이블 레벨에 설정하는것이 좋다.

    + ### **PRIMARY KEY**
        + 테이블에서 한 행의 정보를 구분하기 위한 **고유 식별자 역할** NOT NULL의 의미와 UNIQUE의 의미를 둘 다 가지고 있으며 **한 테이블 당 하나만 설정 가능** 컬럼 레벨과 테이블 레벨 둘 다 지정 가능
        + * 여러컬럼을 묶어서 PRIMARY KEY로 만들수도 있다.

        ```sql
        -- PRIMARY KEY : NOT NULL + UNIQUE
        -- 한 행을 구분 할 수 있는 고유 식별자
        -- 한 테이블 당 하나만 설정 가능, 컬럼레벨/테이블 레벨 둘 다 설정 가능
        -- 한 개 컬럼에 설정 할 수 있고 여러 개 컬럼을 묶어서 설정 할 수 있음

        CREATE TABLE USER_PRIMARYKEY(
            USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
            USER_ID VARCHAR2(20) UNIQUE,
            USER_PWD VARCHAR2(20) NOT NULL,
            USER_NAME VARCHAR2(30),
            GENDER VARCHAR2(10),
            PHONE VARCHAR2(30),
            EMAIL VARCHAR2(50)
        );

        INSERT INTO USER_PRIMARYKEY
        VALUES(1,'user01', 'pass01','홍길동' ,'남', '010-1111-2222','hong123@kh.or.kr');

        INSERT INTO USER_PRIMARYKEY
        VALUES(2,'user02', 'pass02','이순신' ,'남', '010-2222-3333','leee123@kh.or.kr');

        INSERT INTO USER_PRIMARYKEY
        VALUES(2,'user02', 'pass02','이순신' ,'남', '010-2222-3333','leee123@kh.or.kr');
        --unique constraint (KH.PK_USER_NO) violated

        INSERT INTO USER_PRIMARYKEY
        VALUES(null,'user03', 'pass03','유관순' ,'여', '010-33330-4444','you23@kh.or.kr');
        --cannot insert NULL into ("KH"."USER_PRIMARYKEY"."USER_NO")


        CREATE TABLE USER_PRIMARYKEY2( 
            USER_NO NUMBER,
            USER_ID VARCHAR2(20) UNIQUE,
            USER_PWD VARCHAR2(20) NOT NULL,
            USER_NAME VARCHAR2(30),
            GENDER VARCHAR2(10),
            PHONE VARCHAR2(30),
            EMAIL VARCHAR2(50),
            
            CONSTRAINT PK_USER_NO_ID PRIMARY KEY(USER_NO,USER_ID)
        );

        INSERT INTO USER_PRIMARYKEY2
        VALUES(1,'user01', 'pass01','홍길동' ,'남', '010-1111-2222','hong123@kh.or.kr');

        INSERT INTO USER_PRIMARYKEY2
        VALUES(2,'user02', 'pass02','이순신' ,'남', '010-2222-3333','leee123@kh.or.kr');

        INSERT INTO USER_PRIMARYKEY2
        VALUES(null,'user03', 'pass03','유관순' ,'여', '010-33330-4444','you23@kh.or.kr');
        -- ORA-01400: cannot insert NULL into ("KH"."USER_PRIMARYKEY2"."USER_NO")

        ```
    + ### **FOREIGN KEY**
        + 참조 무결성을 위한 제약조건으로 **참조된 다른 테이블이 제공한 값만 사용하도록 제한**을 거는 것 참조되는 컬럼과 참조된 컬럼을 통해 테이블 간에 관계가 형성되는데 참조되는 값은 제공되는 값 외에 NULL을 사용 가능하며 참조할 테이블의 참조할 컬럼 명을 생략할 경우 PRIMARY KEY로 설정된 컬럼이 자동으로 참조할 컬럼이 됨

        + EX1)

        ```SQL
        -- FOREIGN KEY : 참조된 다른 테이블에 제공하는 값만 사용할 수 있음
        -- 제공 되는 값 외에는 NULL 사용 가능

        CREATE TABLE USER_GRADE(
            GRADE_CODE NUMBER PRIMARY KEY,
            GRADE_NAME VARCHAR2(30) NOT NULL
        );

        INSERT INTO USER_GRADE VALUES(10,'일반회원');
        INSERT INTO USER_GRADE VALUES(20, '우수회원');
        INSERT INTO USER_GRADE VALUES(30, '특별회원');

        SELECT * FROM USER_GRADE;

        CREATE TABLE USER_FOREIGNKEY( 
            USER_NO NUMBER PRIMARY KEY,
            USER_ID VARCHAR2(20) UNIQUE,
            USER_PWD VARCHAR2(20) NOT NULL,
            USER_NAME VARCHAR2(30),
            GENDER VARCHAR2(10),
            PHONE VARCHAR2(30),
            EMAIL VARCHAR2(50),
            GRADE_CODE NUMBER,
            CONSTRAINT FK_GRADE_CODE FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
        );

        INSERT INTO USER_FOREIGNKEY
        VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr',10);

        INSERT INTO USER_FOREIGNKEY
        VALUES(2, 'user02', 'pass02', '이순신', '남', '010-2222-3333','lee123@kh.or.kr',10);

        INSERT INTO USER_FOREIGNKEY
        VALUES(3, 'user03', 'pass03', '유관순', '남', '010-3333-4444','yoo123@kh.or.kr',30);

        INSERT INTO USER_FOREIGNKEY
        VALUES(4, 'user04', 'pass04', '안중근', '남', '010-4444-5555','ahn123@kh.or.kr',NULL);

        INSERT INTO USER_FOREIGNKEY
        VALUES(5, 'user05', 'pass05', '윤봉길', '남', '010-5555-6666','yoon123@kh.or.kr', 50);
        -- 오류 보고 - ORA-02291: integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found
        -- 오류 내용 : 참조하는 테이블에서 부모키를 찾을 수 없다고 한다.
        -- 행 삽입 불가 ==> 제약조건은 모두 허용했지만 
        -- 참조하는 테이블에 50이라는 값이 존재 하지 않으므로 삽입 불가, 없는 값은 NULL만 가능하다!!

        -- 삭제 옵션 : 부모 테이블의 데이터 삭제 시 자식 테이블의 데이터를 어떤 식으로 처리할 지에 대한 내용 설정
        DELETE FROM USER_GRADE
        WHERE GRADE_CODE = 10;
        -- integrity constraint (KH.FK_GRADE_CODE) violated - child record found
        -- ON DELETE RESTRAICTED(삭제 제한)로 기본 지정되어 있음
        -- FOREIGN KEY로 지정한 컬럼에서 사용되고 있는 값일 경우 제공하는 컬럼의 값은 삭제하지 못 함

        SELECT * FROM USER_FOREIGNKEY
        LEFT JOIN USER_GRADE USING(GRADE_CODE);

        RESULT :

        30  	3	user03	pass03	유관순	남	010-3333-4444	yoo123@kh.or.kr	 특별회원
        null    4	user04	pass04	안중근	남	010-4444-5555	ahn123@kh.or.kr	   null
        10  	1	user01	pass01	홍길동	남	010-1111-2222	hong123@kh.or.kr 일반회원
        10  	2	user02	pass02	이순신	남	010-2222-3333	lee123@kh.or.kr	 일반회원
        ```

        
    + **CHECK**
        + 해당 컬럼에 입력 되거나 수정되는 값을 체크하여 설정된 값 이외의 값이면 에러 발생 비교 연산자를 이용하여 조건을 설정하며 비교 값을 리터럴만 사용 가능하고 변하는 값이나 함수 사용은 불가능
        
        ```SQL
        CREATE TABLE USER_CHECK2(
            TEST_NUMBER NUMBER,
            CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
        );

        INSERT INTO USER_CHECK2 VALUES(10);
        INSERT INTO USER_CHECK2 VALUES(-1);
        -- check constraint (KH.CK_TEST_NUMBER) violated
        -- 범위가 0보다 커야 하기 때문에 음수를 넣을 수 없다는 에러
        ```

+ ### **서브쿼리를 이용한 테이블 생성**

    +  **CREATE TABLE** 테이블 명(별칭,,,) **AS** (서브쿼리);
        ```SQL
        --EX1)
        CREATE TABLE EMPLOYEE_COPY
        AS SELECT * FROM EMPLOYEE;

        --EX2)
        CREATE TABLE EMPLOYEE_COPY2(사번,사원명,급여,부서명,직급명)
        AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
            FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                LEFT JOIN JOB USING(JOB_CODE);
        ```


### **Data Dictionary 명령어**
+
    + 
    | 키워드 | 설명
    |----| ----
    |USER_TABLES | 사용자가 작성한 테이블을 확인하는 뷰
    |USER_TAB_COLUMNS |테이블, 뷰의 컬럼들과 관련된 정보 조회
    |USER_CONSTRAINTS |  테이블에 적용되어 있는 제약조건 조회
    |DESC (TABLE NAME) | 테이블 구조 표시


+   +

    ```SQL
    SELECT * FROM USER_TABLES;
    -- USER_TABLES : 사용자가 작성한 테이블을 확인하는 뷰

    SELECT * FROM USER_TAB_COLUMNS; 
    -- USER_TAB_COLUMNS : 테이블, 뷰의 컬럼들과 관련된 정보 조회 DATA DICTIONARY

    SELECT * FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = 'MEMBER';

    DESC MEMBER; 
    -- DESC문 : 테이블 구조 표시

    SELECT * FROM USER_VIEWS; 
    -- View 구조
    ```

