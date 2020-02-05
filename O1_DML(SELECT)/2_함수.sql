-- ����Ŭ���� �Լ��� �ڹٿ��� �޼ҵ�� ���� �ֱ��.

-- �Լ�(FUNCTION) : Į���� ���� �о ����� ��� ����
-- ���� �� �Լ� (SINGLE ROW FUNCTION)
--      N���� ���� �־ N���� ��� ����
-- �׷� �Լ�(GROUP FUNCTION)
--      S���� ���� �־ �Ѱ��� ��� ����

-- )) SELECT ���� ���� �� �Լ��� �׷� �Լ��� ���� �ᵵ �Ǵ°�?
-- > �ȵȴ�. ��?
-- > ����� �����Ë� ���� ���� �Ȱ��ƾ��ϴµ�
--> �÷��� 23����� ���� �� �Լ� 23 -> 23. �׷� �Լ� 23 -> 1
-- SELECT ���� ���� �� �Լ��� �׷� �Լ��� �Բ� ��� ���� : ��� ���� ������ �ٸ��� ����

-- LENGTH ���� �� �Լ�
SELECT LENGTH (EMP_NAME)
FROM EMPLOYEE;

-- COUNT �׷� �Լ�
SELECT COUNT (EMP_NAME)
FROM EMPLOYEE;

SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--"not a single-group group function" ����
FROM EMPLOYEE;

-- �Լ��� ��� �� �� �ִ� ��ġ
-- SELECT ��, WHERE��, GROUP BY��, HAVING ��, ORDER BY ��
-- ���� �� �Լ�

-- 1. ���� ���� �Լ�

-- LENGTH/ LENTHB
-- LENGTH(�÷��� | '���ڿ�' ) : ���� �� ��ȯ
-- LENGTHB(�÷��� | '���ڿ�' ) : ������ ����Ʈ ������ ��ȯ
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- �������̺�
-- ����Ŭ���� �ѱ��� 3����Ʈ�� �ν�

--����Ŭ Character set �� ���� �ѱ� ������ Byte ���� �ٸ���.
--EUC-KR : �ѱ� 1�� : 2 Byte
--UTF-8 : �ѱ� 1�� : 3 Byte
--��ó: https://denodo1.tistory.com/265 [dBack]

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ ( ZERO �ε��� ����� �ƴ϶� 1, 2,3,4 ..)
SELECT INSTR('AABAACAABBABA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL; -- ã�°��� ������ 0

SELECT INSTR('AABAACAABBAA','B',1) FROM DUAL; -- 1�������� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- -1��°(��) ���� (<-)�� �б� �����ؼ� ó������ ������ B�� ��ġ(->) ��ȯ
SELECT INSTR('AABAACAABBAA','C',-1) FROM DUAL; -- -1��°(��) ���� (<-)�� �б� �����ؼ� ó������ ������ B�� ��ġ(->) ��ȯ
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 1�������� �б� �����ؼ� �� ��°�� ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- �ǳ����� �б� �����ؼ� �ι�°�� ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA','C',1,2) FROM DUAL; -- ù��°���� �б� �����ؼ� �� ��°�� ������ C�� ��ġ ��ȯ

-- EMPLOYEE ���̺��� �̸����� @ ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '@',-1,1)
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;


-- LPAD / RPAD
SELECT LPAD(EMAIL, 20) -- �� 20ĭ�� ä�� (����� ���ʿ��ٰ� �ٴ´�.)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20 , '#') -- �� 20ĭ (������� ���ʿ��ٰ� '#' ä�� �ְڴ�.)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20) -- �� 20ĭ�� ä�� (����� �����ʿ��ٰ� �ٴ´�.)
FROM EMPLOYEE;

SELECT RPAD(EMAIL,20, '#')
FROM EMPLOYEE;

-- LTRIM/RTRIM/TRIM : �־��� �÷��̳� ���ڿ��� ���� �Ǵ� ������ �Ǵ� ��/��/���ʿ��� ������ ���ڸ� ������ ������ ��ȯ
SELECT LTRIM('  KH') FROM DUAL; -- ������ ���ڿ��� �������� �ʾ��� ��� ������ ����Ʈ�� ��
SELECT LTRIM('  KH', ' ') FROM DUAL; 
SELECT LTRIM('000123456','0') FROM DUAL;
-- RESULT : 123456
SELECT LTRIM('123123KH', '123') FROM DUAL;
-- RESULT : KH
SELECT LTRIM('123123KH123','123') FROM DUAL;
-- RESULT : KH123

SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
-- RESULT : KH
-- 'ABC'�� ������ ���°��� �ƴ϶� 'A','B','C' �ϳ��� �ɰ��� ����
-- ������� ACABACCKH �� �ƴ϶� KH�� �ȴ�.

SELECT LTRIM('56781KH', '0123456789') FROM DUAL;
-- RESULT : KH

SELECT RTRIM('KH    ') FROM DUAL;
-- RESULT : KH
SELECT RTRIM('123456000','0') FROM DUAL;
-- RESULT : 123456
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
-- RESULT : KH

SELECT TRIM('   KH   ') FROM DUAL;
-- �߸��� ������
SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL;
--missing right parenthesis ����

-- �ùٸ� ���

-- TRIM�� �ѹ��ڹۿ� �ȵȴ�.
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM('123' FROM '123132KH123321') FROM DUAL;
-- trim set should have only one character ���� (�� ���ڸ� ���� ����)

SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- ��
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- ��
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL; -- ����

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ���� ���� ������ ���ڿ��� �߶� ��ȯ

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
-- RESULT : THEMONEY

SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
-- RESULT : ME

SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;
-- RESULT : NULL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
-- RESULT : SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
-- RESULT : THE
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;
-- RESULT : ME

-- EMPLOYEE ���̺��� �̸�, �̸���, @ ���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, RTRIM(EMAIL,'@kh.or.kr')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;

-- �ֹε�Ϲ�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱�
SELECT SUBSTR(EMP_NO , 8, 1) 
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� ��� ��, ����, ����, ���� ��ȸ
SELECT EMP_NAME AS �̸�, 
        SUBSTR(EMP_NO , 1, 2) AS ����,
        SUBSTR(EMP_NO , 3, 2) AS ����,
        SUBSTR(EMP_NO , 4, 2) AS ����
FROM EMPLOYEE;

-- LOWER/ UPPER / INITCAP
-- LOWER ��� �ҹ��ڷ�
-- UPPER ��� �빮�ڷ�
-- INITCAP �ձ��ڸ� �빮�ڷ�

SELECT LOWER('Welcome To My World') FROM DUAL;  
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('welcome to my world') FROM DUAL;

-- ���� ) ORACLE DB �� ZERO �ε��� ����̴� ? 0 : X
-- �� : X

-- CONCAT
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-- REPLACE
SELECT REPLACE('����� ������ ���ﵿ','���ﵿ','�Ｚ��') FROM DUAL;
SELECT REPLACE('����ȣ �л��� ������ �����ϱ��?','����','����') FROM DUAL;

-- EMPLOYEE ���̺��� �̸����� �������� gmail.com���� ����
SELECT REPLACE(EMAIL, SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) ,'gmail.com')
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��� ��, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� �������-���� ������ ���̰� �ϰ� ������ ���� '*'�� �ٲٱ�
-- EX. 010114-2******
--1)
SELECT EMP_NAME "��� ��", 
       REPLACE(EMP_NO, SUBSTR(EMP_NO,9),'******') "�ֹι�ȣ(��6���߱�)"
FROM EMPLOYEE;

SELECT EMP_NAME "��� ��", 
       REPLACE(EMP_NO, SUBSTR(EMP_NO,-6),'******') "�ֹι�ȣ(��6���߱�)"
FROM EMPLOYEE;

--2)
SELECT EMP_NAME "��� ��", 
       CONCAT(SUBSTR(EMP_NO,0,8),'******')  "�ֹι�ȣ(��6���߱�)"
FROM EMPLOYEE;

--3)
SELECT EMP_NAME "��� ��", 
       RPAD(SUBSTR(EMP_NO,1,8),14,'*')  "�ֹι�ȣ(��6���߱�)"
FROM EMPLOYEE;

-- 2. ���� ���� �Լ�
-- ABS : ���� ���� �������ִ� �Լ�
-- ABS(NUMBER) : NUMBER

SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : �������� ����
-- MOD(NUMBER,DIVISION) : NUMBER
-- * NUMBER : ���� Ȥ�� ���� ������ �÷� 
-- * DIVISION : ���� �� Ȥ�� ���� ���� ������ �÷�

SELECT MOD(10,3) FROM DUAL; -- 1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10,-3) FROM DUAL; -- 1
-- ��ȣ�� �տ��ִ°͸� ���󰣴�.
SELECT MOD(10.9,3) FROM DUAL; -- 1.9
SELECT MOD(-10.9,3) FROM DUAL;-- -1.9

-- ROUND
-- ROUND(NUMBER) : NUMBER
-- ROUND(NUMBER, POSITION) : NUMBER
-- ���⼭�� ZERO INDEX ���. (POSITON 0 : �Ҽ��� 1��°)

SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678, 0) FROM DUAL; --123
SELECT ROUND(123.456, 1) FROM DUAL; 
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL; -- ���� �ڸ����� �ݿø� 

SELECT ROUND(1234,4) FROM DUAL; -- -1234

SELECT ROUND(-10.61) FROM DUAL; -- -11
SELECT ROUND(-10,61) FROM DUAL; -- -10

-- FLOOR : ����
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : ����(����)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456,-1) FROM DUAL;

-- CELL 
SELECT CEIL(123) FROM DUAL;
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- SELECT CEIL(123.456,1) FROM DUAL;
--ORA-00909: invalid number of arguments
--00909. 00000 -  "invalid number of arguments"

-- 3. ��¥ ���� �Լ�
-- SYSDATE : ���� ��¥ ��ȯ
-- MONTHS_BETWEEN : ��¥�� ��¥ ������ ���� �� ���̸� ���ڷ� �����ϴ� �Լ�(��¥ ���� ��¥)
-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE,HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(HIRE_DATE,SYSDATE)
FROM EMPLOYEE;
-- ������ŭ ���´�.

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ�� ���� ���� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL; 
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥�� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE,'�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'ȭ������ ���� ���������� �ϰ� ������?') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��ȭ���� �ڱ� �̸��� �Ǵ��� �ñ��ϰ���?') FROM DUAL;

-- �������� �ѱ۷� �Ǿ��ֱ⿡. ����� �ٲ��ָ� �ȴ�.
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'THUROSEMARY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,5) FROM DUAL;
-- �� �� ȭ �� �� �� ��
-- 1  2  3  4 5  6 7
SELECT SYSDATE, NEXT_DAY(SYSDATE,1) FROM DUAL;

-- LAST_DAY : �ش� ���� ������ ��¥ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EXTRACT : ��¥���� ��,��,�� �����Ͽ� ����
-- EXTRACT(YEAR FROM ��¥)
-- EXTRACT(MONTH FROM ��¥)
-- EXTRACT(DAY FROM ��¥)
-- EMPLOYEE ���̺��� ����� �̸�, �Ի� ��, �Ի� ��, �Ի� �� ��ȸ

SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
                 EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
                 EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;

-- 4. �� ��ȯ �Լ�
-- TO_CHAR(��¥[, ����]) :  ��¥�� ������ -> ������ ������
-- TO_CHAR(����[, ����]) :  ������ ������ -> ������ ������

SELECT TO_CHAR(1234) �� FROM DUAL;
SELECT TO_CHAR(1234,'99999') �� FROM DUAL; -5ĭ, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234,'00000') �� FROM DUAL; -5ĭ, ������ ����, ��ĭ 0

SELECT TO_CHAR(1234,'L9999') �� FROM DUAL;
SELECT TO_CHAR(1234,'FML9999') �� FROM DUAL;

SELECT TO_CHAR(1234,'$99999') �� FROM DUAL;

SELECT TO_CHAR(1234,'FM$9999') �� FROM DUAL;

SELECT TO_CHAR(1234,'99,999') �� FROM DUAL;
SELECT TO_CHAR(1234,'FM99,999') �� FROM DUAL;
SELECT TO_CHAR(1234,'00,000') �� FROM DUAL;
SELECT TO_CHAR(1234,'FM00,000') �� FROM DUAL;

SELECT TO_CHAR(1234, '9.9EEEE') �� FROM DUAL;
SELECT TO_CHAR(1234, '999') �� FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY,YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
-- RESULT : 2020-02-05 ������
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL;
-- RESULT : 2020-2-05 ������
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL;
-- RESULT : 2020-02-5 ������

SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" DAY') FROM DUAL;

--SELECT TO_CHAR(SYSDATE, 'YYYY AS "��" MM"��" DD"��" DAY') FROM DUAL; ����

-- ���� ��¥ ����
-- ���� ���
SELECT TO_CHAR(SYSDATE,'YYYY'), TO_CHAR(SYSDATE, 'YY'),TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'DDD'), -- �� �������� ��°
       TO_CHAR(SYSDATE, 'DD'), -- �̹� �� �������� ����°����
       TO_CHAR(SYSDATE, 'D') -- �̹����� ����°���� (�� 1, ��2, ȭ3 )
FROM DUAL;

-- �б�, ���� ���
SELECT TO_CHAR(SYSDATE, 'Q'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- TO_DATE : ����/������ ������ --> ��¥�� ������
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;
-- RESULT : 10/01/01
-- �⺻������ ������ ����ҋ��� ����Ŭ���� �α��ڷ� ������ �����Ǿ��ִ�.

-- 2010 01 01 ==> 2010, 1��
SELECT TO_CHAR(TO_DATE('20100101','YYYYMMDD'),'YYYY, MON') 
FROM DUAL;

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'),'YY-MON-DD HH:MI:SS PM')
FROM DUAL;

-- RR�� YY�� ����
-- ������ : �Ѵ� �⵵�� ��Ÿ��
SELECT TO_CHAR(TO_DATE('980630','YYMMDD'),'YYYYMMDD') A, -- 20980630
       TO_CHAR(TO_DATE('140918','YYMMDD'),'YYYYMMDD') B, -- 20140918
       TO_CHAR(TO_DATE('980630','RRMMDD'),'YYYYMMDD') C, -- 19980630
       TO_CHAR(TO_DATE('140918','RRMMDD'),'YYYYMMDD') D  -- 20140918
FROM DUAL;

-- YY : 21���� (�� ���ڸ� ������ ������ ���⸦ ������ ���缭 �־��ش�.)
-- RR : ���ڸ� �⵵�� 50�� �̻��̸� ��������, 50�� �̸��̸� ���缼��
-- 1950 

-- TO_NUMBER : ������ ������ -> ������ ������
SELECT TO_NUMBER('123456789') FROM DUAL;
SELECT '123' + '456' FROM DUAL; -- 579 �ڵ����� ���ڷ� �ٲ㼭 ����� ���ش٤�
-- SELECT '123' + '456A' FROM DUAL; -- ���� 

SELECT '1,000,000' + '550,000' FROM DUAL; -- ����
SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000','999,999') FROM DUAL;

-- 5 NULL ó�� �Լ�
-- NVL (�÷���, �÷� ���� NULL�� �� �ٲ� ��)

SELECT EMP_NAME,NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME , NVL(DEPT_CODE,'�����ϴ�')
FROM EMPLOYEE;

-- NVL2 ( �÷� ��, �ٲ� ��1, �ٲ� �� 2)
-- �÷� �� ���� NULL�� �ƴϸ� �ٲ� �� 1��, NULL�̸� �ٲ� �� 2�� ���ְڴ�.
-- EMPLOYEE ���̺��� ���ʽ��� NULL�� ������ 0.5�� NULL�� �ƴ� ������ 0.7�� �����Ͽ� ��ȸ
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(BONUS, '�ȹ���', '����')
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2) : �� ���� ���� �����ϸ� NULL, �������� ������ �񱳴��1 ����
SELECT NULLIF(123,123)FROM DUAL;

SELECT NULLIF(123,124) FROM DUAL;

SELECT TO_CHAR(TO_DATE('2020/06/30'), 'Q') FROM DUAL;
SELECT TO_CHAR(HIRE_DATE,'YYYY-MM-DD') FROM EMPLOYEE;

-- 6. �����Լ� : ���� ���� ��� ���� �� �� �ִ� ��� ����
-- DECODE (���� | �÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2....)
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8,1),1,'��',2,'��') ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8,1),1,'��','��') ����
FROM EMPLOYEE;

-- ������ ���ڷ� ���� �� ���� ���� ���� �ۼ��ϸ�
-- �ƹ� �͵� �ش���� ���� �� �������� �ۼ��� ���ð��� ������ ������

-- CASE WHEN ���ǽ� THEN ��� ��
--      WHEN ���ǽ� THEN ��� ��
--      ELSE ��� ��
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ(������ ���� ����)

SELECT EMP_ID, EMP_NAME, EMP_NO,
CASE WHEN SUBSTR(EMP_NO,8,1) IN(1,3) THEN '��'
     ELSE '��'
     END ����
FROM EMPLOYEE;

-- �޿��� 500�� �ʰ� 1���, 350�� �ʰ� 2���, 200�� �ʰ� 3���, ������ 4��� ó��

SELECT EMP_ID, EMP_NAME, SALARY,
(CASE WHEN SALARY > 5000000 THEN '1���'
     WHEN SALARY <= 5000000 AND SALARY > 3500000 THEN '2���'
     WHEN SALARY <= 3500000 AND SALARY > 2000000 THEN '3���'
     ELSE '4���'
     END) AS ���
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY,
(CASE WHEN SALARY > 5000000 THEN '1���'
     WHEN SALARY > 3500000 THEN '2���'
     WHEN SALARY > 2000000 THEN '3���'
     ELSE '4���'
     END) AS ���
FROM EMPLOYEE;

-- �켱������ ������ �Ʒ���
SELECT EMP_ID, EMP_NAME, SALARY,
(CASE WHEN SALARY > 3500000 THEN '2���'
      WHEN SALARY > 5000000 THEN '1���'
      WHEN SALARY > 2000000 THEN '3���'
     ELSE '4���'
     END) AS ���
FROM EMPLOYEE;

-- �׷� �Լ� : ���� ���� ������ �Ѱ��� ��� ��ȯ
-- SUM (���ڰ� ��ϵ� �÷�) : �հ�

-- EMPLOYEE ���̺��� �� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY) AS �޿�����
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY) AS "�޿�����(��)"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- AVG(���ڰ� ��ϵ� �÷�) : ��� ����
-- EMPLOYEE ���̺��� �� ����� �޿� ��� ��ȸ
SELECT AVG(SALARY)FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �� ����� BONUS �հ� ��ȸ
SELECT SUM(BONUS) FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �� ����� BONUS ��� ��ȸ
SELECT AVG(BONUS) , AVG(NVL(BONUS,0)) FROM EMPLOYEE;

-- AVG(NVL(BONUS,0)) -- NULL���� ���� ���� ��� ��꿡�� ���� �Ǿ� ���
-- RESULT 0.2166666666666666666666666666666666666667 / 0.0847826086956521739130434782608695652174

-- MIN / MAX : �ּ�/�ִ�
-- EMPLOYEE ���̺��� ���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի��� 
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;





