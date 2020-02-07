# 함수 (FUNCTION)

+ ## [단일 행 함수 (SINGLE ROW FUNCTION)](#단일행-함수single-row-function)
       +  < N개의 값을 넣어서 N개의 결과 리턴 >
       
  + [1.문자 관련 함수](#1-문자-관련-함수)
  
  + [2.숫자 관련 함수](#2-숫자-관련-함수)
  
  + [3.날짜 관련 함수](#3-날짜-관련-함수)
  
  + [4.형 변환 함수](#4-형-변환-함수)
  
  + [5.NULL 처리 함수](#5-NULL-처리-함수)
  
  + [6.선택 함수](#6-선택함수)
  
       
+ ## [그룹 함수(GROUP FUNCTION)](#그룹-함수-group-function)
       +  < S개의 값을 넣어서 한개의 결과 리턴 >
       
---------------------------------------------------------

+ 함수 : Input에 대한 Output이 1:1로 매칭되는 성질. -> 매개변수가 같으면 리턴값(결과)이 같아야한다.
+ 칼럼의 값을 읽어서 계산한 결과 리턴
+ 오라클에서 함수는 자바에서 메소드와 같은 애기다.

+ 함수 형태
+ FUNCTION(매개변수)   : 리턴값
+ FUNCTION(매개변수1,매개변수2)   : 리턴값
+ FUNCTION(매개변수,[FORMAT])   : 리턴값

  + 매개변수/리턴형
    + DATE : 날짜형 데이터 
    + NUMBER : 숫자형 데이터 
    + CHARACTER : 문자형 데이터
    + DATE : 날짜형 데이터
    
 + FORMAT : 출력 형식 (변환형 함수에 쓰임)
  
  형식 | 의미 | 형식 | 의미
 ------|-------|-----|------
  YYYYY|년도(4자리)|YY |년도(2자리)
  MM | 월을 숫자로|MON|월을 문자로
  FMMM |월(02->2)  | FMDD | 일(02->2)
  DD | 일을 숫자로|DY|요일을 약어로
  DAY| 요일       |Q| 분기
  |L | 로컬 화폐표시 |$|달러
  |FM | 공백제거   |,| 구분자
  '0000'| 0123 |'9999' | 123
         

   
  
--------------------------------------------

## < point >

▶  함수를 사용 할 수 있는 위치
+  SELECT 절, WHERE절, GROUP BY절, HAVING 절, ORDER BY 절

▶  SELECT 절에 단일 행 함수와 그룹 함수를 함께 사용 못한다.
+ 결과(result) 행의 개수가 다르기 때문

+ 예시)

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

# 단일행 함수(SINGLE ROW FUNCTION)
[ BACK](#함수-function)

## 1. 문자 관련 함수

![func1](https://user-images.githubusercontent.com/60596128/73858625-0b3e5380-487c-11ea-9601-e8c16e9cf422.png)

▶ LENGTH/ LENTHB
+ LENGTH(컬럼명 | '문자열' ) : 글자 수 반환
+ LENGTHB(컬럼명 | '문자열' ) : 글자의 바이트 사이즈 반환

```SQL
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블
```
-- 오라클에서 한글을 3바이트로 인식
--오라클 Character set 에 따라 한글 저장의 Byte 수가 다르다.
--EUC-KR : 한글 1자 : 2 Byte
--UTF-8 : 한글 1자 : 3 Byte


```SQL
SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
```

+ INSTR : 해당 문자열의 위치 ( ZERO 인덱스 기반이 아니라 1, 2,3,4 ..)
```SQL
SELECT INSTR('AABAACAABBABA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL; -- 찾는것이 없으면 0

SELECT INSTR('AABAACAABBAA','B',1) FROM DUAL; -- 1번쨰부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- -1번째(끝) 부터 (<-)로 읽기 시작해서 처음으로 나오는 B의 위치(->) 반환
SELECT INSTR('AABAACAABBAA','C',-1) FROM DUAL; -- -1번째(끝) 부터 (<-)로 읽기 시작해서 처음으로 나오는 B의 위치(->) 반환
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 1번쨰부터 읽기 시작해서 두 번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- 맨끝부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA','C',1,2) FROM DUAL; -- 첫번째부터 읽기 시작해서 두 번째로 나오는 C의 위치 반환
```

+ EMPLOYEE 테이블에서 이메일의 @ 위치 반환
```SQL
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;
```

+ LPAD / RPAD
```SQL
SELECT LPAD(EMAIL, 20) -- 총 20칸을 채워 (빈공간 왼쪽에다가 붙는다.)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20 , '#') -- 총 20칸 (빈공간을 왼쪽에다가 '#' 채워 넣겠다.)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20) -- 총 20칸을 채워 (빈공간 오른쪽에다가 붙는다.)
FROM EMPLOYEE;

SELECT RPAD(EMAIL,20, '#')
FROM EMPLOYEE;
```
+ LTRIM/RTRIM/TRIM : 주어진 컬럼이나 문자열의 왼쪽 또는 오른쪽 또는 앞/뒤/양쪽에서 지정한 문자를 제거한 나머지 반환
```SQL
SELECT LTRIM('  KH') FROM DUAL; -- 삭제할 문자열을 지정하지 않았을 경우 공백이 디폴트가 됨
SELECT LTRIM('  KH', ' ') FROM DUAL; 
SELECT LTRIM('000123456','0') FROM DUAL;
-- RESULT : 123456
SELECT LTRIM('123123KH', '123') FROM DUAL;
-- RESULT : KH
SELECT LTRIM('123123KH123','123') FROM DUAL;
-- RESULT : KH123

SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
-- RESULT : KH
-- 'ABC'를 통으로 보는것이 아니라 'A','B','C' 하나씩 쪼개서 삭제
-- 결과값이 ACABACCKH 가 아니라 KH가 된다.

SELECT LTRIM('56781KH', '0123456789') FROM DUAL;
-- RESULT : KH

SELECT RTRIM('KH    ') FROM DUAL;
-- RESULT : KH
SELECT RTRIM('123456000','0') FROM DUAL;
-- RESULT : 123456
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
-- RESULT : KH

SELECT TRIM('   KH   ') FROM DUAL;
-- 잘못된 문법예
SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL;
--missing right parenthesis 에러

-- 올바른 사용
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM('123' FROM '123132KH123321') FROM DUAL;
-- trim set should have only one character 에러 (한 글자만 제거 가능)

SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- 앞
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- 뒤
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL; -- 양쪽
```

## 2. 숫자 관련 함수

[ BACK](#함수-function)

![func2](https://user-images.githubusercontent.com/60596128/73858671-1e512380-487c-11ea-80bd-6d0a18beda4d.png)

+ ABS : 절대 값을 리턴해주는 함수
-- ABS(NUMBER) : NUMBER

```SQL
SELECT ABS(10.9) FROM DUAL; -- 10.9
SELECT ABS(-10.9) FROM DUAL; -- 10.9
SELECT ABS(10) FROM DUAL;  -- 10
SELECT ABS(-10) FROM DUAL; -- 10
```

+  MOD : 나머지값 리턴
-- MOD(NUMBER,DIVISION) : NUMBER

```SQL
SELECT MOD(10,3) FROM DUAL; -- 1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10,-3) FROM DUAL; -- 1
-- 부호는 앞에있는것만 따라간다.
SELECT MOD(10.9,3) FROM DUAL; -- 1.9
SELECT MOD(-10.9,3) FROM DUAL;-- -1.9
```

+ ROUND <반올림>
-- ROUND(NUMBER) : NUMBER / ROUND(NUMBER, POSITION) : NUMBER
       
  + 여기서는 ZERO INDEX 기반. (POSITON 0 : 소수점 1번째)

```SQL
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678, 0) FROM DUAL; --123
SELECT ROUND(123.456, 1) FROM DUAL; 
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL; -- 십의 자리에서 반올림 

SELECT ROUND(1234,4) FROM DUAL; -- -1234

SELECT ROUND(-10.61) FROM DUAL; -- -11
SELECT ROUND(-10,61) FROM DUAL; -- -10
```
+ FLOOR < 내림 > 
-- FLOOR(NUMBER) : NUMBER 
```SQL
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;
--SELECT FLOOR(123.434,2) FROM DUAL; -- 에러
```

+ TRUNC < 버림(절삭) >
-- TRUNC(NUMBER, POSITION) : NUMBER 

```SQL
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456,-1) FROM DUAL;
```
+ CELL < 올림 >
-- CEIL(NUMBER) : NUMBER

```SQL
SELECT CEIL(123) FROM DUAL;
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- SELECT CEIL(123.456,1) FROM DUAL;
--ORA-00909: invalid number of arguments
--00909. 00000 -  "invalid number of arguments"
```

### 3. 날짜 관련 함수

[ BACK](#함수-function)

![func3](https://user-images.githubusercontent.com/60596128/73858700-2c9f3f80-487c-11ea-9e1e-1d51c6711470.png)

+ SYSDATE : 오늘 날짜 반환

+ MONTHS_BETWEEN : 날짜와 날짜 사이의 개월 수 차이를 숫자로 리턴하는 함수(날짜 빼기 날짜)

```SQL
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월 수 조회

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE,HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(HIRE_DATE,SYSDATE)
FROM EMPLOYEE;
-- 음수로 나온다.  
```

+ ADD_MONTHS : 날짜에 숫자만큼의 개월 수를 더해 날짜 리턴
```SQL
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL; 
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;
```

+ NEXT_DAY : 기존 날짜에서 구하려는 요일에 가장 가까운 날짜를 리턴
```SQL
SELECT SYSDATE, NEXT_DAY(SYSDATE,'목요일') FROM DUAL;
--RESULT : 20/02/06	20/02/13
SELECT SYSDATE, NEXT_DAY(SYSDATE,'목') FROM DUAL;
--RESULT : 20/02/06	20/02/13
SELECT SYSDATE, NEXT_DAY(SYSDATE,'화진씨는 지금 무슨생각을 하고 있을까?') FROM DUAL;
--RESULT : 20/02/06	20/02/11
--SELECT SYSDATE, NEXT_DAY(SYSDATE,'연화씨는 자기 이름이 되는지 궁금하겠지?') FROM DUAL; 에러

-- 설정값을 한글로 되어있기에. 영어로 바꿔주면 된다.
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THUROSEMARY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,5) FROM DUAL;
-- 일 월 화 수 목 금 토
-- 1  2  3  4 5  6 7
SELECT SYSDATE, NEXT_DAY(SYSDATE,1) FROM DUAL;
```

+ LAST_DAY : 해당 월에 마지막 날짜 리턴
```SQL
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EXTRACT : 날짜에서 년,월,일 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜)
-- EXTRACT(MONTH FROM 날짜)
-- EXTRACT(DAY FROM 날짜)

-- EMPLOYEE 테이블에서 사원의 이름, 입사 년, 입사 월, 입사 일 조회
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 입사년도,
                 EXTRACT(MONTH FROM HIRE_DATE) 입사월,
                 EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;
```

### 4. 형 변환 함수

[ BACK](#함수-function)

 + TO_CHAR(DATE|NUMBER [, FORMAT]) : CHARACTER  (날짜/숫자형 데이터 -> 문자형 데이터)
 
 ```sql
SELECT TO_CHAR(1234) FROM DUAL; 
-- RESULT : 1234
SELECT TO_CHAR(1234, '99999') FROM DUAL; 
-- RESULT :  1234  ( 5칸, 오른쪽 정렬, 빈칸 공백)
SELECT TO_CHAR(1234, '00000') FROM DUAL; 
-- RESULT : 01234  ( 5칸, 오른쪽 정렬, 빈칸 0 )

SELECT TO_CHAR(1234, 'L99999') FROM DUAL; 
-- RESULT :   ￦1234 ==> L 로컬화폐(한국:￦) / $ 달러
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL;
-- RESULT : ￦1234 => FM 을 붙이면 앞의 공백이 제거된다.
SELECT TO_CHAR(1234, 'FM$99,999') FROM DUAL;
-- RESULT : $1,234 ==> , 구분자 사용가능
SELECT TO_CHAR(1234, 'FM$00,000') FROM DUAL;
-- RESULT : $01,234

SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL;
-- RESULT :   1.2E+03 ==> 지수표현
SELECT TO_CHAR(1234, '999') FROM DUAL; 
-- RESULT : #### ==> EX. 엑셀에서 칸을 줄이면 #으로 치환되는 것과 동일
 ```

 + TO_DATE(CHARACTER|NUMBER [, FORMAT]) : DATE (문자/숫자형 데이터 -> 날짜형 데이터)

 ```sql
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
-- RESULT : 오전 09:22:45 ==> 오전/오후 상관없이 알아서 나온다.
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
-- RESULT : 오전 09:22:53

SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
-- RESULT : 2월 목, 2020
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
-- RESULT : 2020-02-06 목요일 
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL;
-- RESULT : 2020-2-6 목요일 

SELECT TO_CHAR(SYSDATE, 'YEAR, Q')||'분기' FROM DUAL;
-- RESULT : TWENTY TWENTY, 1분기 
SELECT TO_CHAR(TO_DATE('20/12/30'),'Q') FROM DUAL; 
--RESULT : 4 ==> 4분기

SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일" DAY') FROM DUAL;
-- RESULT : 2020년02월06일 목요일 ==> 넣으려는 문자 년,월,일을 " " 로 감싸서 넣어준다.

-- < 오늘 날짜에 대해 > --

-- 연도 출력
SELECT TO_CHAR(SYSDATE,'YYYY'), TO_CHAR(SYSDATE, 'YY'),TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
-- RESULT : 20	2020	TWENTY TWENTY

-- 월 출력
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
-- RESULT : 02	2월 	2월 	II  

-- 일 출력
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 년 기준으로 일째
       TO_CHAR(SYSDATE, 'DD'), -- 이번 달 기준으로 몇일째인지
       TO_CHAR(SYSDATE, 'D') -- 이번주의 몇일째인지 (일 1, 월2, 화3 )
FROM DUAL;
-- RESULT : 037	06	5

-- 분기, 요일 출력
SELECT TO_CHAR(SYSDATE, 'Q'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
--RESULT : 1	목요일	목
  ```
 + TO_NUMBER (CHARACTER, [FORMAT]) : NUMBER (문자형 데이터 --> 숫자형 데이터)

 ```SQL
ELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
-- RESULT : 10/01/01
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;
-- RESULT : 10/01/01 
-- 오라클에서는 기본적으로 연도를 출력할때는 뒤의 두숫자만 나오게 설정되어있다.

-- 2010 01 01 ==> 2010, 1월 
SELECT TO_CHAR(TO_DATE(20100101, 'YYYYMMDD'), 'YYYY,MON') FROM DUAL;
-- RESULT : 2010,1월 
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM')
FROM DUAL;
-- RESULT : 04-10월-30 02:30:00 오후 식

-- RR과 YY의 공통점 : 둘다 년도를 나타낸다.
SELECT TO_CHAR(TO_DATE('980630','YYMMDD'),'YYYYMMDD') A, -- 20980630
       TO_CHAR(TO_DATE('140918','YYMMDD'),'YYYYMMDD') B, -- 20140918
       TO_CHAR(TO_DATE('980630','RRMMDD'),'YYYYMMDD') C, -- 19980630
       TO_CHAR(TO_DATE('140918','RRMMDD'),'YYYYMMDD') D  -- 20140918
FROM DUAL;

-- RR과 YY의 차이점
-- YY : 21세기 (앞 두자리 연도에 현재의 세기를 무조건 맞춰서 넣어준다.)
-- RR : 두자리 년도가 50년 이상이면 이전세기, 50년 미만이면 현재세기
 ```

### 5. NULL 처리 함수

[ BACK](#함수-function)

+ NVL (P1: 컬럼명, P2 :컬럼 값이 NULL일 때 바꿀 값) : NUMBER | CHARACTER

 ```SQL
SELECT EMP_NAME,NVL(BONUS,0)  FROM EMPLOYEE; 
RESULT : NULL인 칼럼을 -> 0 으로

SELECT EMP_NAME , NVL(DEPT_CODE,'없습니다')  FROM EMPLOYEE;
RESULT : NULL인 칼럼을 -> '없습니다'로
  ```

+ NVL2 ( 컬럼 명, 바꿀 값1, 바꿀 값 2)

```SQL
-- EMPLOYEE 테이블에서 보너스가 NULL인 직원은 '안받음' NULL이 아닌 직원은 '받음'으로 변경하여 조회
SELECT EMP_NAME, NVL2(BONUS, '안받음', '받음') AS "보너스 받니?"
FROM EMPLOYEE;

```
+ NULLIF(비교대상1, 비교대상2) : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
```SQL
SELECT NULLIF(123,123) FROM DUAL; -- RESULT : (null)
SELECT NULLIF(123,124) FROM DUAL; -- RESULT : 123
 ```

### 6. 선택함수 

-- 여러 가지 경우 선택 할 수 있는 기능 제공

+ DECODE(계산식|컬럼명, 조건1, 결과1, 조건2, 결과2, …, DEFAULT) : 결과

-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
```SQL
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8,1),1,'남',2,'여') 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8,1),1,'남','여') 성별
FROM EMPLOYEE;
```
-- 마지막 인자로 조건 값 없이 선택 값을 작성하면
-- 아무 것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함

+ CASE
```SQL
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
```

# 그룹 함수 (GROUP FUNCTION)

[ BACK](#함수-function)

+ < 여러 행을 넣으면 한개의 결과 반환 >

+ SUM (숫자가 기록된 컬럼) : 합계
```SQL
-- EMPLOYEE 테이블에서 전 사원의 급여 총합 조회
SELECT SUM(SALARY) AS 급여총합
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY) AS "급여총합(남)"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;
```

   + AVG(숫자가 기록된 컬럼) : 평균 리턴
```SQL
-- EMPLOYEE 테이블에서 전 사원의 급여 평균 조회
SELECT AVG(SALARY)FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 BONUS 합계 조회
SELECT SUM(BONUS) FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 BONUS 평균 조회
SELECT AVG(BONUS) , AVG(NVL(BONUS,0)) FROM EMPLOYEE;

-- AVG(NVL(BONUS,0)) -- NULL값을 가진 행은 평균 계산에서 제외 되어 계산
-- RESULT 0.2166666666666666666666666666666666666667 / 0.0847826086956521739130434782608695652174
```

  + MIN / MAX : 최소/최대
```SQL
-- EMPLOYEE 테이블에서 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일 
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;
```

[맨 위로](#함수-function)
