DROP function if exists cjams.createRestrictedCaseAuditLog(v_intakeserviceid character varying, v_userid character varying);

CREATE OR REPLACE FUNCTION cjams.createRestrictedCaseAuditLog(v_intakeserviceid character varying, v_userid character varying)
RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 

v_count int; 

BEGIN  
    SELECT count(*) INTO v_count FROM restricteditems WHERE objectid=v_intakeserviceid;
    
	IF v_count>0 THEN 
	  
	    insert into auditlog(logtypekey, description, isnew, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, objectid) 
    	VALUES ('WL002', 'Accessed Restricted case', false, true, true,v_userid, v_userid, now(), now(), v_intakeserviceid);
	
	END IF;
	
	RETURN 'Success';
END;

$function$
;