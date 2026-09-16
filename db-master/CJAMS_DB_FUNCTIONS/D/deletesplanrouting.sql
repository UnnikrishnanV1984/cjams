DROP FUNCTION IF EXISTS cjams.deletesplanrouting(v_splanid CHARACTER VARYING, v_userid CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.deletesplanrouting(v_splanid CHARACTER VARYING, v_userid CHARACTER VARYING)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_message character varying;
	 	 
BEGIN

	UPDATE routing r
	SET activeflag = 0, updatedon = now(), updatedby = v_userid
	WHERE 
	r.entityid = v_splanid AND activeflag = 1 AND r.routingstatustypeid =15 AND r.eventcode ='SPLAN';
	v_message:= 'Success';

    return v_message;
END  
$function$;