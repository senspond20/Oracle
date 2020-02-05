# 단일 행 함수

## 1. 문자 관련 함수

+ LENGTH/ LENTHB

-- LENGTH(컬럼명 | '문자열' ) : 글자 수 반환
-- LENGTHB(컬럼명 | '문자열' ) : 글자의 바이트 사이즈 반환
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블
-- 오라클에서 한글을 3바이트로 인식

--오라클 Character set 에 따라 한글 저장의 Byte 수가 다르다.
--EUC-KR : 한글 1자 : 2 Byte
--UTF-8 : 한글 1자 : 3 Byte
--출처: https://denodo1.tistory.com/265 [dBack]

```sql
SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
```

-- INSTR : 해당 문자열의 위치 ( ZERO 인덱스 기반이 아니라 1, 2,3,4 ..)
```sql
SELECT INSTR('AABAACAABBABA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL; 
-- 찾는것이 없으면 0

SELECT INSTR('AABAACAABBAA','B',1) FROM DUAL; -- 1번쨰부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- -1번째(끝) 부터 (<-)로 읽기 시작해서 처음으로 나오는 B의 위치(->) 반환
SELECT INSTR('AABAACAABBAA','C',-1) FROM DUAL; -- -1번째(끝) 부터 (<-)로 읽기 시작해서 처음으로 나오는 B의 위치(->) 반환
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 1번쨰부터 읽기 시작해서 두 번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- 맨끝부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA','C',1,2) FROM DUAL; -- 첫번째부터 읽기 시작해서 두 번째로 나오는 C의 위치 반환

-- EMPLOYEE 테이블에서 이메일의 @ 위치 반환
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;
```

--------------------------------------------

-- 2. 숫자 관련 함수

-- 3. 날짜 관련 함수


