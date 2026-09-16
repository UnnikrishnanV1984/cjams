DROP FUNCTION IF EXISTS cjams.deletecourtnumber(v_courtnumberid CHARACTER VARYING, v_userid CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.deletecourtnumber(v_courtnumberid CHARACTER VARYING, v_userid CHARACTER VARYING)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_message character varying;
	 	 
BEGIN

	UPDATE courtnumbers 
	SET activeflag = 0, updatedon = now(), updatedby = v_userid
	WHERE 
	courtnumberid::CHARACTER VARYING = v_courtnumberid AND activeflag = 1;

	v_message:= 'Success';

    return v_message;
END  
$function$;