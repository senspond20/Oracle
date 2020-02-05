# 함수 (FUNCTION)

-- 오라클에서 함수는 자바에서 메소드와 같은 애기다.

-- 함수(FUNCTION) : 
+ 칼럼의 값을 읽어서 계산한 결과 리턴

-- [단일 행 함수 (SINGLE ROW FUNCTION)](url)
+  N개의 값을 넣어서 N개의 결과 리턴

-- [그룹 함수(GROUP FUNCTION)](url)
+   S개의 값을 넣어서 한개의 결과 리턴

-- )) SELECT 절에 단일 행 함수랑 그룹 함수를 같이 써도 되는가?
-- > 안된다. 왜?
-- > 결과를 가져올떄 행의 수가 똑같아야하는데
--> 컬럼이 23개라면 단일 행 함수 23 -> 23. 그룹 함수 23 -> 1

-- SELECT 절에 단일 행 함수와 그룹 함수를 함께 사용 못한다.
+ 결과 행의 개수가 다르기 때문

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
-- 함수를 사용 할 수 있는 위치
+  SELECT 절, WHERE절, GROUP BY절, HAVING 절, ORDER BY 절


