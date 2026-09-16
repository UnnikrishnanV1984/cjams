DROP FUNCTION if exists cjams.cpsresponsetimerupdate(uuid);

CREATE OR REPLACE FUNCTION cjams.cpsresponsetimerupdate(v_intakeserviceid uuid, 
														v_user_id character varying default NULL::character varying
														) 
	RETURNS text 
	LANGUAGE plpgsql 
AS $function$ 
-------------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created : 03/21/2022
-- CPS Response Timer Update (CIDM-4348 - B-124723/B-124724)

-- Argument(s): 1) IN v_intakeserviceid - CPS ID

-- Revision(s)
-- 07/25/2022 Vineet Tirodkar - Modifications to update responsetimer logic with person id (CDM-23868)
-- 08/05/2022 Vineet Tirodkar - Modifications to add new input parameter userid (CDM-24184)
-- 08/17/2022 Vineet Tirodkar - Modifications to make Child/Other Children participation as non-mandatory (CDM-24170)
-- 04/28/2023 Vineet Tirodkar - Modifications to check for in Home Response Timer flag for newly added clients (CIDM-7055/B-156868))
-- 08/03/2023 Vineet Tirodkar - Modifications for all Child & Other Child persons are NOT part of Initial Response (CDM-33396)
-- 01/22/2024 Anil Dharni - CPS Child Fatality Story - Modification based on date of death (CIDM-10009)
-------------------------------------------------------------------------------------------------------------
declare vs_cpstype character varying; 
declare vs_roletype character varying; 
declare l_status text;
	
declare vt_responsetimer timestamp;
declare vt_contactdate timestamp;
declare vt_allegedvictimresponsetime timestamp;
declare vt_caregiverresponsetime timestamp;
declare vt_otherchildrensponsetime timestamp;
declare vt_finalresponsetime  timestamp;
			
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

declare v_timerdetails json;

declare v_av_count integer default 0;
declare v_icc_count integer default 0;
declare v_child_count integer default 0;
declare v_total_child_count integer default 0;
declare v_timer_sw_no_child_count integer default 0;
declare v_intakenumber character varying;

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
												selectedcontact character varying 
											);
				
	-- RAISE NOTICE 'v_intakeserviceid >> %', v_intakeserviceid;	
	If v_user_id is null or btrim(v_user_id) = '' then
		v_user_id := 'cwResponseTm';
	end if;

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
	
	IF vt_responsetimer is not null and vt_responsetimer::date <= '2022-03-18'::date
		and vl_icc_count = 0 THEN
		-- for responsetimer value is NOT NULL and Initial Contact Caregiver (ICC) person is NOT available
		-- Do not re-validate (this is to avoid re-setting of the responsetimer for the old cases)
		-- RAISE NOTICE 'Do not re-validate Response Timer';	
	ELSE
		-- RAISE NOTICE 'Do re-validate >> Alleged victim ';	
		
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
				and insr.intakeservicerequestpersontypekey = 'AV' and p.dateofdeath is null
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
					p.starttime -- p.endtime -- p.contactdate 
				into vs_roletype,
					vl_witsid,
					vt_contactdate
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
						(	roletype, personid, witsid, contactdate, selectedcontact ) 
					values
						(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL );
				ELSE
					Insert into tmp_responsetimer
						(	roletype, personid, witsid, contactdate, selectedcontact ) 
					values
						(	'AV', vu_personid, NULL, NULL, NULL );
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
						p.starttime -- p.endtime -- p.contactdate 
					into vs_roletype,
						vl_witsid,
						vt_contactdate
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
							(	roletype, personid, witsid, contactdate, selectedcontact ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact ) 
						values
							(	'ICC', vu_personid, NULL, NULL, NULL );
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
						p.starttime -- p.endtime -- p.contactdate 
					into vs_roletype,
						vl_witsid,
						vt_contactdate
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
							(	roletype, personid, witsid, contactdate, selectedcontact ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact ) 
						values
							(	'ICC', vu_personid, NULL, NULL, NULL );
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
						p.starttime -- p.endtime -- p.contactdate 
					into vs_roletype,
						vl_witsid,
						vt_contactdate
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
							(	roletype, personid, witsid, contactdate, selectedcontact ) 
						values
							(	vs_roletype, vu_personid, vl_witsid, vt_contactdate, NULL );
					ELSE
						Insert into tmp_responsetimer
							(	roletype, personid, witsid, contactdate, selectedcontact ) 
						values
							(	'OTH', vu_personid, NULL, NULL, NULL );
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
		
		IF vl_missing_info = 0 AND v_av_count = 1 AND v_icc_count = 1 AND v_child_count = 1 THEN
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

			
			-- for Unit Testing
			/*
			select contactdate, witsid
				into vt_allegedvictimresponsetime, vl_allegedvictim_witsid
			from tmp_responsetimer 
			where roletype = 'AV'
				and selectedcontact = 'Y';
				
			RAISE NOTICE 'AV >> %', vt_allegedvictimresponsetime;	
			RAISE NOTICE 'AV >> %', vl_allegedvictim_witsid;	
			*/
			
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

			-- for Unit Testing
			/*
			select contactdate, witsid
				into vt_caregiverresponsetime, vl_caregiver_witsid
			from tmp_responsetimer 
			where roletype = 'ICC'
				and selectedcontact = 'Y';
				
			RAISE NOTICE 'ICC >> %', vt_caregiverresponsetime;	
			RAISE NOTICE 'ICC >> %', vl_caregiver_witsid;	
			*/

			-- 3) Child & Other Child - consider max conatct date
			update tmp_responsetimer
				set selectedcontact = 'Y'
			WHERE roletype = 'OTH'
				and witsid = (	select witsid 
									from tmp_responsetimer 
								where roletype = 'OTH'
								order by contactdate desc 
								limit 1
							  ); 
							  
			-- for Unit Testing
			/*
			select contactdate, witsid
				into vt_otherchildrensponsetime, vl_otherchildren_witsid
			from tmp_responsetimer 
			where roletype = 'OTH'
				and selectedcontact = 'Y';
				
			RAISE NOTICE 'OTH >> %', vt_otherchildrensponsetime;	
			RAISE NOTICE 'OTH >> %', vl_otherchildren_witsid;					  
			*/
			
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
			
			select array_to_json(array_agg(row_to_json(timer))) as Timerdetails
				into v_timerdetails
			from (	select distinct roletype, 
						contactdate,
						witsid
					from tmp_responsetimer
					where selectedcontact = 'Y'
					order by roletype
				) timer	 
			;
			
			-- RAISE NOTICE 'Final ResponseTimer >> %', vt_finalresponsetime;	
			-- RAISE NOTICE 'Final ResponseTimer >> %', vl_final_witsid;
			-- RAISE NOTICE 'v_timerdetails >> %', v_timerdetails;					  
			
			l_status := 'Stop Response Timer' ;
			
			update intakeservicerequest
			set responsetimer = vt_finalresponsetime, 
				responsetimerdetails = v_timerdetails,
				updatedby = v_user_id,
				updatedon = now()
			where intakeserviceid = v_intakeserviceid;
		ELSE
			IF vt_responsetimer is not null THEN
				l_status := 'Reset Response Timer' ;
				-- RAISE NOTICE 'Reset ResponseTimer'; 
			
				update intakeservicerequest
				set responsetimer = NULL, 
					responsetimerdetails = NULL,
					updatedby = v_user_id,
					updatedon = now()
				where intakeserviceid = v_intakeserviceid;
			ELSE
				l_status := 'Response Timer is Null, No changes are required.' ;	
			END IF;	
		END IF;	
		
		-- RAISE NOTICE 'l_status >> %', l_status;	
	END IF;	
	
	DROP TABLE IF EXISTS tmp_responsetimer;
	
	RETURN l_status;
END;

$function$
;
