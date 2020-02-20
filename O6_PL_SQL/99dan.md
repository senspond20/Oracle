```SQL

-- 중첩 반복문
-- 구구단 짝수단 출력하기

BEGIN
    FOR DAN IN 2..9
    LOOP
         IF (MOD(DAN,2) = 0) THEN 
          DBMS_OUTPUT.PUT_LINE('===<' || DAN || '단>===');
         END IF;
        FOR SU IN 1..9
            LOOP 
              IF (MOD(DAN,2) = 0) THEN  
              DBMS_OUTPUT.PUT_LINE( DAN || '*' || SU || '=' || DAN * SU);
              END IF;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN, 2) = 0
        THEN
                DBMS_OUTPUT.PUT_LINE('===<' || DAN || '단>===');
            FOR SU IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' || DAN * SU);
            END LOOP;
                DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/

-- WHILE LOOP
/* 
    WHILE 조건
    LOOP
        처리문
    END LOOP;
*/
-- 1~5출력
DECLARE
    N NUMBER := 1;
BEGIN 
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    END LOOP;
END;
/

-- WHILE문으로 구구단 짝수단 출력
DECLARE
    DAN NUMBER :=2;
    SU NUMBER := 1;
BEGIN
    WHILE DAN <=9
    LOOP
        SU := 1;
        WHILE SU <= 9
            LOOP
              IF MOD(DAN,2) = 0 THEN
              DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' || DAN * SU);
              END IF;
              SU := SU + 1;
            END LOOP;
         DBMS_OUTPUT.PUT_LINE(' ');
    DAN := DAN +1;
    END LOOP;
END;
/

DECLARE
    DAN NUMBER :=2;
    SU NUMBER := 1;
BEGIN
    WHILE DAN <=9
    LOOP
       SU := 1;
        WHILE SU <= 9
            LOOP
              DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' || DAN * SU);
              SU := SU + 1; 
            END LOOP;
         DBMS_OUTPUT.PUT_LINE(' ');
    DAN := DAN +2;
    END LOOP;
END;
/
DECLARE 
    RESULT NUMBER;
    DAN NUMBER :=2;
    SU NUMBER;
BEGIN
    WHILE DAN <=9
    LOOP
        SU :=1;
        IF MOD(DAN,2) = 0
        THEN
            WHILE SU <= 9
            LOOP
                RESULT := DAN * SU;
                DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' ||RESULT);
                SU:= SU+1;
            END LOOP;
        END IF;
        DAN := DAN +1;
    END LOOP;
END;
/
```
