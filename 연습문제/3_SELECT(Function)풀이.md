## 문제풀이

```sql
-- Additional Select - 함수

--1. 영어영문학과(학과 코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL 문장을 작성
--(단, 헤더는 "학번", "이름", "입학년도" 가 되도록 표시)
SELECT STUDENT_NO 학번, STUDENT_NAME 이름 , ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ASC;

--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장 작성
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) !=3;

--3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 작성
-- 단, 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드세요 
-- 단,교수 중 200

SELECT PROFESSOR_NAME 교수이름, PROFESSOR_SSN 주민번호,
TO_NUMBER(EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER((19 || SUBSTR(PROFESSOR_SSN,1,2))) 나이
FROM TB_PROFESSOR
ORDER BY PROFESSOR_SSN DESC;

--4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 처리하시오.
SELECT SUBSTR(PROFESSOR_NAME,2) 이름
FROM TB_PROFESSOR;

--5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?
--(19살에 입학하면 재수를 하지 않은것으로 간주)


--6. 2020년 크리스마스는 무슨 요일인가?
--답 : 금요일

SELECT TO_CHAR(TO_DATE('2020/12/25'),'DAY')
FROM DUAL;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇년 몇월 몇일 의미하는가?
2099년 10월 11일 / 2049년 10월 11일
-- 또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD')은 각각 몇년 몇월 몇일을  의미하는가?
1999년 10월 11일 / 2049년 10월 11일

SELECT EXTRACT(YEAR FROM TO_DATE('99/10/11','YY/MM/DD')) FROM DUAL; -- 2099
SELECT EXTRACT(YEAR FROM TO_DATE('49/10/11','YY/MM/DD')) FROM DUAL; -- 2049
SELECT EXTRACT(YEAR FROM TO_DATE('99/10/11','RR/MM/DD')) FROM DUAL; -- 1999
SELECT EXTRACT(YEAR FROM TO_DATE('49/10/11','RR/MM/DD')) FROM DUAL; -- 2049

--8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL문 작성
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,1) <> 'A';

-- 9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL문 작성
-- 단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 수서점 이하 한자리 까지만 표시

--1) 오라클
SELECT ROUND(AVG(G.POINT),1) 평점
FROM TB_STUDENT S, TB_GRADE G
WHERE S.STUDENT_NO = G.STUDENT_NO AND
      S.STUDENT_NO = 'A517178';

--2) ANSI
SELECT ROUND(AVG(POINT),1) 평점
FROM TB_STUDENT
    JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A517178';

-- 10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값 출력

SELECT  DEPARTMENT_NO 학과번호, DEPARTMENT_NAME 학과 , 
        COUNT(*) 학생수, CAPACITY 정원, CAPACITY - COUNT(*) 남은자리
FROM TB_DEPARTMENT
    JOIN TB_STUDENT USING(DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NO, DEPARTMENT_NAME, CAPACITY
    ORDER BY DEPARTMENT_NO ASC;
    
-- 11. 지도 교수를 배정받지 못한 학생의 수는 몇 명인지 알아내는 SQL문 작성
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문 작성,
-- 점수는 반올림하여 소수점 이하 한자리

SELECT SUBSTR(TERM_NO,1,4) 년도 ,ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY SUBSTR(TERM_NO,1,4);

-- 13. 학과 별 휴학생 수를 파악. 학과번호,휴학생 수 표시

-- 0 명은 안나온다.
SELECT DEPARTMENT_NO 학과번호, NVL(COUNT(*),0) AS "휴학생 수"
FROM TB_STUDENT
WHERE ABSENCE_YN ='Y'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

-- 0명도 나온다.
SELECT DEPARTMENT_NO 학과번호, SUM(DECODE(ABSENCE_YN,'Y',1,0)) AS "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

-- 14. 춘 대학교에 다니는 동명이인 학생들의 이름/ 동명이인 수 조회
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
ORDER BY STUDENT_NAME;

-- 15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL문 작성
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시)
SELECT * FROM TB_STUDENT
    JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113';

SELECT TERM_NO, ROUND(AVG(POINT),1) "학기 별 평점"
FROM TB_STUDENT
    JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY TERM_NO
ORDER BY TERM_NO;

-->
SELECT SUBSTR(TERM_NO,1,4) 년도, SUBSTR(TERM_NO,5,2) 학기 , ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));

-->
SELECT NVL(SUBSTR(TERM_NO,1,4),'총집계') 년도, 
       NVL(SUBSTR(TERM_NO,5,2),'집계') 학기, 
       ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));


```