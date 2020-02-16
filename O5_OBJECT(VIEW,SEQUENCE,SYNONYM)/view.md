# ORACLE OBJECT

## VIEW

+  SELECT 쿼리 실행 결과 화면을 저장한 객체, **논리적인 가상 테이블**
+  실제 데이터를 저장하고 있지 않지만, 사용자는 테이블을 사용하는 것과 동일하게 사용 가능
+ [표현식]
    + **CREATE [OR REPLACE ] VIEW** 뷰이름 **AS** 서브쿼리
      + OR REPLACE : 뷰 생성 시 같은 이름의 뷰가 기존에 존재한다면 해당 뷰를 새롭게 변경
      + OR REPLACE를 사용하지 않고 뷰를 생성 후 같은 이름의 뷰 또 생성 시 이미 다른 객체가 사용중인 이름이라고 에러 발생

        ```sql
        -- 사번, 이름, 부서 명, 근무 지역을 조회하고 그 결과를 V_EMPLOYEE 라는 뷰를 생성하여 저장
        CREATE OR REPLACE VIEW V_EMPLOYEE
        AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
            FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                LEFT JOIN NATIONAL USING(NATIONAL_CODE);
                
        --ORA-01031: insufficient privileges (충분하지 않은 권한)

        -- SYSTEM 계정에서 권한 주기
        GRANT CREATE VIEW TO KH;

        SELECT * FROM V_EMPLOYEE;

        COMMIT;
        ```

        ```sql
        -- EMPLOYEE 테이블에서 사번이 205번인 사원의 이름을 '정중앙'으로 변경

        UPDATE EMPLOYEE 
        SET EMP_NAME = '정중앙'
        WHERE EMP_ID = 205;

        SELECT * FROM EMPLOYEE
        WHERE EMP_ID = 205;

        SELECT * FROM V_EMPLOYEE;
        WHERE EMP_ID = 205;
        -- 베이스 테이블의 정보가 변경되면 VIEW 도 변경됨
        ROLLBACK;
        ```

    + **생성된 뷰 컬럼에 별칭 부여**
        + 서브쿼리의 SELECT 절에 함수가 사용된 경우는 반드시 별칭 지정(뷰 서브쿼리안에 연산 결과도 포함 가능)

        +
            ```sql
            CREATE OR REPLACE VIEW V_EMP_JOB(사번,이름,직급,성별,근무년수)
            AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
                    DECODE(SUBSTR(EMP_NO),8,1) , 1, '남', 2 , '여'),
                    EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
            FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE);
            ```
        +
            ```sql
            CREATE OR REPLACE VIEW V_EMP_JOB
                        AS SELECT EMP_ID 사번, EMP_NAME 이름, JOB_NAME 직급, 
                                DECODE(SUBSTR(EMP_NO),8,1) , 1, '남', 2 , '여') 성별,
                                EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE) 근무년수
                        FROM EMPLOYEE
                                JOIN JOB USING(JOB_CODE);

            ```
    + **생성된 VIEW를 이용해 DML문(INSERT,UPDATE,DELETE) 사용**
        ```sql
        CREATE OR REPLACE VIEW V_JOB
        AS SELECT JOB_CODE, JOB_NAME
            FROM JOB;
        ```


        + 뷰에 INSERT사용
            ```sql
            INSERT INTO V_JOB 
            VALUES ('J8','인턴');

            SELECT * FROM V_JOB;
            SELECT * FROM JOB;
            -- 뷰에서 요청한 DML구문은 베이스 테이블도 변경함
            ```

        + 뷰에 UPDATE 사용 
            ```sql
            UPDATE V_JOB
            SET JOB_NAME = '알바'
            WHERE JOB_NAME = '인턴';
            ```

        + 뷰에 DELETE 사용
            ```sql
            DELETE FROM V_JOB
            WHERE JOB_CODE = 'J8';
            ```


    + ### **생성한 VIEW 에 DML 명령어로 조작이 불가능한 경우**

        + 1.뷰 정의에 포함되지 않은 컬럼을 조작하는 경우 
        + 2.뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우 
        + 3.산술 표현식으로 정의된 경우 
        + 4.그룹함수나 GROUP BY절을 포함한 경우 
        + 5.DISTINCT를 포함한 경우 
        + 6.JOIN을 이용해 여러 테이블을 연결한 경우

        ```SQL
        -- 1) 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우 
        CREATE OR REPLACE VIEW V_JOB2
        AS SELECT JOB_CODE
            FROM JOB;
            
        SELECT * FROM V_JOB2;
        -- 뷰 정의에 JOB_CODE만 정의되어있다.
        --J1
        --J2
        --J3
        --J4
        --J5
        --J6
        --J7
        SELECT * FROM JOB;
        --J1	대표
        --J2	부사장
        --J3	부장
        --J4	차장
        --J5	과장
        --J6	대리
        --J7	사원

        INSERT INTO V_JOB2 VALUES('J8', '인턴');
        -- ORA-00913: too many values
        ROLLBACK;
        --INSERT INTO V_JOB2 VALUES('J8');
        -- J8 , null 로 들어간다.


        UPDATE V_JOB2
        SET JOB_NAME = '인턴'
        WHERE JOB_CODE = 'J7';

        DELETE FROM V_JOB2
        WHERE JOB_NAME = '사원';
        --"JOB_NAME": invalid identifier

        -- 2) 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우 
        -- : INSERT에서만 오류 발생
        -- JOB_NAME만 가진 뷰 V_JOB3 뷰 생성, 
        CREATE OR REPLACE VIEW V_JOB3
        AS SELECT JOB_NAME
            FROM JOB;

        SELECT * FROM V_JOB3;

        INSERT INTO V_JOB3 VALUES('인턴');
        -- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
        -- 기본적으로 뷰에 데이터를 집어넣으면 베이스에도 들어가는데
        -- JOB_CODE에는 NOT NULL 제약조건이 들어가 있기때문에 

        INSERT INTO JOB VALUES('J8', '인턴');
        SELECT * FROM V_JOB3;

        UPDATE V_JOB3
        SET JOB_NAME = '알바'
        WHERE JOB_NAME = '인턴';

        SELECT * FROM V_JOB3;
        SELECT * FROM JOB;

        DELETE FROM V_JOB3
        WHERE JOB_NAME = '알바';

        SELECT * FROM V_JOB3;
        SELECT * FROM JOB;

        -- 3) 산술 표현식으로 정의된 경우 
        -- 사번, 사원 명, 급여, 보너스가 포함된 연봉으로 이루어진 EMP_SAL 뷰 생성

        CREATE OR REPLACE VIEW EMP_SAL
        AS SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + (SALARY * NVL(BONUS,0)))* 12 연봉
            FROM EMPLOYEE;
            
        SELECT * FROM EMP_SAL;

        INSERT INTO EMP_SAL VALUES (800, '정진훈', 3000000, 36000000);
        -- "virtual column not allowed here"
        -- 연봉이라는 컬럼은 SALARY와 BONUS로 계산을 하고 있는데,
        -- 연봉에 바로 지정을 해서 집버리게 되면 오류가난다.

        UPDATE EMP_SAL
        SET 연봉 = 80000000
        WHERE EMP_ID = 200;
        --ORA-01733: virtual column not allowed here

        COMMIT;

        -- 삭제를 할때는 일치된것만 확인해서 삭제하면 되기에 된다.
        DELETE FROM EMP_SAL
        WHERE 연봉 = 124800000;

        -- 삭제된것 확인
            SELECT * FROM EMP_SAL;
            SELECT * FROM EMPLOYEE;

        ROLLBACK;

        -- 4) 그룹함수나 GROUP BY절을 포함한 경우 
        -- 부서 코드, 부서 코드 별 급여 합계, 부서 코드 별 급여 평균을 가지고 있는 V_GROUPDEPT 뷰 생성
        --                      (합계)                    (평균)

        CREATE OR REPLACE VIEW V_GROUPDEPT
        AS SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY) 평균
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY DEPT_CODE NULLS FIRST;

        SELECT * FROM V_GROUPDEPT;
        SELECT * FROM EMPLOYEE;

        INSERT INTO V_GROUPDEPT
        VALUES ('D10', 6000000, 4000000);
        -- ORA-01733: virtual column not allowed here
        -- 그룹함수라는것도 여러개를 계산한것이기 때문에
        -- 산술 표현식으로 정의된 경우와 마찬가지로 값을 집어넣는것이 불가능하다.

        UPDATE V_GROUPDEPT
        SET DEPT_CODE = 'D10'
        WHERE DEPT_CODE = 'D1';
        -- ORA-01732: data manipulation operation not legal on this view
        -- 이 뷰에서는 데이터 조작은 불가하다는 메시지

        DELETE FROM V_GROUPDEPT
        WHERE DEPT_CODE = 'D1';
        --  "data manipulation operation not legal on this view"
        -- 산술 표현식으로 정의된 경우와 다르게 삭제할때도 불가능하다.

        -- 5) DISTINCT를 포함한 경우 
        CREATE OR REPLACE VIEW V_DT_EMP
        AS SELECT DISTINCT JOB_CODE
            FROM EMPLOYEE;

        SELECT * FROM V_DT_EMP;
        SELECT * FROM EMPLOYEE;

        INSERT INTO V_DT_EMP VALUES('J9');
        --  ORA-01732: data manipulation operation not legal on this view

        UPDATE V_DT_EMP
        SET JOB_CODE = 'J9'
        WHERE JOB_CODE = 'J7';

        -- ORA-01732: data manipulation operation not legal on this view

        DELETE FROM V_DT_EMP
        WHERE JOB_CODE = 'J1';
        -- ORA-01732: data manipulation operation not legal on this view

        -- 6) JOIN을 이용해 여러 테이블을 연결한 경우
        -- 사번,사원 명, 부서 명 정보를 가지고 있는 V_JOINEMP 뷰 생성

        CREATE OR REPLACE VIEW V_JOINEMP
        AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

        SELECT * FROM V_JOINEMP;
        SELECT * FROM EMPLOYEE;

        INSERT INTO V_JOINEMP VALUES(888, '조세오','인사관리부');
        -- ORA-01776: cannot modify more than one base table through a join view
        -- 조인뷰를 통해서는 한개 이상의 베이스 테이블을 수정할 수 없다.

        UPDATE V_JOINEMP 
        SET DEPT_TITLE = '인사관리부'
        WHERE EMP_ID = 219;
        -- ORA-01779: cannot modify a column which maps to a non key-preserved table
        -- 

        COMMIT;
        DELETE FROM V_JOINEMP
        WHERE EMP_ID = 219;

        SELECT * FROM V_JOINEMP;
        SELECT * FROM EMPLOYEE;
        SELECT * FROM DEPARTMENT;

        ROLLBACK;
        ```


+ ### **VIEW 구조**
    + 확인
        ```SQL
        SELECT * FROM USER_VIEWS;
        ```
    + **실제 테이블에서 불러오는 것이 아니라**
      **VIEW의 TEXT 칼럼에 저장된 쿼리문 문을 재실행하는 방식이다.**
    + -> 뷰 정의 시 사용한 쿼리 문장이 TEXT컬럼에 저장

+ ### **VIEW 옵션**

    + VIEW 생성 표현식
      
        ```SQL 
        CREATE (OR REPLACE) [FORCE | NOFORCE] VIEW 뷰이름 [(alias[,alias])]
        AS SUBQUERY
        [WITH CHECK OPTION]
        [WITH READ ONLY];
        ```
    + VIEW 옵션

        + **OR REPLACE** 옵션 : 기본에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성

        + **FORCE / NOFORCE** 옵션
            + FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성 
            + NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본 값)
        +  **WITH CHECK OPTION** 옵션 : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함
        +  **WITH READ OLNY** 옵션 : 뷰에 대해 조회만 가능( 삽입, 수정, 삭제 등은 불가능하게 함)


        ```SQL
        --1) OR REPLACE 옵션 : 기본에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
        -- 주민번호와 사원 명 정보를 가지고 있는 V_EMP1 뷰 생성

        CREATE OR REPLACE VIEW V_EMP1
        AS SELECT EMP_NO, EMP_NAME
            FROM EMPLOYEE;

        SELECT * FROM V_EMP1;

        CREATE OR REPLACE VIEW V_EMP1
        AS SELECT EMP_NO, EMP_NAME, SALARY
            FROM EMPLOYEE;

        SELECT * FROM V_EMP1;

        -- (OR REPLACE 키워드를 사용하지 않고 쓸경우)
        CREATE VIEW V_EMP1
        AS SELECT EMP_NO, EMP_NAME
            FROM EMPLOYEE;
        -- ORA-00955: name is already used by an existing object
        -- 이름이 이미 사용중이다면서 덮어쓰기가 불가능하다.

        --2) FORCE / NOFORCE 옵션

        -- FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성 
        -- NOFORCE : 지정하지 않을 시 기본적으로 지정되어있다.

        CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2
        AS SELECT TCODE, TNAME, TCONTENT
            FROM TT;
        --ORA-00942: table or view does not exist
        -- 존재하지 않는 테이블이나 뷰이다.

        CREATE OR REPLACE FORCE VIEW V_EMP2
        AS SELECT TCODE, TNAME, TCONTENT
            FROM TT;
        -- ORA-00942: table or view does not exist
        -- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
        -- 빨간색으로

        SELECT * FROM V_EMP2;
        SELECT * FROM USER_VIEWS;

        -- 3) WITH CHECK OPTION : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함

        CREATE OR REPLACE VIEW V_EMP3
        AS SELECT * 
            FROM EMPLOYEE;
        SELECT * FROM EMPLOYEE;

        CREATE OR REPLACE VIEW V_EMP3
        AS SELECT * 
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D9' WITH CHECK OPTION;
            
        SELECT * FROM V_EMP3;

        UPDATE V_EMP3
        SET DEPT_CODE = 'D1'
        WHERE EMP_ID = 201;
        -- ORA-01402: view WITH CHECK OPTION where-clause violation
        -- WITH CHECK OPTION (컬럼 값 수정 불가능)이 걸려있어서 수정이 안된다.
        -- 만약 조건문에 찾을 수 없는것이 들어가있으면 0행이 삽입되었습니다. 라

        COMMIT;
        UPDATE V_EMP3
        SET EMP_NAME = '선동이'
        WHERE EMP_ID = 201;

        SELECT * FROM V_EMP3;

        ROLLBACK;
        -- 4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능

        CREATE OR REPLACE VIEW V_DEPT
        AS SELECT * FROM DEPARTMENT
        WITH READ ONLY;

        SELECT * FROM V_DEPT;

        DELETE FROM V_DEPT;
        --ORA-42399: cannot perform a DML operation on a read-only view

        COMMIT;

        ```