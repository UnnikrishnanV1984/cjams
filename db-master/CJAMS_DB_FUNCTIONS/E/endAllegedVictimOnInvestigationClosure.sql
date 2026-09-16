DROP FUNCTION IF EXISTS cjams.endallegedvictimoninvestigationclosure(v_servicerequestid character varying, v_securityusersid uuid);
CREATE OR REPLACE FUNCTION cjams.endallegedvictimoninvestigationclosure(v_servicerequestid character varying, v_securityusersid uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
----------------------------------------------------------------------------------------------------------------
-- Revision
-- 11/21/2023 Vinesh Narayanan -  Modification to fix ERROR: column reference "objectid" is ambiguous(CIDM-8170)
----------------------------------------------------------------------------------------------------------------
DECLARE 
  v_status character varying;
  currentrow RECORD;
BEGIN
    
	v_status := 'failed';
				
	FOR currentrow IN (
		SELECT ppa.personprogramid FROM  personprogramarea ppa 
		JOIN intakeservicerequestactor isra ON isra.personid = ppa.personid AND isra.intakeservicerequestpersontypekey IN ('AV') and ppa.objectid::uuid = isra.intakeserviceid 
		WHERE ppa.objectid = v_servicerequestid GROUP BY ppa.personprogramid)
	LOOP
		UPDATE personprogramarea 
			SET enddate = now(),
				updatedon = now(),
				updatedby = v_securityusersid
			WHERE personprogramid = currentrow.personprogramid;
		INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
		VALUES(currentrow.personprogramid,'PRGMAREA','systemupdate01',
				(SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = currentrow.personprogramid),
				now(), v_securityusersid);
				
		v_status := 'success';
	END LOOP;

		
RETURN v_status;			

END;
$function$
;
