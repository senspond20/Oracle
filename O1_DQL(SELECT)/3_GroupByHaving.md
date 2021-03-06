### [◀목차로 돌아가기](https://github.com/senspond20/Oracle#목차)

+ [O1_DML/DQL(SELECT)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)#dqlselect)
  + [연산자](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/1_연산자.md#연산자)
  + [함수(FUNCTION)](https://github.com/senspond20/Oracle/tree/master/O1_DQL(SELECT)/%ED%95%A8%EC%88%98(FUNCTION)#%ED%95%A8%EC%88%98-function))
  + [JOIN](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/4_Join.md#join)
  + [SUBQUERY](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/5_SUBQUERY.md#subquery서브-쿼리)

--------------------------------------------------
# GroupByHaving

+ [ORDER BY](#ORDER-BY)
+ [GROUP BY](#GROUP-BY)
    + [HAVING](#HAVING)

+ [집계함수(ROOLUP/CUBE)](#집계함수rollup-cube)
+ [GROUPING 함수](#GROUPING-함수)
+ [집합연산자](#집합-연산자)
+ [GROUPING SETS](#GROUPING-SETS)

### SELECT 문 실행순서 
+ 
    |순서| SELECT 문 |--|
    |-----|--------------------| --|
    | 5 | SELECT |5.조회를 하고|
    | 1 | FROM   |1.제일 먼저 판을 깔아놓는다.|
    | 2 | WHERE |2.어디서? (조건문을 만족하는 곳에서) |
    | 3 | GROUP BY |3.그룹 함수에 의해|
    | 4 | HAVING |4.( 그룹 함수에 대한 조건을 가지고)|
    | 6 | ORDER BY |6.정렬하고 끝낸다.|


## ORDER BY 
+ SELECT한 컬럼에 대해 정렬을 할 때 작성하는 구문
+ SELECT 구문의 가장 마지막에 작성하며 실행 순서 역시 가장 마지막에 수행됨
+ ORDER BY : SELCT한 컬럼을 가지고 정렬할 때 사용

<표현식>
+ ORDER BY 컬럼명 | 컬럼 별칭 | 컬럼나열순번 [ASC] | DESC

+ 예시)
```sql

SELECT EMP_ID, EMP_NAME, SALARY 급여, DEPT_CODE
FROM EMPLOYEE;

1. ORDER BY EMP_NAME; -- 이름을 오름차순

2. ORDER BY EMP_NAME ASC; -- 이름을 오름차순

3. ORDER BY EMP_NAME DESC; -- 이름을 내림차순

4. ORDER BY DEPT_CODE NULLS FIRST; -- DEPT_CODE 를 NULL을 제일 먼저두고 정렬해라

5. ORDER BY 2; -- 컬럼에 대한 순번으로 
(왠만하면 쓰지 않는것이 좋다. => 조회하고자 하는 SELECT행 숫자가 달라지면 결과값이 달라지기때문)

6. ORDER BY 급여; -- 급여(별칭)에 대해서 오름차순으로

7. ORDER BY 급여 DESC; --급여(별칭)에 대해서 내림차순으로
```

## GROUP BY
[◀back](#GroupByHaving)

+ 그룹 함수는 단 한개의 결과 값만 산출하기 때문에 그룹이 여러개일 경우 오류 발생
+ 여러개의 결과 값을 산출하기 위해 그룹 함수가 적용될 그룹의 기준을 GROUP BY절에 기술하여 사용

```SQL
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE; 
-- 에러 발생

SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE;
```

```sql
-- GROUPBY_HAVING


-- GROUB BY : 여러 개의 값을 묶어서 하나로 처리할 목적으로 사용
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE; -- 결과 값의 개수가 다름

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서 코드 별 그룹을 지정하여 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의 평균,
-- 인원수를 조회하고 부서 코드 순으로 정렬

-- (COUNT 는 NULL을 제외하고 계산한다.)

SELECT DEPT_CODE, SUM(SALARY) 합계 , TRUNC(AVG(SALARY)) 평균 , COUNT(*) 인원수 --, COUNT(DEPT_CODE)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- EMPLOYEE 테이블에서 직급코드, 보너스를 받는 사원수를 조회하여 직급코드 순으로 오름차순 정렬
SELECT JOB_CODE, COUNT(BONUS) "보너스 수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- COUNT(BOUNUS)가 0인 직급은 보고 싶지 않을때
--WHERE COUNT(BONUS) != 0 -- 에러 : "group function is not allowed here"
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서 성별과 성별 별 급여 평균, 급여 합계, 인원 수 조회하고 인원 수로 내림차순 정렬
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남','여') 성별,
    FLOOR(AVG(SALARY)) "급여 평균", 
        SUM(SALARY) "급여 합계", 
        COUNT(*) AS 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'남','여')
ORDER BY 인원수 DESC;

SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남','여') 성별
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE; -- 여러컬럼을 함께 묶을 수 있음
```
[◀back](#GroupByHaving)

+ ## HAVING
    + 그룹함수로 구해 올 그룹에 대해 조건을 설정할 때 사용
    + SELECT -> WHERE , GROUP BY -> HAVING

    ```sql
    -- 부서코드와 급여 300만원 이상인 직원의 그룹별 평균(반올림) 급여 조회
    SELECT DEPT_CODE, ROUND(AVG(SALARY))
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
    GROUP BY DEPT_CODE;

    -- 부서코드와 급여 평균이 300만원 이상인 그룹 조회
    SELECT DEPT_CODE, ROUND(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    HAVING ROUND(AVG(SALARY)) >=3000000;

    -- 부서 별 그룹의 급여 합계 중 9백만원을 초과하는 부서 코드와 급여 합계(부서 코드 순으로 정렬)
    SELECT DEPT_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    HAVING SUM(SALARY) >= 9000000
    ORDER BY DEPT_CODE ASC;
    ```
[◀back](#GroupByHaving)
+ ## 집계함수(ROLLUP, CUBE) 
    + 그룹 별 산출한 결과 값의 집계 계산

    ```sql
    SELECT JOB_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY JOB_CODE
    ORDER BY JOB_CODE;
    --J1	8000000
    --J2	9700000
    --J3	10800000
    --J4	9320000
    --J5	8460000
    --J6	15746240
    --J7	8070000

    SELECT JOB_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY ROLLUP(JOB_CODE)
    ORDER BY JOB_CODE;
    --J1	8000000
    --J2	9700000
    --J3	10800000
    --J4	9320000
    --J5	8460000
    --J6	15746240
    --J7	8070000
    --	    70096240
    --아래 총합이 생겼다.

    SELECT JOB_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY CUBE(JOB_CODE)
    ORDER BY JOB_CODE;
    --J1	8000000
    --J2	9700000
    --J3	10800000
    --J4	9320000
    --J5	8460000
    --J6	15746240
    --J7	8070000
    --	    70096240
    SELECT DEPT_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY ROLLUP(DEPT_CODE)
    ORDER BY DEPT_CODE;
    --D1	7820000
    --D2	6520000
    --D5	15760000
    --D6	10100000
    --D8	6986240
    --D9	17700000
    --	    5210000
    --	   70096240
    ```

 + **ROLLUP 함수**: 그룹 별로 중간 집계 처리
    + 인자로 전달 받은 것 중에서 가장 먼저 지정한 인자에 대해 그룹별 중간집계
    ```sql
    SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
    ORDER BY DEPT_CODE;
    ```
+ **CUBE 함수** : 그룹 별로 중간 집계 처리
    + 인자로 전달 받은것 모두
    ```sql
    SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
    FROM EMPLOYEE
    GROUP BY CUBE(DEPT_CODE, JOB_CODE)
    ORDER BY DEPT_CODE;
    ```
[◀back](#GroupByHaving)   
+ ## GROUPING 함수
    + ROLLUP 이나 CUBE에 의한 산출물이 인자로 전달받은 컬럼의 산출물이면 0 반환, 아니면 1반환
    ```sql
    SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
        GROUPING(DEPT_CODE) 부서별그룹묶인상태,
        GROUPING(JOB_CODE) 직급별그룹묶인상태
    FROM EMPLOYEE
    GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
    ORDER BY DEPT_CODE;
    ```

[◀back](#GroupByHaving)
+ ## **집합 연산자**

    + 여러개의 SELECT 결과물을 하나의 쿼리로 만드는 연산자

        + UNION (합집합) 

        + UNION ALL(공통된 부분이 두번들어간 합집합)

        + INTERSECT(교집합) 

        + MINUS(차집합)


    + **UNION** : 합집합, OR

    ```sql
    SELECT EMP_ID, EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 200
    UNION
    SELECT EMP_ID, EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 201;

    --DEPT_CODE D4코드가 D5이거나 급여가 300만원을 초과하는 직원의 사번, 이름, 부서코드, 급여 조회
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
    UNION
    SELECT EMP_ID , EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHER SALARY > 3000000

    SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;
    ```

    + **UNION ALL** : OR + AND(합집합 + 교집합), 합집합 + 교집한 -> 중복된 부분이 두번 포함
    

    ```sql
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
    UNION
    SELECT EMP_ID , EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE SALARY > 3000000;
    ```

    + **INTERSECT** : 교집합, AND


    ```sql
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
    INTERSCT
    SELECT EMP_ID , EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE SALARY > 3000000;

    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;
    ```

    + **MINUS** : 차집합


    ```sql
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
    MINUS
    SELECT EMP_ID , EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE SALARY > 3000000;

    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;
    ```
[◀back](#GroupByHaving)

+ ## GROUPING SETS
    + 그룹별로 처리된 여러 개의 SELECT 문을 하나로 합칠 때 사용

    ```sql
    SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;


    SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE, MANAGER_ID;

    SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY JOB_CODE, MANAGER_ID;

    SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY GROUPING SETS(
            (DEPT_CODE, JOB_CODE, MANAGER_ID),
            (DEPT_CODE, MANAGER_ID),
            (JOB_CODE, MANAGER_ID))
    ORDER BY DEPT_CODE;
    ```

[▶ 맨위로](https://github.com/senspond20/Oracle/blob/master/O1_DQL(SELECT)/3_GroupByHaving.md#groupbyhaving)
