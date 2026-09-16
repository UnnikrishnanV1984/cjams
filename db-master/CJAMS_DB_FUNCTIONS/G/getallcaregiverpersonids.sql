DROP FUNCTION IF EXISTS cjams.getallcaregiverpersonids(v_objectid CHARACTER VARYING) ;

CREATE OR REPLACE FUNCTION cjams.getallcaregiverpersonids(v_objectid CHARACTER VARYING)                                                                                                                                                                                                                                                                                                                                                                                                               
  RETURNS json
 LANGUAGE plpgsql
  AS $function$
  
  DECLARE                    
	v_caregiverpersonids json ;

 BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
  SELECT json_agg(a) INTO v_caregiverpersonids FROM (
	SELECT
	DISTINCT
	p.personid,
	concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
	ar.caregiverflag
	FROM 	actor a
	INNER JOIN intakeservicerequestactor isa ON isa.actorid = a.actorid
	INNER JOIN person p ON p.personid = a.personid
	LEFT JOIN actorrelationship ar ON ar.person1id = p.personid
	WHERE	a.activeflag=1 and isa.activeflag=1 AND ar.caregiverflag = 1
	AND (	isa.intakeserviceid::CHARACTER VARYING = v_objectid OR 
			isa.intakenumber::CHARACTER VARYING = v_objectid OR 
			isa.servicecaseid::CHARACTER VARYING = v_objectid
		)
	) a;
    
	RETURN v_caregiverpersonids;
 END;

 $function$;