DROP FUNCTION IF EXISTS cjams.getworkload(uuid, integer, integer);
DROP FUNCTION IF EXISTS cjams.getworkload(uuid, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getworkload(
    v_servicecaseid uuid,
    isExpungementSuperUser integer DEFAULT 0,
	isexpunged integer DEFAULT 0::integer
)
RETURNS TABLE(
    responsibilitytypekey character varying,
    caseassignmentid uuid,
    casetype character varying,
    countyname character varying,
    teamname character varying,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    statustypekey character varying,
    remarks character varying,
    assignmenttype character varying,
    toteamid uuid,
    toworkeridno character varying,
    fromworkerdetails json,
    toworkerdetails json,
    loadnumber character varying,
    localdepartment character varying,
    childinfo json,
    tosecurityusersdata json,
    fromsecurityusersiddata json,
    countyid character varying
)
LANGUAGE plpgsql
AS $function$

DECLARE
    v_isexpunged integer;
BEGIN  

v_isexpunged = 0;
IF (isExpungementSuperUser= 1) THEN
	v_isexpunged = isexpunged;
END IF;

IF v_isexpunged =1 THEN


        IF v_isexpunged = 1 THEN
        ------------------------------------------------------------------------
        -- FULLY EXPUNGED (use only ENCR for IntakeServiceRequestActor)
        ------------------------------------------------------------------------

        RETURN  QUERY 
       
        SELECT 
	       CA.responsibilitytypekey,
	       CA.caseassignmentid,
	       CA.objecttypekey as casetype,
	       c.countyname::character varying countyname,
	       T.teamname,
	       COALESCE(CA.startdate,CA.effectivedate)::timestamp,
	       CA.enddate,
	       CA.statustypekey,
	       CA.remarks,
	       CA.assignmenttype,
	       CA.toteamid,
	       CA.toworkeridno,
		     (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid = COALESCE(CA.fromworkeridno,CA.fromsupervisoridno)  --AND UP2.activeflag =1
				     )  AS  x  )  AS  fromworkerdetails,

			
		    (SELECT  json_agg(y)  FROM  (
			    SELECT 
				    cast(UP.firstname || ' ' || UP.lastname as character varying)as toworkername,
				    UP.email,
				    UP.cjamspid,
				    UPA.county,
				    UPP.phonenumber,
				    UP.securityusersid,
				    UP.supervisorid 
			    FROM   userprofile UP 
				    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.toworkeridno AND UPA.activeflag =1
				    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.toworkeridno AND UPP.activeflag =1  
				    WHERE UP.securityusersid = CA.toworkeridno   --AND UP.activeflag =1
			     )  AS  y  )  AS  toworkerdetails,
			
		    (SELECT tm.loadnumber FROM teammember tm
		      INNER JOIN  teammemberassignment tma on tma.teammemberid = tm.teammemberid where tma.securityusersid = CA.toworkeridno limit 1
		    ) AS loadnumber,
		    (CASE COALESCE(ca.toldssid::character varying ,'') 
			    WHEN '' THEN c.countyname
			    ELSE (SELECT c1.countyname from county c1 WHERE c1.countyid = ca.toldssid LIMIT 1)
		    END )::character varying parentteamname,
		    (SELECT  json_agg(x)  
		     FROM  (
			  
			    SELECT 	p.firstname,p.lastname,p.personid,acr.adoptioncaseactorid as intakeservicerequestactorid
			    FROM 	caseassignmentactor CAA
					    INNER JOIN adoptioncaseactor  acr on acr.adoptioncaseactorid = caa.intakeservicerequestactorid --and acr.activeflag =1
					    INNER JOIN person P on p.personid = acr.personid --and p.activeflag = 1
			    WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey ='adoptioncase'
			    UNION  ALL
			    SELECT 	p.firstname,p.lastname,p.personid,isra.intakeservicerequestactorid 
			    FROM 	caseassignmentactor CAA
					    INNER JOIN expunge.intakeservicerequestactor_expunge ISRA on isra.intakeservicerequestactorid = caa.intakeservicerequestactorid --and isra.activeflag =1
					    INNER JOIN person P on p.personid = isra.personid --and p.activeflag = 1
			    WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey <>'adoptioncase'	   )  AS  x  
		    )  AS  childinfo,
		     (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid in 
					    (select tosecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				     )  AS  x  )  AS  tosecurityusersdata,
	         (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid in 
					    (select fromsecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				     )  AS  x  )  AS  fromsecurityusersiddata,
				     (CASE ca.assignmenttype  WHEN 'T' THEN ca.toldssid::character varying ELSE c.countyid::character varying END)
			
	    FROM caseassignment CA 
		    LEFT JOIN team T on T.teamid = CA.toteamid
		    LEFT JOIN county c on c.countyid = t.countyid::uuid AND C.activeflag =1
	    WHERE CA.objectid = v_servicecaseid and objecttypekey not in ('intake') and CA.activeflag = 1  ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) desc ; 

          ELSIF v_isexpunged = 2 THEN

        ------------------------------------------------------------------------
        -- PARTIALLY EXPUNGED (UNION normal + ENCR for IntakeServiceRequestActor)
        ------------------------------------------------------------------------

        RETURN  QUERY 
       
        SELECT 
	       CA.responsibilitytypekey,
	       CA.caseassignmentid,
	       CA.objecttypekey as casetype,
	       c.countyname::character varying countyname,
	       T.teamname,
	       COALESCE(CA.startdate,CA.effectivedate)::timestamp,
	       CA.enddate,
	       CA.statustypekey,
	       CA.remarks,
	       CA.assignmenttype,
	       CA.toteamid,
	       CA.toworkeridno,
		     (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid = COALESCE(CA.fromworkeridno,CA.fromsupervisoridno)  --AND UP2.activeflag =1
				     )  AS  x  )  AS  fromworkerdetails,

			
		    (SELECT  json_agg(y)  FROM  (
			    SELECT 
				    cast(UP.firstname || ' ' || UP.lastname as character varying)as toworkername,
				    UP.email,
				    UP.cjamspid,
				    UPA.county,
				    UPP.phonenumber,
				    UP.securityusersid,
				    UP.supervisorid 
			    FROM   userprofile UP 
				    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.toworkeridno AND UPA.activeflag =1
				    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.toworkeridno AND UPP.activeflag =1  
				    WHERE UP.securityusersid = CA.toworkeridno   --AND UP.activeflag =1
			     )  AS  y  )  AS  toworkerdetails,
			
		    (SELECT tm.loadnumber FROM teammember tm
		      INNER JOIN  teammemberassignment tma on tma.teammemberid = tm.teammemberid where tma.securityusersid = CA.toworkeridno limit 1
		    ) AS loadnumber,
		    (CASE COALESCE(ca.toldssid::character varying ,'') 
			    WHEN '' THEN c.countyname
			    ELSE (SELECT c1.countyname from county c1 WHERE c1.countyid = ca.toldssid LIMIT 1)
		    END )::character varying parentteamname,
		    (SELECT  json_agg(x)  
		     FROM  (
			  
			    SELECT 	p.firstname,p.lastname,p.personid,acr.adoptioncaseactorid as intakeservicerequestactorid
			    FROM 	caseassignmentactor CAA
					    INNER JOIN adoptioncaseactor  acr on acr.adoptioncaseactorid = caa.intakeservicerequestactorid --and acr.activeflag =1
					    INNER JOIN person P on p.personid = acr.personid --and p.activeflag = 1
			    WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey ='adoptioncase'
			    UNION  ALL
			    SELECT 	p.firstname,p.lastname,p.personid,isra.intakeservicerequestactorid 
			    FROM 	caseassignmentactor CAA
					    INNER JOIN (
                            SELECT intakeservicerequestactorid, personid
                            FROM intakeservicerequestactor
                            WHERE activeflag = 1
                            UNION ALL
                            SELECT intakeservicerequestactorid, personid
                            FROM expunge.intakeservicerequestactor_expunge
                            WHERE activeflag = 1
                        ) ISRA on isra.intakeservicerequestactorid = caa.intakeservicerequestactorid
					    INNER JOIN person P on p.personid = isra.personid --and p.activeflag = 1
			    WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey <>'adoptioncase'	   )  AS  x  
		    )  AS  childinfo,
		     (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid in 
					    (select tosecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				     )  AS  x  )  AS  tosecurityusersdata,
	         (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid in 
					    (select fromsecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				     )  AS  x  )  AS  fromsecurityusersiddata,
				     (CASE ca.assignmenttype  WHEN 'T' THEN ca.toldssid::character varying ELSE c.countyid::character varying END)
			
	    FROM caseassignment CA 
		    LEFT JOIN team T on T.teamid = CA.toteamid
		    LEFT JOIN county c on c.countyid = t.countyid::uuid AND C.activeflag =1
	    WHERE CA.objectid = v_servicecaseid and objecttypekey not in ('intake') and CA.activeflag = 1  ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) desc ; 

        ELSE

        ------------------------------------------------------------------------
        -- FALLBACK TO NORMAL (no expunged flag even though isExpungementSuperUser/isexpunged passed)
        ------------------------------------------------------------------------

        RETURN  QUERY 
       
        SELECT 
	       CA.responsibilitytypekey,
	       CA.caseassignmentid,
	       CA.objecttypekey as casetype,
	       c.countyname::character varying countyname,
	       T.teamname,
	       COALESCE(CA.startdate,CA.effectivedate)::timestamp,
	       CA.enddate,
	       CA.statustypekey,
	       CA.remarks,
	       CA.assignmenttype,
	       CA.toteamid,
	       CA.toworkeridno,
		     (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid = COALESCE(CA.fromworkeridno,CA.fromsupervisoridno)  --AND UP2.activeflag =1
				     )  AS  x  )  AS  fromworkerdetails,

			
		    (SELECT  json_agg(y)  FROM  (
			    SELECT 
				    cast(UP.firstname || ' ' || UP.lastname as character varying)as toworkername,
				    UP.email,
				    UP.cjamspid,
				    UPA.county,
				    UPP.phonenumber,
				    UP.securityusersid,
				    UP.supervisorid 
			    FROM   userprofile UP 
				    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.toworkeridno AND UPA.activeflag =1
				    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.toworkeridno AND UPP.activeflag =1  
				    WHERE UP.securityusersid = CA.toworkeridno   --AND UP.activeflag =1
			     )  AS  y  )  AS  toworkerdetails,
			
		    (SELECT tm.loadnumber FROM teammember tm
		      INNER JOIN  teammemberassignment tma on tma.teammemberid = tm.teammemberid where tma.securityusersid = CA.toworkeridno limit 1
		    ) AS loadnumber,
		    (CASE COALESCE(ca.toldssid::character varying ,'') 
			    WHEN '' THEN c.countyname
			    ELSE (SELECT c1.countyname from county c1 WHERE c1.countyid = ca.toldssid LIMIT 1)
		    END )::character varying parentteamname,
		    (SELECT  json_agg(x)  
		     FROM  (
			  
			    SELECT 	p.firstname,p.lastname,p.personid,acr.adoptioncaseactorid as intakeservicerequestactorid
			    FROM 	caseassignmentactor CAA
					    INNER JOIN adoptioncaseactor  acr on acr.adoptioncaseactorid = caa.intakeservicerequestactorid --and acr.activeflag =1
					    INNER JOIN person P on p.personid = acr.personid --and p.activeflag = 1
			    WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey ='adoptioncase'
			    UNION  ALL
			    SELECT 	p.firstname,p.lastname,p.personid,isra.intakeservicerequestactorid 
			    FROM 	caseassignmentactor CAA
					    INNER JOIN intakeservicerequestactor ISRA on isra.intakeservicerequestactorid = caa.intakeservicerequestactorid --and isra.activeflag =1
					    INNER JOIN person P on p.personid = isra.personid --and p.activeflag = 1
			    WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey <>'adoptioncase'	   )  AS  x  
		    )  AS  childinfo,
		     (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid in 
					    (select tosecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				     )  AS  x  )  AS  tosecurityusersdata,
	         (SELECT  json_agg(x)  FROM  (
			    SELECT 
					    cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					    UP2.email,
					    UP2.cjamspid,
					    UPA.county,
					    UPP.phonenumber,
					    UP2.securityusersid
				    FROM  userprofile UP2  
					    LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					    LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					    WHERE UP2.securityusersid in 
					    (select fromsecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				     )  AS  x  )  AS  fromsecurityusersiddata,
				     (CASE ca.assignmenttype  WHEN 'T' THEN ca.toldssid::character varying ELSE c.countyid::character varying END)
			
	    FROM caseassignment CA 
		    LEFT JOIN team T on T.teamid = CA.toteamid
		    LEFT JOIN county c on c.countyid = t.countyid::uuid AND C.activeflag =1
	    WHERE CA.objectid = v_servicecaseid and objecttypekey not in ('intake') and CA.activeflag = 1  ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) desc ; 

        END IF;

    ELSE

    ------------------------------------------------------------------------
    -- NORMAL (original logic)
    ------------------------------------------------------------------------

    RETURN  QUERY 
   
  SELECT 
	   CA.responsibilitytypekey,
	   CA.caseassignmentid,
	   CA.objecttypekey as casetype,
	   c.countyname::character varying countyname,
	   T.teamname,
	   COALESCE(CA.startdate,CA.effectivedate)::timestamp,
	   CA.enddate,
	   CA.statustypekey,
	   CA.remarks,
	   CA.assignmenttype,
	   CA.toteamid,
	   CA.toworkeridno,
		 (SELECT  json_agg(x)  FROM  (
			SELECT 
					cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					UP2.email,
					UP2.cjamspid,
					UPA.county,
					UPP.phonenumber,
					UP2.securityusersid
				FROM  userprofile UP2  
					LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					WHERE UP2.securityusersid = COALESCE(CA.fromworkeridno,CA.fromsupervisoridno)  --AND UP2.activeflag =1
				 )  AS  x  )  AS  fromworkerdetails,

			
		(SELECT  json_agg(y)  FROM  (
			SELECT 
				cast(UP.firstname || ' ' || UP.lastname as character varying)as toworkername,
				UP.email,
				UP.cjamspid,
				UPA.county,
				UPP.phonenumber,
				UP.securityusersid,
				UP.supervisorid 
			FROM   userprofile UP 
				LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.toworkeridno AND UPA.activeflag =1
				LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.toworkeridno AND UPP.activeflag =1  
				WHERE UP.securityusersid = CA.toworkeridno   --AND UP.activeflag =1
			 )  AS  y  )  AS  toworkerdetails,
			
		(SELECT tm.loadnumber FROM teammember tm
		  INNER JOIN  teammemberassignment tma on tma.teammemberid = tm.teammemberid where tma.securityusersid = CA.toworkeridno limit 1
		) AS loadnumber,
		(CASE COALESCE(ca.toldssid::character varying ,'') 
			WHEN '' THEN c.countyname
			ELSE (SELECT c1.countyname from county c1 WHERE c1.countyid = ca.toldssid LIMIT 1)
		END )::character varying parentteamname,
		(SELECT  json_agg(x)  
		 FROM  (
			  
			SELECT 	p.firstname,p.lastname,p.personid,acr.adoptioncaseactorid as intakeservicerequestactorid
			FROM 	caseassignmentactor CAA
					INNER JOIN adoptioncaseactor  acr on acr.adoptioncaseactorid = caa.intakeservicerequestactorid --and acr.activeflag =1
					INNER JOIN person P on p.personid = acr.personid --and p.activeflag = 1
			WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey ='adoptioncase'
			UNION  ALL
			SELECT 	p.firstname,p.lastname,p.personid,isra.intakeservicerequestactorid 
			FROM 	caseassignmentactor CAA
					INNER JOIN intakeservicerequestactor ISRA on isra.intakeservicerequestactorid = caa.intakeservicerequestactorid --and isra.activeflag =1
					INNER JOIN person P on p.personid = isra.personid --and p.activeflag = 1
			WHERE 	CAA.caseassignmentid = CA.caseassignmentid AND CAA.activeflag =1 AND ca.objecttypekey <>'adoptioncase'	   )  AS  x  
		)  AS  childinfo,
		 (SELECT  json_agg(x)  FROM  (
			SELECT 
					cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					UP2.email,
					UP2.cjamspid,
					UPA.county,
					UPP.phonenumber,
					UP2.securityusersid
				FROM  userprofile UP2  
					LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					WHERE UP2.securityusersid in 
					(select tosecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				 )  AS  x  )  AS  tosecurityusersdata,
	     (SELECT  json_agg(x)  FROM  (
			SELECT 
					cast(UP2.firstname || ' ' || UP2.lastname as character varying)as fromworkername,
					UP2.email,
					UP2.cjamspid,
					UPA.county,
					UPP.phonenumber,
					UP2.securityusersid
				FROM  userprofile UP2  
					LEFT JOIN userprofileaddress UPA ON UPA.securityusersid = CA.fromworkeridno AND UPA.activeflag =1
					LEFT JOIN userprofilephonenumber UPP ON UPP.securityusersid = CA.fromworkeridno AND UPP.activeflag =1 
					WHERE UP2.securityusersid in 
					(select fromsecurityusersid from routing where objectid::character varying=v_servicecaseid::character varying)
				 )  AS  x  )  AS  fromsecurityusersiddata,
				 (CASE ca.assignmenttype  WHEN 'T' THEN ca.toldssid::character varying ELSE c.countyid::character varying END)
			
	FROM caseassignment CA 
		LEFT JOIN team T on T.teamid = CA.toteamid
		LEFT JOIN county c on c.countyid = t.countyid::uuid AND C.activeflag =1
	WHERE CA.objectid = v_servicecaseid and objecttypekey not in ('intake') and CA.activeflag = 1  ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) desc ; 

    END IF;

END;

$function$;
