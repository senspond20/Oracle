# Join

### [◀목차로 돌아가기](https://github.com/senspond20/Oracle)

+ [O1_DML/DQL(SELECT)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)#dqlselect)
  + [연산자](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/1_연산자.md#연산자)
  + [함수(FUNCTION)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)/%ED%95%A8%EC%88%98(FUNCTION)#%ED%95%A8%EC%88%98-function))
  + [GROUP BY_HAVING](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/3_GroupByHaving.md#groupbyhaving)
  + [JOIN](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/4_Join.md#join)
  + [SUBQUERY](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/5_%EC%84%9C%EB%B8%8C%EC%BF%BC%EB%A6%AC.md#subquery%EC%84%9C%EB%B8%8C-%EC%BF%BC%EB%A6%AC)

--------------------------------

+ ## JOIN

    + **하나 이상의 테이블** 에서 데이터를 조회하기 위해 사용하고 수행 결과는 하나의 Result Set으로 나옴
        + 두개 이상이 아니라 하나 이상인 이유 ?  => 

    + 기본적으로 JOIN은 [INNER] JOIN
    + 두개 이상의 테이블을 조인할 때 일치하는 값이 없는 행은 조인에서 제외됨
    + [OUTER] JOIN은 일치하지 않은 값도 포함이 되며, 반드시 [OUTER] JOIN 명시 
    + <u>Oracle 전용구문과 ANSI 구문이 달라서 둘다 사용할줄 알아야한다.</u>


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

-----------------------------

## 외부 조인([OUTER] JOIN)

+  두 테이블의 지정하는 컬럼 값이 일치 하지 않는 행도 조인에 포함

+ **LEFT [OUTER] JOIN** 
: 왼쪽에 기술된 테이블의 컬럼 수를 기준으로 JOIN

+ **RIGHT [OUTER] JOIN**
: 오른쪽에 기술된 테이블의 컬럼 수를 기준으로 JOIN

+ **FULL [OUTER] JOIN**
: 두 테이블이 가진 모든 행을 결과에 포함시키려 할때
    + <u>( FULL [OUTER] JOIN 은 오라클 전용문법으로는 불가능하고, ANSI 문법을 사용해야 한다.)</u>


+ ### LEFT [OUTER] JOIN 
    ```sql
    -- ANSI
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
        
    -- ORACLE
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE = DEPT_ID(+); -- '내가 너한테 맟춰줄게~' 라고 말하는 쪾이(+) 를 붙임
    ```

+ ### RIGHT [OUTER] JOIN 

    ```sql
    -- ANSI
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

    -- ORACLE
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE(+) = DEPT_ID;
    ```


+ ### FULL [OUTER] JOIN 

    ```sql
    -- ANSI
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

    -- ORACLE
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE(+) = DEPT_ID(+);
    -- ERROR : one outer-joined table
    -- FULL [OUTER] JOIN 은 오라클로는 불가능하다.

    ```

+ ## CROSS JOIN
    + 카테시안 곱(Cartesian Product) 라고도 하며
    + 조인되는 테이블의 각 행들이 모두 매핑된 데이터가 검색되는 조인 방법
    + 검색되는 데이터 수는 '행의 컬럼 수 * 또 다른 행의 컬럼 수'로 나옴

    ```sql

    SELECT EMP_NAME FROM EMPLOYEE; -- 23개 행

    1.선동일
    2.송종기
    ~ (중략) ~
    22.유하진
    23.이태림

    SELECT DEPT_TITLE FROM DEPARTMENT; -- 9개 행

    1. 인사관리부
    2. 회계관리부
    ~ (중략) ~
    8.기술지원부
    9.총무부

    -- CROSS 조인 : 23 * 9 = 207 개의 행으로 나온다.
    SELECT EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        CROSS JOIN DEPARTMENT;

    1.선동일	인사관리부
    2.송종기	인사관리부
    3.노옹철	인사관리부
    ~ (중략) ~
    205.이중석	총무부
    206.유하진	총무부
    207.이태림	총무부
    ```

+ ## 비등가 조인(NON EQUAL JOIN)
    + '='(등호)를 사용하지 않는 조인문
    + 지정한 컬럼 값이 일치하는 경우가 아닌 값의 범위에 포함되는 행들을 연결하는 방식

+ ## SELF JOIN
    + 두개 이상의 서로 다른 테이블을 연결하는 것이 아닌 **같은 테이블을 조인하는것**  

+ ## 다중 JOIN 
    + N 개의 테이블을 조회할 때 사용 ( N >= 1)
    + 수행결과는 하나의 Result Set으로 나옴
