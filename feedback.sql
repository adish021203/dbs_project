set serveroutput on
set verify off
DECLARE
    cust_id Customer.CustID%TYPE;
    c_name Customer.Name%TYPE;
    rating feedback_form.Rating%TYPE;
    review feedback_form.Review%TYPE;
BEGIN
    cust_id := '&customer_id';
    SELECT name into c_name FROM Customer WHERE CustID = cust_id;
    rating := &rating;
    review := '&review';
    INSERT INTO FEEDBACK_FORM VALUES (cust_id,c_name, rating, review);
    DBMS_OUTPUT.PUT_LINE('Thank you for your feedback ');
    COMMIT;
    EXCEPTION
	WHEN NO_DATA_FOUND THEN
	    dbms_output.put_line('Customer does not exist');
END;
/