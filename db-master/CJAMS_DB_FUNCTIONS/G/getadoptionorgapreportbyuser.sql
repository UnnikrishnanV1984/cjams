CREATE OR REPLACE FUNCTION cjams.getadoptionorgapreportbyuser(userid character varying, pageno integer, pagesize integer, filterdatetype character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- 07/19/2021 - Vineet Tirodkar - Modifications for performance Issue fix (B-107196)
-- 04/07/2023 - Vineet Tirodkar - Modifications to display notifications for subsidy agreement end date renewal. (CDM-29704)
------------------------------------------------------------------------------------------------
DECLARE v_pageoffset int;
  v_pagenumber int;
  v_DateFrom TIMESTAMP;                        
  v_DateTo TIMESTAMP; 
  l_adoptionorgapreport json;
  
BEGIN
	v_pagenumber := pageno-1;
	v_pageoffset = v_pagenumber * pagesize;
    
    IF filterdatetype = 'Nex30' THEN 
         SELECT now() INTO v_DateFrom ; 
         SELECT now() + interval '30' DAY INTO v_DateTo;
    END IF;
    IF filterdatetype = 'Nex60' THEN 
         SELECT now() INTO v_DateFrom ; 
         SELECT now() + interval '60' DAY INTO v_DateTo;
    END IF;
    IF filterdatetype = 'Nex90' THEN 
         SELECT now() INTO v_DateFrom ; 
         SELECT now() + interval '90' DAY INTO v_DateTo;
    END IF;
    
     IF filterdatetype = 'Prev30' THEN 
         SELECT now() INTO v_DateTo ; 
         SELECT now() - interval '30' DAY INTO v_DateFrom;
    END IF;
    IF filterdatetype = 'Prev60' THEN 
         SELECT now() INTO  v_DateTo; 
         SELECT now() - interval '60' DAY INTO  v_DateFrom;
    END IF;
    IF filterdatetype = 'Prev90' THEN 
         SELECT now() INTO v_DateTo ; 
         SELECT now() - interval '90' DAY INTO v_DateFrom;
    END IF;

select json_agg(adoptiondata) INTO l_adoptionorgapreport from 
(	select 'Adoption'::character varying as case_type, 
		(Select countyname from county where statecountycode = cjams.f_prim_county(ta.case_id,'null')) as Case_County,
		ta.adoption_id, 
		(	SELECT staff_nm 
			FROM (
				SELECT row_number() over() AS num, staff_id, assignment_id, staff_nm 
					FROM (  SELECT  userprofile.securityusersid AS staff_id, 
								   caseassignment.caseassignmentid AS assignment_id,
								  (userprofile.lastname || ' ' || userprofile.firstname || 
									COALESCE(case when userprofile.middlename is not null then
										',' || userprofile.middlename 
									end ,'')
								 ) AS staff_nm
							FROM  caseassignment
								  , userprofile  
							WHERE ( caseassignment.objectid = ta.adoption_case_id ) 
								 AND ( caseassignment.objecttypekey = 'adoptioncase') 
								 AND ( caseassignment.responsibilitytypekey = 'family') 
								 AND ( caseassignment.enddate is null ) 
								 AND ( userprofile.securityusersid = caseassignment.toworkeridno) 
								 AND ( caseassignment.activeflag = 1) 
								 AND ( userprofile.activeflag = 1)
						 )AS te 
				) AS rty WHERE num = 1
		) as primary_case_worker,
		ta.subsidy_end_dt::date as Adoption_Subsidy_End_Date,
		ta.case_id, 
		ta.client_id,
		concat(pr.firstname ,' ', pr.lastname)::character varying as client_name,
		tas.agreement_end_dt as Agreement_End_Date,
		(case when tas.agreement_end_dt < current_date then
			'The adoptive client''s subsidy review is overdue and payment has been suspended. Please update the adoption subsidy review rate accordingly.'
		 when tas.agreement_end_dt - interval '90 DAYS' < current_date 
				and tas.agreement_end_dt - interval '60 DAYS' >= current_date then
			'The adoptive client''s subsidy review is due in 90 days. Please update the adoption subsidy review rate accordingly. Failure to update will result in payment not being made to the adoptive parent.'	
		 when tas.agreement_end_dt - interval '60 DAYS' < current_date 
				and tas.agreement_end_dt - interval '30 DAYS' >= current_date then
			'The adoptive client''s subsidy review is due in 60 days. Please update the adoption subsidy review rate accordingly. Failure to update will result in payment not being made to the adoptive parent.'	
		 when tas.agreement_end_dt - interval '30 DAYS' < current_date then
			'The adoptive client''s subsidy review is due in 30 days. Please update the adoption subsidy review rate accordingly. Failure to update will result in payment not being made to the adoptive parent.'
		 when ta.subsidy_end_dt < current_date 
			 or (ta.subsidy_end_dt - interval '90 DAYS' < current_date 
				 and ta.subsidy_end_dt - interval '60 DAYS' >= current_date) 
			 or (ta.subsidy_end_dt - interval '60 DAYS' < current_date 
				and ta.subsidy_end_dt - interval '30 DAYS' >= current_date)
			 or ta.subsidy_end_dt - interval '30 DAYS' < current_date 
		 then
			'Please update the adoption subsidy agreement end date.'	
		 else
			''
		 end) || 
		 coalesce(( case when ((date_part('year',age(CAST((now()) AS DATE),CAST(pr.dob AS DATE))) < 18) AND (date_part('year',age(CAST((now()+interval '30' DAY) AS DATE),CAST(pr.dob AS DATE))) = 18)) THEN ' child turning 18 in 30 days.'
		 when ((date_part('year',age(CAST((now()) AS DATE),CAST(pr.dob AS DATE))) < 18) AND (date_part('year',age(CAST((now()+interval '60' DAY) AS DATE),CAST(pr.dob AS DATE))) = 18)) THEN ' child turning 18 in 60 days.'
		 when ((date_part('year',age(CAST((now()) AS DATE),CAST(pr.dob AS DATE))) < 18) AND (date_part('year',age(CAST((now()+interval '90' DAY) AS DATE),CAST(pr.dob AS DATE))) = 18)) THEN ' Child turning 18 in 90 days.'
		 end),'') as tickler_text
	from tb_adoption ta,
		 tb_adoption_subsidy_agreement tas,
		 person pr
	where ta.adoption_id = tas.adoption_id
		and pr.cjamspid = ta.client_id
		and ta.delete_sw = 'N'
		and tas.delete_sw = 'N'
		and (
				(
					ta.subsidy_end_dt >= current_date
					-- 12/03/2020
					and tas.agreement_end_dt between current_date - interval '90 DAYS' and current_date + interval '90 DAYS'
				)
				or
				(
					ta.subsidy_end_dt between current_date - interval '90 DAYS' and current_date + interval '90 DAYS'
					and ta.subsidy_end_dt::date < (pr.dob + interval '21 YEARS')::date 
	    		)
			)	
		and tas.provider_id is not null
		and coalesce(ta.ma_only_payment_cd, 'N' ) = 'N'
		and tas.approval_status_cd = '3047'
		and (tas.adoptionagreementrateid = (select adoptionagreementrateid
												from adoptioncaseagreementrate agr
											where agr.adoptionagreementid  = tas.adoptionagreementid
												and agr.status = 'Approved' 
												and agr.activeflag = 1
											order by startdate desc
											limit 1
											)
			)
		-- and cjams.f_prim_county(ta.case_id,'null') in ( select statecountycode from county where golivedate <= current_date ) 
	AND (	v_DateFrom IS NULL 
			OR (CAST( tas.agreement_end_dt AS DATE) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE))
			OR (CASE WHEN v_DateTo IS NOT NULL THEN ((date_part('year',age(CAST((now()) AS DATE),CAST(pr.dob AS DATE))) < 18)
				AND (date_part('year',age(CAST((v_DateTo) AS DATE),CAST(pr.dob AS DATE))) = 18)) ELSE 1=1 END
				)
			OR ( ta.subsidy_end_dt between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)
				and ta.subsidy_end_dt::date < (pr.dob + interval '21 YEARS')::date
				)  	
		) 
	AND ta.adoption_case_id in (select distinct objectid from caseassignment where (fromworkeridno = userid or toworkeridno = userid) and (enddate is null or enddate > now()))
	-- or adoption_case_id::varchar in (select distinct objectid::varchar from routing where (tosecurityusersid = userid or fromsecurityusersid = userid)))
	--order by tas.agreement_end_dt  
	
UNION ALL

	select tab.case_type,
		tab.Case_County,
		tab.adoption_id,
		tab.primary_case_worker,
		tab.Adoption_Subsidy_End_Date,
		tab.case_id,
		tab.client_id,
		tab.client_name,
		tab.Agreement_End_Date,
		tab.tickler_text
	from (
		select 'Adoption'::character varying as case_type,
		(select countyname 
			from county 
		 where statecountycode = cjams.f_prim_county(ad.case_id,'null')
		) as Case_County,
		ad.adoption_id, 
		(SELECT staff_nm 
			FROM (
				SELECT row_number() over() AS num, staff_id, assignment_id, staff_nm 
					FROM (  SELECT  userprofile.securityusersid AS staff_id, 
								   caseassignment.caseassignmentid AS assignment_id,
								  (userprofile.lastname || ' ' || userprofile.firstname || 
									COALESCE(case when userprofile.middlename is not null then
										',' || userprofile.middlename 
									end ,'')
								 ) AS staff_nm
							FROM  caseassignment
								  , userprofile  
							WHERE ( caseassignment.objectid = ad.adoption_case_id ) 
								 AND ( caseassignment.objecttypekey = 'adoptioncase') 
								 AND ( caseassignment.responsibilitytypekey = 'family') 
								 AND ( caseassignment.enddate is null ) 
								 AND ( userprofile.securityusersid = caseassignment.toworkeridno) 
								 AND ( caseassignment.activeflag = 1) 
								 AND ( userprofile.activeflag = 1)
						 )AS te 
				) AS rty WHERE num = 1
		) as primary_case_worker,
		ad.subsidy_end_dt::date as Adoption_Subsidy_End_Date,
		ad.case_id, 
		ad.client_id,
		concat(pr.firstname ,' ', pr.lastname)::character varying as client_name,
		asa.agreement_end_dt as Agreement_End_Date, 
		(case when pr.dob + interval '18 YEARS' 
			between current_date - interval '30 DAYS' and current_date + interval '30 DAYS' then
			'Child is turning 18, complete subsidy review on child''s 18th birthday.'
		 else 
			'Child is turning 21, close subsidy case.'
		 end ) as tickler_text,
		 (case when pr.dob + interval '18 YEARS' 
			between current_date - interval '30 DAYS' and current_date + interval '30 DAYS' then
			pr.dob + interval '18 YEARS'
		 else 
			pr.dob + interval '21 YEARS'
		 end )::date as bdate
	from person pr,
		tb_adoption ad,
		tb_adoption_subsidy_agreement asa
	where ad.delete_sw = 'N'
	and asa.delete_sw = 'N'
	and pr.activeflag = 1
	and pr.cjamspid = ad.client_id
	and ad.adoption_id = asa.adoption_id
	and asa.adoptionagreementrateid in (select adoptionagreementrateid
											from adoptioncaseagreementrate agr
										where agr.adoptionagreementid  = asa.adoptionagreementid
											and agr.status = 'Approved' 
											and agr.activeflag = 1
										order by startdate desc
										limit 1
										)
	and ad.adoption_case_id 
		in (select distinct objectid 
				from caseassignment 
			where (fromworkeridno = userid or toworkeridno = userid) 
				and (enddate is null or enddate > now())
			)
	and	 (
			(pr.dob + interval '18 YEARS'
				between current_date - interval '30 DAYS' and current_date + interval '30 DAYS'
			 and asa.agreement_end_dt = (pr.dob + interval '18 YEARS')::date)
			OR 
			(pr.dob + interval '21 YEARS' 
				between current_date - interval '30 DAYS' and current_date + interval '30 DAYS')
		 )
	) tab
	where (case when v_DateFrom is not null and v_DateTo is not null then 
				tab.bdate between v_DateFrom and v_DateTo
			else
				1 = 1
			end) 
			
UNION ALL
	-- CDM-4193 - 12/03/2020 New query
	select tab.case_type,
		tab.Case_County,
		tab.adoption_id,
		tab.primary_case_worker,
		tab.GAP_END_DATE,
		tab.CASE_ID,
		tab.CLIENT_ID,
		tab.client_name,
		tab.max_rate_end_date AS RATE_END_DATE,
		(case 
			when (tab.max_rate_end_date - current_date)::integer >= 0 and (tab.max_rate_end_date - current_date)::integer <= 30::integer then
				'The GAP Annual review is due, the rate will expire in 30 days. Complete review or close case.'	  
			when (tab.max_rate_end_date - current_date)::integer >= 0 and (tab.max_rate_end_date - current_date)::integer <= 60::integer then
				'The GAP Annual review is due, the rate will expire in 60 days. Complete review or close case.'		
			when (tab.max_rate_end_date - current_date)::integer >= 0 and (tab.max_rate_end_date - current_date)::integer <= 90::integer then
				'The GAP Annual review is due, the rate will expire in 90 days. Complete review or close case.'	
			when (tab.max_rate_end_date - current_date)::integer < 0 and (tab.max_rate_end_date - current_date)::integer <= -90::integer then 
				'The GAP Annual review is past due for 90 days. No payment was issued. Complete review or close case.'
			when (tab.max_rate_end_date - current_date)::integer < 0 and (tab.max_rate_end_date - current_date)::integer <= -60::integer then 
				'The GAP Annual review is past due for 60 days. No payment was issued. Complete review or close case.'
			when (tab.max_rate_end_date - current_date)::integer < 0  then 
				'The GAP Annual review is past due for 30 days. No payment was issued. Complete review or close case.'	
			 end
			 || 
			 ( case when ((date_part('year',age(CAST((now()) AS DATE),CAST(tab.dob AS DATE))) < 18) AND (date_part('year',age(CAST((now()+interval '30' DAY) AS DATE),CAST(tab.dob AS DATE))) = 18)) THEN ' child turning 18 in 30 days.'
				 when ((date_part('year',age(CAST((now()) AS DATE),CAST(tab.dob AS DATE))) < 18) AND (date_part('year',age(CAST((now()+interval '60' DAY) AS DATE),CAST(tab.dob AS DATE))) = 18)) THEN ' child turning 18 in 60 days.'
				 when ((date_part('year',age(CAST((now()) AS DATE),CAST(tab.dob AS DATE))) < 18) AND (date_part('year',age(CAST((now()+interval '90' DAY) AS DATE),CAST(tab.dob AS DATE))) = 18)) THEN ' Child turning 18 in 90 days.'
				end
			 )
		 ) AS tickler_text
	from (
	select 'Gap'::character varying as case_type, 
		(Select countyname 
			from county 
		where statecountycode = cjams.f_prim_county(sc.servicecasenumber::bigint,'null')
		) as Case_County, 
		0::bigint as adoption_id,
		(	SELECT staff_nm 
			FROM (
				SELECT row_number() over() AS num, staff_id, assignment_id, staff_nm 
					FROM (  SELECT  userprofile.securityusersid AS staff_id, 
								   caseassignment.caseassignmentid AS assignment_id,
								  (userprofile.lastname || ' ' || userprofile.firstname || 
									COALESCE(case when userprofile.middlename is not null then
										',' || userprofile.middlename 
									end ,'')
								 ) AS staff_nm
							FROM  caseassignment
								  , userprofile  
								  ,servicecase
							WHERE caseassignment.objectid = servicecase.servicecaseid 
								and servicecase.servicecasenumber = sc.servicecasenumber
								and servicecase.activeflag = 1 
								 AND ( caseassignment.objecttypekey = 'servicecase') 
								 AND ( caseassignment.responsibilitytypekey = 'family') 
								 AND ( caseassignment.enddate is null ) 
								 AND ( userprofile.securityusersid = caseassignment.toworkeridno) 
								 AND ( caseassignment.activeflag = 1) 
								 AND ( userprofile.activeflag = 1)
						 )AS te 
				) AS rty WHERE num = 1
		) as primary_case_worker,
		ga.enddate::date AS GAP_END_DATE,
		sc.servicecasenumber::bigint as CASE_ID,
		PR.cjamspid as CLIENT_ID,
		concat(PR.firstname, ' ', PR.lastname)::character varying as client_name,
		pr.dob,
	   ( select max(gr1.enddate)
			from gapagreementrate gr1
		 where gr1.gapagreementid = ga.gapagreementid 
			and gr1.activeflag = 1 
			and gr1.status = 'Approved'
		)::date as max_rate_end_date
	FROM guardianship g
		 JOIN gapagreement ga ON ga.gapid = g.gapid AND ga.activeflag = 1
		 JOIN permanencyplan pp ON pp.permanencyplanid = g.permanencyplanid AND pp.activeflag = 1
		 JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = pp.intakeservicerequestactorid AND isra.activeflag = 1
		 JOIN person PR ON PR.personid = isra.personid AND PR.activeflag = 1
		 JOIN servicecase sc ON sc.servicecaseid = g.servicecaseid AND sc.activeflag = 1
	where ga.enddate::date > current_date
		and (select COUNT(*) 
				from gapsuspension  
			 where gapid = g.gapid
				and activeflag = 1 
				and approvalstatustypekey = '3047' 
				and startdate IS NOT NULL	
				and enddate IS null ) = 0
		and SC.servicecaseid  in (select distinct objectid from caseassignment where (fromworkeridno = userid or toworkeridno = userid) and (enddate is null or enddate > now()))   
	) tab
	where tab.gap_end_date <> tab.max_rate_end_date 
	and tab.max_rate_end_date between current_date - interval '90 DAYS' and current_date + interval '90 DAYS'
	and (case when v_DateFrom is not null and v_DateTo is not null then 
			tab.max_rate_end_date between v_DateFrom::date and v_DateTo::date
		 else
			1 = 1
		 end
		)

) as adoptiondata;	

RETURN l_adoptionorgapreport;			

END;
$function$
;
