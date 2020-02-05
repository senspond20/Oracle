SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;
--WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

-- SELECT
-- Result Set : SELECT �������� �����͸� ��ȸ�� �����, ��ȯ�� ����� ����(0�� �̻�)

-- EMPLOYEE ���̺��� ����� �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
-- ��Ʈ�� ���� : ������ �����ݷк��� ���� �����ݷб��� ����

-- EMPLOYEE ���̺��� ��� ����� ��� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, 
        BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE;
-- �̴� �ǽ� ����
-- 1. JOB ���̺��� ��� ���� ��ȸ
-- 2. JOB ���̺��� ���� �̸� ��ȸ
-- 3. DEPARTMENT ���̺��� ��� ���� ��ȸ
-- 4. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
-- 5. EMPLOYEE ���̺��� �����, ��� �̸�, ���� ��ȸ

SELECT * FROM JOB; --1
SELECT JOB_NAME FROM JOB; --2
SELECT * FROM DEPARTMENT; --3
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE; --4
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE; --5

-- �÷� �� ��� ����
-- SELECT �� �÷� �� �Է� �κп� ��꿡 �ʿ��� �÷� ��, ����, �����ڸ� �̿��ؼ� ��� ��ȸ ����

-- EMPLOYEE ���̺� ���� ��, ���� ��ȸ (���� = �޿� * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ ���� ��, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY * BONUS))*12
FROM EMPLOYEE;

-- ���ʽ��� ���� �ֵ� NULL �� ���´�.
SELECT EMP_NAME, SALARY * 12, (SALARY *(1+ BONUS))*12
FROM EMPLOYEE;

-- �ƽ�Ʈ�δ� ȥ�ڽ���Ѵ�.
SELECT *, SALARY*12
FROM EMPLOYEE;

-- �̴� �ǽ� ����
-- 1. EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (���� * ���� 3% )) ��ȸ
-- 2. EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�(���� ��¥ - �����) ��ȸ
-- SYSDATE
SELECT SYSDATE -- ���� ��¥ ���
FROM DUAL;     -- ���� ���̺�
-- 1
SELECT EMP_NAME, SALARY*12, SALARY *(1+ BONUS)*12, (SALARY *(1+BONUS))*12 - SALARY*12 *0.03
FROM EMPLOYEE;
--SELECT * FROM EMPLOYEE WHERE OF SALARY;
SELECT EMP_NAME, 
       SALARY*12 AS ����, 
       SALARY *(1+ BONUS)*12 AS �Ѽ��ɾ�, 
       (SALARY *(1+BONUS))*12 - SALARY*12 *0.03 AS �Ǽ��ɾ�
FROM EMPLOYEE;
--2
SELECT EMP_NAME AS ����, 
       HIRE_DATE AS ����� ,
       SYSDATE - HIRE_DATE AS �ٹ��ϼ�
FROM EMPLOYEE;

-- �ʴ� �����ϰ� 
SELECT EMP_NAME AS "����", 
       HIRE_DATE AS "�����" ,
       ROUND(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�" -- ROUND : �ݿø��� ������ �Ϸ� �����Ҽ� �ֱ⿡ 
FROM EMPLOYEE;

SELECT EMP_NAME AS "����", 
       HIRE_DATE AS "�����" ,
       FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�" -- FLOOR : �Ҽ��� �Ʒ� ���� .ROUND ���ٴ� FLOOR�� ����.
FROM EMPLOYEE;
--

SELECT EMP_NAME AS "����", 
       HIRE_DATE AS "�����" ,
       FLOOR(SYSDATE - HIRE_DATE) AS "�ݿø�",
       CEIL(SYSDATE - HIRE_DATE) �ø�,
       FLOOR(SYSDATE - HIRE_DATE) ����,
       TRUNC(SYSDATE - HIRE_DATE) ����
FROM EMPLOYEE;

-- �÷� ��Ī
-- �÷� �� AS ��Ī
-- �÷� �� "��Ī"
-- �÷� �� AS "��Ī" 
-- �÷� �� ��Ī
-- ��Ī�� ����, Ư������, ���ڰ� ���Ե� ��� ������ "" ���� ����� �Ѵ�.

-- EMPLOYEE ���̺��� ������ ������(��Ī : �̸�), ����(��Ī : ����(��)), ���ʽ��� �߰��� ����(��Ī : �Ѽҵ�(��)) ����

SELECT EMP_NAME �̸�, SALARY * 12 "����(��)" , SALARY * (1+BONUS) * 12 AS "�Ѽҵ�(��)"
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�( ���ó�¥ - �����) ��ȸ
SELECT EMP_NAME AS �̸�, HIRE_DATE AS �����, SYSDATE - HIRE_DATE �ٹ��ϼ�
FROM EMPLOYEE;