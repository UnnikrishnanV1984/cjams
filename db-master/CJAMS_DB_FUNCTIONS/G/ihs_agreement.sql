DROP FUNCTION IF EXISTS cjams.ihs_agreement(v_agreementid uuid);
CREATE OR REPLACE FUNCTION cjams.ihs_agreement(v_agreementid uuid)
 RETURNS TABLE(agreementdate timestamp without time zone, participants json, collateral json, signatureobtained text,
 attentiontx text, signeddate timestamp without time zone, hoh text, workername character varying, 
 supervisorname character varying, associatename character varying, approvalstatustypekey text, approvaldate timestamp without time zone)
 LANGUAGE plpgsql
AS $function$

BEGIN  

   RETURN  QUERY 
   
 SELECT 
	  sg.agreementdate,
	  (SELECT  json_agg(x)  FROM  (
			SELECT 
			cast(P.firstname || ' ' || P.lastname as character varying)as participantsname, p.personid AS participantid
			FROM  person P  WHERE P.personid = sgl.personid AND P.activeflag =1
	  ) AS x) AS participants,
 	 (SELECT  json_agg(x)  FROM  (
			SELECT 
			cast(c.firstname || ' ' || c.lastname as character varying)as collateralname, C.collateralid
			FROM  collateral C  WHERE C.collateralid = sgl.collateralid AND C.activeflag =1
	  ) AS x) AS collateral,	
	  CASE sg.signatureobtflag WHEN 0 THEN 'no' WHEN 1 THEN 'yes' ELSE NULL END AS signatureobtained,
	  sg.attentiontx,
	  sgl.signeddate,
	(SELECT INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
			CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename) ELSE '' END) AS hoh
    FROM person as P WHERE personid in (
		SELECT PersonId 
		FROM actor 
		WHERE ActorId IN (
			SELECT Actorid  
			FROM IntakeServiceRequestActor isar
			INNER JOIN servicecase sc 
				ON sc.servicecaseid = isar.servicecaseid 
				AND sc.activeflag =1
				AND isar.activeflag = 1
			WHERE sc.servicecaseid = sg.caseid ::uuid 
				AND isar.isheadofhousehold = true
				LIMIT 1))),
	(SELECT up.displayname as workername FROM userprofile up WHERE up.securityusersid = sg.staffid ::character varying and up.activeflag =1),
	(SELECT up.displayname as supervisorname FROM userprofile up WHERE up.securityusersid = sg.supervisorid ::character varying and up.activeflag =1),
	(SELECT up.displayname as associatename FROM userprofile up WHERE up.securityusersid = sg.associateid ::character varying and up.activeflag =1),
	UPPER(sg.approvalstatustypekey),
	sg.approvaldate
FROM serviceagreement sg
LEFT JOIN serviceagreementlist sgl ON sgl.agreementid = sg.agreementid and sgl.activeflag = 1
WHERE sg.activeflag = 1 AND sg.agreementid = v_agreementid;

END;

$function$;