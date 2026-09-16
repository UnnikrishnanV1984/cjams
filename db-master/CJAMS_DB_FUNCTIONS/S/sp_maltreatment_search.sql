Drop function if exists sp_maltreatment_search(character varying);

CREATE OR REPLACE FUNCTION cjams.sp_maltreatment_search(in vl_cjamspid character varying)
RETURNS table (infojson json)
LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 08/22/2022 Vineet Tirodkar - Modifications for performance Issue fix - MyDHR is using this SP (CIDM-5431)
-- 06/28/2023 Vineet Tirodkar - Modifications to remove the duplicate null Decisiondate column (CDM-32604)
------------------------------------------------------------------------------------------------------------	
Declare Vl_rowcount integer;

BEGIN 

RETURN QUERY 
with base as 
(SELECT isr1.intakeserviceid,
	isr1.servicerequestnumber,
	isr1.insertedon,
	isr1.countyid,
	isrt.description
FROM intakeservicerequestactor isra1,
		intakeservicerequest isr1,
		intakeservicerequesttype isrt 
WHERE isra1.intakeserviceid = isr1.intakeserviceid
	and isrt.intakeservreqtypeid = isr1.intakeservreqtypeid
	and isra1.personid = (select pr.personid 
							from person pr 
						where pr.cjamspid = vl_cjamspid::bigint  
							and pr.activeflag = 1 )
	and isra1.activeflag = 1
	and isr1.activeflag = 1
	and isra1.intakeserviceid is not null
	and (isr1.isscreening IS NULL OR isr1.isscreening=0)  
	and isr1.actiontype = 'IR'
	
) 

			
(select json_agg(b) as infojson from 
	(
	SELECT DISTINCT  
		base.servicerequestnumber,
		CURRENT_TIMESTAMP ResultDateTime,
		0 ResultCode,
		'No Errors' ErrorDetails,
		( SELECT
			CASE
			WHEN coalesce(inf.finalfinding,coalesce(invm.overridefindingtypekey,
						coalesce(invm.scdecisiontypekey, coalesce( invm.csahearingdecisiontypekey,
						coalesce(invm.cchearingdecisiontypekey, coalesce(invm.oahearingdecision, 
							coalesce(inf.investigationfindingtypekey,'') )))))) = 'ID' THEN 'Y'
			ELSE 'N'
			END
			FROM intakeservicerequestactor israc
				INNER JOIN investigationallegationmaltreators invm ON invm.intakeservicerequestactorid = israc.intakeservicerequestactorid AND invm.activeflag = 1
				INNER JOIN investigationallegation inva ON inva.investigationallegationid=invm.investigationallegationid AND inva.activeflag=1
				INNER JOIN investigationfinding inf ON inf.activeflag = 1 AND inva.investigationallegationid=inf.investigationallegationid
				INNER JOIN investigation inv  ON inva.investigationid=inv.investigationid AND inv.activeflag=1 and inv.intakeserviceid=israc.intakeserviceid
			WHERE israc.intakeservicerequestpersontypekey IN ('ALVI', 'AV', 'ALMA', 'AM', 'Victim')
				AND israc.personid=isra.personid 
				AND israc.intakeserviceid=isra.intakeserviceid
			order by invm.updatedon desc LIMIT 1         
		) MaltreatorIndicator, 
		base.description type_,
		base.servicerequestnumber cpsID,
		(	SELECT firstname || ' ' || lastname
			FROM person WHERE personid= (SELECT personid FROM intakeservicerequestactor 
				WHERE intakeserviceid=isra.intakeserviceid 
				AND isheadofhousehold=true  LIMIT 1) 
		) caseheadname,
		(select co.countyname from county co where base.countyid is not null and base.countyid = co.countyid limit 1) LocalDeptOfIntake,
		base.insertedon CPSStartDate,
		MAX (coalesce(
				(
				-- select max(finalizeddate) from investigationallegationmaltreators z where z.investigationallegationid = inva.investigationallegationid
				select max(invm1.finalizeddate)  
				from intakeservicerequestactor israc1
					INNER JOIN investigationallegationmaltreators invm1 
						ON invm1.intakeservicerequestactorid = israc1.intakeservicerequestactorid 
						AND invm1.activeflag = 1
					INNER JOIN investigationallegation inva1 
						ON inva1.investigationallegationid = invm1.investigationallegationid 
						AND inva1.activeflag=1
				where israc1.intakeserviceid = isra.intakeserviceid	
				))) as Decisiondate,
		-- null as Decisiondate, -- 08/28
		base.description ReferralType,
		null as WorkerName,
		( 
			SELECT u.countyname FROM v_userprofile u
			INNER JOIN caseassignment ca ON ca.toldssid = u.countyid 
			WHERE ca.activeflag = 1 AND lower(ca.responsibilitytypekey) IN ('family', 'child') 
			AND ca.objectid = isra.intakeserviceid ORDER BY ca.responsibilitytypekey DESC, ca.enddate DESC NULLS FIRST LIMIT 1  
		) LocalDepartment,
		null as PhoneNumber,
		'Family' Responsibility,
		pr.cjamspid PersonID,
		pr.cjamspid ClientID,
		coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = pr.personid and pii.activeflag = 1 limit 1), pr.cisclientid) as CISClientID,
		pr.firstname || ' ' || pr.lastname PersonClientName,
		pr.dob DOB,
		pr.gendertypekey Gender,
		pr.ssnno ssn,
		NULL ConrirmPerson, 
		(	SELECT DISTINCT 
				CASE
				WHEN persontype.ptype='AM'
					AND coalesce(inf.finalfinding,coalesce(invm.overridefindingtypekey,coalesce(invm.scdecisiontypekey, coalesce( invm.csahearingdecisiontypekey,coalesce(invm.cchearingdecisiontypekey, coalesce(invm.oahearingdecision, coalesce(inf.investigationfindingtypekey,'') )))))) = 'ID' --inf.investigationfindingtypekey = 'ID' 
					AND ( (select max(finalizeddate) from investigationallegationmaltreators z where z.investigationallegationid = inva.investigationallegationid) is not null 
						  or inv.intinvfinaldate is not null)
					THEN 'M'
				WHEN persontype.ptype='AM'
					AND coalesce(inf.finalfinding,coalesce(invm.overridefindingtypekey,coalesce(invm.scdecisiontypekey, coalesce( invm.csahearingdecisiontypekey,coalesce(invm.cchearingdecisiontypekey, coalesce(invm.oahearingdecision, coalesce(inf.investigationfindingtypekey,'') )))))) = 'RO' --inf.investigationfindingtypekey = 'ID' 
					AND ( (select max(finalizeddate) from investigationallegationmaltreators z where z.investigationallegationid = inva.investigationallegationid) is not null 
						  or inv.intinvfinaldate is not null)
					THEN ''
				WHEN persontype.ptype='AV'
					AND coalesce(inf.finalfinding,coalesce(invm.overridefindingtypekey,coalesce(invm.scdecisiontypekey, coalesce( invm.csahearingdecisiontypekey,coalesce(invm.cchearingdecisiontypekey, coalesce(invm.oahearingdecision, coalesce(inf.investigationfindingtypekey,'') )))))) = 'ID' --inf.investigationfindingtypekey = 'ID' 
					AND ( (select max(finalizeddate) from investigationallegationmaltreators z where z.investigationallegationid = inva.investigationallegationid) is not null 
						  or inv.intinvfinaldate is not null)
					THEN 'V'
				ELSE persontype.ptype
				END as ptype
			FROM intakeservicerequestactor israc
				JOIN
					(SELECT DISTINCT isra.intakeservicerequestpersontypekey ptype, 
						isra.intakeserviceid intakeserviceid, 
						isra.personid personid
					 FROM intakeservicerequestactor isra
					    WHERE isra.personid=isra.personid 
						AND isra.intakeserviceid=isra.intakeserviceid
						AND isra.intakeservicerequestpersontypekey IN ('ALVI', 'AV', 'ALMA', 'AM', 'Victim')
					) persontype ON persontype.personid=israc.personid AND persontype.intakeserviceid=israc.intakeserviceid
				JOIN investigation inv ON inv.intakeserviceid=israc.intakeserviceid AND israc.activeflag=1
				LEFT JOIN investigationallegation inva ON inva.investigationid=inv.investigationid AND inva.activeflag=1
				LEFT OUTER JOIN investigationfinding inf ON inf.activeflag = 1 AND inva.investigationallegationid=inf.investigationallegationid
				LEFT JOIN investigationallegationmaltreators invm  ON invm.investigationallegationid=inva.investigationallegationid 
					AND invm.intakeservicerequestactorid = israc.intakeservicerequestactorid AND invm.activeflag=1   
				LEFT join investigationmaltreatmentactor ima ON ima.intakeservicerequestactorid = israc.intakeservicerequestactorid and ima.activeflag = 1
			WHERE israc.intakeservicerequestpersontypekey IN ('ALVI', 'AV', 'ALMA', 'AM', 'Victim')
				AND israc.personid=isra.personid AND israc.intakeserviceid=isra.intakeserviceid order by ptype desc  LIMIT 1
	   ) RoleInIntake 
	FROM base
		JOIN intakeservicerequestactor isra on isra.intakeserviceid = base.intakeserviceid 
			and isra.activeflag = 1
		JOIN person pr ON pr.personid = isra.personid 
			AND pr.activeflag = 1
	GROUP BY pr.cjamspid,
			 base.description,
			 base.insertedon,
			 isra.intakeservicerequestpersontypekey,
			 pr.firstname,
			 pr.lastname,
			 pr.dob,
			 pr.gendertypekey,
			 pr.ssnno,
			 isra.isheadofhousehold,
			 base.servicerequestnumber,
			 pr.personid,
			 isra.personid,
			 isra.intakeserviceid,
			 base.countyid
	order by personid
	)b 
) ;

EXCEPTION WHEN NO_DATA_FOUND THEN 
RETURN QUERY (
	select json_agg(b) as infojson from
	(	
		SELECT current_timestamp ResultDateTime, 2 ResultCode, null  row_count , 'No Error' ErrorDetails, 'N' MaltreatorIndicator
	) b );
							
END;
$function$
;
