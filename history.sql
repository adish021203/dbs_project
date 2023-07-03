set serveroutput on
set verify off
DECLARE
    p_custID CUSTOMER.CustID%TYPE;
    p_name CUSTOMER.name%TYPE;
BEGIN
    p_custID := '&customer_id';
    SELECT name INTO p_name FROM customer WHERE CustID = p_custID;
    DBMS_OUTPUT.PUT_LINE('Donation history for ' || p_name || ':');
    FOR rec IN (SELECT name, volume, blood_bank, date_of_donation, time_of_donation FROM donor WHERE id = p_custID AND name = p_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Donated ' || rec.volume || ' ml of blood to ' || rec.blood_bank || ' on ' || rec.date_of_donation);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Receiving history for ' || p_name || ':');
    FOR rec IN (SELECT name, volume, blood_bank, date_of_receiving, time_of_receiving FROM receiver WHERE id = p_custID AND name = p_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Received ' || rec.volume || ' ml of blood from ' || rec.blood_bank || ' on ' || rec.date_of_receiving);
    END LOOP;
    COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(' User does not exist ');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(' Error ');
END;
/