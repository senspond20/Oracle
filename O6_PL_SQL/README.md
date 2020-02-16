# PL/SQL (Procedural Language extension to SQL)

+ 오라클 자체에 내장되어 있는 절차적 언어
+ SQL의 단점을 보완하여 SQL문장 내에서 변수의 정의,
+ 조건 처리(IF), 반복 처리(LOOP, FOR, WHILE) 등 지원하여 SQL 단점 보완

```sql
-- 구조
--/ 선언부 / 실행부 / 예외처리부
-- DECLARE SECTION : DECLARE 로 시작(변수나 상수를 선언)
-- EXECUTABLE SECTION : BEGIN으로 시작(제어문,반복문,함수 정의 등 로직 기술)
-- EXCEPTION SECTION : EXCEPTION으로 시작(예외사항 발생 시 해결하기 위한 문장 기술)

-- 선언부 : DECLARE로 시작
--      변수, 상수 선언
-- 실행부 : BEGIN으로 시작
--      로직 기술
-- 예외처리부 : EXCEPTION
--      예외 상황 발생 시 해결하기 위한 문장 기술

/*
    System.out.println("Hello World");
*/
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
-- 만 뜨고 메시지가 뜨지않느다. => 환경변수 설정을 

--예시
SET SERVEROUTPUT ON; 
--* 프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설정하는 
-- 환경변수로 기본 값은 OFF여서 ON으로 변경
BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END; 
/ 
--* PUT_LINE이라는 프로시저를 이용하여 출력(DBMS_OTUPUT패키지에 속해있음)
-- 끝에 슬러시를 넣어야 에러가 나지 않는다.

-- 타입 변수 선언
-- 변수의 선언 및 초기화, 변수 값 출력
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

-- 레퍼런스 변수의 선언과 초기화, 변수 값 출력
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
-- 한 행에 대한 ROWTYPE 변수 선언과 초기화
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

-- 선택문(조건문)
-- IF ~ THEN ~ END IF (단일 IF문)
-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 단, 보너스를 입력받지 않은 사원은 보너스율 출력 전, 
-- '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.SALARY%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    
    IF(BONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF; 
    DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS * 100 || '%');
    
END;
/




-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE문)

-- IF ~ THEN ~ ELSIF ~ ELSE ~ END IF(IF ~ ELSE IF ~ ELSE문)

-- CASE ~ WHEN ~ THEN ~ END(SWITCH ~ CASE문)
```




    
    
    
    

