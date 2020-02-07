# Join

### [◀목차로 돌아가기](https://github.com/senspond20/Oracle)

+ [O1_DML/DQL(SELECT)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)#dclselect)
  + [함수(FUNCTION)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)/%ED%95%A8%EC%88%98(FUNCTION)#%ED%95%A8%EC%88%98-function))
  + [GROUP BY_HAVING](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/3_GroupByHaving.md#groupbyhaving)
  + [JOIN](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/4_Join.md#join)
  + [SUBQUERY](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/5_%EC%84%9C%EB%B8%8C%EC%BF%BC%EB%A6%AC.md#subquery%EC%84%9C%EB%B8%8C-%EC%BF%BC%EB%A6%AC)
+ 02

--------------------------------

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

