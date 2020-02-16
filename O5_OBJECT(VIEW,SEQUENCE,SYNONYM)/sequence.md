

```sql

-- 주 식별자
-- 인위적 주 식별자.
-- 인위적 주 식별자에 주로 시퀀스가 사용
-- 게시판에 글을 쓸때 게시판번호 / 자동번호 발생기a

-- SEQUNCE
-- 순차적으로 정수 값을 자동으로 생성하는 객체로 자동 번호 발생기 역할을 함

-- ※ 테이블 명을 지정할때 TIP을 붙인다. EX) 뷰 V_ 시원스 SEQ_

--CREATE SEQUENCE 시퀀스명 
--①[START WITH 숫자] ?처음발생시킬시작값,기본값1 
--②[INCREMENT BY 숫자] ?다음값에대한증가치, 기본값1 
--③[MAXVALUE 숫자| NOMAXVALUE] ?발생시킬최대값, 10의27승-1까지가능 
--④[MINVALUE 숫자| NOMINVALUE] ?발생시킬최소값, -10의 26승 
--⑤[CYCLE | NOCYCLE] ?시퀀스가최대값까지증가완료시 CYCLE은 START WITH 설정값으로돌아감 NOCYCLE은에러발생 
--⑥[CACHE | NOCACHE] ? CACHE는메모리상에서시퀀스값관리 기본값20


-- 시퀀스(SEQUENCE) : 자동 번호 발생기

CREATE SEQUENCE SEQ_EMPID -- 시퀀스 이름 지정
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;
--CREATED	20/02/14
--LAST_DDL_TIME	20/02/14
--SEQUENCE_OWNER	KH
--SEQUENCE_NAME	SEQ_EMPID
--MIN_VALUE	1
--MAX_VALUE	310
--INCREMENT_BY	5
--CYCLE_FLAG	N
--ORDER_FLAG	N
--CACHE_SIZE	0
--LAST_NUMBER	300

SELECT * FROM USER_SEQUENCES;

-- SEQUENCE 사용
-- 시퀀스명.CURRVAL : 현재 생성된 시퀀스의 값
-- 시퀀스명.NEXTVAL : 시퀀스를 증가시키거나 최초로 시퀀스 실행
------------------ 시퀀스.NEXTVAL = 시퀀스명.CURRVAL + INCREMENT로 지정한 값
-- 시퀀스명.
-- 시퀀스명.
-- 시퀀스명.

SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPID.CURRVAL is not yet defined in this session
-- 아직 정의되지 않은 시퀀스다. (생성된 되어있지 최초로 시퀀스가 실행되지 않았기 때문에)

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- RESULT : 300;
-- 실행시키고 SEQ_EMPID 에 305 로 너어가 있다.

SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- RESULT : 300;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;-- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; 
-- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- 최대값을 초과했다.

SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 310
-- CURRVAL -> 성공적으로 호출된 마지막 NEXTVAL 의 값을 저장

-- CURRVAL (NEXTVAL 사용 가능 및 불가능
-- 사용 가능
--      서브쿼리가 아닌 SELECT 문
--      INSERT문의 SELECT 절
--      INSERT문의 VALUES 절
--      INSERT문의 SET절
-- 사용 불가능 
--      VIEW 의 SELECT절
--      DISTINCT 키워드가 있는 SELECT문
--      GROUP BY, HAVING, ORDER BY 절의 SELECT문
--      SELECT, UPDATE, DELETE문의 서브쿼리
--      CREATE TALBE, ALTER TABLE의 DEFAULT 값

-- 시작 숫자가 300이고 증가 값은 1이며 최대 숫자가 10000인 비숫환 및 캐시 사용을 안하는 SEQ_EIT 스퀀스 생성

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
COMMIT;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, '홍길동', '666666-6666666','hong_gd@kh.or.kr','01666666666','D2','D7','S1',
     5000000,0.1, 200,SYSDATE,NULL,DEFAULT);
     
SELECT * FROM EMPLOYEE;


CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    E_NAME VARCHAR2(30)
);
-- ORA-00984: column not allowed here
ROLLBACK;

-- 시퀀스 변경
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE 
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --320
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --320
-- 

```



