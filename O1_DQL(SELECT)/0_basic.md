# SELECT_BASIC
  + Result Set
  + SELECT문 작성법
     + SELECT문 예시
     + 컬럼 별칭 사용법
     + 리터럴
  + DISTINCT 
--------------------------------------

## Result Set

- 데이터 조회한 결과를 Result Set이라고 하는데
- SELECT 구문에 의해 반환된 행들의 집합을 의미
- Result Set은 0개 이상의 행이 포함될 수 있고 특정 기준에 의해 정렬 가능
- 한 테이블의 특정 컬럼, 행 , 행/컬럼 또는 여러 테이블의 특정 행/컬럼 조회 가능

※ JDBC - Result Set 가지고 사용하는것이 있다. 기억!


-----------------

## SELECT문 작성법

+ (필수적으로 있어야 하는 구문 -> SELECT, FROM)

    + SELECT 컬럼 명 [, 컬럼명, ...]

    + FROM 테이블 명

    + WHERE 조건식;

```sql
SELECT * FROM EMPLOYEE; -- * ASTRO 전체를 의미

select * from employee;
select * from employee where job_code = 'j1';
select * from employee where job_code = 'J1';

-- 자바에서는 대소문자를 가리지만,
-- DB에서는 명령어는 대소문자를 안가리지만, 
-- 안에 들어가는 데이터 자체는 대소문자를 가린다.
-- DB에서는 무조건 싱글 코테이션 ' '
```

+ SELECT
    + 조회하고자 하는 컬럼명 기술
    + 여러 컬럼을 조회하는 경우 컬럼은 쉼표로 구분하고, 마지막 컬럼 다음은 쉼표를 사용하지 않음
    + 모든 컬럼 조회 시 컬럼 명 대신 '*' 기호 사용 가능하며 조회 결과는 기술한 컬럼 명 순으로 표시 됨
+ FROM
    + 조회 대상 컬럼이 포함된 테이블 명 기술
+ WHRERE
    + 행을 선택하는 조건 기술
    + 여러 개의 제한 조건을 포함 할 수 있으며,

------------------------------------------------

### ○ SELECT 기본 예시

+ 직원 전부의 사번과 이름, 월급을 조회하는 구문

    ```sql
    SELECT EMP_ID,EMP_NAME,SALARY 
    FROM EMPLOYEE;
    ```
+ 직원 전부의 모든 정보를 조회하는 구문. 
    ```sql
    SELECT * 
    FROM EMPLOYEE;
    // * 아스트로
    ```

+ **컬럼 값에 대해 산술 연산한 결과 조회 가능**
    ```sql
    SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY * BONUS)) * 12
    FROM EMPLOYEE;
    ```

### ○ 컬럼 별칭 사용법

+ 컬럼 명 AS 별칭
+ 컬럼 명 "별칭"
+ 컬럼 명 AS "별칭" 
+ 컬럼 명 별칭
+ **별칭에 띄어쓰기, 특수문자, 숫자가 포함될 경우 무조건 "" 으로 묶어야 한다.**

ex) EMPLOYEE 테이블에서 직원의 직원명(별칭 : 이름), 연봉(별칭 : 연봉(원)), 보너스를 추가한 연봉(별칭 : 총소득(원)) 조합

```sql
SELECT EMP_NAME 이름, SALARY * 12 "연봉(원)" , SALARY * (1+BONUS) * 12 AS "총소득(원)"
FROM EMPLOYEE;
```

### ○ 리터럴

+ 임의로 정한 문자열을 SELECT 절에 사용하면 테이블에 존재하는 데이터처럼 사용 가능
-- 문자나 날짜 리터널은 ' ' 기호 사용되며 모든 행에 반복 표시 됨

ex) EMPLOYEE 테이블에서 직원의 직원 번호, 사원 명, 급여, 단위(데이터 값 : 원) 조회

```sql
SELECT EMP_ID "직원 번호", EMP_NAME "사원 명", SALARY "급여", '원' AS 단위
FROM EMPLOYEE;
```

##  DISTINCT 
 + 컬럼에 포함된 중복 값을 한번씩만 표기하고자 할 때 사용
 + **SELECT 절에 딱 한번만 쓸 수가 있음**

```SQL
-- EMPLOYEE 테이블에서 직원의 직급 코드 조회
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 직급코드를 중복제거 하여 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드와 직급코드를 중복제거 하여 조회
--SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
--FROM EMPLOYEE;
--에러가 난다.

SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
```
