-- 2020/02/04

-- 리터럴 : 임의로 정한 문자열을 SELECT 절에 사용하면 테이블에 존재하는 데이터처럼 사용 가능
-- 문자나 날짜 리터널은 ' ' 기호 사용되며 모든 행에 반복 표시 됨

-- EMPLOYEE 테이블에서 직원의 직원 번호, 사원 명, 급여, 단위(데이터 값 : 원) 조회

SELECT EMP_ID "직원 번호", EMP_NAME "사원 명", SALARY "급여", '원' AS 단위
FROM EMPLOYEE;

--< DISTINCT : 컬럼에 포함된 중복 값을 한번씩만 표기하고자 할 때 사용 , SELECT 절에 딱 한번만 쓸 수가 있음>

-- EMPLOYEE 테이블에서 직원의 직급 코드 조회
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 직급코드를 중복제거 하여 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드와 직급코드를 중복제거 하여 조회
--SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
--FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- WHERE 절 : SELECT 에 걸리는 조건문이 들어가는 절
-- 조회할 테이블에서 조건이 맞는 값을 가진 행을 골라냄
-- 비교 연산자
-- = 같냐, > 크냐, < 작냐, >= 크거냐 같냐, <= 작거냐 같냐
-- != , ^= , <> 안 같냐

-- EMPLOYEE 테이블에서 부서코드가 'D9' 인 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 급여가 4000000 이상인 직원의 이름, 급여 조회는
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 부서코드가 D9이 아닌 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE 테이블에서 퇴사 여부가 N인 직원을 조회하고
-- 근무 여부를 재직중으로 표시하여 사번, 이름, 고용일, 근무 여부 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '재직중' AS 근무여부
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 미니 실습 문제
-- 1. EMPLOYEE 테이블에서 월급이 3000000 이상인 사원의 이름, 월급, 고용일 조회
-- 2. EMPLOYEE 테이블에서 SAL_LEVER 이 S1인 사원의 이름, 월급 , 고용일, 연락처 조회
-- 3. EMPLOYEE 테이블에서 실수령액(총 수령액 - (연봉*세금 3%))이 5천 만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

SELECT EMP_NAME 사원이름, SALARY 월급 , 
      (SALARY * (1+BONUS) * 12) - (SALARY * 0.03)*12 AS "실 수령액", 
       HIRE_DATE 고용일
FROM EMPLOYEE
WHERE ((SALARY * (1+BONUS) * 12) - (SALARY * 0.03)) >= 50000000;

-- PL/SQL : ORACLE
-- SQL
--DECLARE @총수령액 INT
--SET @총수령액 = ((SALARY * (1+BONUS) * 12) - (SALARY * 0.03));
--SELECT EMP_NAME 

-- 논리 연산자 : AND / OR
-- EMPLOYEE 테이블에서 부서코드가 'D6' 이고 급여를 2백만보다 많이 받는 직원의 이름, 부서코드, 급여 조회

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 2000000;

-- EMPLOYEE 테이블에서 부서코드가 'D6' 이거나 급여를 2백만보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 2000000;

-- EMPLOYEE 테이블에서 급여를 350만원 이상 600만원 이하를 받는 직원의 사번, 이름, 급여, 부서코드, 직급 코드 조회
SELECT EMP_ID 사번 , EMP_NAME 이름, SALARY 급여 , JOB_CODE "직급 코드"
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- 미니 실습 문제
-- EMPLOYEE 테이블에 월급이 4000000 이상이고 JOB_CODE 가 J2 인 사원의 전체 내용 조회
-- EMPLOYEE 테이블에 DEPT_CODE 가 D9이거나 D5인 사원 중 고용일이 02년 1월 1일 보다 빠른 사원의 이름, 부서코드, 고용일

SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ( DEPT_CODE = 'D9' OR DEPT_CODE = 'D5' ) AND HIRE_DATE < '02/01/01';
-- ( ) 소괄호가 없으면 의미가 달라진다
-- AND 와 OR 연산자가 같이 있으면 의미에 따라 잘 묶어줘야한다.

-- BETWEEN AND
--String str = "안녕하십니까";
--              0 1 2 3 4 5
--str.substring(2,5); // "하십니"
--자바에서는 끝에 있는것을 대부분 포함하지 않았지만

-- BETWEEN AND : 하한 값 이상 상한 값 이하
-- 컬렴명 BEETWEEN 하한 값 AND 상한 값
-- 하한 값 <= 컬럼 명 <= 상한 값
-- 급여를 3500000원 보다 많이 받고 6000000보다 적게 받는 사원의 이름, 급여 조회

-- 1) BETWEEN AND 미 적용
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- 2) BETWEEN ADN 적용
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ( SALARY BETWEEN 3500000 AND 6000000 );
--AND SALARY != 3500000 AND SALARY != 6000000;

-- 반대로 급여를 350만원 미만, 또는 600만원 초과하는 직원의 사번,이름,급여,부서코드,직급코드 조회)

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY NOT BETWEEN 3500000 AND 6000000;

-- 미니 실습 문제
-- EMPLOYEE 테이블에 고용일이 '90/01/01' ~ '01/01/01'인 사원의 전체 내용 조회
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE 
-- 비교하려는 값이 지정한 특정 패턴을 만족 시키는지 조회
-- %  : 0 글자 이상
-- %  : 1 글자
-- '글자%' : 글자로 시작하는 값 (글자, 글자박, 글자바 ....)
-- '%글자%' : 글자를 포함된 값
-- '%글자' : 글자로 끝나는 값
-- '_' : 한 글자
-- '__' : 두 글자
-- '박__' : 박으로 시작하는 세 글자 (박근우,박신우,박지성......)

-- EMPLOYEE 테이블에서 성이 전씨인 사원의 사번, 이름, 고용일 조회

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 이름에 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME 이름, EMP_NO 주민번호, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE EMP_NAME LIKE '하%';

-- EMPLOYEE 테이블에서 이름에 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME 이름, EMP_NO 주민번호, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 이메일 중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일 주소 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMAIL 이메일
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';

-- 와일드 카드인 _가 검색하고자 하는 조간 안에 들어가는 문자와 같이 때문에
-- 문자 자체가 아닌 와일드 카드로 인식\

-- ESCAPE OPTION 
SELECT EMP_ID 사번, EMP_NAME 이름, EMAIL 이메일
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- #에 있는것은 문자라고 알려준다.
-- 구분할 수 있는 아무문자나 사용 가능하다.

-- NOT LIKE : 특정 패턴을 만족시키지 않는 값 조회
-- EMPLOYEE 테이블에서 김씨 성이 아닌 직원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE EMP_NAME NOT LIKE '김%';
WHERE NOT EMP_NAME LIKE '김%';

-- 미니 실습 문제
-- 1. EMPLOYEE 테이블에서 이름 끝이 '연' 으로 끝나는 사원의 이름 조회
SELECT EMP_NAME 이름 FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME 이름, PHONE 전화번호 FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4자 이면서 DEPT_CODE가 D9 또는 D6이고
--     고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
SELECT * FROM EMPLOYEE
WHERE (EMAIL LIKE '____A_%' ESCAPE 'A') AND ( DEPT_CODE = 'D9' OR DEPT_CODE = 'D6' )
      AND (HIRE_DATE BETWEEN '90/01/01' AND '00/12/01')
      AND (SALARY >= 2700000);
      
-- IS NULL / IS NOT NULL 
-- IS NULL : 컬럼 값이 NULL 인 경우
-- IS NOT NULL : 컬럼 값이 NULL이 아닌 경우

-- EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE 테이블에서 보너스를 받는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- EMPLOYEE 테이블에서 관리자도 없고 부서배치도 받지 않은 직원의 이름, 관리자, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE 테이블에서 부서배치를 받지 않았지만 보너스를 받는 직원의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN
-- 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산자
-- EMPLOYEE 테이블에서 부서코드가 D6이거나 D9 인 사원의 이름, 부서코드, 급여 조회

--SELECT EMP_NAME, DEPT_CODE, SALARY
--FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D9');

-- 직급 코드가 J1, J2, J3, J4 인 사람들의 이름, 직급 코드, 급여 조회
-- 1) IN 미사용
SELECT EMP_NAME 이름 , JOB_CODE 직급코드 , SALARY 급여
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';
      
-- 2) IN 사용
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J2','J3','J4');

-- 연결 연산자 || : 여러 컬럼을 연결하거나 컬럼과 리터럴 연결
-- EMPLOYEE 테이블에서 사번, 이름, 급여를 연결하여 조합

SELECT EMP_ID || EMP_NAME ||SALARY --사번이름급여
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 '사원 명의 월급은 급여원입니다.' 형식으로 조회
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.'
FROM EMPLOYEE;


