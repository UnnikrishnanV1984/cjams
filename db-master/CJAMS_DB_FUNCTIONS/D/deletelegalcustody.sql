DROP FUNCTION IF EXISTS cjams.deletelegalcustody(v_visitationlogid CHARACTER VARYING, v_userid CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.deletelegalcustody(v_legalcustodyid CHARACTER VARYING, v_userid CHARACTER VARYING)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_message character varying;
	 	 
BEGIN

	UPDATE legalcustody
	SET activeflag = 0, updatedon = now(), updatedby = v_userid
	WHERE 
	legalcustodyid::CHARACTER VARYING = v_legalcustodyid AND activeflag = 1;

	v_message:= 'Success';

    return v_message;
END  
$function$;
