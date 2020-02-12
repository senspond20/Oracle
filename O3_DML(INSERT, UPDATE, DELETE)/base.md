# DML(INSERT, UPDATE, DELETE)

### INSERT
+ 테이블에 새로운 행을 추가하여 테이블의 행 개수를 증가시키는 구문

    ```sql
    INSERT INTO USER_FROEIGNKEY
    VALUES(5, 'user05', 'pass05', '윤봉길', '남' '010-5555-6666','yoon123@kh.or.kr' 50);
    ```

### UPDATE
+  테이블에 기록된 컬럼 값 수정을 하는 구문으로 테이블 전체 행 개수는 변화없음

    ```sql
    UPDATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENTL;

    UPDATE DEPT_COPY
    SET DEPT_TITLE = '전략기획팀'
    WHERE DEPT_ID = 'D9'
    ```
### DELETE

