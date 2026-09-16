DROP FUNCTION if exists  cjams.getFileUploadStatusUpdate(v_userid character varying, filestatuspendinglist varchar[]);
CREATE OR REPLACE FUNCTION cjams.getFileUploadStatusUpdate(v_userid character varying, filestatuspendinglist varchar[])
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
--09/18/2025 - Manasa Kasula- CIDM-10472: EDMS file upload implementation.
---------------------------------------------------------------------------------------------------------------
DECLARE
	jsondata json;
BEGIN

	SELECT JSON_AGG(pla) INTO jsondata FROM (

	SELECT COUNT(1) over(),
	dp.documentpropertiesid, 
	dp.originalfilename,  
	dp.ecmsdocumentid,
	dp.uploadstatus,
	dp.finalstatus
	FROM documentproperties dp 
	WHERE dp.activeflag in (1,4,5) and dp.insertedby = v_userid and dp.ecmsdocumentid = ANY (filestatuspendinglist) 
	ORDER BY dp.insertedon desc) AS pla;

	RETURN jsondata ;

END;

$function$
;
