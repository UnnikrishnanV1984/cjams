
DROP FUNCTION IF EXISTS cjams.deletevisitationlog(v_visitationlogid CHARACTER VARYING, v_userid CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.deletevisitationlog(v_visitationlogid CHARACTER VARYING, v_userid CHARACTER VARYING)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_message character varying;
	 	 
BEGIN

	UPDATE visitationlog 
	SET activeflag = 0, updatedon = now(), updatedby = v_userid
	WHERE 
	visitationlogid::CHARACTER VARYING = v_visitationlogid AND activeflag = 1;

	UPDATE visitationlogclient
	SET activeflag = 0, updatedon = now(), updatedby = v_userid
	WHERE
	visitationlogid::CHARACTER VARYING = v_visitationlogid AND activeflag = 1;

	v_message:= 'Success';

    return v_message;
END  
$function$;