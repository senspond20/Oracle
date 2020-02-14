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
+   + **INSERT ALL**
        + INSERT시 서브쿼리가 사용하는 테이블이 같은 경우, 두 개 이상의 테이블에 INSERT ALL을 이용하여 한번에 삽입 가능
        
        + **각 서브쿼리의 조건이 같은 경우**
   
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
        + **각 서브쿼리의 조건이 다른 경우**
        ```


        ```

### **UPDATE**
+  테이블에 기록된 **컬럼 값 수정**을 하는 구문으로 테이블 전체 행 개수는 변화없음
+ 조건문을 적어주지 않을 시 모든 행의 값이 변경됨
+    + **UPDATE** 테이블명 **SET** 수정내용 [**WHERE**ㄴ] 조건문

        ```sql
        UPDATE TABLE DEPT_COPY
        AS SELECT * FROM DEPARTMENTL;

        UPDATE DEPT_COPY
        SET DEPT_TITLE = '전략기획팀'
        WHERE DEPT_ID = 'D9'
        ```

### **DELETE**

+ 테이블의 행을 삭제하는 구문으로 테이블의 행 개수가 줄어듦
+ 조건문을 적어주지 않을 경우 모든 행의 값이 삭제됨
+   + **DELETE FROM** 테이블명 [**WHERE**] 조건식