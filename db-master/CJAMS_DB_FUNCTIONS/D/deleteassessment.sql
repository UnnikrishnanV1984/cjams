DROP FUNCTION IF EXISTS cjams.deleteassessment(uuid, character varying);

CREATE OR REPLACE FUNCTION cjams.deleteassessment(
	v_assessmentid uuid,
	v_updatedby character varying)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 10/02/2024 - Yogeshvar - CIDM-9370 Comment out the submissioncollection as application does not use it.
------------------------------------------------------------------------------------------------------------
DECLARE
v_date timestamp without time zone;

BEGIN
v_date:= now() ;
	
	-- UPDATE submissioncollection SET activeflag = 0,updatedby = v_updatedby,updatedon = v_date 
	-- WHERE assessmentsubmissionid IN (SELECT assessmentsubmissionid FROM assessmentsubmission WHERE assessmentid = v_assessmentid);
	
	-- UPDATE assessmentsubmission SET activeflag = 0,updatedby = v_updatedby,updatedon = v_date WHERE assessmentid = v_assessmentid;
	UPDATE assessmentcomments SET activeflag = 0,updatedby = v_updatedby,updatedon = v_date WHERE assessmentid = v_assessmentid;
	UPDATE assessment SET activeflag = 0,updatedby = v_updatedby,updatedon = v_date WHERE assessmentid = v_assessmentid;
	
    update routing set activeflag = 0, updatedon = now(), updatedby = v_updatedby where eventcode = 'ASST' and routingstatustypeid = 15 and activeflag = 1 and objectid = v_assessmentid :: character varying;
    
    update cjams.usernotification set activeflag = 0, updatedon = now(), updatedby = v_updatedby where objectid = v_assessmentid :: character varying and activeflag = 1;

RETURN 'Success';
		
END
$BODY$;