DROP FUNCTION IF EXISTS cjams.sp_gap_worksheet_guardian_info(vd_providerapprovalid integer);
CREATE OR REPLACE FUNCTION cjams.sp_gap_worksheet_guardian_info(vd_providerapprovalid integer)
 RETURNS TABLE(primaryguardianinfo json, secondaryguardianinfo json, householdmeminfo json)
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 01/30/2024 Vineet Tirodkar - Modifications for Background Check Dates logic (CDM-36080)
-- 02/23/2024 Smitha Somasekharan-CIDM-8351-b-185141-gapdetermination userstory changes
-- 04/05/2024 Vinesh Puthan-CIDM-8581-Getting server error - Title IV-E Gap initial determination
-- 05/16/2024 Vinesh Puthan- CDM-38365- Date of Home Approval Feature 
-- 11/21/2024 Naresh Moola - CIDM-9814 - IV-E GAP - Throwing server error when selecting date
------------------------------------------------------------------------------------------------------------	
DECLARE 
		vs_Procedure_nm 										VARCHAR(100) DEFAULT 'sp_gap_worksheet_guardian_info';	
		vn_ive_primary_guardian									JSON;
		vn_ive_secondary_guardian								JSON;
		vn_ive_household_mem									JSON;
		vd_full_apprvl_id										int;
		
		vd_ha_approval_dt										Date;
		vl_pubprovapphouseholdbgchecks							Integer;
		vn_provider_id                                          Integer;
		
BEGIN	
	CREATE TEMP TABLE IF NOT EXISTS
	Temp_worksheet_guardian_info ( 
			primaryguardianinfo										JSON,
			secondaryguardianinfo									JSON,
			householdmeminfo										JSON
		);	
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																 
	-- Primary Guardian Info
	-- Applicant
	vl_pubprovapphouseholdbgchecks := 0 ;

	select provider_id into vn_provider_id from tb_provider_approval 
							where provider_approval_id = vd_providerapprovalid;

	select count(*)
		into vl_pubprovapphouseholdbgchecks
	from pubprovapphouseholdbgchecks
	where objectid = (select  pap.applicant_id from tb_provider_approval tpa 
join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1)
		and delete_sw = 'N'
		and active_sw = 'Y' ;
		
	if vl_pubprovapphouseholdbgchecks > 0 then
		select json_agg(json_build_object(                                                                                                                     
						 'approvalid', vd_providerapprovalid,
						 'persontypecode', '3610',                                                                                                    
						 'persontype', 'Applicant',                                                                                                    
						 'name', tab.client_name,   
						 'dob', tab.dob,                                                                                            
						 'statebackgrounddate', tab.mdClearance_date, 
						 'federalbackgrounddate', tab.fbiClearance_date,
						 'childabusemaltdatacheck', childProtectiveServ_date,
						 'oospast5years',tab.outOfState_5years,
						 'ossmdClearance_date',tab.ossmdClearance_date --incorrect name corrected						 
				 ))                                                                                                                                                     
			INTO vn_ive_primary_guardian 
		from (
		select COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date,
			(((tppa.app_information->>'is_applicant_oos'))) as outOfState_5years,
			(((submission_data -> 'outOfStateClearences' -> 0 ->> 'clearance_date'))) as ossmdClearance_date
 
		from pubprovapphouseholdbgchecks pgc
		left join tb_public_provider_applicant tppa on tppa.applicant_id =pgc.objectid
			join person pr1 on pr1.personid = pgc.personid
					and pr1.activeflag = 1
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and(

			pgc.objectid = (select  pap.applicant_id from tb_provider_approval tpa 
		join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
		join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
		where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1))
			
			and pgc.personid in (
				SELECT isr.personid
				FROM intakeservicerequestactor isr
				JOIN person pr ON isr.personid = pr.personid
				WHERE isr.objectid = (
					SELECT CAST(provider_id AS character varying)
					FROM tb_provider_approval tpa
					WHERE tpa.provider_approval_id = vd_providerapprovalid
				) 
				
				AND isr.intakeservicerequestpersontypekey = 'APLCNT' -- Applicant
				AND isr.activeflag = 1
				)
		order by pgc.create_ts desc
		limit 1
		) tab;	    	    
	else
		select json_agg(json_build_object(                                                                                                                     
						 'approvalid', vd_providerapprovalid,
						 'persontypecode', '3610',                                                                                                    
						 'persontype', 'Applicant',                                                                                                    
						 'name', tab.client_name,   
						 'dob', tab.dob,                                                                                            
						 'statebackgrounddate', tab.mdClearance_date, 
						 'federalbackgrounddate', tab.fbiClearance_date,
						 'childabusemaltdatacheck', childProtectiveServ_date,
						 'oospast5years',tab.outOfState_5years,
						 'ossmdClearance_date',tab.ossmdClearance_date --incorrect name corrected						 
				 ))	INTO vn_ive_primary_guardian  
		FROM  (
		select COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date,
			(((tppa.app_information->>'is_applicant_oos'))) as outOfState_5years,
			(((submission_data -> 'outOfStateClearences' -> 0 ->> 'clearance_date'))) as ossmdClearance_date
 
		from pubprovapphouseholdbgchecks pgc
		left join tb_public_provider_applicant tppa on tppa.applicant_id =pgc.objectid
			join person pr1 on pr1.personid = pgc.personid
					and pr1.activeflag = 1
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and(

			pgc.objectid =(select tpa.applicant_id  from tb_public_provider_applicant tpa
		join providerapprovalphaserecord pap on  pap.applicant_id = tpa.applicant_id
		join tb_provider_approval ta on ta.approval_status_cd = '3579' and active_sw='Y'
		where pap.provider_id = vn_provider_id ::character varying and ta.provider_approval_id = vd_providerapprovalid and tpa.update_ts::date < ta.approval_dt :: date 
		and tpa.application_typecode in ('ARECONSIDER','INITIAL','APPLCHANGE','CONVPROV','REOPENPROV')and tpa.delete_sw='N' order by tpa.update_ts desc limit 1))
		and pgc.personid in (
			SELECT isr.personid
			FROM intakeservicerequestactor isr
			JOIN person pr ON isr.personid = pr.personid
			WHERE isr.objectid = (
				SELECT CAST(provider_id AS character varying)
				FROM tb_provider_approval tpa
				WHERE tpa.provider_approval_id = vd_providerapprovalid
			) 
			AND isr.intakeservicerequestpersontypekey = 'APLCNT' -- Applicant
			AND isr.activeflag = 1
			)
		order by pgc.create_ts desc
		limit 1
		) tab ;
		if vn_ive_primary_guardian is null then
			SELECT json_agg(json_build_object(                                                                                                                     
					'approvalid', tpap.provider_approval_id ,                                                                                                       
					'persontypecode', tpap.person_type_cd,                                                                                                    
					'persontype', (SELECT pv.VALUE_TX FROM tb_picklist_values pv WHERE tpap.person_type_cd = pv.PICKLIST_VALUE_CD AND pv.PICKLIST_TYPE_ID = 371),                                                                                                    
					'name', COALESCE(tpap.first_nm,' ') || ' '||COALESCE(tpap.middle_nm,' ')||' '||COALESCE(tpap.last_nm,' '),   
					'dob',  tpap.dob_dt,                                                                                            
					'statebackgrounddate', tpap.state_complete_dt, 
					'federalbackgrounddate', tpap.federal_complete_dt,
					'childabusemaltdatacheck', tpap.cps_dt
					))                                                                                                                                                     
				INTO vn_ive_primary_guardian  
			FROM 
				tb_prov_approval_person tpap 
			WHERE tpap.provider_approval_id = vd_providerapprovalid 
				and tpap.DELETE_SW = 'N'
				and tpap.person_type_cd in ('3610');
		end if;
	end if;


	-- Secondary Guardian Info
	-- Co-Applicant
	vl_pubprovapphouseholdbgchecks := 0 ;

	select count(*)
		into vl_pubprovapphouseholdbgchecks
	from pubprovapphouseholdbgchecks
	where objectid = (select  pap.applicant_id from tb_provider_approval tpa 
	join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
	join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
	where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1)
			and delete_sw = 'N'
			and active_sw = 'Y' ;
		
	if vl_pubprovapphouseholdbgchecks > 0 then
		select json_agg(json_build_object(                                                                                                                     
						 'approvalid', vd_providerapprovalid,
						 'persontypecode', '3611',                                                                                                    
						 'persontype', 'Co-Applicant',                                                                                                    
						 'name', tab.client_name,   
						 'dob', tab.dob,                                                                                            
						 'statebackgrounddate', tab.mdClearance_date, 
						 'federalbackgrounddate', tab.fbiClearance_date,
						 'childabusemaltdatacheck', childProtectiveServ_date,
						 'oospast5years',tab.outOfState_5years,
						 'Dateofchildabuseoss',tab.Dateofchildabuseoss 
				 ))                                                                                                                                                     
			INTO vn_ive_secondary_guardian 
		from (
		select COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date')))as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date,
			(((tppa.app_information->>'is_coapplicant_oos'))) as outOfState_5years,
			(((submission_data -> 'outOfStateClearences' -> 0 ->> 'clearance_date'))) as Dateofchildabuseoss 

		from pubprovapphouseholdbgchecks pgc
		left join tb_public_provider_applicant tppa on tppa.applicant_id =pgc.objectid
			join person pr1 on pr1.personid = pgc.personid
					and pr1.activeflag = 1
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and( pgc.objectid = (select  pap.applicant_id from tb_provider_approval tpa 
			join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
			join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
			where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1))
						and pgc.personid in (
							SELECT isr.personid
							FROM intakeservicerequestactor isr
							JOIN person pr ON isr.personid = pr.personid
							WHERE isr.objectid = (
								SELECT CAST(provider_id AS character varying)
								FROM tb_provider_approval tpa
								WHERE tpa.provider_approval_id = vd_providerapprovalid
							)
				AND isr.intakeservicerequestpersontypekey = 'COAPLCNT' -- Co-Applicant
				)
		order by pgc.create_ts desc
		limit 1
		) tab;	   

	else
		SELECT json_agg(json_build_object(                                                                                                                     
						 'approvalid', vd_providerapprovalid,
						 'persontypecode', '3611',                                                                                                    
						 'persontype', 'Co-Applicant',                                                                                                    
						 'name', tab.client_name,   
						 'dob', tab.dob,                                                                                            
						 'statebackgrounddate', tab.mdClearance_date, 
						 'federalbackgrounddate', tab.fbiClearance_date,
						 'childabusemaltdatacheck', childProtectiveServ_date,
						 'oospast5years',tab.outOfState_5years,
						 'Dateofchildabuseoss',tab.Dateofchildabuseoss 
				 ))                                                                                                                                                     
			INTO vn_ive_secondary_guardian     
			FROM  (
		select COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date,
			(((tppa.app_information->>'is_applicant_oos'))) as outOfState_5years,
			(((submission_data -> 'outOfStateClearences' -> 0 ->> 'clearance_date'))) as Dateofchildabuseoss --incorrect name corrected
 
		from pubprovapphouseholdbgchecks pgc
		left join tb_public_provider_applicant tppa on tppa.applicant_id =pgc.objectid
			join person pr1 on pr1.personid = pgc.personid
					and pr1.activeflag = 1
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and(

			pgc.objectid =(select tpa.applicant_id  from tb_public_provider_applicant tpa
		join providerapprovalphaserecord pap on  pap.applicant_id = tpa.applicant_id
		join tb_provider_approval ta on ta.approval_status_cd = '3579' and active_sw='Y'
		where pap.provider_id = vn_provider_id ::character varying and ta.provider_approval_id = vd_providerapprovalid and tpa.update_ts::date < ta.approval_dt :: date 
		and tpa.application_typecode in ('ARECONSIDER','INITIAL','APPLCHANGE','CONVPROV','REOPENPROV')and tpa.delete_sw='N' order by tpa.update_ts desc limit 1))

			and pgc.personid in (
				SELECT isr.personid
				FROM intakeservicerequestactor isr
				JOIN person pr ON isr.personid = pr.personid
				WHERE isr.objectid = (
					SELECT CAST(provider_id AS character varying)
					FROM tb_provider_approval tpa
					WHERE tpa.provider_approval_id = vd_providerapprovalid
				) 
				AND isr.intakeservicerequestpersontypekey = 'COAPLCNT' -- Applicant
				AND isr.activeflag = 1
				)
		order by pgc.create_ts desc
		limit 1
		) tab  ;
		if vn_ive_secondary_guardian is null then
			SELECT json_agg(json_build_object(                                                                                                                     
					'approvalid', tpap.provider_approval_id ,                                                                                                       
					'persontypecode', tpap.person_type_cd,                                                                                                    
					'persontype', (SELECT pv.VALUE_TX FROM tb_picklist_values pv WHERE tpap.person_type_cd = pv.PICKLIST_VALUE_CD AND pv.PICKLIST_TYPE_ID = 371),                                                                                                    
					'name', COALESCE(tpap.first_nm,' ') || ' '||COALESCE(tpap.middle_nm,' ')||' '||COALESCE(tpap.last_nm,' '),   
					'dob',  tpap.dob_dt,                                                                                            
					'statebackgrounddate', tpap.state_complete_dt,
					'federalbackgrounddate', tpap.federal_complete_dt,
					'childabusemaltdatacheck', tpap.cps_dt
					))                                                                                                                                                     
				INTO vn_ive_secondary_guardian     
			FROM 
				tb_prov_approval_person tpap 
			WHERE tpap.provider_approval_id = vd_providerapprovalid 
				and tpap.DELETE_SW = 'N' 
				and tpap.person_type_cd in ('3611');
		end if;		
	end if;

 
	-- Household members Info
	vl_pubprovapphouseholdbgchecks := 0 ;

	select count(*)
		into vl_pubprovapphouseholdbgchecks
	from pubprovapphouseholdbgchecks
	where objectid = (select  pap.applicant_id from tb_provider_approval tpa 
	join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
	join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
	where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1 )
	and delete_sw = 'N'
	and active_sw = 'Y' ;
	
	select ha_approval_dt
		into vd_ha_approval_dt
	from prov.tb_provider_approval 
	where provider_approval_id = vd_providerapprovalid ;
								
	if vl_pubprovapphouseholdbgchecks > 0 then
		select json_agg(json_build_object(                                                                                                                     
						 'approvalid', vd_providerapprovalid,
						 'persontypecode', tab.persontypecode,                                                                                                    
						 'persontype', tab.persontype,                                                                                                    
						 'name', tab.client_name,   
						 'dob', tab.dob,                                                                                            
						 'statebackgrounddate', tab.mdClearance_date, 
						 'federalbackgrounddate', tab.fbiClearance_date,
						 'childabusemaltdatacheck', childProtectiveServ_date
				 ))                                                                                                                                                     
			INTO vn_ive_household_mem 
		from (
		select '3612' as persontypecode, -- Child
			'Child' as persontype,
			COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date
		from pubprovapphouseholdbgchecks pgc
			join person pr1 on pr1.personid = pgc.personid
				and pr1.activeflag = 1
				and (vd_ha_approval_dt::date > (pr1.dob + interval '18 years')::date)
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and pgc.objectid = (select  pap.applicant_id from tb_provider_approval tpa 
		join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
		join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
		where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1)
		and pgc.personid in (
			SELECT isr.personid
			FROM intakeservicerequestactor isr
			JOIN person pr ON isr.personid = pr.personid
			WHERE isr.objectid= (
				SELECT CAST(provider_id AS character varying)
				FROM tb_provider_approval tpa
				WHERE tpa.provider_approval_id = vd_providerapprovalid
			)
			AND isr.intakeservicerequestpersontypekey = 'CHILD' -- Child
			)
		-- order by pgc.create_ts desc
		-- limit 1
		union all
		select '3613' as persontypecode, -- Other Household member
			'Other Household member' as persontype,
			COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date
		from pubprovapphouseholdbgchecks pgc
			join person pr1 on pr1.personid = pgc.personid
					and pr1.activeflag = 1
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and pgc.objectid = (select  pap.applicant_id from tb_provider_approval tpa 
			join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
			join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
			where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1 )
			and pgc.personid in (
				SELECT isr.personid
				FROM intakeservicerequestactor isr
				JOIN person pr ON isr.personid = pr.personid
				WHERE isr.objectid::text = (
					SELECT CAST(provider_id AS TEXT)
					FROM tb_provider_approval tpa
					WHERE tpa.provider_approval_id = vd_providerapprovalid
				)
				AND isr.intakeservicerequestpersontypekey = 'OTHHM' -- Other Household member
				)
		-- order by pgc.create_ts desc
		-- limit 1
		) tab;		
	else
	select json_agg(json_build_object(                                                                                                                     
						 'approvalid', vd_providerapprovalid,
						 'persontypecode', tab.persontypecode,                                                                                                    
						 'persontype', tab.persontype,                                                                                                    
						 'name', tab.client_name,   
						 'dob', tab.dob,                                                                                            
						 'statebackgrounddate', tab.mdClearance_date, 
						 'federalbackgrounddate', tab.fbiClearance_date,
						 'childabusemaltdatacheck', childProtectiveServ_date
				 ))                                                                                                                                                     
			INTO vn_ive_household_mem 
		from (
		select '3612' as persontypecode, -- Child
			'Child' as persontype,
			COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date
		from pubprovapphouseholdbgchecks pgc
			join person pr1 on pr1.personid = pgc.personid
				and pr1.activeflag = 1
				and (vd_ha_approval_dt::date > (pr1.dob + interval '18 years')::date)
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and pgc.objectid = (select tpa.applicant_id  from tb_public_provider_applicant tpa
		join providerapprovalphaserecord pap on  pap.applicant_id = tpa.applicant_id
		join tb_provider_approval ta on ta.approval_status_cd = '3579' and active_sw='Y'
		where pap.provider_id = vn_provider_id ::character varying and ta.provider_approval_id = vd_providerapprovalid and tpa.update_ts::date < ta.approval_dt :: date 
		and tpa.application_typecode in ('ARECONSIDER','INITIAL','APPLCHANGE','CONVPROV','REOPENPROV')and tpa.delete_sw='N' order by tpa.update_ts desc limit 1)

			and pgc.personid in (
				SELECT isr.personid
				FROM intakeservicerequestactor isr
				JOIN person pr ON isr.personid = pr.personid
				WHERE isr.objectid= (
					SELECT CAST(provider_id AS character varying)
					FROM tb_provider_approval tpa
					WHERE tpa.provider_approval_id = vd_providerapprovalid
				)
				AND isr.intakeservicerequestpersontypekey = 'CHILD' -- Child
				)
		-- order by pgc.create_ts desc
		-- limit 1
		union all
		select '3613' as persontypecode, -- Other Household member
			'Other Household member' as persontype,
			COALESCE(pr1.firstname,' ') || ' '||COALESCE(pr1.middlename,' ')||' '||COALESCE(pr1.lastname,' ') as client_name,
			pr1.dob::date as dob,
			(((criminal_history_check_data -> 'mdClearance' ->> 'clearance_date'))) as mdClearance_date,
			(((criminal_history_check_data -> 'fbiClearance' ->> 'clearance_date'))) as fbiClearance_date,
			(((submission_data -> 'childProtectiveServ' ->> 'clearance_date'))) as childProtectiveServ_date
		from pubprovapphouseholdbgchecks pgc
			join person pr1 on pr1.personid = pgc.personid
				and pr1.activeflag = 1
		where pgc.active_sw = 'Y'
			and pgc.delete_sw = 'N'
			and pgc.objectid = (select  pap.applicant_id from tb_provider_approval tpa 
		join providerapprovalphaserecord pap on pap.provider_id = vn_provider_id ::character varying
		join tb_provider_decision tpd on tpd.decisiondate::date = tpa.approval_dt::date and tpd.objectid = pap.applicant_id
		where tpa.provider_id = vn_provider_id and tpa.provider_approval_id = vd_providerapprovalid and  tpa.approval_status_cd = '3579'  ORDER BY ha_approval_dt desc limit 1 )
			and pgc.personid in (
				SELECT isr.personid
				FROM intakeservicerequestactor isr
				JOIN person pr ON isr.personid = pr.personid
				WHERE isr.objectid::text = (
					SELECT CAST(provider_id AS TEXT)
					FROM tb_provider_approval tpa
					WHERE tpa.provider_approval_id = vd_providerapprovalid
				)
				AND isr.intakeservicerequestpersontypekey = 'OTHHM' -- Other Household member
				)
		-- order by pgc.create_ts desc
		-- limit 1
		) tab;

		if vn_ive_household_mem is null then
			SELECT json_agg(json_build_object(                                                                                                                     
				 'approvalid', tpap.provider_approval_id ,                                                                                                       
				 'persontypecode', tpap.person_type_cd,                                                                                                    
				 'persontype', (SELECT pv.VALUE_TX FROM tb_picklist_values pv WHERE tpap.person_type_cd = pv.PICKLIST_VALUE_CD AND pv.PICKLIST_TYPE_ID = 371),                                                                                                    
				 'name', COALESCE(tpap.first_nm,' ') || ' '||COALESCE(tpap.middle_nm,' ')||' '||COALESCE(tpap.last_nm,' '),   
				 'dob', tpap.dob_dt,                                                                                            
				 'statebackgrounddate', TPAP2.state_complete_dt,
				 'federalbackgrounddate', TPAP2.federal_complete_dt,                                                                                                      
				 'childabusemaltdatacheck', TPAP2.cps_dt                                                                                                                    
		 ))                                                                                                                                                     
				 INTO vn_ive_household_mem  
			FROM 
				tb_prov_approval_person tpap 
				left join (select min(tpap2.approval_person_id) as approval_person_id, tpap2.dob_dt, tpap2.ssn_no, tpap2.first_nm, tpap2.last_nm
						from tb_provider_approval tpa
						join tb_provider_approval tpa1 on tpa.provider_id = tpa1.provider_id
						join tb_prov_approval_person tpap2 on tpap2.provider_approval_id = tpa1.provider_approval_id
						where tpa.provider_approval_id = vd_providerapprovalid
							 and tpa.approval_status_cd = '3579' 
							 and tpap2.DELETE_SW = 'N' 
							 and tpap2.person_type_cd in ('3612', '3613') 
							 and (tpa1.ha_approval_dt > (tpap2.dob_dt + interval '18 years'))
						group by tpap2.dob_dt, tpap2.ssn_no, tpap2.first_nm, tpap2.last_nm 
					) AS TPAP1 on TPAP1.first_nm = tpap.first_nm 
						and TPAP1.last_nm = tpap.last_nm 
						and TPAP1.dob_dt = tpap.dob_dt  	
				left join tb_prov_approval_person TPAP2 on TPAP2.approval_person_id = TPAP1.approval_person_id 	
			WHERE tpap.provider_approval_id = vd_providerapprovalid 
				and tpap.DELETE_SW = 'N' 
				and tpap.person_type_cd in ('3612', '3613');
		end if;
	end if;
INSERT INTO Temp_worksheet_guardian_info
SELECT 
		vn_ive_primary_guardian,
		vn_ive_secondary_guardian,
		vn_ive_household_mem;		
   	
RETURN QUERY SELECT *
               FROM Temp_worksheet_guardian_info;
              
DROP TABLE Temp_worksheet_guardian_info;

   END
    $function$
;
