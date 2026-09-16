DROP FUNCTION IF EXISTS cjams.listconsultreview(v_objectid uuid, v_objecttypekey character varying, pageno integer, pagesize integer);

CREATE OR REPLACE FUNCTION cjams.listconsultreview(v_objectid character varying, v_objecttypekey character varying, pageno integer, pagesize integer)
 RETURNS TABLE(totalcount bigint, intakeservicerequestconsultreviewid uuid, name character varying, reviewdate timestamp without time zone, notes text, objectid character varying, objecttypekey character varying, resourceconsultuser json)
 LANGUAGE plpgsql
AS $function$

DECLARE
BEGIN

RETURN QUERY 
SELECT count(1) over() as totalcount ,INCR.intakeservicerequestconsultreviewid, INCR.name, INCR.date AS reviewdate, INCR.notes, INCR.objectid, INCR.objecttypekey, 
   (SELECT json_agg(x) FROM 
		( SELECT INC.intakeservicerequestconsultreviewconfigid, INC.name, INC.consultreviewusertypekey, CRY.description as consultreviewusertype
		 FROM intakeservicerequestconsultreviewconfig INC
		 INNER JOIN  consultreviewusertype CRY ON CRY.consultreviewusertypekey=INC.consultreviewusertypekey 
		 WHERE INC.intakeservicerequestconsultreviewid = INCR.intakeservicerequestconsultreviewid AND INC.activeflag=1 ) as x ) as resourceConsultUser 
  FROM intakeservicerequestconsultreview INCR
  WHERE INCR.objectid = v_objectid  AND INCR.activeflag=1 
 LIMIT pagesize OFFSET  (pageno - 1) * pagesize; 
END;
 
$function$
;

