-- FUNCTION: cjams.getexpungement(uuid, integer, integer)

-- DROP FUNCTION cjams.getexpungement(uuid, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getexpungement(
	v_investigationfindingid uuid,
	v_page integer,
	v_limit integer)
RETURNS json
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
AS $BODY$

DECLARE

DECLARE                    
v_offset    integer;
l_expungement json ;

BEGIN
v_offset  :=  (v_page  -  1)  *  v_limit;    

SELECT row_to_json(v) INTO l_expungement FROM 
	(SELECT   (SELECT  CASE WHEN COUNT(isra.personid) > 0 THEN 0 ELSE 1 END  
				FROM 	investigationallegationmaltreators im 
						INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid AND ia.activeflag =1
						INNER JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = ia.maltreatmentid AND ima.activeflag =1
						INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = im.intakeservicerequestactorid AND isra.activeflag =1
						INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = isra.intakeserviceid
						INNER join investigationfinding inf on ia.investigationallegationid = inf.investigationallegationid and inf.activeflag = 1  
						INNER JOIN investigation iv ON iv.intakeserviceid = isr.intakeserviceid 
				WHERE 	COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey) IN ('RO', 'UD', 'ID')
						AND isra.personid IN (SELECT  isra.personid
												FROM	investigationallegation ia
														INNER JOIN investigationallegationmaltreators ima ON ima.investigationallegationid = ia.investigationallegationid AND ima.activeflag =1
														INNER join investigationfinding inf on ia.investigationallegationid = inf.investigationallegationid and inf.activeflag = 1 
														INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = ima.intakeservicerequestactorid ANd isra.activeflag = 1
												WHERE inf.investigationfindingid = v_investigationfindingid)
					   	AND iv.investigationid NOT IN (SELECT 	iva.investigationid
														FROM 	investigationfinding ivf 
																INNER JOIN investigationallegation iva ON iva.investigationallegationid = ivf.investigationallegationid
														WHERE 	ivf.investigationfindingid = v_investigationfindingid)) canexpungerouledout	
	 	, (SELECT json_agg(f)  FROM
		   (SELECT  aa. * ,(select rs.typedescription as status from routing r inner join routingstatustype rs 
				on r.objectid=aa.expungementid:: character varying and r.routingstatustypeid= rs.sequencenumber 
					order by r.insertedon desc limit 1),
			up.fullname
			FROM expungement aa 
			inner join userprofile up on up.securityusersid = aa.updatedby 
			WHERE aa.activeflag =1 AND aa.investigationfindingid = v_investigationfindingid
			ORDER BY aa.insertedon DESC)f) expungement
	  ) v;

Return l_expungement;
 
  END;

$BODY$;

