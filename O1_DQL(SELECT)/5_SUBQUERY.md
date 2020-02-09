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

```sql
-- 1) 전 직원의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) 급여가 3047662.60869565217391304347826086956522
--  원보다 많이 받고있는 직원의 사번,이름,급여코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;

-- 1) + 2) : 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
```




### **1. 단일 행 서브쿼리** 
 + 서브쿼리의 조회 결과 값의 개수가 1개일 떄
+ 일반적으로 단일 행 서브쿼리 앞에는 일반 연산자 사용
+ <, >, <=, >=, =, !=, <>, ^=
    

### **2. 다중 행 서브쿼리**
+ 서브쿼리의 조회 결과 값의 개수가 여러 개일때
+ **다중행 서브쿼리 앞에는 일반 비교 연산자 사용 불가**
+  IN / NOT IN 
+  ANY, < ANY : 
+  ALL, < ALL 
+ EXISTS/ NOT EXISTS : 값이 존재하는지/ 존재하지 않는지


### **3. 다중 열 서브쿼리** 
+ 서브쿼리 SELECT 절에 나열된 항목 수가 여러 개일때

### **4. 다중 행 다중 열 서브쿼리**
+ 조회 결과 행 수와 열 수가 여러개 일때

----------------------------

## 인라인 뷰(INLINE-VIEW)
+ FROM 절에 서브쿼리를 사용한것

### WITH

  + 서브 쿼리에 이름을 붙여주고 인라인 뷰로 사용 시 서브쿼리의 이름으로 FROM 절에 기술 가능.
  + 같은 서브쿼리가 여러번 사용될 경우 중복 작성 줄임, 실행속도도 빨라짐

  +  RANK() OVER / DENSE_RANK() OVER
  +  RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수 만큼 건너 뛰고 순위
  + DENSE RANK() OVER : 중복되는 순위 이후의 등수를 바로 다음 등수로 처리
