DROP FUNCTION IF EXISTS cjams.getresponsibilitychild(v_caseid uuid);
CREATE OR REPLACE FUNCTION cjams.getresponsibilitychild(v_caseid uuid)
 RETURNS TABLE(firstname character varying, lastname character varying, personid uuid, intakeservicerequestactorid uuid, isassignment integer)
 LANGUAGE plpgsql
AS $function$
DECLARE l_adoptioncnt bigint;

BEGIN

	

SELECT COUNT(1) INTO l_adoptioncnt FROM adoptioncase WHERE adoptioncaseid =  v_caseid;

IF (COALESCE(l_adoptioncnt,0)) > 0 THEN
	RETURN QUERY
	SELECT 	p.firstname,p.lastname,p.personid,a.adoptioncaseactorid intakeservicerequestactorid,
			COALESCE (CA.isassignment,0) isassignment
	FROM  	adoptioncaseactor a
			INNER JOIN person p ON p.personid  = a.personid AND p.activeflag = 1
			LEFT JOIN  (SELECT	 DISTINCT CAA.intakeservicerequestactorid  , 1 isassignment
						FROM 	caseassignmentactor CAA 
								INNER JOIN caseassignment ca ON ca.caseassignmentid = CAA.caseassignmentid and ca.activeflag =1 and ca.enddate is null 
						WHERE caa.activeflag  =1  AND ca.objectid =v_caseid
						) ca ON CA.intakeservicerequestactorid = a.adoptioncaseactorid 
	WHERE 	a.adoptioncaseid = v_caseid  
			AND a.actortypekey IN ('CHILD')
			AND a.activeflag =1;
ELSE
	RETURN QUERY
	SELECT 	p.firstname,p.lastname,p.personid,isa.intakeservicerequestactorid,
			COALESCE (CA.isassignment,0) isassignment
	FROM  	intakeservicerequestactor isa
			INNER JOIN person p ON p.personid  = isa.personid AND p.activeflag = 1
			LEFT JOIN  (SELECT	 DISTINCT CAA.intakeservicerequestactorid  , 1 isassignment
						FROM 	caseassignmentactor CAA 
								INNER JOIN caseassignment ca ON ca.caseassignmentid = CAA.caseassignmentid and ca.activeflag =1 and ca.enddate is null 
						WHERE caa.activeflag  =1  AND ca.objectid =v_caseid
						) ca ON CA.intakeservicerequestactorid = isa.intakeservicerequestactorid 
	WHERE 	v_caseid IN (isa.servicecaseid,isa.intakeserviceid)
			AND isa.intakeservicerequestpersontypekey IN ('CHILD')
			AND isa.activeflag =1;
END IF;
END;
$function$;
