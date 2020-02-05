# DML(SELECT)

```
▶ SELECT
```
- 데이터 조회한 결과를 Result Set이라고 하는데
- SELECT 구문에 의해 반환된 행들의 집합을 의미
- Result Set은 0개 이상의 행이 포함될 수 있고 특정 기준에 의해 정렬 가능
- 한 테이블의 특정 컬럼, 행 , 행/컬럼 또는 여러 테이블의 특정 행/컬럼 조회 가능


```
▶ SELECT 작성법
```
+ (필수적으로 있어야 하는 구문 -> SELECT, FROM)

    + [SELECT 컬럼 명 [, 컬럼명, ...]]()

    + [FROM 테이블 명]()

    + [WHERE 조건식]();

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


```
▶ Result Set
```

데이터를 조회한 결과를 Result Set 이라고 하는데 
SELECT 구문에 의해 반환된 행들의 집합을 의미함

Result Set은 0개 이상의 행이 포함 될 수 있고 특정 기준에 의해 정렬 가능한 테이블의 특정 컬럼, 행, 행/컬럼 또는 여러 테이블의 특정 행/컬럼 조회 가능

※ JDBC - Result Set 가지고 사용하는것이 있다. 기억!

-----------------

## SELECT 기본 구문

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

+ 컬럼 값에 대해 산술 연산한 결과 조회 가능
```sql
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY * BONUS)) * 12
FROM EMPLOYEE;
```