set serveroutput on
set verify off
DECLARE
    v_cusID CUSTOMER.CustID%TYPE;
    v_name CUSTOMER.Name%TYPE;
    in_bankname BLOOD_BANK.bank_name%TYPE;
    in_volume RECEIVER.volume%TYPE;
    v_blood_group Customer.blood_group%TYPE;
    flag integer;
BEGIN
    flag := 0;    
    v_cusID := '&customer_id';
    v_name := '&name';
    in_bankname := '&blood_bank_name';
    in_volume := &volume;
    SELECT COUNT(*) INTO flag FROM blood_bank WHERE bank_name = in_bankname;
    SELECT blood_group INTO v_blood_group
    FROM CUSTOMER
    WHERE CustID = v_cusID AND Name = v_name;
    IF flag = 0 THEN
        dbms_output.put_line('Invalid blood bank name');
    ELSE
        CASE v_blood_group
            WHEN 'A+' THEN UPDATE blood_bank SET A_positive = A_positive - in_volume WHERE bank_name = in_bankname;
            WHEN 'A-' THEN UPDATE blood_bank SET A_negative = A_negative - in_volume WHERE bank_name = in_bankname;
            WHEN 'B+' THEN UPDATE blood_bank SET B_positive = B_positive - in_volume WHERE bank_name = in_bankname;
            WHEN 'B-' THEN UPDATE blood_bank SET B_negative = B_negative - in_volume WHERE bank_name = in_bankname;
            WHEN 'O+' THEN UPDATE blood_bank SET O_positive = O_positive - in_volume WHERE bank_name = in_bankname;
            WHEN 'O-' THEN UPDATE blood_bank SET O_negative = O_negative - in_volume WHERE bank_name = in_bankname;
            WHEN 'AB+' THEN UPDATE blood_bank SET AB_positive = AB_positive - in_volume WHERE bank_name = in_bankname;
            WHEN 'AB-' THEN UPDATE blood_bank SET AB_negative = AB_negative - in_volume WHERE bank_name = in_bankname;
            ELSE
                dbms_output.put_line('Invalid blood group');
        END CASE;
        INSERT INTO RECEIVER VALUES(v_cusID, v_name, in_volume, in_bankname, SYSDATE, CURRENT_TIMESTAMP);
        dbms_output.put_line('Blood received successfully');
    END IF;
    COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Invalid user details');
        WHEN OTHERS THEN
            dbms_output.put_line('Error: ' || SQLERRM);
END;
/