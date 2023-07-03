set serveroutput on
set verify off
BEGIN
    FOR bank_rec IN (SELECT * FROM blood_bank) LOOP
         DBMS_OUTPUT.PUT_LINE(bank_rec.bank_name || ' Inventory:');
         DBMS_OUTPUT.PUT_LINE('A+ : ' || bank_rec.A_positive);
         DBMS_OUTPUT.PUT_LINE('A- : ' || bank_rec.A_negative);
         DBMS_OUTPUT.PUT_LINE('B+ : ' || bank_rec.B_positive);
         DBMS_OUTPUT.PUT_LINE('B- : ' || bank_rec.B_negative);
         DBMS_OUTPUT.PUT_LINE('O+ : ' || bank_rec.O_positive);
         DBMS_OUTPUT.PUT_LINE('O- : ' || bank_rec.O_negative);
         DBMS_OUTPUT.PUT_LINE('AB+ : ' || bank_rec.AB_positive);
         DBMS_OUTPUT.PUT_LINE('AB- : ' || bank_rec.AB_negative);
         DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/