# 동의어(SYNONYM) 
+ 다른 DB가 가진 객체에 대한 별칭
+ 동의어를 사용하여 간단하게 접근할 수 있도록 한다.

    ```SQL
    -- EMP를 EMPLOYEE와 동의어로 만들시 
    -- 같은 결과 출력 --
    SELECT * FROM EMPLOYEE;
    SELECT * FROM EMP;
    ```

### 동의어

+ **비공개 동의어**
    + 객체에 대한 **접근 권한을 부여 받은** 사용자가 정의한 동의어로 **해당 사용자만 사용 가능**
+ **공개 동의어**(public)
    + 모든 권한을 주는 사용자(DBA)가 정의한 동의어
    + **모든 사용자가 사용할 수 있음**


### **동의어 생성**

+ 비공개 동의어 생성
    + **CREATE SYSNONYM** 동의어명 **FOR** 테이블명;

        ```SQL
        CREATE SYNONYM EMP FOR EMPLOYEE;
        -- 에러가 나는 경우
        --> 관리자 계정에서 SYNONYM 권한을 부여후 실행.
        GRANT CREATE SYNONYM TO KH; -- (SYSTEM 계정)
        ```
+ 공개 동의어 생성
    + **CREATE PUBLIC SYSNONYM** 동의어명 **FOR** 테이블명;

        ```SQL
        -- 관리자 계정에서.
        CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;
        ```

### **동의어 삭제**

+ 비공개 동의어 삭제
    + **DROP SYNONYM** 동의어명
        ```SQL
        DROP SYNONYM EMP;
        ```

+ 공개 동의어 삭제
   + **DROP PUBLIC SYNONYM** 동의어명
        ```SQL
        DROP PUBLIC SYNONYM DEPT; -- 관리자 계정에서 삭제 가능
        ```
