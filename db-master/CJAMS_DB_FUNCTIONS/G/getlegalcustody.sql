DROP FUNCTION IF EXISTS cjams.getlegalcustody(uuid); 
DROP FUNCTION IF EXISTS cjams.getlegalcustody(uuid, character varying, integer); 
DROP FUNCTION IF EXISTS cjams.getlegalcustody(uuid, integer);
  CREATE OR REPLACE FUNCTION cjams.getlegalcustody(v_personid uuid, isExpungementSuperUser integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 03/01/2024-To display servicecasenumber correctly-Charan sai Bodapati - (CIDM-8275)
-- 11/17/2025 Amiya Pradhan - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-- 02/11/2026 Sandeep Kiran Anugolu - CIDM-11127 - Query Optimization for better performance
------------------------------------------------------------------------------------------------------------
DECLARE l_legalcustody json;
v_isexpunged integer := 0;

BEGIN 

IF isExpungementSuperUser = 1 THEN 
IF ( v_personid is not null ) THEN  
		RAISE  NOTICE  'v_personid>>>>>>>>>>>%',v_personid;   
SELECT json_agg(legalcustody) INTO l_legalcustody FROM (
SELECT lc.legalcustodyid, lc.servicecaseid,
(case when lc.servicecaseid is not null then 
	  (select servicecasenumber from servicecase where servicecaseid = lc.servicecaseid )
	  else
	  (select servicerequestnumber from expunge.intakeservicerequest_expunge i where intakeserviceid=lc.intakeserviceid)
	  end)as servicecasenumber,
	   lc.intakeservicerequestactorid,lc.permanencyplanid,
       lc.legalcustodytypekey, TBPLV.value_text AS legalcustodytypedesc , lc.reason, lc.fromdate, lc.todate, pn.personid, 
	   (SELECT 	r2.description 
		FROM	actorrelationship arp, relationshiptype r2 
		WHERE TRIM(r2.relationshiptypekey) = TRIM(arp.relationshiptypekey) and	arp.intakeservicerequestactorid = isra2.intakeservicerequestactorid AND arp.activeflag =1 order by arp.updatedon desc LIMIT 1
	   ) relationshiptypekey,
	   padd.address As personaddress, concat_ws(' ',coalesce(pn.prefx,null),coalesce(pn.firstname,null),coalesce(pn.middlename,null),coalesce(pn.lastname,null),coalesce(pn.suffix,null) ):: character varying As personname, 
	   (Select ppn.phonenumber from personphonenumber ppn where ppn.personid = pn.personid AND ppn.activeflag =1 order by updatedon DESC Limit 1),
	(SELECT  json_agg(legalcustodydetail)  AS  legalcustodydetail  FROM  (
		    SELECT lcy.legalcustodytypekey, rv.description FROM legalcustody lcy
			INNER JOIN referencevalues rv ON rv.ref_key = lcy.legalcustodytypekey AND rv.activeflag =1 AND lcy.activeflag =1
			WHERE lcy.legalcustodyid = lc.legalcustodyid															
 )  legalcustodydetail)
FROM legalcustody lc
INNER JOIN person pn ON pn.personid = lc.personid AND pn.activeflag = 1 AND lc.activeflag = 1
INNER JOIN expunge.intakeservicerequestactor_expunge isra2 ON isra2.personid = lc.personid 
LEFT JOIN LATERAL (
    SELECT address
    FROM personaddress pa
    WHERE pa.personid = pn.personid
      AND pa.personaddresstypekey = 'C'
      AND pa.activeflag = 1
    ORDER BY pa.updatedon DESC
    LIMIT 1
) padd ON TRUE
LEFT JOIN  referencevalues as TBPLV ON TBPLV.ref_key = lc.legalcustodytypekey and TBPLV.referencetypeid=28
WHERE isra2.intakeservicerequestactorid =  v_personid

UNION ALL

SELECT lc.legalcustodyid, lc.servicecaseid,
(case when lc.servicecaseid is not null then 
	  (select servicecasenumber from servicecase where servicecaseid = lc.servicecaseid )
	  else
	  (select servicerequestnumber from intakeservicerequest i where intakeserviceid=lc.intakeserviceid)
	  end)as servicecasenumber,
	   lc.intakeservicerequestactorid,lc.permanencyplanid,
       lc.legalcustodytypekey, TBPLV.value_text AS legalcustodytypedesc , lc.reason, lc.fromdate, lc.todate, pn.personid, 
	   (SELECT 	r2.description 
		FROM	actorrelationship arp, relationshiptype r2 
		WHERE TRIM(r2.relationshiptypekey) = TRIM(arp.relationshiptypekey) and	arp.intakeservicerequestactorid = isra5.intakeservicerequestactorid AND arp.activeflag =1 order by arp.updatedon desc LIMIT 1
	   ) relationshiptypekey,
	   padd.address As personaddress, concat_ws(' ',coalesce(pn.prefx,null),coalesce(pn.firstname,null),coalesce(pn.middlename,null),coalesce(pn.lastname,null),coalesce(pn.suffix,null) ):: character varying As personname, 
	   (Select ppn.phonenumber from personphonenumber ppn where ppn.personid = pn.personid AND ppn.activeflag =1 order by updatedon DESC Limit 1),
	(SELECT  json_agg(legalcustodydetail)  AS  legalcustodydetail  FROM  (
		    SELECT lcy.legalcustodytypekey, rv.description FROM legalcustody lcy
			INNER JOIN referencevalues rv ON rv.ref_key = lcy.legalcustodytypekey AND rv.activeflag =1 AND lcy.activeflag =1
			WHERE lcy.legalcustodyid = lc.legalcustodyid															
 )  legalcustodydetail)
FROM legalcustody lc
INNER JOIN person pn ON pn.personid = lc.personid AND pn.activeflag = 1 AND lc.activeflag = 1
INNER JOIN intakeservicerequestactor isra5 ON isra5.personid = lc.personid 
LEFT JOIN LATERAL (
    SELECT address
    FROM personaddress pa
    WHERE pa.personid = pn.personid
      AND pa.personaddresstypekey = 'C'
      AND pa.activeflag = 1
    ORDER BY pa.updatedon DESC
    LIMIT 1
) padd ON TRUE
LEFT JOIN  referencevalues as TBPLV ON TBPLV.ref_key = lc.legalcustodytypekey and TBPLV.referencetypeid=28
WHERE isra5.intakeservicerequestactorid =  v_personid

) AS legalcustody;

RETURN l_legalcustody;    
end if;
ELSE 
IF ( v_personid is not null ) THEN  
		RAISE  NOTICE  'v_personid>>>>>>>>>>>%',v_personid;   
SELECT json_agg(legalcustody) INTO l_legalcustody FROM (
SELECT lc.legalcustodyid, lc.servicecaseid,
(case when lc.servicecaseid is not null then 
	  (select servicecasenumber from servicecase where servicecaseid = lc.servicecaseid )
	  else
	  (select servicerequestnumber from intakeservicerequest i where intakeserviceid=lc.intakeserviceid)
	  end)as servicecasenumber,
	   lc.intakeservicerequestactorid,lc.permanencyplanid,
       lc.legalcustodytypekey, TBPLV.value_text AS legalcustodytypedesc , lc.reason, lc.fromdate, lc.todate, pn.personid, 
	   (SELECT 	r2.description 
		FROM	actorrelationship arp, relationshiptype r2 
		WHERE TRIM(r2.relationshiptypekey) = TRIM(arp.relationshiptypekey) and	arp.intakeservicerequestactorid = isra5.intakeservicerequestactorid AND arp.activeflag =1 order by arp.updatedon desc LIMIT 1
	   ) relationshiptypekey,
	   padd.address As personaddress, concat_ws(' ',coalesce(pn.prefx,null),coalesce(pn.firstname,null),coalesce(pn.middlename,null),coalesce(pn.lastname,null),coalesce(pn.suffix,null) ):: character varying As personname, 
	   (Select ppn.phonenumber from personphonenumber ppn where ppn.personid = pn.personid AND ppn.activeflag =1 order by updatedon DESC Limit 1),
	(SELECT  json_agg(legalcustodydetail)  AS  legalcustodydetail  FROM  (
		    SELECT lcy.legalcustodytypekey, rv.description FROM legalcustody lcy
			INNER JOIN referencevalues rv ON rv.ref_key = lcy.legalcustodytypekey AND rv.activeflag =1 AND lcy.activeflag =1
			WHERE lcy.legalcustodyid = lc.legalcustodyid															
 )  legalcustodydetail)
FROM legalcustody lc
INNER JOIN person pn ON pn.personid = lc.personid AND pn.activeflag = 1 AND lc.activeflag = 1
INNER JOIN intakeservicerequestactor isra5 ON isra5.personid = lc.personid 
LEFT JOIN LATERAL (
    SELECT address
    FROM personaddress pa
    WHERE pa.personid = pn.personid
      AND pa.personaddresstypekey = 'C'
      AND pa.activeflag = 1
    ORDER BY pa.updatedon DESC
    LIMIT 1
) padd ON TRUE
LEFT JOIN  referencevalues as TBPLV ON TBPLV.ref_key = lc.legalcustodytypekey and TBPLV.referencetypeid=28
WHERE isra5.intakeservicerequestactorid =  v_personid
) AS legalcustody;

RETURN l_legalcustody;     

end if;
END IF;
 
end;

$function$;
