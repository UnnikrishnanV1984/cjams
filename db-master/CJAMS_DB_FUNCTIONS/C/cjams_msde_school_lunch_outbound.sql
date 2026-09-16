DROP FUNCTION if exists cjams.cjams_msde_school_lunch_outbound();

CREATE OR REPLACE FUNCTION cjams.cjams_msde_school_lunch_outbound()
 RETURNS TABLE(cl_id character, status character, category character, dob_dt character, ldss character, first_nm character, last_nm character, middle_initial character, address_line1 character, address_line2 character, filler character, city_nm character, state_cd character, pa_adr_zip5_no character, ssn_no character, sasid character, race character, gender character)
 LANGUAGE plpgsql
AS $function$
---------------------------------------------------------------------------------------
-- This extract derives all the children in CJAMS, who have been in foster care for 
-- atleast 1 day, in the current state fiscal year(starting 7/1 and ending 6/30)
-- Note: This excludes the same day returns and those clients whose removal has been in review.
-- Revision Log:
-- DATE					AUTHOR					COMMENTS
-- 05/28/2020			Sarma Bandi				Initial Draft
-- 07/22/2020			Sarma Bandi				Commenting out the Load date field in the final output
--											   ,for the CJAMS statewide cutover
-- 09/20/2022 Vineet Tirodkar - Type casting fixes for Aurora DB migration 
-- 05/06/2025 Vineet Tirodkar - To fix the client placement location address logic (CIDM-10466)
---------------------------------------------------------------------------------------
BEGIN

DROP TABLE IF EXISTS tmp_msde_extract;

CREATE TEMP TABLE tmp_msde_extract
				(CL_ID 			char(9),
				 STATUS 		char(1),
				 CATEGORY 		char(3),
				 DOB_DT 		char(8),
				 LDSS 			char(2),
				 FIRST_NM 		char(30),
				 LAST_NM 		char(30),
				 MIDDLE_INITIAL char(30),
				 ADDRESS_LINE1 	char(40),
				 ADDRESS_LINE2 	char(5),
				 FILLER 		char(25),
				 CITY_NM 		char(30),
				 STATE_CD 		char(2),
				 PA_ADR_ZIP5_NO char(5),
				 SSN_NO 		char(9),
				 SASID 			char(10),
				 RACE 			char(1),
				 GENDER 		char(1),
				 LOAD_DT 		date
				 );
				 
-- Loading the result set of all the CJAMS clients
INSERT INTO tmp_msde_extract(CL_ID,STATUS,CATEGORY,DOB_DT,LDSS,FIRST_NM,LAST_NM,MIDDLE_INITIAL, 
							 ADDRESS_LINE1,ADDRESS_LINE2,FILLER,CITY_NM,STATE_CD,PA_ADR_ZIP5_NO, 
							 SSN_NO,SASID,RACE,GENDER,LOAD_DT
							 )
	with tmp_fy as (
	SELECT CASE WHEN extract(MONTH from CURRENT_DATE) BETWEEN 7 AND 12 THEN DATE('07/01/'||extract(YEAR from CURRENT_DATE))
				ELSE DATE('07/01/'||(extract(YEAR from CURRENT_DATE)-1))
				END AS FY_START_DT
		   , CASE WHEN extract(MONTH from CURRENT_DATE) BETWEEN 7 AND 12 THEN DATE('06/30/'||(extract(YEAR from CURRENT_DATE)+1))
				ELSE DATE('06/30/'||(extract(YEAR from CURRENT_DATE)))
				END AS FY_END_DT   
	) 

	, removals as (
		select pr.cjamspid as CL_ID,
			pr.firstname as firstname,
			pr.middlename as middlename,
			pr.lastname as lastname,
			cast(replace(to_char(pr.dob,'mm/dd/yyyy'), '/', '') as char(8)) as birthdate,
			(case when btrim(pr.gendertypekey) = 'M' Then	-- Male
				'M' -- Male 
			when btrim(pr.gendertypekey) = 'TGIF' Then -- Transgender- Identifies as Female
				'M' -- Male 
			when btrim(pr.gendertypekey) = 'TGIM' Then -- Transgender- Identifies as Male
				'F' -- Female 
			when btrim(pr.gendertypekey) = 'F' Then -- Female	
				'F' -- Female 
			-- Changes for newly added gender type/substype 
			when btrim(pr.gendertypekey) = 'O' and pr.othergendertypekey = 0 then -- Assigned Male at Birth *
				'M' -- Male 
			when btrim(pr.gendertypekey) = 'O' and pr.othergendertypekey = 1 then -- Assigned Female at Birth *
				'F' -- Female 
			else
				'O' -- Other
			end ) as gender,
			-- NULLIF(regexp_replace(pr.ssnno, '\D','','g'), '') as ssn,
			SUBSTR(LPAD(NULLIF(regexp_replace(pr.ssnno, '\D','','g'), '')::varchar,9,'0'), 1, 9) as ssn,
			(case when trim(pr.ethnicgrouptypekey) = 'H' THEN 
				'H'
			else
				(case when 
					(select count(*) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) > 0 then 'A' -- Asian
				when 
					(select count(*) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) > 0 then 'B' -- Black
				when 
					(select count(*) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) > 0 then 'C' -- Caucasian
				when 
					(select count(*) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN', 'PI')
					) > 0 then 'P' -- American Indian,Alaskan Native OR Native Hawaiian/Pacific Islander
				when 
					(select count(*) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) > 0 then 'U' -- unknown
				else 
					'O' -- Other	
				end)
			end) as race,
			rm.intakeservreqchildremovalid,
			rm.removaldate::date as removal_date, 
			rm.exitdate::date as removal_exit_date,
			rm.personid,
			( select c.countyname 
				from caseassignment ca  
					join county c on c.countyid:: character varying = ca.toldssid::character varying
			  where ca.objectid = rm.servicecaseid
				 and lower(ca.responsibilitytypekey) = 'family'
					and ca.activeflag = 1
			  order by ca.insertedon desc
			  limit 1
			 ) as LDSS,
			 ROW_NUMBER() OVER(PARTITION BY pr.cjamspid 
				ORDER BY COALESCE(rm.exitdate,'9999-12-31'::date) DESC, rm.removaldate DESC) rem_rank
		from tmp_fy,
			intakeservreqchildremoval rm
			join person pr on pr.personid = rm.personid 
				and pr.activeflag = 1
			join servicecase sc on sc.servicecaseid = rm.servicecaseid 
				and sc.activeflag = 1
		where rm.activeflag  = '1'
			and ( select count(*) 
					from routing rur
				where rur.objectid = rm.intakeservreqchildremovalid::character varying
					and rur.eventcode = 'CHRR'
					and rur.activeflag = 1
					and rur.routingstatustypeid = '16'
				) > 0
			and rm.removaldate <= tmp_fy.FY_END_DT 
			and (rm.exitdate IS NULL OR rm.exitdate >= tmp_fy.FY_START_DT)
			and COALESCE(rm.exitdate,'9999-12-31') <> rm.removaldate
			-- Unit Test
			-- and pr.cjamspid in (1701170, 1701244, 4415503, 4407693, 3504092) 
		)
		-- select * from removals  where rem_rank = 1      
	,
	placements as (
		select *,
				(case when provadd.adr_format_cd = 'S' then 
					coalesce(provadd.adr_street_tx,'') || ' ' ||
					coalesce((	select coalesce(value_tx,'') 
							from tb_picklist_values 
						where trim(picklist_value_cd) in (trim(provadd.adr_pre_dir_cd)) 
							and picklist_type_id = '69'),'') || ' ' ||
					coalesce(provadd.adr_street_nm,'') || ' ' ||
					coalesce((	select coalesce(value_tx,'') 
							from tb_picklist_values 
						where trim(picklist_value_cd) in ( trim(provadd.adr_street_suffix_cd) ) 
							and picklist_type_id = '212'
					),'')
				when provadd.adr_format_cd = 'R' then
					coalesce('Rural Rte','') || ' ' ||
					coalesce(provadd.adr_street_tx,'') || ' ' ||
					(case when provadd.adr_box_no is not null then
						'Box Number ' || coalesce(provadd.adr_box_no :: character varying,'')
					end)
				when provadd.adr_format_cd = 'F' then
					coalesce(provadd.adr_foreign_tx,'')
				when provadd.adr_format_cd = 'P' then   
					coalesce('PO Box','')  || ' ' ||
						coalesce(provadd.adr_box_no :: character varying,'')
				when lgr.streetname is null then
					'Unknown'
				else -- LA
					lgr.streetname      
				end) as "address1",
				
				(case when tab_plc.provider_id is not null and provadd.adr_format_cd = 'S' then 
					coalesce((	select value_tx 
									from tb_picklist_values 
								where trim(picklist_value_cd) in (trim(provadd.adr_unit_type_cd) )
								and picklist_type_id = '250'
							),'') || ' ' ||
							coalesce(provadd.adr_unit_no_tx,'') 
				when tab_plc.provider_id is not null and provadd.adr_format_cd = 'F' then           
					provadd.adr_country_tx
				else -- LA  
					lgr.streettext  
				end ) as "address2",
				
			(case when tab_plc.provider_id is not null then
					provadd.adr_city_nm 
				else -- LA
					lgr.cityname
				end ) as "city",

				(case when tab_plc.provider_id is not null and provadd.adr_format_cd = 'F' then 
					null
				when tab_plc.provider_id is not null then   
					provadd.adr_state_cd 
				else   -- LA 
					lgr.statetypekey    
				end) as "state",
				
				(case when tab_plc.provider_id is not null and provadd.adr_format_cd = 'F' then
					provadd.adr_postal_code_tx::character varying
				when tab_plc.provider_id is not null then
					provadd.adr_zip5_no::character varying 
				else -- LA
					lgr.zip5no::character varying   
				end) as "zip",
			-- Get the active placement as provider placement, else the living arrangement.
			RANK() OVER(PARTITION BY tab_plc.intakeservreqchildremovalid
						order by
						(case when tab_plc.placement_exit_date is null 
							and tab_plc.provider_id is null then -- 'Living Arrangement'
								1 
						 when tab_plc.placement_exit_date is null 
							and tab_plc.provider_id is not null then -- Provider Placements
								2 
						 else 
								3     
						end)
						, tab_plc.placement_entry_date desc
						, tab_plc.alternateid desc
				) as placement_rnk
		from (
		select 'Public Provider Placement' as "Placement Type",
			pl.alternateid,
			pl.altproviderid as provider_id,
			pl.startdatetime::date as placement_entry_date,
			pl.enddatetime::date as placement_exit_date,
			rm.intakeservreqchildremovalid,
			null::uuid as livingid
		from removals rm,
			placement pl
		WHERE pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
			and COALESCE(pl.isvoided, 0) <> 1 
			and pl.altproviderid is not null
			and pl.contractprogramid is null -- Public Provider Placement
			and (SELECT count(*) 
					FROM routing
				WHERE routing.routingstatustypeid = 16 
					AND routing.eventcode::text = 'PLTR'::text 
					AND routing.activeflag = 1 
					AND routing.objectid::text = pl.placementid::character varying::text
				) > 0
		union all
		select 'Private Provider Placement' as "Placement Type",
			pl.alternateid,
			coalesce(cpa.altproviderid, pl.altproviderid) as provider_id,
			coalesce(cpa.entrydt::date, pl.startdatetime::date) as placement_entry_date,
			coalesce(cpa.exitdt::date,	pl.enddatetime::date) as placement_exit_date,
			rm.intakeservreqchildremovalid,
			null::uuid as livingid
		from removals rm,
			placement pl
			left join placementcpahomes cpa on cpa.placementid = pl.placementid
				and cpa.activeflag = 1
				and cpa.entrydt is not null
				and cpa.exitdt is null
		WHERE pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
			and COALESCE(pl.isvoided, 0) <> 1 
			and pl.altproviderid is not null
			and pl.contractprogramid is not null -- Private Provider Placement
			and (SELECT count(*) 
					FROM routing
				WHERE routing.routingstatustypeid = 16 
					AND routing.eventcode::text = 'PLTR'::text 
					AND routing.activeflag = 1 
					AND routing.objectid::text = pl.placementid::character varying::text
				) > 0 
		union all   
		select 'Living Arrangement' as "Placement Type",
			pl.alternateid,
			NULL as provider_id,
			pl.startdatetime::date as placement_entry_date,
			pl.enddatetime::date as placement_exit_date,
			rm.intakeservreqchildremovalid,
			la.livingid 
		from removals rm,
			placement pl,
			livingarrangement la
		where rm.personid = pl.personid
			and pl.placementid = la.placementid
			and pl.activeflag = 1
			and la.activeflag = 1
			and pl.altproviderid is null
			and ( SELECT count(*) AS count
					FROM routing
				WHERE routing.routingstatustypeid = 16 
					AND routing.eventcode::text = 'PLTR'::text 
					AND routing.activeflag = 1 
					AND routing.objectid::text = pl.placementid::character varying::text
				) > 0 
			and pl.startdatetime::date <= coalesce(rm.removal_exit_date, current_date)
			and (pl.enddatetime is null or pl.enddatetime::date >= rm.removal_date)
			and btrim(la.livingarrangementtypekey) NOT In ('32944', 'PLMT', 'RNW', 'UNK', 'HMLS', 'ADPN')
		) tab_plc 
			left join prov.tb_provider_addresses provadd on provadd.parent_key_id::bigint = tab_plc.provider_id
				and provadd.delete_sw  = 'N'
				and provadd.adr_type_cd = '3357' -- Provider location
				and provadd.adr_default_sw = 'Y'
			left join livingarrangement lgr on lgr.livingid  = tab_plc.livingid     
				and lgr.activeflag = 1
		order by tab_plc.intakeservreqchildremovalid, tab_plc.placement_entry_date desc 
	) 

	select lpad(rem.CL_ID::varchar,9,'0') as CL_ID
		,'A' as Status
		,'FTR' AS CATEGORY
		,CAST(rem.birthdate AS CHAR(8)) AS DOB_DT
		,CAST(
		(	case when  lower(btrim(rem.ldss)) = lower('Allegany') then '01' 		-- 1427
				when lower(btrim(rem.ldss)) = lower('Anne Arundel') then '02' 		-- 1428
				when lower(btrim(rem.ldss)) = lower('Baltimore County') then '03'	-- 1430
				when lower(btrim(rem.ldss)) = lower('Calvert') then '04' 			-- 1431
				when lower(btrim(rem.ldss)) = lower('Caroline') then '05' 			-- 1432
				when lower(btrim(rem.ldss)) = lower('Carroll') then '06'			-- 1433
				when lower(btrim(rem.ldss)) = lower('Cecil') then '07' 				-- 1434
				when lower(btrim(rem.ldss)) = lower('Charles') then '08' 			-- 1435
				when lower(btrim(rem.ldss)) = lower('Dorchester') then '09' 		-- 1436
				when lower(btrim(rem.ldss)) = lower('Frederick') then '10' 			-- 1437
				when lower(btrim(rem.ldss)) = lower('Garrett') then '11' 			-- 1438
				when lower(btrim(rem.ldss)) = lower('Harford') then '12' 			-- 1439
				when lower(btrim(rem.ldss)) = lower('Howard') then '13'				-- 1440
				when lower(btrim(rem.ldss)) = lower('Kent') then '14' 				-- 1441
				when lower(btrim(rem.ldss)) = lower('Montgomery') then '15' 		-- 1442
				when lower(btrim(rem.ldss)) = lower('Prince George''s') then '16' 	-- 1443
				when lower(btrim(rem.ldss)) = lower('Queen Anne''s') then '17' 		-- 1444
				when lower(btrim(rem.ldss)) = lower('St. Mary''s') then '18' 		-- 1446
				when lower(btrim(rem.ldss)) = lower('Somerset') then '19' 			-- 1445
				when lower(btrim(rem.ldss)) = lower('Talbot') then '20' 			-- 1447
				when lower(btrim(rem.ldss)) = lower('Washington') then '21' 		-- 1448
				when lower(btrim(rem.ldss)) = lower('Wicomico') then '22' 			-- 1449
				when lower(btrim(rem.ldss)) = lower('Worcester') then '23'			-- 1450
				when lower(btrim(rem.ldss)) = lower('Baltimore City') then '30' 	-- 1429
				else '00'
			end
		) AS CHAR(2)) AS LDSS
		,CAST(rem.firstname AS CHAR(30)) AS FIRST_NM
		,CAST(rem.lastname AS CHAR(30)) AS LAST_NM
		,CAST(rem.middlename AS CHAR(30)) AS MIDDLE_INITIAL
		,CAST(coalesce(prpl.address1, 'Unknown') AS CHAR(40)) AS ADDRESS_LINE1
		,CAST(prpl.address2 AS CHAR(5)) AS ADDRESS_LINE2
		,CAST('' AS CHAR(25)) as FILLER
		,CAST(prpl.city AS CHAR(30)) AS CITY_NM
		,CAST(prpl.state AS CHAR(2)) AS STATE_CD
		,CAST(prpl.zip AS CHAR(5)) AS PA_ADR_ZIP5_NO
		,CAST(SUBSTR(LPAD(COALESCE(rem.ssn::varchar,''),9,'0'), 1, 9) AS CHAR(9)) as SSN_NO
		,CAST('' AS CHAR(10)) AS SASID
		,CAST(rem.race AS CHAR(1)) AS RACE
		,CAST(rem.gender AS CHAR(1)) AS GENDER
		,CURRENT_DATE AS LOAD_DT
	from removals rem
		left join placements prpl 
			on rem.intakeservreqchildremovalid = prpl.intakeservreqchildremovalid
				and prpl.placement_rnk = 1
	where rem.rem_rank = 1            
	order by rem.CL_ID;

-- Insert records into history table
INSERT INTO CJAMS.cjams_msde_Load_hist
(LOAD_ID,CL_ID,STATUS,CATEGORY,DOB_DT,LDSS,FIRST_NM,LAST_NM,MIDDLE_INITIAL, 
ADDRESS_LINE1,ADDRESS_LINE2,FILLER,CITY_NM,STATE_CD,PA_ADR_ZIP5_NO, 
SSN_NO,SASID,RACE,GENDER,LOAD_DT
)
SELECT COALESCE((SELECT MAX(LOAD_ID)+1 FROM CJAMS.cjams_msde_Load_hist),1) AS LOAD_ID 
	   ,t1.CL_ID,t1.STATUS,t1.CATEGORY,t1.DOB_DT,t1.LDSS,t1.FIRST_NM,t1.LAST_NM,t1.MIDDLE_INITIAL, 
		t1.ADDRESS_LINE1,t1.ADDRESS_LINE2,t1.FILLER,t1.CITY_NM,t1.STATE_CD,t1.PA_ADR_ZIP5_NO, 
		t1.SSN_NO,t1.SASID,t1.RACE,t1.GENDER,t1.LOAD_DT
  FROM tmp_msde_extract t1
;
RETURN QUERY 
SELECT tme.CL_ID,tme.STATUS,tme.CATEGORY,tme.DOB_DT,tme.LDSS,tme.FIRST_NM,tme.LAST_NM,tme.MIDDLE_INITIAL, 
	   tme.ADDRESS_LINE1,tme.ADDRESS_LINE2,tme.FILLER,tme.CITY_NM,tme.STATE_CD,tme.PA_ADR_ZIP5_NO, 
	   tme.SSN_NO,tme.SASID,tme.RACE,tme.GENDER
FROM tmp_msde_extract tme
;

END

$function$
;
