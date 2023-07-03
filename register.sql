set serveroutput on
set verify off
DECLARE
   v_cusID CUSTOMER.CustID%TYPE;
   v_name CUSTOMER.Name%TYPE;
   v_dob CUSTOMER.DOB%TYPE;
   v_phone CUSTOMER.Phone%TYPE;
   v_blood_group CUSTOMER.blood_group%TYPE;
   v_city CUSTOMER.city%TYPE;
BEGIN
   v_cusID := '&customer_id';
   v_name := '&name';
   v_dob := to_date('&date', 'dd/mm/yyyy');
   v_phone := '&phone';
   v_blood_group := '&blood_group';
   v_city := '&city';
   INSERT INTO CUSTOMER VALUES(v_cusID, v_name, v_dob, v_phone, v_blood_group, v_city);
   dbms_output.put_line('User registered successfully');
   COMMIT;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         dbms_output.put_line('User already exists');
      WHEN OTHERS THEN
         dbms_output.put_line('Error: ' || SQLERRM);
END;
/
