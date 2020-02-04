-- 2020/02/04

-- ���ͷ� : ���Ƿ� ���� ���ڿ��� SELECT ���� ����ϸ� ���̺� �����ϴ� ������ó�� ��� ����
-- ���ڳ� ��¥ ���ͳ��� ' ' ��ȣ ���Ǹ� ��� �࿡ �ݺ� ǥ�� ��

-- EMPLOYEE ���̺��� ������ ���� ��ȣ, ��� ��, �޿�, ����(������ �� : ��) ��ȸ

SELECT EMP_ID "���� ��ȣ", EMP_NAME "��� ��", SALARY "�޿�", '��' AS ����
FROM EMPLOYEE;

--< DISTINCT : �÷��� ���Ե� �ߺ� ���� �ѹ����� ǥ���ϰ��� �� �� ��� , SELECT ���� �� �ѹ��� �� ���� ����>

-- EMPLOYEE ���̺��� ������ ���� �ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ �����ڵ带 �ߺ����� �Ͽ� ��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ�� �����ڵ带 �ߺ����� �Ͽ� ��ȸ
--SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
--FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- WHERE �� : SELECT �� �ɸ��� ���ǹ��� ���� ��
-- ��ȸ�� ���̺��� ������ �´� ���� ���� ���� ���
-- �� ������
-- = ����, > ũ��, < �۳�, >= ũ�ų� ����, <= �۰ų� ����
-- != , ^= , <> �� ����

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9' �� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �޿��� 4000000 �̻��� ������ �̸�, �޿� ��ȸ��
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� ��� ���ΰ� N�� ������ ��ȸ�ϰ�
-- �ٹ� ���θ� ���������� ǥ���Ͽ� ���, �̸�, �����, �ٹ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' AS �ٹ�����
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- �̴� �ǽ� ����
-- 1. EMPLOYEE ���̺��� ������ 3000000 �̻��� ����� �̸�, ����, ����� ��ȸ
-- 2. EMPLOYEE ���̺��� SAL_LEVER �� S1�� ����� �̸�, ���� , �����, ����ó ��ȸ
-- 3. EMPLOYEE ���̺��� �Ǽ��ɾ�(�� ���ɾ� - (����*���� 3%))�� 5õ ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

SELECT EMP_NAME ����̸�, SALARY ���� , 
      (SALARY * (1+BONUS) * 12) - (SALARY * 0.03)*12 AS "�� ���ɾ�", 
       HIRE_DATE �����
FROM EMPLOYEE
WHERE ((SALARY * (1+BONUS) * 12) - (SALARY * 0.03)) >= 50000000;

-- PL/SQL : ORACLE
-- SQL
--DECLARE @�Ѽ��ɾ� INT
--SET @�Ѽ��ɾ� = ((SALARY * (1+BONUS) * 12) - (SALARY * 0.03));
--SELECT EMP_NAME 

-- �� ������ : AND / OR
-- EMPLOYEE ���̺��� �μ��ڵ尡 'D6' �̰� �޿��� 2�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 2000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D6' �̰ų� �޿��� 2�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 2000000;

-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������ ���, �̸�, �޿�, �μ��ڵ�, ���� �ڵ� ��ȸ
SELECT EMP_ID ��� , EMP_NAME �̸�, SALARY �޿� , JOB_CODE "���� �ڵ�"
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- �̴� �ǽ� ����
-- EMPLOYEE ���̺� ������ 4000000 �̻��̰� JOB_CODE �� J2 �� ����� ��ü ���� ��ȸ
-- EMPLOYEE ���̺� DEPT_CODE �� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�� ���� ���� ����� �̸�, �μ��ڵ�, �����

SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ( DEPT_CODE = 'D9' OR DEPT_CODE = 'D5' ) AND HIRE_DATE < '02/01/01';
-- ( ) �Ұ�ȣ�� ������ �ǹ̰� �޶�����
-- AND �� OR �����ڰ� ���� ������ �ǹ̿� ���� �� ��������Ѵ�.

-- BETWEEN AND
--String str = "�ȳ��Ͻʴϱ�";
--              0 1 2 3 4 5
--str.substring(2,5); // "�Ͻʴ�"
--�ڹٿ����� ���� �ִ°��� ��κ� �������� �ʾ�����

-- BETWEEN AND : ���� �� �̻� ���� �� ����
-- �÷Ÿ� BEETWEEN ���� �� AND ���� ��
-- ���� �� <= �÷� �� <= ���� ��
-- �޿��� 3500000�� ���� ���� �ް� 6000000���� ���� �޴� ����� �̸�, �޿� ��ȸ

-- 1) BETWEEN AND �� ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- 2) BETWEEN ADN ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ( SALARY BETWEEN 3500000 AND 6000000 );
--AND SALARY != 3500000 AND SALARY != 6000000;

-- �ݴ�� �޿��� 350���� �̸�, �Ǵ� 600���� �ʰ��ϴ� ������ ���,�̸�,�޿�,�μ��ڵ�,�����ڵ� ��ȸ)

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY NOT BETWEEN 3500000 AND 6000000;

-- �̴� �ǽ� ����
-- EMPLOYEE ���̺� ������� '90/01/01' ~ '01/01/01'�� ����� ��ü ���� ��ȸ
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE 
-- ���Ϸ��� ���� ������ Ư�� ������ ���� ��Ű���� ��ȸ
-- %  : 0 ���� �̻�
-- %  : 1 ����
-- '����%' : ���ڷ� �����ϴ� �� (����, ���ڹ�, ���ڹ� ....)
-- '%����%' : ���ڸ� ���Ե� ��
-- '%����' : ���ڷ� ������ ��
-- '_' : �� ����
-- '__' : �� ����
-- '��__' : ������ �����ϴ� �� ���� (�ڱٿ�,�ڽſ�,������......)

-- EMPLOYEE ���̺��� ���� ������ ����� ���, �̸�, ����� ��ȸ

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� �̸��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� �̸��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPLOYEE ���̺��� ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- �̸��� �� _ �� ���ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� �ּ� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, EMAIL �̸���
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';

-- ���ϵ� ī���� _�� �˻��ϰ��� �ϴ� ���� �ȿ� ���� ���ڿ� ���� ������
-- ���� ��ü�� �ƴ� ���ϵ� ī��� �ν�\

-- ESCAPE OPTION 
SELECT EMP_ID ���, EMP_NAME �̸�, EMAIL �̸���
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- #�� �ִ°��� ���ڶ�� �˷��ش�.
-- ������ �� �ִ� �ƹ����ڳ� ��� �����ϴ�.

-- NOT LIKE : Ư�� ������ ������Ű�� �ʴ� �� ��ȸ
-- EMPLOYEE ���̺��� �达 ���� �ƴ� ������ ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE EMP_NAME NOT LIKE '��%';
WHERE NOT EMP_NAME LIKE '��%';

-- �̴� �ǽ� ����
-- 1. EMPLOYEE ���̺��� �̸� ���� '��' ���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME �̸� FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME �̸�, PHONE ��ȭ��ȣ FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4�� �̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
--     ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT * FROM EMPLOYEE
WHERE (EMAIL LIKE '____A_%' ESCAPE 'A') AND ( DEPT_CODE = 'D9' OR DEPT_CODE = 'D6' )
      AND (HIRE_DATE BETWEEN '90/01/01' AND '00/12/01')
      AND (SALARY >= 2700000);
      
-- IS NULL / IS NOT NULL 
-- IS NULL : �÷� ���� NULL �� ���
-- IS NOT NULL : �÷� ���� NULL�� �ƴ� ���

-- EMPLOYEE ���̺��� ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE ���̺��� ���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- EMPLOYEE ���̺��� �����ڵ� ���� �μ���ġ�� ���� ���� ������ �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE ���̺��� �μ���ġ�� ���� �ʾ����� ���ʽ��� �޴� ������ �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN
-- ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ������
-- EMPLOYEE ���̺��� �μ��ڵ尡 D6�̰ų� D9 �� ����� �̸�, �μ��ڵ�, �޿� ��ȸ

--SELECT EMP_NAME, DEPT_CODE, SALARY
--FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D9');

-- ���� �ڵ尡 J1, J2, J3, J4 �� ������� �̸�, ���� �ڵ�, �޿� ��ȸ
-- 1) IN �̻��
SELECT EMP_NAME �̸� , JOB_CODE �����ڵ� , SALARY �޿�
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';
      
-- 2) IN ���
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J2','J3','J4');

-- ���� ������ || : ���� �÷��� �����ϰų� �÷��� ���ͷ� ����
-- EMPLOYEE ���̺��� ���, �̸�, �޿��� �����Ͽ� ����

SELECT EMP_ID || EMP_NAME ||SALARY --����̸��޿�
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� '��� ���� ������ �޿����Դϴ�.' �������� ��ȸ
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.'
FROM EMPLOYEE;


