## **PROCEDURE**
+ **PL/SQL문을 저장하는 객체** 
+ 필요할 떄 마다 복잡한 구문을 다시 입력 할 필요 없이 간단하게 호출해서 실행결과를 얻을 수 있음
+ 특정 로직을 처리하기만 하고 결과 값을 반환하지는 않음

    ```sql
    -- EMPLOYEE테이블을 복사한 EMP_DUP테이블 생성
    CREATE TABLE EMP_DUP
    AS 
    SELECT * FROM EMPLOYEE;

    SELECT * FROM EMP_DUP;

    -- 호출 시 EMP_DUP 테이블에 있는 모든 데이터를 삭제하는 DEL_ALL_EMP프로시저 생성
    CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
    IS 
    BEGIN 
        DELETE FROM EMP_DUP;
        COMMIT;
    END;
    /
    -- 호출해 사용하지 않았기에 아직 지워지지 않았다.
    SELECT * FROM EMP_DUP;

    -- DEL_ALL_EMP라는 프로시저를 실행하겠다.
    EXECUTE DEL_ALL_EMP;

    SELECT * FROM EMP_DUP;

    SELECT * FROM USER_SOURCE;
    -- 프로시저 관리용 DD(DATA DICTIONARY)
    -- TEXT 칼럼에 사용자가 기록한 라인대로 기록되어 저장된다.

    COMMIT;

    CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
    IS
    BEGIN
        DELETE FROM EMPLOYEE
        WHERE EMP_ID = V_EMP_ID;
    END;
    /

    --EXECUTE 를 줄여서 EXEC로 사용해도 된다.DF
    EXEC DEL_EMP_ID('&사번');

    SELECT * FROM EMPLOYEE;

    ROLLBACK;
    ```

+ **IN /OUT [매개변수] 있는 프로시저**
    + IN 매개변수 : 프로시저 내부에서 사용될 변수
    + OUT 매개변수 : 프로시저 외부(호출부)에서 사용될 변수

    ```sql
    -- 사용자가 입력한 사번으로 사원의 이름, 급여, 보너스 조회하는 SELECT_EMP_ID 프로시저 생성
    CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
        V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
        V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
        V_SALARY OUT EMPLOYEE.SALARY%TYPE,
        V_BONUS OUT EMPLOYEE.BONUS%TYPE
    )
    IS 
    BEGIN
        SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
        INTO V_EMP_NAME,V_SALARY, V_BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = V_EMP_ID;
    END;
    /
    ```

+ **바인드 변수** (VARIABLE OR VAR)
    + SQL문을 실행할 때 SQL에 사용 값을 전달 할 수 있는 통로 역할

    ```sql
    VARIABLE VAR_EMP_NAME VARCHAR2(30);
    VAR VAR_SALARY NUMBER;
    VAR VAR_BONUS NUMBER;

    PRINT VAR_EMP_NAME;
    PRINT VAR_SALARY;
    PRINT VAR_BONUS;

    EXECUTE SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

    -- PRINT를 수동으로 호출 하지 않아도 자동으로 하나씩
    SET AUTOPRINT ON;

    /*
        Public void method(int a){
            int result = a;
        }

    */
    ```


## **FUNCTION**
+ 프로시저와 사용 용도는 거의 비슷하지만 실행결과를 되돌려받을 수 있음(RETRUN)

    ```sql
    CREATE OR REPLACE FUNCTION 함수명 (매개변수1 매개변수 타입, ....)   
    RETURN 데이터타입  
    IS [AS]  
        선언부  
    BEGIN   
        실행부  
        RETURN 반환값;  
    [EXCEPTION  
        예외 처리부]  
    END [함수명];  
    /
    ```

+ 예제)

    ```sql
    -- 사번을 입력받아 해당 사원의 연봉을 계산하고 리턴하는 함수 생성 (BONUS_CALC)
    CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
    RETURN NUMBER
    IS 
        V_SAL EMPLOYEE.SALARY%TYPE;
        V_BONUS EMPLOYEE.BONUS%TYPE;
        CALC_SAL NUMBER;
    BEGIN
        SELECT SALARY, NVL(BONUS,0)
        INTO V_SAL, V_BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = V_EMP_ID;
        
        CALC_SAL := (V_SAL + (V+SAL * V_BONUS)) * 12;
        
        RETURN CALC_SAL;
    END;
    /

    VAR VAR_CALC NUMBER;
    EXEC :VAR_CALC := BONUS_CALC('&사번');


    CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
    RETURN NUMBER
    IS
        V_SAL EMPLOYEE.SALARY%TYPE;
        V_BONUS EMPLOYEE.BONUS%TYPE;
        CALC_SAL NUMBER;
    BEGIN
        SELECT SALARY, NVL(BONUS, 0)
        INTO V_SAL, V_BONUS
        FROM EMPLOYEE
        WHERE EMP_ID = V_EMP_ID;
        
        CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
        
        RETURN CALC_SAL;
    END;
    /

    VAR VAR_CALC NUMBER;
    -- 
    EXEC :VAR_CALC :=BONUS_CALC('&사번'); 
    -- 주석을 ; 다음에 달지 말것
    ```



