# DML(INSERT, UPDATE, DELETE)

### **INSERT**
+ 테이블에 새로운 행을 추가하여 테이블의 행 개수를 증가시키는 구문
   
    + **INSERT INTO** 테이블명(칼럼명,,,) **VALUES** (값,,,)

        ```sql
        INSERT INTO EMPLOYEE ( EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
        VALUES(900,'장채현','901123-1080503' ,'JANG_CH@kh.or.kr', '01055569512', 'D1', 'J7', 'S3', 4300000,0.2, '200', SYSDATE, NULL, DEFAULT);
        ```
    + **INSERT INTO** 테이블명 **VALUES** (값,,,)
         + 모든 컬럼에 대해 INSERT할 때 모든 컬럼을 다 기입하지 않고 생략할 수 있다.
         + 대신 순서를 잘 지켜 값을 넣어야한다.

        ```sql
        INSERT INTO EMPLOYEE
        VALUES(900,'장채현','901123-1080503' ,'JANG_CH@kh.or.kr', '01055569512', 'D1', 'J7', 'S3', 4300000,0.2, '200', SYSDATE, NULL, DEFAULT);
        ```

+   + **서크쿼리를 이용**
        + **INSERT INTO** 테이블명(**서브쿼리 SELECT문**)
        ```sql
        CREATE TABLE EMP_01(
            EMP_ID NUMBER,
            EMP_NAME VARCHAR2(30),
            DEPT_TITLE VARCHAR2(20)
        );

        INSERT INTO EMP_01(
            SELECT EMP_ID, EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE 
                LETF JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
        );
        ```
+  ### **INSERT ALL**
    +
        + INSERT시 서브쿼리가 사용하는 테이블이 같은 경우, 두 개 이상의 테이블에 INSERT ALL을 이용하여 한번에 삽입 가능
        
        + **EX) 각 서브쿼리의 조건이 같은 경우**
   
        ```sql
        -- INSERT ALL을 사용하기 위한 TABLE 생성
        CREATE TABLE EMP_DEPT_D1
        AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
            FROM EMPLOYEE
            WHERE 1 = 0;
        -- INSERT ALL을 사용하기 위한 TABLE 생성
        CREATE TABLE EMP_MANAGER
        AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
            FROM EMPLOYEE
            WHERE 1 = 0;

        -- 서브쿼리의 조건이 같은 INSERT ALL
        INSERT ALL 
        INTO EMP_DEPT_D1 VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE )
        INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
            SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1';
        ```
        + **EX) 각 서브쿼리의 조건이 다른 경우**

        ```SQL
       
        INSERT INTO EMP_OLD(
            SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
            FROM EMPLOYEE
            WHERE HIRE_DATE < '2000/01/01'
        );

        INSERT INTO EMP_NEW(
            SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
            FROM EMPLOYEE
            WHERE HIRE_DATE >= '2000/01/01'
        );

        SELECT * FROM EMP_OLD; -- 8개
        SELECT * FROM EMP_NEW; -- 16개 

        ROLLBACK;

        -- 서브쿼리의 조건이 다른 INSERT ALL
        INSERT ALL
        WHEN HIRE_DATE < '2000/01/01' THEN 
            INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
        WHEN HIRE_DATE >= '2000/01/01' THEN
            INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
        SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
        FROM EMPLOYEE;

        -- WHEN 절을 ELSE로 바꾸어서 할 수도 있다.
        INSERT ALL
        WHEN HIRE_DATE < '2000/01/01' THEN 
            INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
        ELSE
            INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
        SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
        FROM EMPLOYEE;

        ```

### **UPDATE**
+  테이블에 기록된 **컬럼 값 수정**을 하는 구문으로 테이블 전체 행 개수는 변화없음
+ 조건문을 적어주지 않을 시 모든 행의 값이 변경됨 (행의 개수는 변화 X )
+    + **UPDATE** 테이블명 **SET** 수정내용 [**WHERE**] 조건문

        ```sql
        UPDATE DEPT_COPY
        SET DEPT_TITLE = '전략기획팀'
        WHERE DEPT_ID = 'D9'

        -- WHERE 문이 빠진 업데이트 -> 모두 다 바꿔버린다.
        UPDATE DEPT_COPY
        SET DEPT_TITLE = '전략기획팀';
        ```

+ **UPDATE 시에도 서브쿼리 가능**

+  + EX) 평상 시 유재식 사원을 부러워하던 방명수 사원의 급여와 보너스를
         유재식 사원과 동일하게 변경해주기로 했다.

        ```SQL
        CREATE TABLE EMP_SALARY
        AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
            FROM EMPLOYEE;
            
        SELECT * FROM EMP_SALARY
        WHERE EMP_NAME IN ('유재식', '방명수');

        UPDATE EMP_SALARY
        SET SALARY = (SELECT SALARY
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '유재식'),
            BONUS = (SELECT BONUS
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '유재식')
        WHERE EMP_NAME = '방명수';

        ROLLBACK;

        -- 다중열 다중행 서브쿼리 이용
        UPDATE EMP_SALARY
        SET(SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '유재식')
        WHERE EMP_NAME IN ('방명수', '노옹철','전형돈','정중하','하동운');

        SELECT * FROM EMP_SALARY
        WHERE EMP_NAME IN ('방명수', '노옹철','전형돈','정중하','하동운');
        
        --EMP_SALARY 테이블에서 아시아지역에서 근무하는 직원의 보너스를 0.3으로 변경
        -- 아시아에 근무하는 직원 조회(사번, 이름, 급여 ,보너스 , 지역 명)

        SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME 
        FROM LOCATION
            JOIN DEPARTMENT ON (LOCAL_CODE = LOCATION_ID)
            JOIN EMPLOYEE ON (DEPT_ID = DEPT_CODE)
        WHERE LOCAL_NAME LIKE 'ASIA%';
            
        SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME 
        FROM EMP_SALARY
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
            JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        WHERE LOCAL_NAME LIKE 'ASIA%';

        UPDATE EMP_SALARY
        SET BONUS = 0.3
        WHERE EMP_ID IN(SELECT EMP_ID
                    FROM EMP_SALARY
                        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                    WHERE LOCAL_NAME LIKE 'ASIA%');

        SELECT * FROM EMP_SALARY;
        ```

### **DELETE**

+ 테이블의 행을 삭제하는 구문으로 테이블의 행 개수가 줄어듦
+ 조건문을 적어주지 않을 경우 모든 행의 값이 삭제됨
+   + **DELETE FROM** 테이블명 [**WHERE**] 조건식

        ```sql
        COMMIT;

        DELETE FROM EMPLOYEE
        WHERE EMP_NAME = '장채현';

        SELECT * FROM EMPLOYEE;

        ROLLBACK;
        ```

### **TRUNCATE**

+  테이블의 전체 행 삭제 시 사용
+  DELETE 보다 수행속도가 더 빠르나 **ROLLBACK 을 통해 복구 불가능**
+  -> **조심해서 사용해야 한다.**
+ (※ ALTER / CREATE 도 롤백이 안된다)
+  + EX)
        ```SQL
        SELECT * FROM EMP_SALARY;
        COMMIT;

        DELETE FROM EMP_SALARY;
        -- 00개 개 행 이(가) 삭제되었습니다.
        ROLLBACK;

        TRUNCATE TABLE EMP_SALARY;
        --Table EMP_SALARY이(가) 잘렸습니다.
        ```
