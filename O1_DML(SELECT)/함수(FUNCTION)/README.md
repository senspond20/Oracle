# 함수 (FUNCTION)

▶ 오라클에서 함수는 자바에서 메소드와 같은 애기다.
+ FUNCTION(매개변수)   : 리턴값

▶  함수(FUNCTION) : 
+ 칼럼의 값을 읽어서 계산한 결과 리턴

▶  함수를 사용 할 수 있는 위치
+  SELECT 절, WHERE절, GROUP BY절, HAVING 절, ORDER BY 절

▶  [단일 행 함수 (SINGLE ROW FUNCTION)](url)
+  N개의 값을 넣어서 N개의 결과 리턴

▶  [그룹 함수(GROUP FUNCTION)](url)
+   S개의 값을 넣어서 한개의 결과 리턴

-- )) SELECT 절에 단일 행 함수랑 그룹 함수를 같이 써도 되는가?
-- > 안된다. 왜?
-- > 결과를 가져올떄 행의 수가 똑같아야하는데
--> 컬럼이 23개라면 단일 행 함수 23 -> 23. 그룹 함수 23 -> 1

-- SELECT 절에 단일 행 함수와 그룹 함수를 함께 사용 못한다.
+ 결과 행의 개수가 다르기 때문

-- LENGTH 단일 행 함수
```sql
SELECT LENGTH (EMP_NAME)
FROM EMPLOYEE;
```
-- COUNT 그룹 함수
```sql
SELECT COUNT (EMP_NAME)
FROM EMPLOYEE;
```

-- 잘못된 예 
```sql
SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--"not a single-group group function" 에러
FROM EMPLOYEE;
```

# 단일행 함수

## 1. 문자 관련 함수

![func1](https://user-images.githubusercontent.com/60596128/73858625-0b3e5380-487c-11ea-9601-e8c16e9cf422.png)

## 2. 숫자 관련 함수

![func2](https://user-images.githubusercontent.com/60596128/73858671-1e512380-487c-11ea-80bd-6d0a18beda4d.png)

### 3. 날짜 관련 함수
![func3](https://user-images.githubusercontent.com/60596128/73858700-2c9f3f80-487c-11ea-9e1e-1d51c6711470.png)

### 4. 형 변환 함수
-- TO_CHAR(날짜[, 포맷]) :  날짜형 데이터 -> 문자형 데이터
-- TO_CHAR(숫자[, 포맷]) :  숫자형 데이터 -> 문자형 데이터

### 5. NULL 처리 함수
-- NVL (컬럼명, 컬럼 값이 NULL일 때 바꿀 값)

SELECT EMP_NAME,NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME , NVL(DEPT_CODE,'없습니다')
FROM EMPLOYEE;

-- NVL2 ( 컬럼 명, 바꿀 값1, 바꿀 값 2)
-- 컬럼 명 값이 NULL이 아니면 바꿀 값 1로, NULL이면 바꿀 값 2로 해주겠다.
-- EMPLOYEE 테이블에서 보너스가 NULL인 직원은 0.5로 NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(BONUS, '안받음', '받음')
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2) : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
SELECT NULLIF(123,123)FROM DUAL;

SELECT NULLIF(123,124) FROM DUAL;

SELECT TO_CHAR(TO_DATE('2020/06/30'), 'Q') FROM DUAL;
SELECT TO_CHAR(HIRE_DATE,'YYYY-MM-DD') FROM EMPLOYEE;

### 6. 선택함수 

-- 여러 가지 경우 선택 할 수 있는 기능 제공
-- DECODE (계산식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2....)
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8,1),1,'남',2,'여') 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8,1),1,'남','여') 성별
FROM EMPLOYEE;

-- 마지막 인자로 조건 값 없이 선택 값을 작성하면
-- 아무 것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함

-- CASE WHEN 조건식 THEN 결과 값
--      WHEN 조건식 THEN 결과 값
--      ELSE 결과 값
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(조건은 범위 가능)

SELECT EMP_ID, EMP_NAME, EMP_NO,
CASE WHEN SUBSTR(EMP_NO,8,1) IN(1,3) THEN '남'
     ELSE '여'
     END 성별
FROM EMPLOYEE;

-- 급여가 500만 초과 1등급, 350만 초과 2등급, 200만 초과 3등급, 나머지 4등급 처리

SELECT EMP_ID, EMP_NAME, SALARY,
(CASE WHEN SALARY > 5000000 THEN '1등급'
     WHEN SALARY <= 5000000 AND SALARY > 3500000 THEN '2등급'
     WHEN SALARY <= 3500000 AND SALARY > 2000000 THEN '3등급'
     ELSE '4등급'
     END) AS 등급
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY,
(CASE WHEN SALARY > 5000000 THEN '1등급'
     WHEN SALARY > 3500000 THEN '2등급'
     WHEN SALARY > 2000000 THEN '3등급'
     ELSE '4등급'
     END) AS 등급
FROM EMPLOYEE;

-- 우선순위가 위부터 아래로
SELECT EMP_ID, EMP_NAME, SALARY,
(CASE WHEN SALARY > 3500000 THEN '2등급'
      WHEN SALARY > 5000000 THEN '1등급'
      WHEN SALARY > 2000000 THEN '3등급'
     ELSE '4등급'
     END) AS 등급
FROM EMPLOYEE;

# 그룹 함수 
-- 여러 행을 넣으면 한개의 결과 반환
-- SUM (숫자가 기록된 컬럼) : 합계

-- EMPLOYEE 테이블에서 전 사원의 급여 총합 조회
SELECT SUM(SALARY) AS 급여총합
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY) AS "급여총합(남)"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- AVG(숫자가 기록된 컬럼) : 평균 리턴
-- EMPLOYEE 테이블에서 전 사원의 급여 평균 조회
SELECT AVG(SALARY)FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 BONUS 합계 조회
SELECT SUM(BONUS) FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 BONUS 평균 조회
SELECT AVG(BONUS) , AVG(NVL(BONUS,0)) FROM EMPLOYEE;

-- AVG(NVL(BONUS,0)) -- NULL값을 가진 행은 평균 계산에서 제외 되어 계산
-- RESULT 0.2166666666666666666666666666666666666667 / 0.0847826086956521739130434782608695652174

-- MIN / MAX : 최소/최대
-- EMPLOYEE 테이블에서 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일 
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

[맨 위로](# 함수-FUNCTION)
