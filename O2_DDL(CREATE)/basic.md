
# DDL(Data Definition Language)

 + 데이터 정의 언어로 객체(OBJECT)를 만들고(CREATE), 수정하고(ALTER), 삭제(DROP)하는 구문을 말함

+ CREATE
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
    + CHAR
    + VARCAHR2
    + NUMBER
    + NUMBER(길이)
    + DATE
    + LONG
    + LOB
    + RWOID
    + BFILE
    + TIMESTAMPS
    + INTERVAL YEAR TO MONTH
    + INTERVAL DAY TO SECONT

+ 컬럼 주석
    + 테이블의 컬럼에 주석을 다는 구문

    + COMMENT ON COLUMN 테이블명.컬럼명 IS '별칭';

    ```SQL
    COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
    COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
    COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
    ```

+ 제약조건(CONSTRAINTS)
    + 테이블 작성 시 각 컬럼에 기록될 데이터에 대해 제약조건을 설정 할 수 있는데 이는 **데이터 무결성 보장**을 주 목적으로 함
    + 입력 데이터에 문제가 없는지에 대한 검사와 
    + 데이터 수정/삭제 가능 여부 검사 등을 위해 사용

    + * 컬럼이 여러개일때 제약조건이 여러개일 수 있다.
   

    |제약조건| 설명|
    |-------|-----|
    |NOT NULL| 데이터에 NULL을 허용하지 않음|
    |UNIQUE | 중복된 값을 허용하지 않음|
    |PRIMARY KEY | NULL과 중복 값을 허용하지 않음(컬럼의 고유 식별자로 사용하기 위해) |
    |FOREIGN KEY | 참조되는 테이블의 컬럼의 값이 존재하면 허용|
    |CHECK | 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만 허용

    + 제약조건 확인

    ```SQL
    DESC USER_CONSTRAINTS; 
    DESC USER_CONS_COLUMNS;
    ```

    + **NOT NULL**
        + 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
        + 특정 컬럼에 값을 저장/수정할 때는 NULL값을 허용하지 않도록 컬럼 레벨에서 제한
        + * NOT NULL 제약조건이 설정된 컬럼에 NULL값이 입력되면, 행 자체를 삽입하지 않음
    + **UNIQUE** 
        + 컬럼 입력 값에 대해 **중복을 제한**하는 제약조건으로 컬럼 레벨과 테이블 레벨에 설정 가능
        + * 왠만하면 테이블 레벨에 설정하는것이 좋다.

    + **PRIMARY KEY**
        + 테이블에서 한 행의 정보를 구분하기 위한 **고유 식별자 역할** NOT NULL의 의미와 UNIQUE의 의미를 둘 다 가지고 있으며 **한 테이블 당 하나만 설정 가능** 컬럼 레벨과 테이블 레벨 둘 다 지정 가능
        + * 여러컬럼을 묶어서 PRIMARY KEY로 만들수도 있다.

    + **FOREIGN KEY**
        + 참조 무결성을 위한 제약조건으로 **참조된 다른 테이블이 제공한 값만 사용하도록 제한**을 거는 것 참조되는 컬럼과 참조된 컬럼을 통해 테이블 간에 관계가 형성되는데 참조되는 값은 제공되는 값 외에 NULL을 사용 가능하며 참조할 테이블의 참조할 컬럼 명을 생략할 경우 PRIMARY KEY로 설정된 컬럼이 자동으로 참조할 컬럼이 됨
    + **CHECK**
        + 해당 컬럼에 입력 되거나 수정되는 값을 체크하여 설정된 값 이외의 값이면 에러 발생 비교 연산자를 이용하여 조건을 설정하며 비교 값을 리터럴만 사용 가능하고 변하는 값이나 함수 사용은 불가능

    
+ ssss

    ```SQL
    SELECT * FROM USER_TABLES;
    -- USER_TABLES : 사용자가 작성한 테이블을 확인하는 뷰

    SELECT * FROM USER_TAB_COLUMNS; 
    -- USER_TAB_COLUMNS : 테이블, 뷰의 컬럼들과 관련된 정보 조회 DATA DICTIONARY

    SELECT * FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = 'MEMBER';

    DESC MEMBER; 
    -- DESC문 : 테이블 구조 표시
    ```

