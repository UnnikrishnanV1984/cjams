-- DROP FUNCTION if exists cjams.getresponsetimerdetails(uuid);
DROP FUNCTION if exists cjams.getresponsetimerdetails(uuid, character varying);
DROP FUNCTION if exists cjams.getresponsetimerdetails(uuid, character varying,int,character varying);
DROP FUNCTION if exists cjams.getresponsetimerdetails(uuid, character varying,int,character varying, integer);
DROP FUNCTION if exists cjams.getresponsetimerdetails(uuid, character varying,int, integer);

CREATE OR REPLACE FUNCTION cjams.getresponsetimerdetails(v_intakeserviceid uuid,
														v_request_type character varying default NULL,
														isExpungementSuperUser integer DEFAULT 0,
														isexpunged integer DEFAULT 0::integer
														) 	
RETURNS TABLE(	alleged_victim_contact_sw character varying,
				alleged_victim_contact_ts timestamp,
				icc_contact_sw character varying,
				icc_contact_ts timestamp,
				other_children_contact_sw character varying,
				other_children_contact_ts timestamp,
				reporteddate timestamp,
				responsetimer timestamp,
				malt_type character varying,
				responsetimer_duedate timestamp,
				responsetimer_status character varying,
				responsetimer_duedate_formatted character varying
			 )
LANGUAGE plpgsql 
AS $function$ 
-------------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created : 08/30/2022
-- To Get CPS Response Timer Details (CIDM-5447 - B-143046)

-- Argument(s): 1) IN v_intakeserviceid - CPS ID
			
-- Revision(s)
-- 09/12/2022 - Vineet Tirodkar - To verify the Response Timer value/status (CIDM-5447/B-144171)
-- 09/28/2022 - Vineet Tirodkar - Changes to remove 'Child' Role for Other Childrens Logic (CIDM-5447/B-144171)
-- 09/29/2022 - Vineet Tirodkar - Changes to verify if contact data entry was On-time/late (CIDM-5447/B-144171)
-- 10/03/2022 - Vineet Tirodkar - Changes to verify if contact date for entry was On-time/late (CIDM-5447/B-144171)
-- 11/28/2022 - Vigneshwar Kumar - Changes to daylight saving conflicts (CDM-26648)
-- 11/30 - Veera - Return error issue fix
-- 04/28/2023 Vineet Tirodkar - Modifications to check for in Home Response Timer flag for newly added clients (CIDM-7055/B-156868))
-- 08/03/2023 Vineet Tirodkar - Modifications for all Child & Other Child persons are NOT part of Initial Response (CDM-33396)
-- 01/22/2024 Anil Dharni - CPS Child Fatality Story - Modification based on date of death (CIDM-10009)
-- 07/09/2025 - Sandeep Kiran Anugolu - Changes to get response timer and date for approved records from pathway change in sdm (CIDM-10637) 
-- 01/29/2026 — Umasankar Raavi — Added `ismalpa_laborTrafficking` column per the “Add Labor Trafficking to SDM as Physical Abuse Sub-Category” user story
-------------------------------------------------------------------------------------------------------------
declare vs_cpstype character varying; 
declare vs_roletype character varying; 
declare vs_alleged_victim_contact_sw character varying;
declare vs_icc_contact_sw character varying;
declare vs_other_children_contact_sw character varying;
declare vs_responsetimer_status	character varying;
declare vs_malt_type character varying;

declare vt_responsetimer timestamp;
declare vt_contactdate timestamp;
declare vt_finalresponsetime  timestamp;
declare vt_reporteddate timestamp;
declare vt_responsetimer_duedate timestamp;
declare vt_alleged_victim_contact_ts timestamp;
declare vt_icc_contact_ts timestamp;
declare vt_other_children_contact_ts timestamp;
declare vt_insertedon timestamp;
declare vt_max_insertedon  timestamp;
declare vt_responsetimer_duedate_formatted character varying;

declare vl_icc_count integer;
declare vl_missing_info integer default 0;
declare vl_witsid bigint;
declare vl_allegedvictim_witsid bigint;
declare vl_caregiver_witsid bigint;
declare vl_otherchildren_witsid bigint;
declare vl_final_witsid bigint;
declare vl_icc_contact_count integer;
declare vl_response_timer_sw integer;

declare vu_personid uuid;

declare v_av_count integer default 0;
declare v_icc_count integer default 0;
declare v_child_count integer default 0;
declare v_total_child_count integer default 0;
declare v_timer_sw_no_child_count integer default 0;
declare v_intakenumber character varying;
declare v_isexpunged integer;

-- Alleged Victim
cur_victim_person record;
cur_victim_person_refcur REFCURSOR;

cur_icc_person record;
cur_icc_person_refcur REFCURSOR;

cur_other_person record;
cur_other_person_refcur REFCURSOR;

BEGIN
	DROP TABLE IF EXISTS tmp_responsetimer;
	CREATE TEMPORARY TABLE tmp_responsetimer(	roletype character varying, 
												personid uuid,
												witsid bigint, 
												contactdate timestamp,
												selectedcontact character varying,
												insertedon timestamp
											);
v_isexpunged = 0;				
IF isExpungementSuperUser  = 1 THEN
  v_isexpunged = isexpunged;
END IF;

IF v_isexpunged = 1 THEN
-------------------------------------------------------------------------------------------------
       -- Fully expunged
-------------------------------------------------------------------------------------------------
	select isr.actiontype, 
		isr.responsetimer,
		( select count(*)
			from expunge.intakeservicerequestactor_expunge insr
		  where insr.intakeserviceid = isr.intakeserviceid
			and insr.activeflag = 1
			and insr.intakeservicerequestpersontypekey = 'ICC' -- Initial Contact Caregiver
		) as ICC_count,
		isr.intakenumber
	into vs_cpstype, 
		vt_responsetimer,
		vl_icc_count,
		v_intakenumber	
	from expunge.intakeservicerequest_expunge isr
	where isr.intakeserviceid = v_intakeserviceid ; 

	-- RAISE NOTICE 'vs_cpstype >> %', vs_cpstype;	
	-- RAISE NOTICE 'vt_responsetimer >> %', vt_responsetimer;	
	-- RAISE NOTICE 'vl_icc_count >> %', vl_icc_count;	
	
	IF v_request_type is null or btrim(v_request_type) = '' THEN
		v_request_type  = 'responsetimer_check';
	END IF;
	
	-- To identify if the Response Timer is stopped before the due date/time
	select isr.reporteddate,
		(case when 
				-- PHYSICAL ABUSE
			(	coalesce(ismalpa_suspeciousdeath, false) = true -- Suspicious death of a child due to abuse 
				or coalesce(ismalpa_nonaccident, false) = true -- Non-accidental physical injury
				or coalesce(ismalpa_injuryinconsistent, false) = true -- Injury inconsistent with explanation
				or coalesce(ismalpa_insjury, false) = true -- Injury that appears suspicious
				or coalesce(ismalpa_childtoxic, false) = true -- Giving child toxic chemicals, alcohol, or drugs
				or coalesce(ismalpa_caregiver, false) = true -- Caregiver action that likely caused injury
				or coalesce(ismalpa_labortrafficking, false) = true --Labor Trafficking
				-- SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, false) = true -- Sexual molestation of a child by an adult caregiver
				or coalesce(ismalsa_sexualact, false) = true -- Sexual act(s) among siblings or other children living
				or coalesce(ismalsa_sexualexploitation, false) = true -- Sexual exploitation of a child by an adult caregiver
				or coalesce(ismalsa_physicalindicators, false) = true -- Physical, behavioral or suspicious indicators consistent with sexual abuse
				or coalesce(ismalsa_sex_trafficking, false) = true -- Risk of Sex Trafficking	
			) then
				'ABUSE'
		when coalesce(isnoimmed_substantial_risk, false) = true then -- Substance Exposed Newborn
				'RISKOFHARM_SEN'
		else
				'NEGLECT'
		end ) as malt_type,
		(case when 
				-- PHYSICAL ABUSE
			(	coalesce(ismalpa_suspeciousdeath, false) = true -- Suspicious death of a child due to abuse 
				or coalesce(ismalpa_nonaccident, false) = true -- Non-accidental physical injury
				or coalesce(ismalpa_injuryinconsistent, false) = true -- Injury inconsistent with explanation
				or coalesce(ismalpa_insjury, false) = true -- Injury that appears suspicious
				or coalesce(ismalpa_childtoxic, false) = true -- Giving child toxic chemicals, alcohol, or drugs
				or coalesce(ismalpa_caregiver, false) = true -- Caregiver action that likely caused injury
				or coalesce(ismalpa_labortrafficking, false) = true --Labor Trafficking
				-- SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, false) = true -- Sexual molestation of a child by an adult caregiver
				or coalesce(ismalsa_sexualact, false) = true -- Sexual act(s) among siblings or other children living
				or coalesce(ismalsa_sexualexploitation, false) = true -- Sexual exploitation of a child by an adult caregiver
				or coalesce(ismalsa_physicalindicators, false) = true -- Physical, behavioral or suspicious indicators consistent with sexual abuse
				or coalesce(ismalsa_sex_trafficking, false) = true -- Risk of Sex Trafficking	
			) then
				isr.reporteddate + interval '24 hours'
		when coalesce(isnoimmed_substantial_risk, false) = true then -- Substance Exposed Newborn
				isr.reporteddate + interval '48 hours'
		else
				isr.reporteddate + interval '5 days' -- all others
		end ) as responsetimer_duedate,
		to_char((case when 
				-- PHYSICAL ABUSE
			(	coalesce(ismalpa_suspeciousdeath, false) = true -- Suspicious death of a child due to abuse 
				or coalesce(ismalpa_nonaccident, false) = true -- Non-accidental physical injury
				or coalesce(ismalpa_injuryinconsistent, false) = true -- Injury inconsistent with explanation
				or coalesce(ismalpa_insjury, false) = true -- Injury that appears suspicious
				or coalesce(ismalpa_childtoxic, false) = true -- Giving child toxic chemicals, alcohol, or drugs
				or coalesce(ismalpa_caregiver, false) = true -- Caregiver action that likely caused injury
				or coalesce(ismalpa_labortrafficking, false) = true --Labor Trafficking
				-- SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, false) = true -- Sexual molestation of a child by an adult caregiver
				or coalesce(ismalsa_sexualact, false) = true -- Sexual act(s) among siblings or other children living
				or coalesce(ismalsa_sexualexploitation, false) = true -- Sexual exploitation of a child by an adult caregiver
				or coalesce(ismalsa_physicalindicators, false) = true -- Physical, behavioral or suspicious indicators consistent with sexual abuse
				or coalesce(ismalsa_sex_trafficking, false) = true -- Risk of Sex Trafficking	
			) then
				isr.reporteddate + interval '24 hours'
		when coalesce(isnoimmed_substantial_risk, false) = true then -- Substance Exposed Newborn
				isr.reporteddate + interval '48 hours'
		else
				isr.reporteddate + interval '5 days' -- all others
		end ), 'MM/DD/YYYY HH:MI AM') as responsetimer_duedate_formatted
	into vt_reporteddate,
		vs_malt_type,
		vt_responsetimer_duedate,
		vt_responsetimer_duedate_formatted
	from expunge.intakeservicerequestsdm_expunge sdm,
		expunge.intakeservicerequest_expunge isr 
	where sdm.intakeserviceid = isr.intakeserviceid 
		and sdm.activeflag = 1
		and isr.activeflag = 1
		and sdm.status = '16'
		and sdm.intakeserviceid = v_intakeserviceid
	order by sdm.insertedon desc 
	limit 1;

	IF vt_responsetimer is null THEN
		vs_responsetimer_status := 'Running';
	ELSIF vt_responsetimer <= vt_responsetimer_duedate THEN
		vs_responsetimer_status := 'Stopped';
	ELSE
		vs_responsetimer_status := 'Delay';
	END IF;	
	
	-- RAISE NOTICE 'vt_responsetimer_duedate >> %', vt_responsetimer_duedate;	
	
	
	IF v_request_type  = 'responsetimer_check' then
		-- IF vt_responsetimer is not null THEN
		-- 	vs_alleged_victim_contact_sw := 'Y';
		-- 	vs_icc_contact_sw := 'Y';
		-- 	vs_other_children_contact_sw := 'Y';
		-- ELSE
		-- Intitail values
		vs_alleged_victim_contact_sw := 'N';
		vs_icc_contact_sw := 'N';
		vs_other_children_contact_sw := 'N'; 

		-- 1) Alleged victim - consider max conatct date
		-- CPS-IR or CPS-AR
		-- Face To Face OR Initial Face to Face 
		-- Completed
		OPEN cur_victim_person_refcur FOR
			select distinct p.personid
				from expunge.intakeservicerequestactor_expunge insr
				join person p on p.personid = insr.personid and p.activeflag=1
			where insr.intakeserviceid = v_intakeserviceid
				and insr.activeflag = 1
				and insr.intakeservicerequestpersontypekey = 'AV'
				and p.dateofdeath is null
			;
		loop
			fetch cur_victim_person_refcur into cur_victim_person ;
			exit when not found;

			vu_personid := cur_victim_person.personid;
			vl_witsid := null; 
			vt_contactdate := null;
			vl_response_timer_sw := null;
			
			-- RAISE NOTICE 'vu_personid >> %', vu_personid;
			
			-- Check for In Home Response Timer flag for newly added clients	
			select count(*)
				into vl_response_timer_sw
			from personrole prl
			where coalesce(prl.initialresponse, 1) = 0 -- No
				and prl.personid = vu_personid
				and prl.intakeserviceid = v_intakeserviceid
				and prl.activeflag = 1 ;
				
			if vl_response_timer_sw > 0 then
				-- Skip, Do not consider this client for Response Timer calculations
			else
				select 'AV' as roletype,
					p.witsid::bigint, 
					p.starttime,-- p.endtime -- p.contactdate 
					p.insertedon
				into vs_roletype,
					vl_witsid,
					vt_contactdate,
					vt_insertedon
				from expunge.progressnote_expunge p 
					inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
						and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
					inner join expunge.contactparticipant_expunge cp on cp.progressnoteid = p.progressnoteid 
						and cp.activeflag = 1
					inner join expunge.intakeservicerequestactor_expunge insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
						-- Do not consider activeflag	
				where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying) 
					and p.activeflag = 1
					and p.attemptindicator <> true -- Completed
					-- and cp.intakeservicerequestactorid 
					and insr2.personid
						in (	select insr1.personid
										--insr1.intakeservicerequestactorid
									from expunge.intakeservicerequestactor_expunge insr1
								where insr1.intakeserviceid = v_intakeserviceid
									and insr1.personid = vu_personid
									and insr1.activeflag = 1
							)
				order by p.starttime -- p.endtime -- p.contactdate 
				limit 1;
				
				-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
				-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
				v_av_count := 1;
				IF vl_witsid > 0 THEN
					Insert into tmp_responsetimer
						(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
					values
						(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
				ELSE
					Insert into tmp_responsetimer
						(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
					values
						(	'AV', vu_personid, NULL, NULL, NULL, NULL );
				END IF;	
			end if;	
		end loop;
		close cur_victim_person_refcur;

		IF (
			SELECT count(*)
			FROM expunge.intakeservicerequestactor_expunge insr
			JOIN person p ON p.personid = insr.personid and p.activeflag=1
			WHERE insr.intakeserviceid = v_intakeserviceid
			AND insr.activeflag = 1
			AND insr.intakeservicerequestpersontypekey = 'AV'
			AND p.dateofdeath IS NULL
		) = 0
			and (
			select count(*)
			from tmp_responsetimer
			where roletype = 'AV'
			and contactdate is not null 
			and contactdate <> '1900-01-01'::date 
			) = 0 then
			v_av_count := 1;
			INSERT INTO tmp_responsetimer
				(roletype, personid, witsid, contactdate, selectedcontact) 
			VALUES
				('AV', '00000000-0000-0000-0000-000000000000', 99999, '1900-01-01', NULL);
		END IF;
		
		-- 2) Initial Contact Caregiver - consider min conatct date
		IF vs_cpstype  = 'IR' THEN
			-- Face To Face OR Initial Face to Face 
			-- Attempted or Completed 
			OPEN cur_icc_person_refcur FOR
				select distinct insr.personid
					from expunge.intakeservicerequestactor_expunge insr
				where insr.intakeserviceid = v_intakeserviceid
					and insr.activeflag = 1
					and insr.intakeservicerequestpersontypekey = 'ICC'
				;
			loop
				fetch cur_icc_person_refcur into cur_icc_person ;
				exit when not found;

				vu_personid := cur_icc_person.personid;
				vl_witsid := null; 
				vt_contactdate := null;
				vl_response_timer_sw := null;
				
				-- RAISE NOTICE 'vu_personid >> %', vu_personid;
				
				-- Check for In Home Response Timer flag for newly added clients	
				select count(*)
					into vl_response_timer_sw
				from personrole prl
				where coalesce(prl.initialresponse, 1) = 0 -- No
					and prl.personid = vu_personid
					and prl.intakeserviceid = v_intakeserviceid
					and prl.activeflag = 1 ;
					
				if vl_response_timer_sw > 0 then
					-- Skip, Do not consider this client for Response Timer calculations
				else
					select 'ICC' as roletype,
						p.witsid::bigint, 
						p.starttime, -- p.endtime -- p.contactdate 
						p.insertedon
					into vs_roletype,
						vl_witsid,
						vt_contactdate,
						vt_insertedon
					from expunge.progressnote_expunge p 
						inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
							and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
						inner join expunge.contactparticipant_expunge cp on cp.progressnoteid = p.progressnoteid 
							and cp.activeflag = 1
						inner join expunge.intakeservicerequestactor_expunge insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
							-- Do not consider activeflag		
					where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying)  
						and p.activeflag = 1
						-- and p.attemptindicator any -- (Attempted or Completed)
						-- and cp.intakeservicerequestactorid 
						and insr2.personid
							in (	select insr1.personid
										-- insr1.intakeservicerequestactorid
										from expunge.intakeservicerequestactor_expunge insr1
									where insr1.intakeserviceid = v_intakeserviceid
										and insr1.personid = vu_personid
										and insr1.activeflag = 1
								)
					order by p.starttime -- p.endtime -- p.contactdate 
					limit 1;
					
					-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
					-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
					v_icc_count := 1;
					IF vl_witsid > 0 THEN
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	'ICC', vu_personid, NULL, NULL, NULL, NULL );
					END IF;	
				end if;	
			end loop;
			close cur_icc_person_refcur;	

		ELSE -- CPS-AR
			-- Face To Face OR Initial Face to Face 
			-- Completed 
			OPEN cur_icc_person_refcur FOR
				select distinct insr.personid
					from expunge.intakeservicerequestactor_expunge insr
				where insr.intakeserviceid = v_intakeserviceid
					and insr.activeflag = 1
					and insr.intakeservicerequestpersontypekey = 'ICC'
				;
			loop
				fetch cur_icc_person_refcur into cur_icc_person ;
				exit when not found;

				vu_personid := cur_icc_person.personid;
				vl_witsid := null; 
				vt_contactdate := null;
				vl_response_timer_sw := null;
				
				-- RAISE NOTICE 'vu_personid >> %', vu_personid;
				
				-- Check for In Home Response Timer flag for newly added clients	
				select count(*)
					into vl_response_timer_sw
				from personrole prl
				where coalesce(prl.initialresponse, 1) = 0 -- No
					and prl.personid = vu_personid
					and prl.intakeserviceid = v_intakeserviceid
					and prl.activeflag = 1 ;
					
				if vl_response_timer_sw > 0 then
					-- Skip, Do not consider this client for Response Timer calculations
				else
					select 'ICC' as roletype,
						p.witsid::bigint, 
						p.starttime, -- p.endtime -- p.contactdate 
						p.insertedon
					into vs_roletype,
						vl_witsid,
						vt_contactdate,
						vt_insertedon
					from expunge.progressnote_expunge p 
						inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
							and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
						inner join expunge.contactparticipant_expunge cp on cp.progressnoteid = p.progressnoteid 
							and cp.activeflag = 1
						inner join expunge.intakeservicerequestactor_expunge insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
							-- Do not consider activeflag			
					where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying) 
						and p.activeflag = 1
						and p.attemptindicator <> true -- Completed
						-- and cp.intakeservicerequestactorid 
						and insr2.personid
							in (	select insr1.personid
										-- insr1.intakeservicerequestactorid
										from expunge.intakeservicerequestactor_expunge insr1
									where insr1.intakeserviceid = v_intakeserviceid
										and insr1.personid = vu_personid
										and insr1.activeflag = 1
								)
					order by p.starttime -- p.endtime -- p.contactdate 
					limit 1;
					
					-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
					-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
					v_icc_count := 1;
					IF vl_witsid > 0 THEN
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	'ICC', vu_personid, NULL, NULL, NULL, NULL );
					END IF;	
				end if;	
			end loop;
			close cur_icc_person_refcur;	
		
		END IF;
		
		IF vl_icc_count = 0 THEN
			Insert into tmp_responsetimer
				(	roletype, personid, witsid, contactdate, selectedcontact ) 
			values
				(	'ICC', NULL, NULL, NULL, NULL );
		END IF;
		
		-- 3) Child & Other Child - consider max conatct date
		-- CPS-IR or CPS-AR
		-- Face To Face OR Initial Face to Face 
		-- Attempted or Completed 
		select count(distinct insr.personid)
			into v_total_child_count
		from expunge.intakeservicerequestactor_expunge insr,
			expunge.actor_expunge act join person p on act.personid = p.personid and p.activeflag=1
		where insr.actorid = act.actorid
			and insr.intakeserviceid = v_intakeserviceid
			and insr.activeflag = 1
			and act.activeflag = 1
			and insr.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
			and act.ishouseholdmember = 1 
			and p.dateofdeath is null
			and (select count(*)
					from expunge.intakeservicerequestactor_expunge insv
					where insv.intakeserviceid = insr.intakeserviceid 
					and insv.personid = insr.personid
					and insv.intakeservicerequestpersontypekey = 'AV'
					and insv.activeflag = 1
				) = 0 ;
			
		If v_total_child_count > 0 THEN
			OPEN cur_other_person_refcur FOR
				select distinct insr.personid
					from expunge.intakeservicerequestactor_expunge insr,
						expunge.actor_expunge act join person p on act.personid = p.personid and p.activeflag=1
				where  insr.actorid = act.actorid
					and insr.intakeserviceid = v_intakeserviceid
					and insr.activeflag = 1
					and act.activeflag = 1
					and insr.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
					and act.ishouseholdmember = 1
					and p.dateofdeath is null
					and (select count(*)
							from expunge.intakeservicerequestactor_expunge insv
							where insv.intakeserviceid = insr.intakeserviceid 
							and insv.personid = insr.personid
							and insv.intakeservicerequestpersontypekey = 'AV'
							and insv.activeflag = 1
						) = 0 
				;
			loop
				fetch cur_other_person_refcur into cur_other_person ;
				exit when not found;

				vu_personid := cur_other_person.personid;
				vl_witsid := null; 
				vt_contactdate := null;
				vl_response_timer_sw := null;
				
				-- RAISE NOTICE 'vu_personid >> %', vu_personid;
				
				-- Check for In Home Response Timer flag for newly added clients	
				select count(*)
					into vl_response_timer_sw
				from personrole prl
				where coalesce(prl.initialresponse, 1) = 0 -- No
					and prl.personid = vu_personid
					and prl.intakeserviceid = v_intakeserviceid
					and prl.activeflag = 1 ;
					
				if vl_response_timer_sw > 0 then
					-- Skip, Do not consider this client for Response Timer calculations
					v_timer_sw_no_child_count := v_timer_sw_no_child_count + 1;
				else
					select 'OTH' as roletype,
						p.witsid::bigint, 
						p.starttime, -- p.endtime -- p.contactdate 
						p.insertedon
					into vs_roletype,
						vl_witsid,
						vt_contactdate,
						vt_insertedon
					from expunge.progressnote_expunge p 
						inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
							and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
						inner join expunge.contactparticipant_expunge cp on cp.progressnoteid = p.progressnoteid 
							and cp.activeflag = 1
						inner join expunge.intakeservicerequestactor_expunge insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
							-- Do not consider activeflag				
					where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying) 
						and p.activeflag = 1
						-- and p.attemptindicator any -- (Attempted or Completed)
						-- and cp.intakeservicerequestactorid 
						and insr2.personid
							in (	select insr1.personid
										-- insr1.intakeservicerequestactorid
										from expunge.intakeservicerequestactor_expunge insr1
									where insr1.intakeserviceid = v_intakeserviceid
										and insr1.personid = vu_personid
										and insr1.activeflag = 1
								)
					order by p.starttime -- p.endtime -- p.contactdate 
					limit 1;
					
					-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
					-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
					v_child_count := 1;
					IF vl_witsid > 0 THEN
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	'OTH', vu_personid, NULL, NULL, NULL, NULL );
					END IF;	
				end if;	
			end loop;
			close cur_other_person_refcur;	
			
			if v_total_child_count = v_timer_sw_no_child_count then
				-- No Clients participating as a Child or Other Child 
				v_child_count := 1;
			end if;
		else
			-- No Clients participating as a Child or Other Child 
			v_child_count := 1;
		end if;	
		-- Verify if any one ICC Contact date is available
		vl_icc_contact_count := 0;
		
		select count(*)
			into vl_icc_contact_count
		from tmp_responsetimer
		where roletype = 'ICC'	
			and contactdate is not null ;
		
		IF vl_icc_contact_count > 0 THEN
			-- Delete other ICC Contact with No Contact date(s) (if any)
			delete from tmp_responsetimer
			where roletype = 'ICC'	
				and contactdate is null ;	
		END IF;	
		
		-- Verify all required dates are available
		select count(*)
			into vl_missing_info 
		from tmp_responsetimer 
		where contactdate is null ;

		-- RAISE NOTICE 'vl_missing_info >> %', vl_missing_info;
		
		--	IF vl_missing_info = 0 AND v_av_count = 1 AND v_icc_count = 1 AND v_child_count = 1 THEN
		-- Stop Response Timer
		
		-- 1) Alleged victim - consider max conatct date
		update tmp_responsetimer
			set selectedcontact = 'Y'
		WHERE roletype = 'AV'
			and witsid = (	select witsid 
								from tmp_responsetimer 
							where roletype = 'AV'
							order by contactdate desc 
							limit 1
							); 
								
		vt_max_insertedon := null; 
		
		select max(contactdate)
			into vt_max_insertedon
		from tmp_responsetimer
		where selectedcontact = 'Y'
			and roletype = 'AV'
			and contactdate is not null 
			and ( select count(*)
					from tmp_responsetimer 
					where roletype = 'AV'	
					and contactdate is null ) = 0 ;
			
		RAISE NOTICE 'AV vt_max_insertedon >> %', vt_max_insertedon;	
		
		vt_alleged_victim_contact_ts := vt_max_insertedon; 
		
		-- vs_alleged_victim_contact_sw := COALESCE(vs_alleged_victim_contact_sw, 'N');
		IF vt_max_insertedon is null THEN
			vs_alleged_victim_contact_sw := 'N';
		ELSE -- 	vt_max_insertedon is not NULL
			IF vt_max_insertedon <= vt_responsetimer_duedate THEN
				vs_alleged_victim_contact_sw := 'Y';
			ELSE
				vs_alleged_victim_contact_sw := 'L';
				-- vs_alleged_victim_contact_sw := 'Y';
			END IF;	
		END IF;
			
		-- 2) Initial Contact Caregiver - consider min conatct date
		update tmp_responsetimer
			set selectedcontact = 'Y'
		WHERE roletype = 'ICC'
			and witsid = (	select witsid 
								from tmp_responsetimer 
							where roletype = 'ICC'
							order by contactdate 
							limit 1
							); 
			
		vt_max_insertedon := null; 
		
		select min(contactdate)	
			into vt_max_insertedon
		from tmp_responsetimer
		where selectedcontact = 'Y'
			and roletype = 'ICC'
			and contactdate is not null 
			and ( select count(*)
					from tmp_responsetimer 
					where roletype = 'ICC'	
					and contactdate is null ) = 0 ;
		
		RAISE NOTICE 'ICC vt_max_insertedon >> %', vt_max_insertedon;	
		
		vt_icc_contact_ts := vt_max_insertedon; 
		
		-- vs_icc_contact_sw := COALESCE(vs_icc_contact_sw, 'N');				
		IF vt_max_insertedon is null THEN
			vs_icc_contact_sw := 'N';
		ELSE -- 	vt_max_insertedon is not NULL
			IF vt_max_insertedon <= vt_responsetimer_duedate THEN
				vs_icc_contact_sw := 'Y';
			ELSE
				vs_icc_contact_sw := 'L';
				-- vs_icc_contact_sw := 'Y';
			END IF;	
		END IF;

		-- 3) Child & Other Child - consider max conatct date
		
		if v_total_child_count > 0 and v_total_child_count <> v_timer_sw_no_child_count then 
			update tmp_responsetimer
				set selectedcontact = 'Y'
			WHERE roletype = 'OTH'
				and witsid = (	select witsid 
									from tmp_responsetimer 
								where roletype = 'OTH'
								order by contactdate desc 
								limit 1
								); 
			
				
			vt_max_insertedon := null; 
			
			select max(contactdate)	
				into vt_max_insertedon
			from tmp_responsetimer
			where selectedcontact = 'Y'
				and roletype = 'OTH'
				and contactdate is not null 
				and ( select count(*)
						from tmp_responsetimer 
						where roletype = 'OTH'	
						and contactdate is null ) = 0 ;
		
			RAISE NOTICE 'OTH vt_max_insertedon >> %', vt_max_insertedon;	
			
			vt_other_children_contact_ts := vt_max_insertedon;
				
			-- vs_other_children_contact_sw := COALESCE(vs_other_children_contact_sw, 'N');			
			IF vt_max_insertedon is null THEN
				vs_other_children_contact_sw := 'N';
			ELSE -- 	vt_max_insertedon is not NULL
				IF vt_max_insertedon <= vt_responsetimer_duedate THEN
					vs_other_children_contact_sw := 'Y';
				ELSE
					vs_other_children_contact_sw := 'L';
					-- vs_other_children_contact_sw := 'Y';
				END IF;	
			END IF;
		else
			vs_other_children_contact_sw := 'Y';
		end if;	
		
		-- 4) Final Response timer (lt_responsetimer) 
		-- consider max conatct date from 1,2 & 3
		select contactdate, 
			witsid
		into vt_finalresponsetime, 
			vl_final_witsid
		from tmp_responsetimer 
		where selectedcontact = 'Y'
		order by contactdate desc
		limit 1;	
		
    	DROP TABLE IF EXISTS tmp_responsetimer;
	ELSE
		vs_alleged_victim_contact_sw := 'N/A';
		vs_icc_contact_sw := 'N/A';
		vs_other_children_contact_sw := 'N/A';		
	END IF;
ELSE 
-------------------------------------------------------------------------------------------------
		-- Normal Query
----------------------------------------------------------------------------------------------------
	select isr.actiontype, 
		isr.responsetimer,
		( select count(*)
			from intakeservicerequestactor insr
		  where insr.intakeserviceid = isr.intakeserviceid
			and insr.activeflag = 1
			and insr.intakeservicerequestpersontypekey = 'ICC' -- Initial Contact Caregiver
		) as ICC_count,
		isr.intakenumber
	into vs_cpstype, 
		vt_responsetimer,
		vl_icc_count,
		v_intakenumber	
	from intakeservicerequest isr
	where isr.intakeserviceid = v_intakeserviceid ; 

	-- RAISE NOTICE 'vs_cpstype >> %', vs_cpstype;	
	-- RAISE NOTICE 'vt_responsetimer >> %', vt_responsetimer;	
	-- RAISE NOTICE 'vl_icc_count >> %', vl_icc_count;	
	
	IF v_request_type is null or btrim(v_request_type) = '' THEN
		v_request_type  = 'responsetimer_check';
	END IF;
	
	-- To identify if the Response Timer is stopped before the due date/time
	select isr.reporteddate,
		(case when 
				-- PHYSICAL ABUSE
			(	coalesce(ismalpa_suspeciousdeath, false) = true -- Suspicious death of a child due to abuse 
				or coalesce(ismalpa_nonaccident, false) = true -- Non-accidental physical injury
				or coalesce(ismalpa_injuryinconsistent, false) = true -- Injury inconsistent with explanation
				or coalesce(ismalpa_insjury, false) = true -- Injury that appears suspicious
				or coalesce(ismalpa_childtoxic, false) = true -- Giving child toxic chemicals, alcohol, or drugs
				or coalesce(ismalpa_caregiver, false) = true -- Caregiver action that likely caused injury
				or coalesce(ismalpa_labortrafficking, false) = true --Labor Trafficking
				-- SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, false) = true -- Sexual molestation of a child by an adult caregiver
				or coalesce(ismalsa_sexualact, false) = true -- Sexual act(s) among siblings or other children living
				or coalesce(ismalsa_sexualexploitation, false) = true -- Sexual exploitation of a child by an adult caregiver
				or coalesce(ismalsa_physicalindicators, false) = true -- Physical, behavioral or suspicious indicators consistent with sexual abuse
				or coalesce(ismalsa_sex_trafficking, false) = true -- Risk of Sex Trafficking	
			) then
				'ABUSE'
		when coalesce(isnoimmed_substantial_risk, false) = true then -- Substance Exposed Newborn
				'RISKOFHARM_SEN'
		else
				'NEGLECT'
		end ) as malt_type,
		(case when 
				-- PHYSICAL ABUSE
			(	coalesce(ismalpa_suspeciousdeath, false) = true -- Suspicious death of a child due to abuse 
				or coalesce(ismalpa_nonaccident, false) = true -- Non-accidental physical injury
				or coalesce(ismalpa_injuryinconsistent, false) = true -- Injury inconsistent with explanation
				or coalesce(ismalpa_insjury, false) = true -- Injury that appears suspicious
				or coalesce(ismalpa_childtoxic, false) = true -- Giving child toxic chemicals, alcohol, or drugs
				or coalesce(ismalpa_caregiver, false) = true -- Caregiver action that likely caused injury
				or coalesce(ismalpa_labortrafficking, false) = true --Labor Trafficking
				-- SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, false) = true -- Sexual molestation of a child by an adult caregiver
				or coalesce(ismalsa_sexualact, false) = true -- Sexual act(s) among siblings or other children living
				or coalesce(ismalsa_sexualexploitation, false) = true -- Sexual exploitation of a child by an adult caregiver
				or coalesce(ismalsa_physicalindicators, false) = true -- Physical, behavioral or suspicious indicators consistent with sexual abuse
				or coalesce(ismalsa_sex_trafficking, false) = true -- Risk of Sex Trafficking	
			) then
				isr.reporteddate + interval '24 hours'
		when coalesce(isnoimmed_substantial_risk, false) = true then -- Substance Exposed Newborn
				isr.reporteddate + interval '48 hours'
		else
				isr.reporteddate + interval '5 days' -- all others
		end ) as responsetimer_duedate,
		to_char((case when 
				-- PHYSICAL ABUSE
			(	coalesce(ismalpa_suspeciousdeath, false) = true -- Suspicious death of a child due to abuse 
				or coalesce(ismalpa_nonaccident, false) = true -- Non-accidental physical injury
				or coalesce(ismalpa_injuryinconsistent, false) = true -- Injury inconsistent with explanation
				or coalesce(ismalpa_insjury, false) = true -- Injury that appears suspicious
				or coalesce(ismalpa_childtoxic, false) = true -- Giving child toxic chemicals, alcohol, or drugs
				or coalesce(ismalpa_caregiver, false) = true -- Caregiver action that likely caused injury
				or coalesce(ismalpa_labortrafficking, false) = true --Labor Trafficking
				-- SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, false) = true -- Sexual molestation of a child by an adult caregiver
				or coalesce(ismalsa_sexualact, false) = true -- Sexual act(s) among siblings or other children living
				or coalesce(ismalsa_sexualexploitation, false) = true -- Sexual exploitation of a child by an adult caregiver
				or coalesce(ismalsa_physicalindicators, false) = true -- Physical, behavioral or suspicious indicators consistent with sexual abuse
				or coalesce(ismalsa_sex_trafficking, false) = true -- Risk of Sex Trafficking	
			) then
				isr.reporteddate + interval '24 hours'
		when coalesce(isnoimmed_substantial_risk, false) = true then -- Substance Exposed Newborn
				isr.reporteddate + interval '48 hours'
		else
				isr.reporteddate + interval '5 days' -- all others
		end ), 'MM/DD/YYYY HH:MI AM') as responsetimer_duedate_formatted
	into vt_reporteddate,
		vs_malt_type,
		vt_responsetimer_duedate,
		vt_responsetimer_duedate_formatted
	from intakeservicerequestsdm sdm,
		intakeservicerequest isr 
	where sdm.intakeserviceid = isr.intakeserviceid 
		and sdm.activeflag = 1
		and isr.activeflag = 1
		and sdm.status = '16'
		and sdm.intakeserviceid = v_intakeserviceid
	order by sdm.insertedon desc 
	limit 1;

	IF vt_responsetimer is null THEN
		vs_responsetimer_status := 'Running';
	ELSIF vt_responsetimer <= vt_responsetimer_duedate THEN
		vs_responsetimer_status := 'Stopped';
	ELSE
		vs_responsetimer_status := 'Delay';
	END IF;	
	
	-- RAISE NOTICE 'vt_responsetimer_duedate >> %', vt_responsetimer_duedate;	
	
	
	IF v_request_type  = 'responsetimer_check' then
		-- IF vt_responsetimer is not null THEN
		-- 	vs_alleged_victim_contact_sw := 'Y';
		-- 	vs_icc_contact_sw := 'Y';
		-- 	vs_other_children_contact_sw := 'Y';
		-- ELSE
		-- Intitail values
		vs_alleged_victim_contact_sw := 'N';
		vs_icc_contact_sw := 'N';
		vs_other_children_contact_sw := 'N'; 

		-- 1) Alleged victim - consider max conatct date
		-- CPS-IR or CPS-AR
		-- Face To Face OR Initial Face to Face 
		-- Completed
		OPEN cur_victim_person_refcur FOR
			select distinct insr.personid
				from intakeservicerequestactor insr
				join person p on p.personid = insr.personid and p.activeflag=1
			where insr.intakeserviceid = v_intakeserviceid
				and insr.activeflag = 1
				and insr.intakeservicerequestpersontypekey = 'AV'
				and p.dateofdeath is null
			;
		loop
			fetch cur_victim_person_refcur into cur_victim_person ;
			exit when not found;

			vu_personid := cur_victim_person.personid;
			vl_witsid := null; 
			vt_contactdate := null;
			vl_response_timer_sw := null;
			
			-- RAISE NOTICE 'vu_personid >> %', vu_personid;
			
			-- Check for In Home Response Timer flag for newly added clients	
			select count(*)
				into vl_response_timer_sw
			from personrole prl
			where coalesce(prl.initialresponse, 1) = 0 -- No
				and prl.personid = vu_personid
				and prl.intakeserviceid = v_intakeserviceid
				and prl.activeflag = 1 ;
				
			if vl_response_timer_sw > 0 then
				-- Skip, Do not consider this client for Response Timer calculations
			else
				select 'AV' as roletype,
					p.witsid, 
					p.starttime,-- p.endtime -- p.contactdate 
					p.insertedon
				into vs_roletype,
					vl_witsid,
					vt_contactdate,
					vt_insertedon
				from progressnote p 
					inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
						and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
					inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
						and cp.activeflag = 1
					inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
						-- Do not consider activeflag	
				where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying) 
					and p.activeflag = 1
					and p.attemptindicator <> true -- Completed
					-- and cp.intakeservicerequestactorid 
					and insr2.personid
						in (	select insr1.personid
										--insr1.intakeservicerequestactorid
									from intakeservicerequestactor insr1
								where insr1.intakeserviceid = v_intakeserviceid
									and insr1.personid = vu_personid
									and insr1.activeflag = 1
							)
				order by p.starttime -- p.endtime -- p.contactdate 
				limit 1;
				
				-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
				-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
				v_av_count := 1;
				IF vl_witsid > 0 THEN
					Insert into tmp_responsetimer
						(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
					values
						(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
				ELSE
					Insert into tmp_responsetimer
						(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
					values
						(	'AV', vu_personid, NULL, NULL, NULL, NULL );
				END IF;	
			end if;	
		end loop;
		close cur_victim_person_refcur;

		IF (
			SELECT count(*)
			FROM intakeservicerequestactor insr
			JOIN person p ON p.personid = insr.personid and p.activeflag=1
			WHERE insr.intakeserviceid = v_intakeserviceid
			AND insr.activeflag = 1
			AND insr.intakeservicerequestpersontypekey = 'AV'
			AND p.dateofdeath IS NULL
		) = 0
			and (
			select count(*)
			from tmp_responsetimer
			where roletype = 'AV'
			and contactdate is not null 
			and contactdate <> '1900-01-01'::date 
			) = 0 then
			v_av_count := 1;
			INSERT INTO tmp_responsetimer
				(roletype, personid, witsid, contactdate, selectedcontact) 
			VALUES
				('AV', '00000000-0000-0000-0000-000000000000', 99999, '1900-01-01', NULL);
		END IF;
		
		-- 2) Initial Contact Caregiver - consider min conatct date
		IF vs_cpstype  = 'IR' THEN
			-- Face To Face OR Initial Face to Face 
			-- Attempted or Completed 
			OPEN cur_icc_person_refcur FOR
				select distinct insr.personid
					from intakeservicerequestactor insr
				where insr.intakeserviceid = v_intakeserviceid
					and insr.activeflag = 1
					and insr.intakeservicerequestpersontypekey = 'ICC'
				;
			loop
				fetch cur_icc_person_refcur into cur_icc_person ;
				exit when not found;

				vu_personid := cur_icc_person.personid;
				vl_witsid := null; 
				vt_contactdate := null;
				vl_response_timer_sw := null;
				
				-- RAISE NOTICE 'vu_personid >> %', vu_personid;
				
				-- Check for In Home Response Timer flag for newly added clients	
				select count(*)
					into vl_response_timer_sw
				from personrole prl
				where coalesce(prl.initialresponse, 1) = 0 -- No
					and prl.personid = vu_personid
					and prl.intakeserviceid = v_intakeserviceid
					and prl.activeflag = 1 ;
					
				if vl_response_timer_sw > 0 then
					-- Skip, Do not consider this client for Response Timer calculations
				else
					select 'ICC' as roletype,
						p.witsid, 
						p.starttime, -- p.endtime -- p.contactdate 
						p.insertedon
					into vs_roletype,
						vl_witsid,
						vt_contactdate,
						vt_insertedon
					from progressnote p 
						inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
							and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
						inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
							and cp.activeflag = 1
						inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
							-- Do not consider activeflag		
					where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying)  
						and p.activeflag = 1
						-- and p.attemptindicator any -- (Attempted or Completed)
						-- and cp.intakeservicerequestactorid 
						and insr2.personid
							in (	select insr1.personid
										-- insr1.intakeservicerequestactorid
										from intakeservicerequestactor insr1
									where insr1.intakeserviceid = v_intakeserviceid
										and insr1.personid = vu_personid
										and insr1.activeflag = 1
								)
					order by p.starttime -- p.endtime -- p.contactdate 
					limit 1;
					
					-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
					-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
					v_icc_count := 1;
					IF vl_witsid > 0 THEN
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	'ICC', vu_personid, NULL, NULL, NULL, NULL );
					END IF;	
				end if;	
			end loop;
			close cur_icc_person_refcur;	

		ELSE -- CPS-AR
			-- Face To Face OR Initial Face to Face 
			-- Completed 
			OPEN cur_icc_person_refcur FOR
				select distinct insr.personid
					from intakeservicerequestactor insr
				where insr.intakeserviceid = v_intakeserviceid
					and insr.activeflag = 1
					and insr.intakeservicerequestpersontypekey = 'ICC'
				;
			loop
				fetch cur_icc_person_refcur into cur_icc_person ;
				exit when not found;

				vu_personid := cur_icc_person.personid;
				vl_witsid := null; 
				vt_contactdate := null;
				vl_response_timer_sw := null;
				
				-- RAISE NOTICE 'vu_personid >> %', vu_personid;
				
				-- Check for In Home Response Timer flag for newly added clients	
				select count(*)
					into vl_response_timer_sw
				from personrole prl
				where coalesce(prl.initialresponse, 1) = 0 -- No
					and prl.personid = vu_personid
					and prl.intakeserviceid = v_intakeserviceid
					and prl.activeflag = 1 ;
					
				if vl_response_timer_sw > 0 then
					-- Skip, Do not consider this client for Response Timer calculations
				else
					select 'ICC' as roletype,
						p.witsid, 
						p.starttime, -- p.endtime -- p.contactdate 
						p.insertedon
					into vs_roletype,
						vl_witsid,
						vt_contactdate,
						vt_insertedon
					from progressnote p 
						inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
							and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
						inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
							and cp.activeflag = 1
						inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
							-- Do not consider activeflag			
					where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying) 
						and p.activeflag = 1
						and p.attemptindicator <> true -- Completed
						-- and cp.intakeservicerequestactorid 
						and insr2.personid
							in (	select insr1.personid
										-- insr1.intakeservicerequestactorid
										from intakeservicerequestactor insr1
									where insr1.intakeserviceid = v_intakeserviceid
										and insr1.personid = vu_personid
										and insr1.activeflag = 1
								)
					order by p.starttime -- p.endtime -- p.contactdate 
					limit 1;
					
					-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
					-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
					v_icc_count := 1;
					IF vl_witsid > 0 THEN
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	'ICC', vu_personid, NULL, NULL, NULL, NULL );
					END IF;	
				end if;	
			end loop;
			close cur_icc_person_refcur;	
		
		END IF;
		
		IF vl_icc_count = 0 THEN
			Insert into tmp_responsetimer
				(	roletype, personid, witsid, contactdate, selectedcontact ) 
			values
				(	'ICC', NULL, NULL, NULL, NULL );
		END IF;
		
		-- 3) Child & Other Child - consider max conatct date
		-- CPS-IR or CPS-AR
		-- Face To Face OR Initial Face to Face 
		-- Attempted or Completed 
		select count(distinct insr.personid)
			into v_total_child_count
		from intakeservicerequestactor insr,
			actor act join person p on act.personid = p.personid and p.activeflag=1
		where insr.actorid = act.actorid
			and insr.intakeserviceid = v_intakeserviceid
			and insr.activeflag = 1
			and act.activeflag = 1
			and insr.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
			and act.ishouseholdmember = 1 
			and p.dateofdeath is null
			and (select count(*)
					from intakeservicerequestactor insv
					where insv.intakeserviceid = insr.intakeserviceid 
					and insv.personid = insr.personid
					and insv.intakeservicerequestpersontypekey = 'AV'
					and insv.activeflag = 1
				) = 0 ;
			
		If v_total_child_count > 0 THEN
			OPEN cur_other_person_refcur FOR
				select distinct insr.personid
					from intakeservicerequestactor insr,
						actor act join person p on act.personid = p.personid and p.activeflag=1
				where  insr.actorid = act.actorid
					and insr.intakeserviceid = v_intakeserviceid
					and insr.activeflag = 1
					and act.activeflag = 1
					and insr.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
					and act.ishouseholdmember = 1
					and p.dateofdeath is null
					and (select count(*)
							from intakeservicerequestactor insv
							where insv.intakeserviceid = insr.intakeserviceid 
							and insv.personid = insr.personid
							and insv.intakeservicerequestpersontypekey = 'AV'
							and insv.activeflag = 1
						) = 0 
				;
			loop
				fetch cur_other_person_refcur into cur_other_person ;
				exit when not found;

				vu_personid := cur_other_person.personid;
				vl_witsid := null; 
				vt_contactdate := null;
				vl_response_timer_sw := null;
				
				-- RAISE NOTICE 'vu_personid >> %', vu_personid;
				
				-- Check for In Home Response Timer flag for newly added clients	
				select count(*)
					into vl_response_timer_sw
				from personrole prl
				where coalesce(prl.initialresponse, 1) = 0 -- No
					and prl.personid = vu_personid
					and prl.intakeserviceid = v_intakeserviceid
					and prl.activeflag = 1 ;
					
				if vl_response_timer_sw > 0 then
					-- Skip, Do not consider this client for Response Timer calculations
					v_timer_sw_no_child_count := v_timer_sw_no_child_count + 1;
				else
					select 'OTH' as roletype,
						p.witsid, 
						p.starttime, -- p.endtime -- p.contactdate 
						p.insertedon
					into vs_roletype,
						vl_witsid,
						vt_contactdate,
						vt_insertedon
					from progressnote p 
						inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
							and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
						inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
							and cp.activeflag = 1
						inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
							-- Do not consider activeflag				
					where (p.entitytypeid = v_intakeserviceid::character varying or p.entitytypeid = v_intakenumber::character varying) 
						and p.activeflag = 1
						-- and p.attemptindicator any -- (Attempted or Completed)
						-- and cp.intakeservicerequestactorid 
						and insr2.personid
							in (	select insr1.personid
										-- insr1.intakeservicerequestactorid
										from intakeservicerequestactor insr1
									where insr1.intakeserviceid = v_intakeserviceid
										and insr1.personid = vu_personid
										and insr1.activeflag = 1
								)
					order by p.starttime -- p.endtime -- p.contactdate 
					limit 1;
					
					-- RAISE NOTICE 'vl_witsid >> %', vl_witsid;
					-- RAISE NOTICE 'vt_contactdate >> %', vt_contactdate;
					v_child_count := 1;
					IF vl_witsid > 0 THEN
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL, vt_insertedon );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact, insertedon ) 
						values
							(	'OTH', vu_personid, NULL, NULL, NULL, NULL );
					END IF;	
				end if;	
			end loop;
			close cur_other_person_refcur;	
			
			if v_total_child_count = v_timer_sw_no_child_count then
				-- No Clients participating as a Child or Other Child 
				v_child_count := 1;
			end if;
		else
			-- No Clients participating as a Child or Other Child 
			v_child_count := 1;
		end if;	
		
		-- Verify if any one ICC Contact date is available
		vl_icc_contact_count := 0;

		select count(*)
			into vl_icc_contact_count
		from tmp_responsetimer
		where roletype = 'ICC'	
			and contactdate is not null ;

		IF vl_icc_contact_count > 0 THEN
			-- Delete other ICC Contact with No Contact date(s) (if any)
			delete from tmp_responsetimer
			where roletype = 'ICC'	
				and contactdate is null ;	
		END IF;	

		-- Verify all required dates are available
		select count(*)
			into vl_missing_info 
		from tmp_responsetimer 
		where contactdate is null ;

		-- RAISE NOTICE 'vl_missing_info >> %', vl_missing_info;

		--	IF vl_missing_info = 0 AND v_av_count = 1 AND v_icc_count = 1 AND v_child_count = 1 THEN
		-- Stop Response Timer

		-- 1) Alleged victim - consider max conatct date
		update tmp_responsetimer
			set selectedcontact = 'Y'
		WHERE roletype = 'AV'
			and witsid = (	select witsid 
								from tmp_responsetimer 
							where roletype = 'AV'
							order by contactdate desc 
							limit 1
							); 
							
		vt_max_insertedon := null; 
		
		select max(contactdate)
			into vt_max_insertedon
		from tmp_responsetimer
		where selectedcontact = 'Y'
			and roletype = 'AV'
			and contactdate is not null 
			and ( select count(*)
					from tmp_responsetimer 
					where roletype = 'AV'	
					and contactdate is null ) = 0 ;
		
		RAISE NOTICE 'AV vt_max_insertedon >> %', vt_max_insertedon;	
		
		vt_alleged_victim_contact_ts := vt_max_insertedon; 
		
		-- vs_alleged_victim_contact_sw := COALESCE(vs_alleged_victim_contact_sw, 'N');
		IF vt_max_insertedon is null THEN
			vs_alleged_victim_contact_sw := 'N';
		ELSE -- 	vt_max_insertedon is not NULL
			IF vt_max_insertedon <= vt_responsetimer_duedate THEN
				vs_alleged_victim_contact_sw := 'Y';
			ELSE
				vs_alleged_victim_contact_sw := 'L';
				-- vs_alleged_victim_contact_sw := 'Y';
			END IF;	
		END IF;
		
		-- 2) Initial Contact Caregiver - consider min conatct date
		update tmp_responsetimer
			set selectedcontact = 'Y'
		WHERE roletype = 'ICC'
			and witsid = (	select witsid 
								from tmp_responsetimer 
							where roletype = 'ICC'
							order by contactdate 
							limit 1
							); 
			
		vt_max_insertedon := null; 
		
		select min(contactdate)	
			into vt_max_insertedon
		from tmp_responsetimer
		where selectedcontact = 'Y'
			and roletype = 'ICC'
			and contactdate is not null 
			and ( select count(*)
					from tmp_responsetimer 
					where roletype = 'ICC'	
					and contactdate is null ) = 0 ;
		
		RAISE NOTICE 'ICC vt_max_insertedon >> %', vt_max_insertedon;	
		
		vt_icc_contact_ts := vt_max_insertedon; 
		
		-- vs_icc_contact_sw := COALESCE(vs_icc_contact_sw, 'N');				
		IF vt_max_insertedon is null THEN
			vs_icc_contact_sw := 'N';
		ELSE -- 	vt_max_insertedon is not NULL
			IF vt_max_insertedon <= vt_responsetimer_duedate THEN
				vs_icc_contact_sw := 'Y';
			ELSE
				vs_icc_contact_sw := 'L';
				-- vs_icc_contact_sw := 'Y';
			END IF;	
		END IF;

		-- 3) Child & Other Child - consider max conatct date
		
		if v_total_child_count > 0 and v_total_child_count <> v_timer_sw_no_child_count then 
			update tmp_responsetimer
				set selectedcontact = 'Y'
			WHERE roletype = 'OTH'
				and witsid = (	select witsid 
									from tmp_responsetimer 
								where roletype = 'OTH'
								order by contactdate desc 
								limit 1
								); 
			
			
			vt_max_insertedon := null; 
			
			select max(contactdate)	
				into vt_max_insertedon
			from tmp_responsetimer
			where selectedcontact = 'Y'
				and roletype = 'OTH'
				and contactdate is not null 
				and ( select count(*)
						from tmp_responsetimer 
						where roletype = 'OTH'	
						and contactdate is null ) = 0 ;
		
			RAISE NOTICE 'OTH vt_max_insertedon >> %', vt_max_insertedon;	
			
			vt_other_children_contact_ts := vt_max_insertedon;
			
			-- vs_other_children_contact_sw := COALESCE(vs_other_children_contact_sw, 'N');			
			IF vt_max_insertedon is null THEN
				vs_other_children_contact_sw := 'N';
			ELSE -- 	vt_max_insertedon is not NULL
				IF vt_max_insertedon <= vt_responsetimer_duedate THEN
					vs_other_children_contact_sw := 'Y';
				ELSE
					vs_other_children_contact_sw := 'L';
					-- vs_other_children_contact_sw := 'Y';
				END IF;	
			END IF;
		else
			vs_other_children_contact_sw := 'Y';
		end if;	
		
		-- 4) Final Response timer (lt_responsetimer) 
		-- consider max conatct date from 1,2 & 3
		select contactdate, 
			witsid
		into vt_finalresponsetime, 
			vl_final_witsid
		from tmp_responsetimer 
		where selectedcontact = 'Y'
		order by contactdate desc
		limit 1;	
		
    	DROP TABLE IF EXISTS tmp_responsetimer;
	ELSE
		vs_alleged_victim_contact_sw := 'N/A';
		vs_icc_contact_sw := 'N/A';
		vs_other_children_contact_sw := 'N/A';		
	END IF;
END IF;
RETURN QUERY select vs_alleged_victim_contact_sw,
	vt_alleged_victim_contact_ts,
	vs_icc_contact_sw,
	vt_icc_contact_ts,
	vs_other_children_contact_sw,
	vt_other_children_contact_ts,
	vt_reporteddate,
	vt_responsetimer,
	vs_malt_type,
	vt_responsetimer_duedate,
	vs_responsetimer_status,
	vt_responsetimer_duedate_formatted ;
END;

$function$
;
