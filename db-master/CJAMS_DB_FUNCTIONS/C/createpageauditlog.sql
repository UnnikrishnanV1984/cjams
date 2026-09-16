CREATE OR REPLACE FUNCTION cjams.createpageauditlog(	as_securityusersid uuid,
														as_logtypekey character varying, 
														as_referenceid uuid, 
														as_objectype character varying,
														as_objectid character varying, 
														as_description character varying													
													)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created : 01/11/2022
-- To capture CJAMS Audit Log Events

-- Argument   : 1) IN as_securityusersid - User ID
--				2) IN as_logtypekey - Audit Log Event Type (auditlogtype table)
--				3) IN as_referenceid - Audit Log reference Transaction ID
--				4) IN as_objectype - Entity Type (Intake/CPS/Case etc.)
--				5) IN as_objectid - Entity ID (Intake/CPS/Case numbers)
--				6) IN as_description - Audit Log additional info

-- Revision(s)
------------------------------------------------------------------------
Declare v_event_description character varying;
Declare v_isnew boolean ;
Declare v_isedit boolean ;
Declare v_isdelete boolean ;
Declare v_isview boolean ;

BEGIN

	select logtype 
		into v_event_description
	from auditlogtype 
	where lower(btrim(logtypekey)) = lower(btrim(as_logtypekey)); 
	
	IF as_description is not null and btrim(as_description) <> '' THEN
		v_event_description := v_event_description || ' ' || as_description ;
	END IF;	

	-- Default 
	v_isnew := false;
	v_isedit := false;
	v_isdelete := false;
	v_isview := false;
	
	IF lower(btrim(as_logtypekey)) in ( 'add-contact-note' ) THEN
		  v_isnew := true;
		  v_isedit := false;
		  v_isdelete := false;
		  v_isview := false;	
	ELSEIF lower(btrim(as_logtypekey)) in ( 'edit-contact-note', 'add-note-addendum', 'save-contact-note' ) THEN
		  v_isnew := false;
		  v_isedit := true;
		  v_isdelete := false;
		  v_isview := false;
	ELSEIF lower(btrim(as_logtypekey)) in ( 'open-contact-note', 'view-contact-note', 'leave-from-contact-note', 'download-contact-note' ) THEN
		  v_isnew := false;
		  v_isedit := false;
		  v_isdelete := false;
		  v_isview := true;
	END IF;

	INSERT INTO cjams.auditlog
		(	logid, logtypekey, intakeserviceid, servicerequestnumber, referenceid, 
			description, isnew, isedit, isdelete, insertedby, 
			updatedby, insertedon, updatedon, metadata, ipaddress, 
			old_id, modifieddata, objectid, objecttype
		)
	VALUES
		(	gen_random_uuid(), as_logtypekey, NULL, NULL, as_referenceid, 
			v_event_description, v_isnew, v_isedit, v_isdelete, as_securityusersid, 
			as_securityusersid, now(), now(), NULL, NULL, 
			NULL, NULL, as_objectid, as_objectype
		);

	Return 1;
END;

$function$
;

