# PL/SQL (Procedural Language extension to SQL)

○  오라클 자체에 내장되어 있는 절차적 언어  
○ SQL의 단점을 보완하여 SQL문장 내에서 변수의 정의, 조건 처리(IF), 반복 처리(LOOP, FOR, WHILE) 등 지원하여 SQL 단점 보완



+ **SERVEROUTPUT** 
    프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설정하는 환경변수로 기본 값은 OFF여서 ON으로 변경

    ```sql
    SET SERVEROUTPUT ON; 
    ```
+ **PUT_LINE** 
   PUT_LINE이라는 프로시저를 이용하여 출력(DBMS_OTUPUT패키지에 속해있음)
    ```sql
    BEGIN
    DBMS_OUTPUT.PUT_LINE(‘HELLO WORLD’);
    END; 
    /
    -- 맨 끝에 / 를 넣어줘야한다.
    -- SERVEROUTPUT 설정이 ON이 되지 않으면 화면에 출력되지 않는다.
    ```

### **구조**

   +  **선언부** : **DECLARE**로 시작  
    -->      변수, 상수 선언  

   + **실행부** : **BEGIN**으로 시작  
    -->      로직 기술(제어문,반복문,함수 정의) 

   + **예외처리부** : **EXCEPTION**  
    -->      예외 상황 발생 시 해결하기 위한 문장 기술

------------

### **타입 변수 선언**

+ **변수의 선언 및 초기화, 변수 값 출력**

    ```sql
    DECLARE
        EMP_ID NUMBER; --int empId;  NUMBER타입 변수 EMP_ID 선언 =>JAVA : int empId;
    --  ↑변수명 ↑자료형
        EMP_NAME VARCHAR(30); --VARCHAR2 타입 변수 EMP_NAME 선언 => JAVA : String empName;
        
        PI CONSTANT NUMBER := 3.14; -- NUMBER 타입의 상수 PI 선언 => JAVA : final double PI = 3.14;
        -- 변수 값 대입 연산자 :=
    BEGIN -- 실행부
        EMP_ID := 888;       -- EMP_ID변수에 888로 값 초기화
        EMP_NAME := '배장남'; -- EMP_NAME 변수에 배장남으로 값 초기화
        DBMS_OUTPUT.PUT_LINE('EMP_ID :' || EMP_ID);
        DBMS_OUTPUT.PUT_LINE('EMP_NAME :' || EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
    END;
    /
    ```

+ **레퍼런스 변수의 선언과 초기화, 변수 값 출력**

    ```SQL
    DECLARE
        EMP_ID EMPLOYEE.EMP_ID%TYPE; -- 변수 EMP_ID의 타입을 EMPLOYEE 테이블의 EMP_ID컬럼 타입으로 지정
        EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    BEGIN
        SELECT EMP_ID, EMP_NAME -- EMP_ID, EMP_NAME => 컬럼이름
        INTO EMP_ID, EMP_NAME   -- EMP_ID, EMP_NAME => 변수
        FROM EMPLOYEE           -- 
        WHERE EMP_ID = '&EMP_ID';
        
        DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
        DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    END;
    /

    -- 레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY 를선언하고
    -- EMPLOYEE 테이블에서 사번, 이름, 직급코드,부서코드, 급여를 조회하고
    -- 선언한 레퍼런스 변수에 담아 출력하시오
    -- 단, 입력받은 이름과 일치하는 조건의 직원을 조회하세요

    DECLARE
        EMP_ID EMPLOYEE.EMP_ID%TYPE; -- 변수 EMP_ID의 타입을 EMPLOYEE 테이블의 EMP_ID컬럼 타입으로 지정
        EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
        DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
        JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
        SALARY EMPLOYEE.SALARY%TYPE;
    BEGIN
        SELECT EMP_ID, EMP_NAME,JOB_CODE,DEPT_CODE, SALARY -- EMP_ID, EMP_NAME => 컬럼이름
        INTO EMP_ID, EMP_NAME,JOB_CODE,DEPT_CODE, SALARY   -- EMP_ID, EMP_NAME => 변수
        FROM EMPLOYEE           -- 
        WHERE EMP_NAME = '&EMP_NAME';
        
        DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
        DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
        DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
        DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
        
    END;
    /
    ```

+ **한 행에 대한 ROWTYPE 변수 선언과 초기화**

    ```SQL
    DECLARE 
        E EMPLOYEE%ROWTYPE;
        -- %ROWTYPE : 테이블 또는 뷰의 컬럼 데이터 형, 크기, 속성 참조
    BEGIN
        SELECT *  
        INTO E 
        FROM EMPLOYEE
        WHERE EMP_ID = '&사번';
        -- 사번, 이름, 주민번호, 급여
        DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
        DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME );
        DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
        DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
    END;
    /
    ```

--------------------

+ 선택문
    + IF ~ THEN ~ END IF (단일 IF문)
    + IF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE문)
    + IF ~ THEN ~ ELSIF ~ ELSE ~ END IF(IF ~ ELSE IF ~ ELSE문)
    + CASE ~ WHEN ~ THEN ~ END(SWITCH ~ CASE문)

+ 반복문
+ 예외처리

-----------------------------


+ ### **선택문**

+ ### **반복문**
    + **BASIC LOOP**  
    내부에 처리문을 작성하고 마지막에 LOOP를 벗어날 조건 명시

        ```SQL
        LOOP
            처리문
            조건문
        END LOOP;
        
        조건문
            1) IF 조건식 THEN EXIT; END IF;
            2) EXIT WHEN 조건식;
        ```

    + 예시) 1 ~ 5 까지 순차적으로 출력
        ```SQL
        DECLARE
            N NUMBER :=1;
        BEGIN
            LOOP
                DBMS_OUTPUT.PUT_LINE(N);
                N := N + 1;
        --        IF N > 5 THEN EXIT;
        --        END IF;
                EXIT WHEN N > 5;
            END LOOP;
        END;
        /
        ```

    + **FOR LOOP**

        ```SQL
        FOR 인덱스 IN [REVERSE] 초기값..최종값
        LOOP 
            처리문
        END LOOP;
        ```
    + 예시) 

        ```SQL
        -- 1 ~ 5 까지 순차적으로 출력
        --DECLARE 
        --    N NUMBER :=1;
        --for문의 변수는 선언부에서 선언하지 않고 사용이 가능하다.
        BEGIN
            FOR N IN 1..5
            LOOP
                DBMS_OUTPUT.PUT_LINE(N);
            END LOOP;
        END;
        /

        -- 5 ~ 1까지 순차적으로 출력
        BEGIN
            FOR N IN REVERSE 1..5
            LOOP
            DBMS_OUTPUT.PUT_LINE(N);
            END LOOP;
        END;
        /
        ```

    + 응용) 반복문을 이용한 데이터 삽입

        ```sql
        CREATE TABLE TEST1(
            BUNHO NUMBER(3),
            NALJJA DATE  
        );

        BEGIN
            FOR I IN 1..10
            LOOP
                INSERT INTO TEST1 VALUES(I, SYSDATE);
            END LOOP;
        END;
        /

        SELECT * FROM TEST1;
        ```

+ **예외처리**

    + **EXCEPTION절에 예외 상황 발생 시 해결하기 위한 문장 기술** 
    오라클에서 미리 정의된 예외에 대해서 예외처리를 할 수도 있고 사용자 정의 예외에 대해서 예외처리를 할 수도 있음

        |예외종류 | 설명 |
        |--------|------|
        |NO_DATA_FOUND|SELECT 문이 아무런 데이터 행을 반환하지 못할 때|
        |DUP_VAL_ON_INDEX |UNIQUE 제약을 갖는 컬럼에 중복된 데이터가 들어갔을 때
        |ZERO_DIVIDE |0으로 나눌때
        |           |


        ```sql  
        -- DUP_VAL_ON_INDEX
        BEGIN
            UPDATE EMPLOYEE
            SET EMP_ID = '&사번'
            WHERE EMP_ID = 200;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
        END;
        /
        SELECT * FROM EMPLOYEE;

        -- NO_DATA_FOUND
        DECLARE
            NAME VARCHAR2(30);
        BEGIN
            SELECT EMP_NAME
            INTO NAME
            FROM EMPLOYEE
            WHERE EMP_ID = 5;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('존재하지 않는 데이터입니다.');
        END;
        /
        ```
------------------


### 테이블 타입

+ 테이블 : 키와 값의 쌍으로 이루어진 컬렉션
+ 하나의 테이블의 한 개의 컬럼 데이터 저장

+ [표현식]  

    ```sql
    DECLARE
        TYPE 테이블명 IS TABLE OF 데이터타입  
        INDEX BY BYNARY_INTEGER;
    ```
    + 예제)
        ```sql
        DECLARE 
            -- 테이블 타입 선언
            TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
            INDEX BY BINARY_INTEGER;
            -- EMPLOYEE.EMP_ID의 타입의 데이터를 저장 할 수 있는 테이블 타입 변수 EMP_ID_TABLE_TYPE 선언
            
            TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE
            INDEX BY BINARY_INTEGER;
            -- EMPLOYEE.EMP_NAME 타입의 데이터를 저장 할 수 있는 테이블 타입 EMP_NAME_TABLE_TYPE 선언
            
            -- 변수 선언
            -- 테이블 타입 EMP_ID_TABLE_TYPE 변수 EMP_ID_TABLE 선언
            EMP_ID_TABLE EMP_ID_TABLE_TYPE;
            
            -- 테이블 타입 EMP_NAME_TABLE_TYPE 변수 EMP_NAME_TABLE 선언
            EMP_NAME_TABLE EMP_NAME_TABLE_TYPE;
            
            I BINARY_INTEGER := 0;
            
        BEGIN
            FOR K IN (SELECT EMP_ID, EMP_NAME FROM EMPLOYEE)
            -- K에 SELECT 해온 행 하나하나가 들어감
            LOOP
                I := I + 1;
                EMP_ID_TABLE(I) := K.EMP_ID;
                EMP_NAME_TABLE(I) := K.EMP_NAME;
            END LOOP;
            
            FOR J IN 1..I
            LOOP
                DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID_TABLE(J) || ', EMP_NAME : ' || EMP_NAME_TABLE(J));
            END LOOP;
        END;
        /
        ```

### 레코드 타입

+ 서로 다른 유형의 데이터를 한 줄로 나열한 형태
+ 테이블 타입의 경우 한 타입만 들어갈 수 있다면 레코드 타입의 경우 내가 정한 여러 타입이 들어갈 수 있음

+ [표현식]
    ```sql
    DECLARE
        TYPE 레코드명 IS RECORE(
            필드명 필드타입 [ [NOT NULL] := DEFAULT 값],
            필드명 필드타입 [ [NOT NULL] := DEFAULT 값],
            ...
        );
    ```
    + 예제)
        ```sql
        DECLARE
        -- 레코드 타입 선언
            TYPE EMP_RECORD_TYPE IS RECORD(
                EMP_ID EMPLOYEE.EMP_ID%TYPE,
                EMP_NAME EMPLOYEE.EMP_NAME%TYPE,
                DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
                JOB_NAME JOB.JOB_NAME%TYPE
            );
        EMP_RECORD EMP_RECORD_TYPE;
       
        BEGIN
        SELECT EMP_ID,EMP_NAME, DEPT_TITLE, JOB_NAME
        INTO EMP_RECORD
        FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
            LEFT JOIN JOB USING(JOB_CODE)
        WHERE EMP_NAME = '&이름';

        DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_RECORD.EMP_ID);
        DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_RECORD.EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('부서 : ' || EMP_RECORD.DEPT_TITLE);
        DBMS_OUTPUT.PUT_LINE('직급 : ' || EMP_RECORD.JOB_NAME);
        
        END;
        /
        ```