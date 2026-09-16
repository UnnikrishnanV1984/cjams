--DROP FUNCTION IF EXISTS f_personname(v_personid uuid)

CREATE OR REPLACE FUNCTION f_personname(v_personid uuid)
 RETURNS TABLE(fname CHARACTER VARYING, mname CHARACTER VARYING, lname CHARACTER VARYING,
 shortname CHARACTER VARYING, name CHARACTER VARYING, fullname CHARACTER VARYING)
 LANGUAGE plpgsql
AS $function$

DECLARE

	VN_FIRST_NAME text;
    VN_LAST_NAME text;

BEGIN

RETURN QUERY 
SELECT 
firstname, 
middlename, 
lastname, 
concat(trim(firstname), ' ', trim(lastname))::CHARACTER VARYING ,
concat(trim(firstname), ' ', trim(middlename || ' ' || lastname ))::CHARACTER VARYING,
TRIM(concat(trim(salutation ||' '|| firstname), ' ', trim(middlename ||' '|| lastname ||' '|| suffix )))::CHARACTER VARYING 
FROM person WHERE personid = v_personid ;

END;

$function$;