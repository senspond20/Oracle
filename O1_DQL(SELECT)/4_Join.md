# Join

+ ## Oracle 전용구문
    + FROM 절에 ','로 구분하여 합치게 될 테이블 명을 기술하고 WHERE 절에 합치기에 사용할 컬럼 명 명시
    
    ```SQL
    SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
    FROM EMPLOYEE, JOB
    WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
    ```




+ ## ANSI 표준 구문
    + 연결에 사용하려는 컬럼 명이 같은 경우 USING() 사용,
    + 다른 경우 ON() 사용
    ```SQL
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    ```

