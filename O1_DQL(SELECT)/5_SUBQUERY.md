### [◀목차로 돌아가기](https://github.com/senspond20/Oracle#목차)

+ [O1_DML/DQL(SELECT)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)#dclselect)
  + [연산자](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/1_연산자.md#연산자)
  + [함수(FUNCTION)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)/%ED%95%A8%EC%88%98(FUNCTION)#%ED%95%A8%EC%88%98-function))
  + [GROUP BY_HAVING](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/3_GroupByHaving.md#groupbyhaving)
  + [JOIN](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/4_Join.md#join)
  + [SUBQUERY](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/5_SUBQUERY.md#subquery서브-쿼리)

-------------------------
# SUBQUERY(서브 쿼리)

+ 하나의 SQL 문 안에 포함된 또 다른 SQL문
+ 메인쿼리(기존쿼리) 를 위해 보조 역할을 하는 쿼리문
+ **※ 서브쿼리는 SELECT, WHERE, FROM, HAVING 절에도 사용할 수 있다**

+ ### **서브쿼리 유형**
    + **※ <U>서브쿼리의 유형에 따라 서브쿼리 앞에 붙는 연산자가 달라짐</U>**

        + **1. 단일 행 서브쿼리** : 서브쿼리의 조회 결과 값의 개수가 1개일 떄
        + **2. 다중 행 서브쿼리** : 서브쿼리의 조회 결과 값의 개수가 여러 개일 때
        + **3. 다중 열 서브쿼리** : 서브쿼리 SELECT 절에 나열된 항목 수가 여러 개일 때
        + **4. 다중 행 다중 열 서브쿼리** : 조회 결과 행 수와 열 수가 여러 개일때
  
   
**< 서브쿼리 맛보기 >**

-- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
  ```sql
  -- 1) 노옹철 사원의 부서코드 조회
  SELECT DEPT_CODE
  FROM EMPLOYEE
  WHERE DEMP_NAME = '노옹철';

  -- 2) 서브쿼리 적용
  SELECT EMP_NAME
  FROM EMPLOYEE
  WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');
  ```

-- 전 직원의 평균급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회


### **1. 단일 행 서브쿼리** 
 + 서브쿼리의 조회 결과 값의 개수가 1개일 떄
+ 일반적으로 단일 행 서브쿼리 앞에는 **일반 연산자 사용**
+ <, >, <=, >=, =, !=, <>, ^=

  ```sql
  -- 1) 전 직원의 평균 급여
  SELECT AVG(SALARY)  FROM EMPLOYEE;

  -- 2) 서브쿼리 적용 
  --  전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
  SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
  ```

### **2. 다중 행 서브쿼리**
+ 서브쿼리의 조회 결과 값의 개수가 여러 개일때
+ **다중행 서브쿼리 앞에는 일반 비교 연산자 사용 불가**
+ **IN / NOT IN**  :  
  + 여러 개의 결과 값 중에서 한개라도 일치하는 값이 있으면/ 없다면 
+ **ANY, < ANY** : 
  + 여러 개의 결과 값 중에서 한개라도 큰 / 작은 값이 작은지
  + 가장 작은 값보다 큰지 / 가장 큰 값보다 작은지 
+ **ALL, < ALL** : 
  + 모든 값 보다 큰/ 작은 값이 있다면
  + 가장 큰 값보다 큰지/ 가장 작은 값 보다 작은지
+ **EXISTS/ NOT EXISTS** : 
  + 값이 존재하는지/ 존재하지 않는지 ==> TRUE /   FALSE 로 반환

  ```SQL
  --차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원 조회
  -- 사번, 이름, 직급, 급여 조회

  -- 1) 과장 직급의 사번, 이름, 직급, 급여
  SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE
      JOIN JOB USING(JOB_CODE)
  WHERE JOB_NAME = '과장';
  
  207	하이유	과장	2200000
  208	김해술	과장	2500000
  215	대북혼	과장	3760000

  -- 2) 차장 직급의 급여   
  SELECT SALARY
  FROM EMPLOYEE
      JOIN JOB USING(JOB_CODE)
  WHERE JOB_NAME = '차장';   
  
  2800000
  1550000
  2490000
  2480000

  --3) 1+2) 다중행 서브쿼리 ALL 연산자 사용
  -- 차장중 가장 높은 급여(2800000) 보다 많이 받는 과장 -> 대북혼
  SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
  FROM EMPLOYEE
      JOIN JOB USING(JOB_CODE)
  WHERE JOB_NAME = '과장' 
      AND SALARY > ALL(SELECT SALARY
                      FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                      WHERE JOB_NAME = '차장');

  215	대북혼	과장	3760000

  ```

### **3. 다중 열 서브쿼리** 
+ 서브쿼리 SELECT 절에 나열된 항목 수가 여러 개일떄

  ```HTML
  < 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급 코드, 부서코드, 입사일 조회 >
  ```

  ```SQL
  -- 1) 퇴사한 여직원
  SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
  FROM EMPLOYEE
  WHERE ENT_YN = 'Y'
      AND SUBSTR(EMP_NO,8,1) = 2;

  -- 2) 퇴사한 여직원과 같은 부서, 같은 직급 (다중열이 아닌 방식)
  SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
  FROM EMPLOYEE
  WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y') -- 같은 부서
      AND JOB_CODE = (SELECT JOB_CODE
                      FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8,1) = 2 AND ENT_YN = 'Y')
      AND EMP_NAME != (SELECT EMP_NAME
                      FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8,1) = 2 AND ENT_YN = 'Y');

  -- 3) 다중열을 적용하여 해보기
  SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
  FROM   EMPLOYEE
  WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                  FROM   EMPLOYEE
                                  WHERE  SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
                                  
                  AND EMP_NAME != (SELECT EMP_NAME
                FROM EMPLOYEE
                WHERE SUBSTR(EMP_NO, 8,1) = 2 AND ENT_YN = 'Y');
  ```
### **4. 다중 행 다중 열 서브쿼리**
+ 조회 결과 행 수와 열 수가 여러개 일때

----------------------------

## 인라인 뷰(INLINE-VIEW)
+ FROM 절에 서브쿼리를 사용한것
+ 서브쿼리가 만든 결과(RESULT SET)를 테이블 대신 사용

  **<전 직원 중 급여가 높은 상위 5명 순위, 이름, 급여 조회 >**
  

  ```sql
  SELECT EMP_NAME, SALARY
  FROM EMPLOYEE
  ORDER BY SALARY DESC; -- 급여 내림차순 정렬.

  ( 급여 높은 사람 5명 : 선동일, 송종기, 정중하 , 대북혼, 노옹철)
  ```

  + 틀린 해법

    ```sql
    SELECT ROWNUM, EMP_NAME, SALARY
    FROM EMPLOYEE
    WHERE ROWNUM <=5
    ORDER BY SALARY DESC;
    ```

      + ROWNUM은 FROM절을 수행하면서 부여지기 때문에 top-N 분석 시 SELECT 절에 사용한 ROWNUM이 의미 없게 된다.

      + RESULT :

        |ROWNUM | EMP_NAME | SALARY
        |-------|----------|--------
        |1	|선동일|	8000000
        |2	|송종기	|6000000
        |3	|노옹철	|3700000
        |5	|유재식|	3400000
        |4	|송은희|	2800000
 
  + 맞는 해법 <인라인 뷰 적용 >
      ```SQL
      SELECT ROWNUM, EMP_NAME, SALARY
      FROM (SELECT * FROM EMPLOYEE ORDER BY SALARY DESC)
      WHERE ROWNUM <= 5;
      ```
  
    + FROM 절에 이미 정렬된 서브쿼리(인라인 뷰) 적용 시 ROWNUM이 top-N 분석에 사용가능

    + RESULT : 

      |ROWNUM | EMP_NAME | SALARY
      |-------|----------|--------
      |1	|선동일|	8000000
      |2	|송종기	|6000000
      |3	|정중하	|3900000
      |4	|대북혼|3760000
      |5	|노옹철|	3700000


## WITH

  + 서브 쿼리에 이름을 붙여주고 인라인 뷰로 사용 시 서브쿼리의 이름으로 FROM 절에 기술 가능.
  + 같은 서브쿼리가 여러번 사용될 경우 중복 작성 줄임, 실행속도도 빨라짐

    + WITH 미적용 SQL문 
      ```SQL
      SELECT ROWNUM, EMP_NAME,SALARY
      FROM (SELECT EMP_ID, EMP_NAME, SALARY
          FROM EMPLOYEE
          ORDER BY SALARY DESC);
      ````
    + **WITH 적용 예시** (서브쿼리를 TOPN_SAL 로 이름 지정하고 FROM문에서 사용)
      ```SQL
      WITH TOPN_SAL AS(SELECT EMP_NAME, SALARY
                      FROM EMPLOYEE
                      ORDER BY SALARY DESC)
      SELECT ROWNUM, EMP_NAME, SALARY
      FROM TOPN_SAL;
      ```



## RANK() OVER / DENSE_RANK() OVER

  + ### RANK() OVER 
    + 동일한 순위 이후의 등수를 동일한 인원 수 만큼 건너 뛰고 순위

      ```SQL
      SELECT RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
      FROM EMPLOYEE;
      ```

  + ### DENSE RANK() OVER 
    +  중복되는 순위 이후의 등수를 바로 다음 등수로 처리

        ```SQL
        SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
        FROM EMPLOYEE;           
        ```