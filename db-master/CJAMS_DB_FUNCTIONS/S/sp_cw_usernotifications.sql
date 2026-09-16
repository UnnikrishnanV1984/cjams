CREATE OR REPLACE FUNCTION cjams.sp_cw_usernotifications(as_notification_type character varying, ad_run_dt date)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created : 06/02/2021 
-- To Create CJAMS CW User Notifications

-- Argument   : 1) IN as_notification_type - To differentiate type of Notifications
--					'LIVARG' - Living Arrangement of 'Runaway'
--				2) IN ad_run_dt - Batch Run Date 	

-- Revision(s)
-- 06/09/2021 - Vineet Tirodkar - Changes for NOT to delete any old notifications.
-- 08/18/2021 - Vineet Tirodkar - To add new notification for Fiscal Category Code 4180 (B-107734)
-- 08/24/2021 - Vineet Tirodkar - To add new notification for Child Removal/Placement correction (B-96794)
-- 09/14/2021 - Vineet Tirodkar - To add new notification for System Generated Suspension on GAP / Adoption (B-108967 & B-113025)
-- 09/17/2021 - Vineet Tirodkar - To remove 60 Days Adoption Suspension Notifications (B-113025)
-- 10/25/2021 - Vineet Tirodkar - To call sp_cw_autocaseclosure (B-108258) - This User Story is pulled back
-- 01/12/2022 - Vineet Tirodkar - To add new notification for unconfirmed clients (Quick Add Person) (B-120424) - This User Story is pulled back
-- 01/31/2022 - Vineet Tirodkar - To add new notification for Placement Structure 525 - CfE Placement (CIDM-4204/B-123939)
-- 03/04/2022 - Vineet Tirodkar - To un-comment code of unconfirmed clients (Quick Add Person) (B-120424)
-- 03/07/2022 - Vineet Tirodkar - To add new notification for Education Best Interest Determination (CIDM-4302/B-85071)
-- 04/01/2022 - Vineet Tirodkar - To add new notification for Do Not Expunge (CIDM-4371/B-115575)
-- 04/05/2022 - Vineet Tirodkar - To un-comment call of sp_cw_autocaseclosure (CIDM-4364/B-119350)
-- 04/05/2022 - Vineet Tirodkar - To add new notification for Education Information updates Quarterly Alerts (CIDM-4403/B-85070)
-- 05/18/2022 - Vineet Tirodkar - To generate Education BID notifications for active clients only - activefalg = 1 (CDM-21308)
-- 05/24/2022 - Vineet Tirodkar - To fix the client name uuid issue for BID Placement notifications (CDM-22731)
-- 07/12/2022 - Pratap P - To generate notification for unkonwn person marital status B-125245 - ICWA Story (CIDM-5027)
-- 07/29/2022 - Pratap P - To Generate notification for supervisors for placements approved but not updated person card (CIDM-4942-AFCARS-Sex-Trafficking)
-- 08/18/2022 - Vineet Tirodkar - To add POSC SEN User story Notifications (CIDM-5024)
-- 10/07/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 10/01/2022 - Vineet Tirodkar - To add Response Timer Delay User Story Notifications (CIDM-5447/B-144171)
-- 10/06/2022 - Vineet Tirodkar - To call sp_update_historic_sen_person_flag (CIDM-5758/B-137390)
-- 10/12/2022 - Vineet Tirodkar - To fix CJAMS CW user Notifications batch failure 10/11 & 10/12 (Integer casting) - CIDM-5836
-- 11/09/2022 - Aurora Changes
-- 11/22/2022 - To fix violates not-null constraint on column body - usernotification table 
--				Plan Of Safe Care (POSC) to check person table substanceexposednewbornflag column 
-- 12/15/2022 -- Umasankar Raavi -- Added teamtypekey quickaddperson -- (CDM-27104)
-- 12/19/2022 - Vineet Tirodkar - Modifications To Re-Start the On Hold/Stop Education Alerts (CIDM-6268/B-129401)
-- 12/27/2022 - Vineet Tirodkar - For Plan Of Safe Care (POSC) to check person table substanceexposednewbornflag column (CDM-27547)
-- 02/16/2023 - Vineet Tirodkar - To Fix - Not to generate Sex-Trafficking Notifications for Closed Cases (CDM-28428)
-- 04/14/2023 - Prashanth Sampathirao - CW-Placement/Living Arrangement Placeholder Options  (CIDM-6996)
-- 04/05/2023 - Prashant Sampathirao send a notification (Bell) to the assigned caseworker if the Permanency Plan is not created after 60 days(CIDM-6812)
-- 04/27/2023 - Prashanth Sampathirao - CW-Placement/Living Arrangement Placeholder Options -modified  (CIDM-6996)
-- 05/31/2023 - Vineet Tirodkar - To Fix Child Removal/Permanency Plan notification logic (CDM-30353)
-- 06/13/2023 - Vineet Tirodkar - To fix  usernotication alert  not stopping after placement added and education added (CDM-32010)
-- 06/30/2023 - Vineet Tirodkar - Sex trafficking user notification logic fix (CDM-32568)
-- 10/04/2023 - Vineet Tirodkar - Modifications CfE Differential Board Rates Extension (CIDM-8046/B-178498)
-- 10/31/2023 - Amiya Pradhan - To fix the duplicate BID user notifications issue (CDM-35089) 
-- 01/22/2024 - Akhil Katukuri - Payment History to end based on eligibility (CIDM-8278)
-- 02-27-2024 - Veera Nadimpalli - CIDM-8350 - Notifications for IVE case closure
-- 05/06/2024 - Smitha Somasekharan- CIDM-8661-user notification for QI assessment userstory
-- 06/03/2024 - Smitha Somasekharan - IV-E Case closure update userstory changes (CIDM-8903)
-- 07/12/2024 -Charan sai Bodapati - Add Demographic story -Bell notification to add Relationship to at least one child as a Caregiver (CIDM-9027/B-195073)
-- 10/25/2024 - Veera Nadimpalli CIDM-9688 - B-207876 - Restrictions on Placements following Kinship Regulation Deployment
-- 06/03/2025 - Parshal Chitrakar CDM-44404 - Quick person notification was coming in CW while it was added on AS intake.
-- 04/14/2025 - Veera Nadimpalli CIDM-10366 B-216159 EBP Missing Data Short Term Fix
-- 05/28/2025 - Veera Nadimpalli CIDM-10434 B-214953 Living arrangement Updates
-- 06/15/2025 - Naveenkumar Chemutu CIDM-10354 - Medication psychotropic task and health disorder task status update and create series of task.
-- 08/28/2025 - Veera Nadimpalli CIDM-10626 Redetermination User story
-- 01/07/2026 - Yogeshvar Senthilkumar CIDM-10983 - ICWA notifications - 90 day reminder for Unknown ICWA Status update.
------------------------------------------------------------------------
Declare v_livingid uuid;
Declare v_servicecaseid uuid;
Declare v_personid uuid;
Declare v_toworkeridno uuid;
Declare v_supervisorid uuid;
Declare v_directorid uuid;
Declare v_securityusersid uuid;
Declare v_usernotificationid uuid;
Declare v_intakeservreqchildremovalid uuid;
Declare v_caseid uuid;
Declare v_suspensionid uuid;
Declare v_entityid uuid;
Declare v_quickpersonid uuid;
Declare v_placementid uuid;
Declare vu_objectid uuid;
Declare vu_case_id uuid;
Declare vu_intakeserviceid uuid;
Declare vu_investigationfindingid uuid;
Declare vu_alleged_maltreator uuid;
Declare vu_expungementid uuid;
Declare vu_personprogramid uuid;
Declare vs_kinship_message character varying;

Declare vs_ebp_message character varying;
Declare v_intakeservicerequestactorid uuid;
Declare vu_safecareplanid uuid;

Declare vl_servicecasenumber bigint;
Declare vl_la_days integer;
Declare vl_active_placement integer;
Declare vl_active_removal integer;
Declare vl_day integer; 
Declare vl_month integer;
Declare vl_year integer;
Declare vl_count integer;
Declare v_client_id bigint;
Declare v_removalid bigint;
Declare vl_casenumber bigint;
Declare vl_sql_code integer;
Declare v_quickperson_days integer; 
Declare vl_edu_count integer; 
Declare vl_edu_det_value integer; 
Declare vl_plcc_edu_cnt integer; 
Declare vl_edu_active_removal integer; 
	
Declare vs_client_nm varchar(150);
Declare vs_responsibilitytypekey varchar(50);
Declare vs_statecountycode varchar(5);
Declare vs_notification_txt varchar(500);
Declare vs_user_id varchar(50) DEFAULT 'cwadmin';
Declare v_notification_type varchar(50);
Declare vs_objecttype character varying;
Declare vs_fin_supervisorid character varying;
Declare vs_ive_supervisorid character varying;
Declare vs_securityusersid character varying;
Declare vs_rem_caseworkerid character varying;
Declare v_objecttype character varying;
Declare v_objectnumber character varying;
Declare v_cps_id character varying;
Declare v_cps_number character varying;
Declare vs_person_nm character varying;
Declare v_case_id character varying;
Declare v_case_type character varying;
Declare vs_exittypekey character varying;
Declare vs_send_notification character varying;
Declare vs_transactiontype character varying;
Declare vs_old_id character varying;
Declare vs_cps_id character varying;
Declare vs_subsequent_vs_cps_id character varying;
Declare vs_toworker_name character varying;
Declare vs_approvalstatus character varying;
Declare vs_posc_sen_client character varying;
Declare vs_malt_type character varying;
Declare vs_responsetimer_status character varying;
Declare vs_message character varying;
Declare vs_ive_message character varying;
Declare vs_alteraction_type character varying;
Declare vs_cfe_diff_end_date character varying;

Declare v_batch_rundate date;
Declare vd_livingstartdate date;
Declare vd_effectivedate date;
Declare	vd_expirationdate date;
Declare	v_removaldate date;
Declare	vd_placement_entry_dt date;
Declare	vd_placement_exit_dt date;
Declare	vd_enrty_plus_five date;
Declare	vd_expung_date date;
Declare	vd_subsequent_expung_date date;
Declare	vd_cfe_diff_end_date date;
Declare v_enddate date;

Declare v_current_timestamp timestamp ;
Declare vt_cps_receivedon timestamp ;
Declare vt_responsetimer timestamp ;
Declare vt_responsetimer_duedate timestamp ;
				
Declare vb_donotexpunge boolean ;
Declare vb_generate_notifications boolean ;

--CIDM-4942-AFCARS-Sex-Trafficking
declare v_sendnotification boolean;
declare vl_output_sqlcode character varying;
declare v_livingarrangementtypekey character varying;
declare v_notificationresponse character varying;
declare v_personlastupdated boolean;
cur_approved_placement record;
cur_approved_placement_refcur REFCURSOR;
case_assignment_worker record;
case_assignment_worker_refcur REFCURSOR;
v_status character varying;
	
vs_tep_approvalstatus  character varying;
v_personname  character varying;

 declare vd_placement_entry_ts date;
declare vl_client_age integer ;
declare vd_qrtp_date date;
declare v_youth_parenting_child_status character varying;
declare v_case_closure character varying;


	
-- B-102959	
cur_runaway record;
cur_runaway_refcur REFCURSOR;

cur_runaway_temp record;
cur_runaway_temp_refcur REFCURSOR;

-- Common
cur_fam_chld_assgn record;
cur_fam_chld_assgn_refcur REFCURSOR;

cur_admin_assgn record;
cur_admin_assgn_refcur REFCURSOR;

cur_county_assgn record;
cur_county_assgn_refcur REFCURSOR;

cur_directors record;
cur_directors_refcur REFCURSOR;

-- B-107734
cur_CfE record;
cur_CfE_refcur REFCURSOR;

-- B-96794
cur_removals record; 
cur_removals_refcur REFCURSOR;

cur_removal_temp record; 
cur_removal_temp_refcur REFCURSOR;

-- B-186250
cur_notifications record; 
cur_phnotifications_refcur REFCURSOR;
cur_phnotif_temp_refcur REFCURSOR;
cur_phnotif_temp record;

cur_all_assgn record;
cur_all_assgn_refcur REFCURSOR;


-- B-185252
iveccr_notifications record; 
iveccr_phnotifications_refcur REFCURSOR;
iveccr_phnotif_temp record;
iveccr_all_assgn record;
iveccr_all_assgn_refcur REFCURSOR;

Declare v_ivecaseclosurereviewid uuid;
Declare v_ivecaseclosurefromid character varying;
Declare v_ivecaseclosuretoid character varying;

-- B-108967 & B-113025 
cur_gap_supension record;
cur_gap_supension_refcur REFCURSOR;

cur_adop_supension record;
cur_adop_supension_refcur REFCURSOR;

cur_suspensions record;
cur_suspensions_refcur REFCURSOR;

cur_finance_sup record;
cur_finance_sup_refcur REFCURSOR;

cur_ive_sup record;
cur_ive_sup_refcur REFCURSOR;

-- B-120424
cur_quickaddperson record;
cur_quickaddperson_refcur REFCURSOR;

cur_quickaddperson_temp record;
cur_quickaddperson_temp_refcur REFCURSOR;

-- B-123939
cur_cfe_placement record;
cur_cfe_placement_refcur REFCURSOR;

cur_cfe_placement_temp record;
cur_cfe_placement_temp_refcur REFCURSOR;

-- B-85071
cur_edu_bid_removal record;
cur_edu_bid_removal_refcur REFCURSOR;

cur_edu_bid_temp record;
cur_edu_bid_temp_refcur REFCURSOR;

cur_pp_bid_temp record;
cur_pp_bid_temp_refcur REFCURSOR;

cur_pp_bid_removal record;
cur_pp_bid_removal_refcur REFCURSOR;

cur_la_bid_temp record;
cur_la_bid_temp_refcur REFCURSOR;

cur_la_bid_removal record;
cur_la_bid_removal_refcur REFCURSOR;


cur_edu_bid_person record;
cur_edu_bid_person_refcur REFCURSOR;

cur_edu_bid_placement record;
cur_edu_bid_placement_refcur REFCURSOR;

-- B-115575
cur_donot_expunge record;
cur_donot_expunge_refcur REFCURSOR;

cur_donot_expunge_temp record;
cur_donot_expunge_temp_refcur REFCURSOR;

-- B-85070
cur_qtrlyalerts record;
cur_qtrlyalerts_refcur REFCURSOR;

cur_qtrlyalerts_temp record;
cur_qtrlyalerts_temp_refcur REFCURSOR;

-- CIDM-5024
cur_posc00 record;
cur_posc00_refcur REFCURSOR;

cur_ttb_posc record;
cur_ttb_posc_refcur REFCURSOR;

cur_posc_next record;
cur_posc_next_refcur REFCURSOR;

cur_posc_sen_client record;
cur_posc_sen_clients_refcur REFCURSOR;

-- CIDM-5447/B-144171
cur_responsetimer record;
cur_responsetimer_refcur REFCURSOR;

cur_ttb_responsetimer record;
cur_ttb_responsetimer_refcur REFCURSOR;

-- CIDM-6268 / B-129401
cur_reset_education_alert record;
cur_reset_education_alert_refcur REFCURSOR;


qicur_qinotifications_refcur REFCURSOR;
qicur_notifications record;
qicur_all_assgn_refcur REFCURSOR;
qicur_all_assgn record;
qicur_qinotif_temp_refcur REFCURSOR;
qicur_qinotif_temp record;

		
BEGIN

	DROP TABLE IF EXISTS tmp_batch_run;
	CREATE TEMPORARY TABLE tmp_batch_run (batchrundate date);

	DROP TABLE IF EXISTS ttb_la_runaways CASCADE;
	CREATE TEMPORARY TABLE ttb_la_runaways
		(	livingid uuid,
			securityusersid uuid,
			notification_txt varchar(500),
			effectivedate date,
			expirationdate date,
			case_number bigint,
			servicecaseid uuid
		) ;

	IF ad_run_dt is null OR ad_run_dt = '1900-01-01' THEN
		-- ad_run_dt := current_date;
		Insert into tmp_batch_run (batchrundate)
		(select generate_series(
			coalesce(( select max(start_ts)::date + interval '1 day' 
						from tb_batch_log 
					   where batch_master_id = 75
						and success_sw = 'Y'
					  ), now()::date
					), 
			now()::date, 
			'1 day'::interval
			)
		 order by 1
		 );
	ELSE
		Insert into tmp_batch_run ( batchrundate ) 
		values ( ad_run_dt::date ) ;
	END IF;
	
	IF as_notification_type is null or btrim(as_notification_type) = '' THEN
		as_notification_type := 'All';
	END IF;
	-- RAISE NOTICE 'as_notification_type >> %',as_notification_type;
	
	-- v_batch_rundate - Start
	FOR v_batch_rundate in select batchrundate from tmp_batch_run
	LOOP
		RAISE NOTICE 'v_batch_rundate >> %', v_batch_rundate;

		ad_run_dt := v_batch_rundate ; 
		RAISE NOTICE 'ad_run_dt >> %',ad_run_dt;
		
		vd_effectivedate := current_date;
		
		-- CIDM-4942-AFCARS-Sex-Trafficking
		RAISE NOTICE 'sex trafficking start';

		IF lower(as_notification_type) = 'refppcourtorder' OR lower(as_notification_type) = 'all' THEN
			select * into vs_ive_message from sp_cw_ive_usernotifications(as_notification_type, ad_run_dt);
		END IF;

		IF lower(as_notification_type) = 'placement_notification' OR lower(as_notification_type) = 'all' THEN
			v_sendnotification := false;

			open cur_approved_placement_refcur for
			select 
				un.insertedon as initialapproval, un.entityid as placementid, un.objecttype as objecttype, un.objectcasenumber as servicecasenum, 
				un.objectid as servicecaseid, p.personid as personid,
				' ('||person.cjamspid || '/'|| person.lastname || ' ' || person.firstname || ') ' as persondetails,
				'10' as daynum
				--un.insertedon ::date + interval '55' day = '2022-08-08'::date, un.insertedon ::date + interval '55' day, un.insertedon ::date, now()::date, un.insertedon ::date= now()::date, p.placementid, p.personid , * 
			from placement p 
				inner join usernotification un on un.entityid ::uuid = p.placementid
				inner join person person on person.personid = p.personid and person.activeflag = 1
				left join personbehavioralhealth pbh on pbh.personid  = p.personid
			where un.old_id = 'MS_INITIAL'
				and (un.insertedon ::date + interval '10' day = ad_run_dt::date or un.insertedon ::date + interval '55' day = ad_run_dt::date) 
				and (un.insertedon > pbh.updatedon or pbh.updatedon is null)
				and p.activeflag = 1
				and (select (case when sd.intakeserreqstatustypekey <> 'Closed' then 
								sd.intakeserreqstatustypekey
							else 
								(case when (select ro.routingstatustypeid
											from routing ro 
											where ro.objectid = sd.servicecasedispositionid::character varying
											and ro.activeflag = 1
											order by ro.insertedon desc
											limit 1
											) = 16 then 
									sd.intakeserreqstatustypekey
								else
									'Open'
								end )
							end )
						from servicecasedisposition sd
					 where sd.servicecaseid = p.servicecaseid
						and sd.activeflag = 1
					order by sd.insertedon desc
					limit 1
					) <> 'Closed'
				-- Check for the Sex Trafficking Update
				and (select count(*)
						from personabusesubstance psa
					where psa.personid = person.personid
						and psa.activeflag = 1
						and psa.ischildhassextraffic is not null -- (During The Current Removal, If Applicable)
						and psa.updatedon > un.insertedon   
					) = 0	
			union all
			(WITH personchild AS(
					select max(removaldate)::date as removaldate, iscr.personid from intakeservreqchildremoval iscr
					inner join placement p on p.personid = iscr.personid 
					inner join usernotification un on un.entityid ::uuid = p.placementid
					where iscr.activeflag = 1 and un.old_id = 'MS_INITIAL'
					group by iscr.personid
			)
			select 
				un.insertedon as initialapproval, un.entityid as placementid, un.objecttype as objecttype, un.objectcasenumber as servicecasenum, 
				un.objectid as servicecaseid, p.personid as personid,
				' ('||person.cjamspid || '/'|| person.lastname || ' ' || person.firstname || ') ' as persondetails,
				'55' as daynum
				--un.insertedon ::date + interval '55' day = '2022-08-08'::date, un.insertedon ::date + interval '55' day, un.insertedon ::date, now()::date, un.insertedon ::date= now()::date, p.placementid, p.personid , * 
			from placement p 
				inner join usernotification un on un.entityid ::uuid = p.placementid
				inner join person person on person.personid = p.personid and person.activeflag = 1
				left join intakeservreqchildremoval isrcr on isrcr.intakeservreqchildremovalid = p.intakeservreqchildremovalid
				left join personchild on personchild.personid = person.personid 
				-- left join (select max(removaldate)::date as removaldate, personid from intakeservreqchildremoval where activeflag = 1 group by personid) personchild 
				-- on personchild.personid = person.personid
				left join personbehavioralhealth pbh on pbh.personid  = p.personid
			where un.old_id = 'MS_INITIAL'
				and ( ad_run_dt :: date = 
					case 
						when (isrcr.removaldate is not null) then isrcr.removaldate :: date + interval '55' day
					 	when (isrcr.removaldate is null) then personchild.removaldate :: date + interval '55' day
					end )
				and (un.insertedon > pbh.updatedon or pbh.updatedon is null)
				and p.activeflag =1
				and (select (case when sd.intakeserreqstatustypekey <> 'Closed' then 
								sd.intakeserreqstatustypekey
							else 
								(case when (select ro.routingstatustypeid
											from routing ro 
											where ro.objectid = sd.servicecasedispositionid::character varying
											and ro.activeflag = 1
											order by ro.insertedon desc
											limit 1
											) = 16 then 
									sd.intakeserreqstatustypekey
								else
									'Open'
								end )
							end )
						from servicecasedisposition sd
					 where sd.servicecaseid = p.servicecaseid
						and sd.activeflag = 1
					order by sd.insertedon desc
					limit 1
					) <> 'Closed'
				-- Check for the Sex Trafficking Update
				and (select count(*)
						from personabusesubstance psa
					where psa.personid = person.personid
						and psa.activeflag = 1
						and psa.ischildhassextraffic is not null -- (During The Current Removal, If Applicable)
						and psa.updatedon > un.insertedon   
					) = 0	
			)
			;
			
			-- RAISE NOTICE 'sex trafficking after cursor';

			loop
				fetch cur_approved_placement_refcur into cur_approved_placement;
				exit when not found;
			
				v_status := v_status || ' placement:' ||cur_approved_placement.placementid;
					
				vs_notification_txt := cur_approved_placement.persondetails || 'sex trafficking information hasnot updated yet.' || ' Please update the information in Person Card > Health Tab > Behavioral Health/Substance Use Card.';

				open case_assignment_worker_refcur for
					select ca.toworkeridno,
						up.supervisorid as supervisor
					from caseassignment ca  
						-- join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = cur_approved_placement.servicecaseid::uuid
						and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

					/*
					select r.fromsecurityusersid as supervisor 
						from routing r 
					where r.objectid = cur_approved_placement.placementid::character varying 
						and r.activeflag =1 and r.tosecurityusersid is not null
						and r.fromroleid = 'CWSP' and r.toroleid = 'CWCW' and r.routingstatustypeid = 16 limit 1;
					*/
				loop 
					fetch case_assignment_worker_refcur into case_assignment_worker;
					exit when not found;
					
					-- RAISE NOTICE 'case_assignment_worker supervisor:%, servicecaseid:%',case_assignment_worker.supervisor, cur_approved_placement.servicecaseid;
					-- For Worker
					INSERT INTO usernotification 
					(	securityusersid,usernotificationtypekey,objectid,activeflag,subject,
						priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
						updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
						teamtypekey, old_id, entityid
					)
					VALUES 
					(	case_assignment_worker.toworkeridno, 'System'::character varying, cur_approved_placement.servicecaseid, 1, vs_notification_txt::character varying,
						'Normal'::character varying, vs_notification_txt::character varying, false, vs_user_id,                                                                                                                                                                                                                                                                                        
						now(), vs_user_id, now(), now(), false, 'servicecase', cur_approved_placement.servicecasenum, 
						'CW', 'MS_'|| cur_approved_placement.daynum, cur_approved_placement.placementid
					)  RETURNING "usernotificationid" INTO  v_usernotificationid;                                                                                                                                                                                                                                             
																																																																																									
					INSERT INTO usernotificationmap
					(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
						effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
					)
					VALUES 
					(	v_usernotificationid, case_assignment_worker.toworkeridno, case_assignment_worker.toworkeridno, false,
						now(), 1, vs_user_id, now(), vs_user_id, now()
					);
					
					-- For supervsior 
					INSERT INTO usernotification 
					(	securityusersid,usernotificationtypekey,objectid,activeflag,subject,
						priorityleveltypekey,body,isexternalentity,updatedby,                                                                                                                                                                                                                                                                        
						updatedon,insertedby,insertedon,effectivedate,ismailsent, objecttype, objectcasenumber, 
						teamtypekey, old_id, entityid
					)
					VALUES 
					(	case_assignment_worker.supervisor, 'System'::character varying, cur_approved_placement.servicecaseid, 1, vs_notification_txt::character varying,
						'Normal'::character varying, vs_notification_txt::character varying, false, vs_user_id,                                                                                                                                                                                                                                                                                        
						now(), vs_user_id, now(), now(), false, 'servicecase', cur_approved_placement.servicecasenum, 
						'CW', 'MS_'|| cur_approved_placement.daynum, cur_approved_placement.placementid
					)  RETURNING "usernotificationid" INTO  v_usernotificationid;                                                                                                                                                                                                                                             
																																																																																									
					INSERT INTO usernotificationmap
					(	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
						effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
					)
					VALUES 
					(	v_usernotificationid, case_assignment_worker.supervisor, case_assignment_worker.supervisor, false,
						now(), 1, vs_user_id, now(), vs_user_id, now()
					);
		
					-- select * into v_notificationresponse  from send_notification(case_assignment_worker.fromsecurityusersid, case_assignment_worker.fromsecurityusersid, case_assignment_worker.fromsecurityusersid, 
					-- 		'System'::character varying, 'Normal'::character varying, vs_notification_txt::character varying, vs_notification_txt::text, cur_approved_placement.servicecaseid::character varying, false);	
					--v_status := v_status || ' notification sent to '|| case_assignment_worker.fromsecurityusersid;
					-- RAISE NOTICE 'notification sent to :%, person:%, servicecase:%',case_assignment_worker.supervisor, cur_approved_placement.persondetails, cur_approved_placement.servicecasenum;
		
				end loop;
				close case_assignment_worker_refcur;
				
			end loop;
			close cur_approved_placement_refcur;
		END IF;
		-- RAISE NOTICE 'sex trafficking end';

		--CIDM-5027 -- unkown person marital status start
		
		IF lower(as_notification_type) = 'unkonwn_person_maritalstatus' THEN

			v_sendnotification := false;

			DROP TABLE IF EXISTS ttb_notification CASCADE;
			CREATE TEMPORARY TABLE ttb_notification
			(	workerid varchar(50),
				servicecaseid character varying,
				workertype varchar(20),
				notificationdays varchar(50)
			) ;

			insert into ttb_notification ( servicecaseid, workerid, workertype, notificationdays)
			select distinct isra.servicecaseid as servicecaseid, ca.toworkeridno, 'caseworker', DATE_PART('day', current_Date-p.updatedon)
				from person p 
				inner join intakeservicerequestactor isra on isra.personid = p.personid 
				join servicecase sc on sc.servicecaseid = isra.servicecaseid and sc.activeflag = 1
				join caseassignment ca on ca.objectid = isra.servicecaseid and (ca.enddate is null or ca.enddate >= now())
				where p.maritalstatustypekey = 'UK' and p.activeflag = 1 
					and (DATE_PART('day', current_Date-p.updatedon)::number %30)=0 and DATE_PART('day', current_Date-p.updatedon)::number >1;
			
			insert into ttb_notification ( servicecaseid, workerid, workertype, notificationdays)
			select distinct isra.intakeserviceid as servicecaseid, ca.toworkeridno, 'caseworker', DATE_PART('day', current_Date-p.updatedon)
				from person p 
				inner join intakeservicerequestactor isra on isra.personid = p.personid 
				join intakeservicerequest isc on isc.intakeserviceid = isra.intakeserviceid and isc.activeflag = 1
				join caseassignment ca on ca.objectid = isra.intakeserviceid and (ca.enddate is null or ca.enddate >= now())
				where p.maritalstatustypekey = 'UK' and p.activeflag = 1 
					and (DATE_PART('day', current_Date-p.updatedon)::number %30)=0 and DATE_PART('day', current_Date-p.updatedon)::number >1;

--			supervisors information from 60 days onwards.
			insert into ttb_notification ( servicecaseid, workerid, workertype, notificationdays)
			select distinct isra.servicecaseid as servicecaseid, up.supervisorid, 'casesupervisor', DATE_PART('day', current_Date-p.updatedon)
				from person p 
				inner join intakeservicerequestactor isra on isra.personid = p.personid 
				join servicecase sc on sc.servicecaseid = isra.servicecaseid and sc.activeflag = 1
				join caseassignment ca on ca.objectid = isra.servicecaseid and (ca.enddate is null or ca.enddate >= now())
				join userprofile up on up.securityusersid = ca.toworkeridno and up.activeflag  = 1
				where p.maritalstatustypekey = 'UK' and p.activeflag = 1 
					and (DATE_PART('day', current_Date-p.updatedon)::number %30)=0 and DATE_PART('day', current_Date-p.updatedon)::number >30;

			insert into ttb_notification ( servicecaseid, workerid, workertype, notificationdays)
			select distinct isra.intakeserviceid as servicecaseid, up.supervisorid, 'casesupervisor', DATE_PART('day', current_Date-p.updatedon)
				from person p 
				inner join intakeservicerequestactor isra on isra.personid = p.personid 				
				join intakeservicerequest isc on isc.intakeserviceid = isra.intakeserviceid and isc.activeflag = 1
				join caseassignment ca on ca.objectid = isra.intakeserviceid and (ca.enddate is null or ca.enddate >= now())
				join userprofile up on up.securityusersid = ca.toworkeridno and up.activeflag  = 1				
				where p.maritalstatustypekey = 'UK' and p.activeflag = 1 
					and (DATE_PART('day', current_Date-p.updatedon)::number %30)=0 and DATE_PART('day', current_Date-p.updatedon)::number >30;

			vs_notification_txt := 'Please update marital status.';
			open case_assignment_worker_refcur for
				select distinct workerid, servicecaseid from ttb_notification where length(workerid) > 30;

			loop 
				fetch case_assignment_worker_refcur into case_assignment_worker;
				exit when not found;
					-- RAISE NOTICE 'case_assignment_worker.workerid:%, case_assignment_worker.servicecaseid:%',case_assignment_worker.workerid, case_assignment_worker.servicecaseid;

					select * into v_notificationresponse  from send_notification(case_assignment_worker.workerid, case_assignment_worker.workerid, case_assignment_worker.workerid, 
							'System'::character varying, 'Normal'::character varying, vs_notification_txt::character varying, vs_notification_txt::text, case_assignment_worker.servicecaseid::character varying, false);	
					--v_status := v_status || ' notification sent to '|| case_assignment_worker.workerid;
					-- RAISE NOTICE 'v_notificationresponse:%',v_notificationresponse;

			end loop;
			close case_assignment_worker_refcur;

		END IF;
		--CIDM-5027 -- unkown person marital status end
		
		IF lower(as_notification_type) = 'livarg' OR lower(as_notification_type) = 'all' THEN

			OPEN cur_runaway_refcur FOR
				select la.livingid,
					pl.servicecaseid,
					sc.servicecasenumber,
					pl.personid,
					pr.firstname || ' ' || pr.lastname || ' (# ' || (pr.cjamspid)::character varying || ')' as client_nm,
					la.livingstartdate::date as livingstartdate,
					(
					case when (la.livingstartdate::date + INTERVAL '7 day')::date = ad_run_dt::date then 
						7 -- '7 days'
					when (la.livingstartdate::date + INTERVAL '14 day')::date = ad_run_dt::date then 
						14 -- '14 days'
					when (la.livingstartdate::date + INTERVAL '21 day')::date = ad_run_dt::date then 
						21 -- '21 days'
					when (la.livingstartdate::date + INTERVAL '30 day')::date = ad_run_dt::date then
						30 -- '30 days'
					when ( extract(epoch from age(ad_run_dt::date, la.livingstartdate::date)/ 86400)::integer > 30
							and 
							mod((extract(epoch from age(ad_run_dt::date, (la.livingstartdate::date + interval '30 days'))/ 86400)::integer)::integer, 14) = 0
						 ) then
						44 -- 'every 14 after first 30'
					-- else	0
					end) as la_days,
					(select count(*) 
						from tb_placement plc
					where plc.personid = pl.personid
						and plc.provider_id is not null
						and plc.entry_dt is not null 
						and plc.exit_dt is null 
						and plc.approval_status_cd  = '3047' 
						and coalesce (plc.void_sw, 'N') <> 'Y'
					) as active_placement,
					(select count(*)
						from intakeservreqchildremoval icr  
							join routing rur on rur.objectid = icr.intakeservreqchildremovalid::character varying
								and rur.eventcode = 'CHRR'
								and rur.activeflag = 1
								and rur.routingstatustypeid = '16'
					where icr.personid = pl.personid
						and icr.activeflag = 1
						and icr.removaldate is not null
						and icr.exitdate is null
					) active_removal
					
				from livingarrangement la,
					placement pl,
					person pr,
					servicecase sc 	
				where la.placementid  = pl.placementid 
					and la.personid = pr.personid
					and pl.servicecaseid  = sc.servicecaseid 
					and la.activeflag = 1
					and pl.activeflag = 1
					and la.livingarrangementtypekey = 'RNW'
					and la.livingstartdate is not null
					and la.livingenddate is null
					and ( select count(*) 
							from routing ro
						  where ro.routingstatustypeid = 16 
							and ro.eventcode::text = 'PLTR'::text 
							and ro.activeflag = 1 
							and ro.objectid::text = pl.placementid::character varying::text
						) > 0
					and (
							(la.livingstartdate::date + INTERVAL '7 day')::date = ad_run_dt::date 
							or
							(la.livingstartdate::date + INTERVAL '14 day')::date = ad_run_dt::date
							or
							(la.livingstartdate::date + INTERVAL '21 day')::date = ad_run_dt::date
							or
							(la.livingstartdate::date + INTERVAL '30 day')::date = ad_run_dt::date
							or
							(
								-- date_part( 'day', age(ad_run_dt::date, (la.livingstartdate::date + INTERVAL '30 day')::date)) > 30
								-- (la.livingstartdate::date + INTERVAL '30 day')::date < ad_run_dt::date
								extract(epoch from age(ad_run_dt::date, la.livingstartdate::date)/ 86400)::integer > 30
								and 
								mod((extract(epoch from age(ad_run_dt::date, (la.livingstartdate::date + interval '30 days'))/ 86400)::integer)::integer, 14) = 0
							)
						)
					and ( select lower(dispositioncode) 
							from servicecasedisposition 
						  where servicecaseid  = pl.servicecaseid
							and activeflag  = 1
						  order by statusdate desc
						  limit 1 
						) <> 'closed'	
					-- Unit Test
					-- and pl.servicecaseid = 'f3df9c3b-19a8-4e19-a3b2-b4ad7a652738'  -- Stage 3     
					-- and pl.servicecaseid = '7dc09b82-21ba-47d7-bed1-3c1820e076bf' -- Fin-Batch 
					-- and pl.servicecaseid = 'da76744b-b1d6-414a-b465-381c99fd7b8c' -- Both
				;	
			loop
				fetch cur_runaway_refcur into cur_runaway;
				exit when not found;
			
				v_livingid := cur_runaway.livingid;
				v_servicecaseid := cur_runaway.servicecaseid;
				v_personid := cur_runaway.personid;
				vl_servicecasenumber := cur_runaway.servicecasenumber;
				vl_la_days := cur_runaway.la_days;
				vl_active_placement := cur_runaway.active_placement;
				vl_active_removal := cur_runaway.active_removal;
				vs_client_nm := cur_runaway.client_nm;
				vd_livingstartdate := cur_runaway.livingstartdate;
				
				/*
				RAISE NOTICE 'v_livingid >> %',v_livingid;
				RAISE NOTICE 'vl_la_days >> %',vl_la_days;
				RAISE NOTICE 'vd_livingstartdate >> %',vd_livingstartdate;
				RAISE NOTICE 'vl_active_placement >> %',vl_active_placement;
				RAISE NOTICE 'vl_active_removal >> %',vl_active_removal;
				
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vs_client_nm >> %',vs_client_nm;
				*/
				
				IF vl_la_days < 21 THEN
					vd_expirationdate := vd_effectivedate + interval '7 days';
				ELSE
					vd_expirationdate := vd_effectivedate + interval '14 days';
				END IF;
				
				IF vl_la_days <= 30 THEN
					vs_notification_txt := 'Alert. A Client ' || vs_client_nm || ', in this case has a Living arrangement of ''Runaway''. Complete actions in accordance to the Runaway policy.';
				ELSE -- > 30
					IF vl_active_placement > 0 THEN
						vs_notification_txt := 'Reminder notice. Client ' || vs_client_nm || ' remains in runaway status. Provider placement must be end dated.' ;
					ELSE
						vs_notification_txt := 'Reminder notice. Client ' || vs_client_nm || ' remains in runaway status.' ;
					END IF;	
				END IF;
				
				-- RAISE NOTICE 'vs_notification_txt >> %',vs_notification_txt;
				
				-- For In-Home & OOH
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_fam_chld_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
						and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
					exit when not found;
			
					vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;
					
					/*
					RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
					RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
					RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;
					*/
					-- Family/Child Worker
					Insert into ttb_la_runaways
						( 	livingid, securityusersid, notification_txt, 
							effectivedate, expirationdate, case_number, servicecaseid 
						)
					values
						( 	v_livingid, v_toworkeridno, vs_notification_txt, 
							vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
						);
						
					-- Family/Child Supervisor
					Insert into ttb_la_runaways
						(	livingid, securityusersid, notification_txt, 
							effectivedate, expirationdate, case_number, servicecaseid 
						)
					values
						(	v_livingid, v_supervisorid, vs_notification_txt, 
							vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
						);	
				
				end loop;
				close cur_fam_chld_assgn_refcur;
				
				-- For OOH
				IF vl_active_removal > 0 THEN -- OOH
					-- RAISE NOTICE 'Active Removal - OOH';
					
					-- Administrative assigned worker(s)
					OPEN cur_admin_assgn_refcur FOR
						select lower(ca.responsibilitytypekey) as responsibilitytypekey,
							ca.toworkeridno,
							up.supervisorid 
						from caseassignment ca  
							join county c on c.countyid:: character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = v_servicecaseid
							and lower(ca.responsibilitytypekey) = 'administrative'
							and ca.activeflag = 1
							and ca.enddate is null ;
					loop
						fetch cur_admin_assgn_refcur into cur_admin_assgn;
						exit when not found;
				
						vs_responsibilitytypekey := cur_admin_assgn.responsibilitytypekey;
						v_toworkeridno := cur_admin_assgn.toworkeridno;
						v_supervisorid := cur_admin_assgn.supervisorid;
						/*
						RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
						RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
						RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;
						*/
						-- Admin Worker
						Insert into ttb_la_runaways
							( 	livingid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_number, servicecaseid 
							)
						values
							( 	v_livingid, v_toworkeridno, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
							);
							
						-- Admin Supervisor
						Insert into ttb_la_runaways
							(	livingid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_number, servicecaseid 
							)
						values
							(	v_livingid, v_supervisorid, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
							);	
					end loop;
					close cur_admin_assgn_refcur;
					
					-- Aassistant director(s) & Director(s) 
					OPEN cur_county_assgn_refcur FOR
						select distinct c.statecountycode
						from caseassignment ca  
							join county c on c.countyid:: character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = v_servicecaseid
							and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
							and ca.activeflag = 1
							and ca.enddate is null 
						order by c.statecountycode desc;
					loop
						fetch cur_county_assgn_refcur into cur_county_assgn;
						exit when not found;
				
						vs_statecountycode := cur_county_assgn.statecountycode;
						
						-- RAISE NOTICE 'vs_statecountycode  >> %',vs_statecountycode;
						
						OPEN cur_directors_refcur FOR
							select up.securityusersid as directorid 
							from team t 
								join teammember tm on tm.teamid = t.teamid 
									and tm.activeflag = 1 
								join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
									and tma.activeflag = 1 
								join muser mu on mu.securityusersid = tma.securityusersid 
									and mu.activeflag = 1 
								join rolemapping rm on rm.principalid::int = mu.id 
									and rm.activeflag = 1 
									and rm.teamtypekey = 'CW'
								join county c on c.countyid::character varying = t.countyid 
								join userresource ur on ur.userid = mu.id 
									and ur.activeflag = 1
								join role r on r.id = rm.roleid::int
									and r.activeflag = 1
								join userprofile up on up.securityusersid = mu.securityusersid 
									and up.activeflag = 1
							where ur.permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e' -- DIRECTOR APPROVAL	
								and c.statecountycode = vs_statecountycode ;
						loop
							fetch cur_directors_refcur into cur_directors;
							exit when not found;
			
							v_directorid := cur_directors.directorid;
						
							-- RAISE NOTICE 'v_directorid  >> %',v_directorid;
							
							Insert into ttb_la_runaways
							( 	livingid, securityusersid, notification_txt, 
									effectivedate, expirationdate, case_number, servicecaseid 
								)
							values
								( 	v_livingid, v_directorid, vs_notification_txt, 
									vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
								);
								
						end loop;
						close cur_directors_refcur ;
					end loop;
					close cur_county_assgn_refcur;
				END IF;
			end loop;	
			close cur_runaway_refcur;
			
			-- Create Notifications
			RAISE NOTICE 'Final Runaway Notifications';
			
			OPEN cur_runaway_temp_refcur FOR
				select distinct livingid, 
					securityusersid, 
					notification_txt, 
					effectivedate, 
					expirationdate, 
					case_number,
					servicecaseid				
				from ttb_la_runaways 
				order by livingid;
			loop
				fetch cur_runaway_temp_refcur into cur_runaway_temp;
				exit when not found;
		
				v_livingid := cur_runaway_temp.livingid;
				v_securityusersid := cur_runaway_temp.securityusersid;
				vs_notification_txt := cur_runaway_temp.notification_txt;
				vd_effectivedate := cur_runaway_temp.effectivedate;
				vd_expirationdate := cur_runaway_temp.expirationdate;
				vl_servicecasenumber := cur_runaway_temp.case_number;
				v_servicecaseid := cur_runaway_temp.servicecaseid;
				vs_user_id := v_securityusersid;
				
				/*
				RAISE NOTICE 'v_livingid  >> %',v_livingid;
				RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
				RAISE NOTICE 'vs_notification_txt  >> %',vs_notification_txt;
				RAISE NOTICE 'vd_effectivedate  >> %',vd_effectivedate;
				RAISE NOTICE 'vd_expirationdate  >> %',vd_expirationdate;
				RAISE NOTICE 'vl_servicecasenumber  >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid  >> %',v_servicecaseid;
				*/
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, 'LA-RNW', 'servicecase', 
						vl_servicecasenumber, v_livingid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
							
			end loop;
			close cur_runaway_temp_refcur;
		END IF;	
		
		
		-- B-107734 - Fiscal Category Code 4180-Center for Excellence (CfE)
		vs_user_id := 'cwadmin';
		vd_expirationdate := NULL;
		vd_effectivedate := ad_run_dt;
		
		-- RAISE NOTICE 'ad_run_dt  >> %',ad_run_dt;
		
		select date_part('day', ad_run_dt::date),
			date_part('month', ad_run_dt::date),
			date_part('year', ad_run_dt::date)
		into vl_day, 
			vl_month,
			vl_year ;
			
		-- RAISE NOTICE 'vl_day  >> %',vl_day;
		-- RAISE NOTICE 'vl_month  >> %',vl_month;
		-- RAISE NOTICE 'vl_year  >> %',vl_year;	
		
		IF vl_year <= 2023 THEN
			-- 30-day notification
			/*
			You have 30 days from this date to expend funds for services using the CfE funds. 
			Expenditures not approved by the Supervisor before this cut off date will not be eligible.
			*/
			IF ( vl_month = 8 and vl_day = 31 ) 
				OR ( vl_month = 9 and vl_day = 1 ) 
				OR ( vl_month = 9 and vl_day = 2 ) THEN
				
				-- Verify if notifications are generated before
				select count(*)
					into vl_count
				from cjams.usernotification
				where lower(old_id) = 'cfe-30' 
					and date_part('month', vd_effectivedate::date) in (8,9)
					and date_part('year', vd_effectivedate::date) = vl_year;
				
				-- RAISE NOTICE 'cfe-30 - vl_count  >> %',vl_count;	
				
				IF vl_count = 0 THEN
					-- Create Notifications
					-- RAISE NOTICE 'cfe-30 Notifications';
					
					vs_notification_txt := 'You have 30 days from this date to expend funds for services using the CfE funds. Expenditures not approved by the Supervisor before this cut off date will not be eligible.'; 
					
					OPEN cur_CfE_refcur FOR
						select distinct securityusersid
							from ( 
								select up.securityusersid 
								from caseassignment ca,  
									county c, 
									userprofile up, 
									servicecase sc 
								where c.countyid:: character varying = ca.toldssid::character varying
									and up.securityusersid = ca.toworkeridno
									and ca.objectid = sc.servicecaseid
									and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
									and ca.enddate is null
									and btrim(c.statecountycode) in ('1430', '1433', '1437', '1443', '1442')
									and ca.activeflag = 1
									and up.activeflag = 1
									and sc.activeflag = 1
								union all
								select up.supervisorid 
								from caseassignment ca,  
									county c, 
									userprofile up, 
									servicecase sc 
								where c.countyid:: character varying = ca.toldssid::character varying
									and up.securityusersid = ca.toworkeridno
									and ca.objectid = sc.servicecaseid
									and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
									and ca.enddate is null
									and btrim(c.statecountycode) in ('1430', '1433', '1437', '1443', '1442')
									and ca.activeflag = 1
									and up.activeflag = 1
									and sc.activeflag = 1
								union all	
								select vu.securityusersid 
									from cjams.v_userprofile vu 
								where btrim(vu.statecountycode) in ('1430', '1433', '1437', '1443', '1442') 
									and userteamtype  = 'FNS'
								union all
								select up.securityusersid  
								from team t 
									join teammember tm on tm.teamid = t.teamid 
										and tm.activeflag = 1 
									join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
										and tma.activeflag = 1 
									join muser mu on mu.securityusersid = tma.securityusersid 
										and mu.activeflag = 1 
									join rolemapping rm on rm.principalid::int = mu.id 
										and rm.activeflag = 1 
										and rm.teamtypekey = 'CW'
									join county c on c.countyid::character varying = t.countyid 
									join userresource ur on ur.userid = mu.id 
										and ur.activeflag = 1
									join role r on r.id = rm.roleid::int
										and r.activeflag = 1
									join userprofile up on up.securityusersid = mu.securityusersid 
										and up.activeflag = 1
								where ur.permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e' -- DIRECTOR APPROVAL	
									and btrim(c.statecountycode) in ('1430', '1433', '1437', '1443', '1442') 
							) as tav;
					loop
						fetch cur_CfE_refcur into cur_CfE;
						exit when not found;
				
						v_securityusersid := cur_CfE.securityusersid;
						
						-- RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
						
						insert into cjams.usernotification
							(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
								url, subject, priorityleveltypekey, "body", hasattachments, 
								updatedby, updatedon, insertedby, insertedon, effectivedate, 
								expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
								isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
								objectcasenumber, entityid, isdeleted, teamtypekey
							)
						values
							(	gen_random_uuid(), v_securityusersid, 'System', NULL, 1, 
								NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
								vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
								vd_expirationdate, NULL, NULL, NULL, NULL, 
								false, false, NULL, 'cfe-30', NULL, 
								NULL, NULL, NULL, 'CW'
							)
						RETURNING "usernotificationid" INTO  v_usernotificationid; 

						insert into cjams.usernotificationmap
							(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
								isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
								activeflag, teammemberid, insertedby, updatedby, insertedon, 
								updatedon, fromsecurityusersid, old_id, isdeleted
							)
						values
							( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
								NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
								1, NULL, vs_user_id, vs_user_id, now(), 
								now(), NULL, NULL, NULL
							);
									
									
					end loop;
					close cur_CfE_refcur;
				ELSE
					RAISE NOTICE 'cfe-30 Notifications already generated for this year';
				END IF;
			END IF;
			
			-- 15-day notification
			/*
			You have 15 days from this date to expend funds for services using the CfE funds. 
			Expenditures not approved by the Supervisor before this cut off date will not be eligible.
			*/
			IF vl_month = 9 and ( vl_day = 15 or vl_day = 16 or vl_day = 17 ) THEN
				
				-- Verify if notifications are generated before
				select count(*)
					into vl_count
				from cjams.usernotification
				where old_id = 'cfe-15' 
					and date_part('month', vd_effectivedate::date) = 9
					and date_part('year', vd_effectivedate::date) = vl_year;
				
				-- RAISE NOTICE 'cfe-15 - vl_count  >> %',vl_count;	
				
				IF vl_count = 0 THEN
					-- Create Notifications
					-- RAISE NOTICE 'cfe-15 Notifications';
					
					vs_notification_txt := 'You have 15 days from this date to expend funds for services using the CfE funds. Expenditures not approved by the Supervisor before this cut off date will not be eligible.'; 
					
					OPEN cur_CfE_refcur FOR
						select distinct securityusersid
							from ( 
								select up.securityusersid 
								from caseassignment ca,  
									county c, 
									userprofile up, 
									servicecase sc 
								where c.countyid:: character varying = ca.toldssid::character varying
									and up.securityusersid = ca.toworkeridno
									and ca.objectid = sc.servicecaseid
									and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
									and ca.enddate is null
									and btrim(c.statecountycode) in ('1430', '1433', '1437', '1443', '1442')
									and ca.activeflag = 1
									and up.activeflag = 1
									and sc.activeflag = 1
								union all
								select up.supervisorid 
								from caseassignment ca,  
									county c, 
									userprofile up, 
									servicecase sc 
								where c.countyid:: character varying = ca.toldssid::character varying
									and up.securityusersid = ca.toworkeridno
									and ca.objectid = sc.servicecaseid
									and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
									and ca.enddate is null
									and btrim(c.statecountycode) in ('1430', '1433', '1437', '1443', '1442')
									and ca.activeflag = 1
									and up.activeflag = 1
									and sc.activeflag = 1
								union all	
								select vu.securityusersid 
									from cjams.v_userprofile vu 
								where btrim(vu.statecountycode) in ('1430', '1433', '1437', '1443', '1442') 
									and userteamtype  = 'FNS'
								union all
								select up.securityusersid  
								from team t 
									join teammember tm on tm.teamid = t.teamid 
										and tm.activeflag = 1 
									join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
										and tma.activeflag = 1 
									join muser mu on mu.securityusersid = tma.securityusersid 
										and mu.activeflag = 1 
									join rolemapping rm on rm.principalid::int = mu.id 
										and rm.activeflag = 1 
										and rm.teamtypekey = 'CW'
									join county c on c.countyid::character varying = t.countyid 
									join userresource ur on ur.userid = mu.id 
										and ur.activeflag = 1
									join role r on r.id = rm.roleid::int
										and r.activeflag = 1
									join userprofile up on up.securityusersid = mu.securityusersid 
										and up.activeflag = 1
								where ur.permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e' -- DIRECTOR APPROVAL	
									and btrim(c.statecountycode) in ('1430', '1433', '1437', '1443', '1442') 
							) as tav;
					loop
						fetch cur_CfE_refcur into cur_CfE;
						exit when not found;
				
						v_securityusersid := cur_CfE.securityusersid;
						
						-- RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
						
						insert into cjams.usernotification
							(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
								url, subject, priorityleveltypekey, "body", hasattachments, 
								updatedby, updatedon, insertedby, insertedon, effectivedate, 
								expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
								isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
								objectcasenumber, entityid, isdeleted, teamtypekey
							)
						values
							(	gen_random_uuid(), v_securityusersid, 'System', NULL, 1, 
								NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
								vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
								vd_expirationdate, NULL, NULL, NULL, NULL, 
								false, false, NULL, 'cfe-15', NULL, 
								NULL, NULL, NULL, 'CW'
							)
						RETURNING "usernotificationid" INTO  v_usernotificationid; 

						insert into cjams.usernotificationmap
							(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
								isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
								activeflag, teammemberid, insertedby, updatedby, insertedon, 
								updatedon, fromsecurityusersid, old_id, isdeleted
							)
						values
							( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
								NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
								1, NULL, vs_user_id, vs_user_id, now(), 
								now(), NULL, NULL, NULL
							);
					end loop;
					close cur_CfE_refcur;
				ELSE
					RAISE NOTICE 'cfe-15 Notifications already generated for this year';
				END IF;
			END IF;
		END IF;
		
		-- B-96794
		DROP TABLE IF EXISTS ttb_removals CASCADE;
		CREATE TEMPORARY TABLE ttb_removals
			(	notification_type varchar(50),
				intakeservreqchildremovalid uuid,
				securityusersid uuid,
				notification_txt varchar(500),
				-- effectivedate date,
				-- expirationdate date,
				case_number bigint,
				servicecaseid uuid
			) ;
			
		IF lower(as_notification_type) = 'removals' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;
			
			OPEN cur_removals_refcur FOR
				select distinct
					  (case when tab.old_id = 'RM00' then
							'RM24'
						when tab.old_id = 'RM24' then
							'RM48'
						when tab.old_id = 'RM48' then
							'RM72'
						else -- tab.old_id = 'RM72' or 'RM96'
							'RM96'
						end ) as notification_type,
					tab.intakeservreqchildremovalid,
					tab.cjamspid,
					tab.client_nm,
					tab.servicecaseid,
					tab.servicecasenumber 
				from ( select rm.intakeservreqchildremovalid,
							rm.removaldate::date as removal_date,
							pr.cjamspid ,
							pr.firstname || ' ' || pr.lastname as client_nm,
							rm.servicecaseid, 
							sc.servicecasenumber,
							btrim(un.old_id) as old_id, 
							(select count(*) 
								from placement pl
							where pl.activeflag = 1
								and pl.personid = rm.personid
								and pl.startdatetime::date = rm.removaldate::date
								and coalesce(pl.isvoided, 0) <> 1
							) as placement_cnt		
						from usernotification un,
							intakeservreqchildremoval rm,
							servicecase sc,
							person pr
						where un.entityid = rm.intakeservreqchildremovalid
							and un.insertedon::date = ad_run_dt - interval '1 Day' 
							and un.old_id in ( 'RM00', 'RM24', 'RM48', 'RM72', 'RM96')
							-- un.insertedon between v_current_timestamp - interval '24 hours' and v_current_timestamp
							and rm.servicecaseid = sc.servicecaseid 
							and rm.personid  = pr.personid 
							and rm.activeflag = 1 
							and sc.activeflag = 1
							and pr.activeflag = 1
					) tab
				where tab.placement_cnt = 0
				;
			loop
				fetch cur_removals_refcur into cur_removals;
				exit when not found;
			
				v_notification_type := cur_removals.notification_type;
				v_intakeservreqchildremovalid := cur_removals.intakeservreqchildremovalid;
				v_client_id = cur_removals.cjamspid;
				vs_client_nm = cur_removals.client_nm;
				v_servicecaseid := cur_removals.servicecaseid;
				vl_servicecasenumber := cur_removals.servicecasenumber;
				
				/*
				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservreqchildremovalid >> %',v_intakeservreqchildremovalid;
				RAISE NOTICE 'v_client_id >> %',v_client_id;
				RAISE NOTICE 'vs_client_nm >> %',vs_client_nm;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				*/
				
				IF v_notification_type = 'RM24' THEN
					vs_notification_txt := 'It''s been past 24 Hrs. the Child Removal Episode is updated for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (v_client_id)::character varying || ', Please make sure the Placement and Living arrangement are adjusted accordingly.' ;
				ELSEIF v_notification_type = 'RM48' THEN
					vs_notification_txt := 'It''s been past 48 Hrs. the Child Removal Episode is updated for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (v_client_id)::character varying || ', Please make sure the Placement and Living arrangement are adjusted accordingly.' ;
				ELSEIF v_notification_type = 'RM72' THEN
					vs_notification_txt := 'It''s been past 72 Hrs. the Child Removal Episode is updated for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (v_client_id)::character varying || ', Please make sure the Placement and Living arrangement are adjusted accordingly.';
				ELSE
					vs_notification_txt := 'It''s been past 96 Hrs. the Child Removal Episode is updated for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (v_client_id)::character varying || ', Please make sure the Placement and Living arrangement are adjusted accordingly.';
				END IF;
				
				-- RAISE NOTICE 'vs_notification_txt >> %',vs_notification_txt;
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_fam_chld_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
						and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
					exit when not found;
			
					vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;
					
					/*
					RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
					RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
					RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;
					*/
					-- Family/Child Worker
					Insert into ttb_removals
						( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
							case_number, servicecaseid 
						)
					values
						( 	v_notification_type, v_intakeservreqchildremovalid, v_toworkeridno, vs_notification_txt, 
							vl_servicecasenumber, v_servicecaseid 
						);
						
					-- Family/Child Supervisor
					IF v_supervisorid is not null THEN
						Insert into ttb_removals
							( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
								case_number, servicecaseid 
							)
						values
							(	v_notification_type, v_intakeservreqchildremovalid, v_supervisorid, vs_notification_txt, 
								vl_servicecasenumber, v_servicecaseid 
							);	
					END IF;
				end loop;
				close cur_fam_chld_assgn_refcur;
				
				IF v_notification_type <> 'RM24' THEN
					-- Add Directors
					-- Aassistant director(s) & Director(s) 
					OPEN cur_county_assgn_refcur FOR
						select distinct c.statecountycode
						from caseassignment ca  
							join county c on c.countyid:: character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag = 1
						where ca.objectid = v_servicecaseid
							and lower(ca.responsibilitytypekey) in ('family', 'child')
							and ca.activeflag = 1
							and ca.enddate is null 
						order by c.statecountycode desc;
					loop
						fetch cur_county_assgn_refcur into cur_county_assgn;
						exit when not found;
				
						vs_statecountycode := cur_county_assgn.statecountycode;
						
						-- RAISE NOTICE 'vs_statecountycode  >> %',vs_statecountycode;
						
						OPEN cur_directors_refcur FOR
							select up.securityusersid as directorid 
							from team t 
								join teammember tm on tm.teamid = t.teamid 
									and tm.activeflag = 1 
								join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
									and tma.activeflag = 1 
								join muser mu on mu.securityusersid = tma.securityusersid 
									and mu.activeflag = 1 
								join rolemapping rm on rm.principalid::int = mu.id 
									and rm.activeflag = 1 
									and rm.teamtypekey = 'CW'
								join county c on c.countyid::character varying = t.countyid 
								join userresource ur on ur.userid = mu.id 
									and ur.activeflag = 1
								join role r on r.id = rm.roleid::int
									and r.activeflag = 1
								join userprofile up on up.securityusersid = mu.securityusersid 
									and up.activeflag = 1
							where ur.permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e' -- DIRECTOR APPROVAL	
								and c.statecountycode = vs_statecountycode ;
						loop
							fetch cur_directors_refcur into cur_directors;
							exit when not found;
			
							v_directorid := cur_directors.directorid;
						
							-- RAISE NOTICE 'v_directorid  >> %',v_directorid;
							
							Insert into ttb_removals
								( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
									case_number, servicecaseid 
								)
							values
								( 	v_notification_type, v_intakeservreqchildremovalid, v_directorid, vs_notification_txt, 
									vl_servicecasenumber, v_servicecaseid 
								);
								
						end loop;
						close cur_directors_refcur ;
					end loop;
					close cur_county_assgn_refcur;	
				END IF;
			end loop;	
			close cur_removals_refcur;
			
			-- Create Notifications
			RAISE NOTICE 'Final Removal Notifications';
			
			OPEN cur_removal_temp_refcur FOR
				select distinct notification_type,
					intakeservreqchildremovalid, 
					securityusersid, 
					notification_txt, 
					case_number,
					servicecaseid				
				from ttb_removals 
				order by notification_type;
			loop
				fetch cur_removal_temp_refcur into cur_removal_temp;
				exit when not found;
		
				v_notification_type := cur_removal_temp.notification_type;
				v_intakeservreqchildremovalid := cur_removal_temp.intakeservreqchildremovalid;
				v_securityusersid := cur_removal_temp.securityusersid;
				vs_notification_txt := cur_removal_temp.notification_txt;
				vl_servicecasenumber := cur_removal_temp.case_number;
				v_servicecaseid := cur_removal_temp.servicecaseid;
				
				/*
				RAISE NOTICE 'v_notification_type  >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservreqchildremovalid  >> %',v_intakeservreqchildremovalid;
				RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
				RAISE NOTICE 'vs_notification_txt  >> %',vs_notification_txt;
				RAISE NOTICE 'vl_servicecasenumber  >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid  >> %',v_servicecaseid;
				*/
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, v_intakeservreqchildremovalid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
							
			end loop;
			close cur_removal_temp_refcur;
			
			delete from ttb_removals;	
		END IF;

	    -- B-186250 -- start of IVEPH
		DROP TABLE IF EXISTS ttb_phnotifications CASCADE;
		CREATE TEMPORARY TABLE ttb_phnotifications
			(	notification_type varchar(50),
				intakeservreqchildremovalid uuid,
				securityusersid uuid,
				notification_txt varchar(500),
				case_number bigint,
				servicecaseid uuid
			) ;
			
		IF lower(as_notification_type) = 'paymenthistorynotification' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;
            
			OPEN cur_phnotifications_refcur FOR
					select 
					(case when date(un.insertedon) = ad_run_dt - interval '5 Day'  then
						'IVEPH5'
					 when date(un.insertedon) = ad_run_dt - interval '10 Day'  then
						'IVEPH10'
					end ) as notification_type,
					rm.intakeservreqchildremovalid,
					pr.cjamspid,
					pr.firstname || ' ' || pr.lastname as client_nm,
					rm.servicecaseid, 
					sc.servicecasenumber,
					sc.enddate,
					un.insertedon,
					btrim(un.old_id) as old_id,
					(select max(ifa.dateagencylostlegalresponsibility)::date  
						from tb_ive_fostercare_audit ifa
						where ifa.eligibility_period_id 
							in (select eligibility_period_id   
									from tb_client_eligibility tce, 
										tb_eligibility_period tep
								where tce.eligibility_id  = tep.eligibility_id 
									and tce.delete_sw = 'N'                    
								and tep.delete_sw = 'N'
								and tce.removal_id = rm.removalid
							) 
						and ifa.dateagencylostlegalresponsibility is not null
					) as dateagencylostresp,
					(select coalesce(tep.approvalstatus, 'DRAFT')   
							from tb_client_eligibility tce, 
								tb_eligibility_period tep,
								tb_ive_fostercare_audit ifa
						where tce.eligibility_id  = tep.eligibility_id 
							and tep.eligibility_period_id = ifa.eligibility_period_id
							and tce.delete_sw = 'N'                    
							and tep.delete_sw = 'N'
							and tce.removal_id = rm.removalid
							and ifa.dateagencylostlegalresponsibility is not null
						order by ifa.dateagencylostlegalresponsibility desc
						limit 1	
						) as tep_approvalstatus											
				from usernotification un,
					intakeservreqchildremoval rm,
					servicecase sc,
					person pr
				where un.entityid = rm.intakeservreqchildremovalid
					and rm.personid  = pr.personid
					and rm.servicecaseid = sc.servicecaseid 
					and (date(un.insertedon) = ad_run_dt - interval '5 Day' or date(un.insertedon) = ad_run_dt - interval '10 Day')  
					and un.old_id = 'IVEPH0'
					and rm.exitdate is null
					and rm.activeflag = 1 
					and sc.activeflag = 1
					and pr.activeflag = 1 ;					
			loop
				fetch cur_phnotifications_refcur into cur_notifications;
				exit when not found;
			
				v_notification_type := cur_notifications.notification_type;
				v_intakeservreqchildremovalid := cur_notifications.intakeservreqchildremovalid;
				v_client_id = cur_notifications.cjamspid;
				vs_client_nm = cur_notifications.client_nm;
				v_servicecaseid := cur_notifications.servicecaseid;
				vl_servicecasenumber := cur_notifications.servicecasenumber;
				v_enddate := cur_notifications.dateagencylostresp;
				vs_tep_approvalstatus := cur_notifications.tep_approvalstatus;
				
				
				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservreqchildremovalid >> %',v_intakeservreqchildremovalid;
				RAISE NOTICE 'v_client_id >> %',v_client_id;
				RAISE NOTICE 'vs_client_nm >> %',vs_client_nm;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_enddate >> %',v_enddate;
				RAISE NOTICE 'vs_tep_approvalstatus >> %',vs_tep_approvalstatus;
				
				IF upper(vs_tep_approvalstatus) <> 'REJECTED' then

				IF v_notification_type = 'IVEPH5' THEN
					vs_notification_txt := '2nd notice: Please end-date the current placement for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (v_client_id)::character varying || ', as the agency has lost placement and care responsibility effective ('|| v_enddate ||'). Do not validate the placement beyond this date.' ;
				ELSEIF v_notification_type = 'IVEPH10' THEN
				    vs_notification_txt := 'Repeat notice: Please end-date the current placement for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (v_client_id)::character varying || ', as the agency has lost placement and care responsibility effective ('|| v_enddate ||'). Do not validate the placement beyond this date.' ;
				END IF;
				
				 RAISE NOTICE 'vs_notification_txt >> %',vs_notification_txt;
				
				-- Get Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_all_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
					--	and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_all_assgn_refcur into cur_all_assgn;
					exit when not found;
			
					vs_responsibilitytypekey := cur_all_assgn.responsibilitytypekey;
					v_toworkeridno := cur_all_assgn.toworkeridno;
					v_supervisorid := cur_all_assgn.supervisorid;
					
					
					RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
					RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
					RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;
					
					-- Family/Child Worker
					Insert into ttb_phnotifications
						( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
							case_number, servicecaseid 
						)
					values
						( 	v_notification_type, v_intakeservreqchildremovalid, v_toworkeridno, vs_notification_txt, 
							vl_servicecasenumber, v_servicecaseid 
						);
						
					-- Family/Child Supervisor
					IF v_supervisorid is not null THEN
						Insert into ttb_phnotifications
							( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
								case_number, servicecaseid 
							)
						values
							(	v_notification_type, v_intakeservreqchildremovalid, v_supervisorid, vs_notification_txt, 
								vl_servicecasenumber, v_servicecaseid 
							);	
					END IF;
				end loop;
				close cur_all_assgn_refcur;

				END IF;
					
			end loop;	
			close cur_phnotifications_refcur;

			-- Create Notifications
			RAISE NOTICE '2nd and 3rd Notifications';
			
			OPEN cur_phnotif_temp_refcur FOR
				select distinct notification_type,
					intakeservreqchildremovalid, 
					securityusersid, 
					notification_txt, 
					case_number,
					servicecaseid				
				from ttb_phnotifications 
				order by notification_type;
			loop
				fetch cur_phnotif_temp_refcur into cur_phnotif_temp;
				exit when not found;
		
				v_notification_type := cur_phnotif_temp.notification_type;
				v_intakeservreqchildremovalid := cur_phnotif_temp.intakeservreqchildremovalid;
				v_securityusersid := cur_phnotif_temp.securityusersid;
				vs_notification_txt := cur_phnotif_temp.notification_txt;
				vl_servicecasenumber := cur_phnotif_temp.case_number;
				v_servicecaseid := cur_phnotif_temp.servicecaseid;
				
				
				RAISE NOTICE 'v_notification_type  >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservreqchildremovalid  >> %',v_intakeservreqchildremovalid;
				RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
				RAISE NOTICE 'vs_notification_txt  >> %',vs_notification_txt;
				RAISE NOTICE 'vl_servicecasenumber  >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid  >> %',v_servicecaseid;
				
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, v_intakeservreqchildremovalid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
							
			end loop;
			close cur_phnotif_temp_refcur;
			
			delete from ttb_phnotifications;	
		END IF;

		-- end of IVEPH			


		-- B-185252 -- start of IVECCR

		IF lower(as_notification_type) = 'ivecaseclosurenotification' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;

						RAISE NOTICE 'vs_responsibilitytypekey  >> %',as_notification_type;
						RAISE NOTICE 'v_toworkeridno 1830  >> %',vd_effectivedate;
						RAISE NOTICE 'v_supervisorid 1983 >> %',v_current_timestamp;
						RAISE NOTICE 'v_supervisorid 1831 >> %',ad_run_dt;
            
			OPEN iveccr_phnotifications_refcur FOR

			select
					'IVECCR5' as notification_type,
					rm.ivecaseclosurereviewid,
					rt.tosecurityusersid,
					rt.fromsecurityusersid,
					sc.servicecaseid, 
					sc.servicecasenumber,
					rm.insertedon,
--					btrim(un.old_id) as old_id,
					rm.ivereviewstatus as tep_approvalstatus					
				from ivecaseclosurereview rm
				inner join servicecase sc on rm.objectid = sc.servicecaseid and sc.activeflag = 1
				inner join routing rt on rt.objectid = rm.ivecaseclosurereviewid::character varying and rt.routingstatustypeid in (201,202,203,205)
				where date(rm.insertedon) <= ad_run_dt::date - interval '5 Day' and rt.activeflag = 1 and rt.eventcode = 'IVECCR'
			union
			    select
					'IVECCR5' as notification_type,
					rm.ivecaseclosurereviewid,
					rt.tosecurityusersid,
					rt.fromsecurityusersid,
					sc.adoptioncaseid , 
					sc.adoptioncasenumber,
					rm.insertedon,
                    rm.ivereviewstatus as tep_approvalstatus					
				from ivecaseclosurereview rm
				inner join adoptioncase sc on rm.objectid = sc.adoptioncaseid  and sc.activeflag = 1
				inner join routing rt on rt.objectid = rm.ivecaseclosurereviewid::character varying and rt.routingstatustypeid in (201,202,203,205)
				where date(rm.insertedon) <=  ad_run_dt::date - interval '5 Day' and rt.activeflag = 1 and rt.eventcode = 'IVECCR';


			loop
				fetch iveccr_phnotifications_refcur into iveccr_notifications;
				exit when not found;
			
				v_notification_type := iveccr_notifications.notification_type;
				v_ivecaseclosurereviewid := iveccr_notifications.ivecaseclosurereviewid;
				v_servicecaseid := iveccr_notifications.servicecaseid;
				vl_servicecasenumber := iveccr_notifications.servicecasenumber;
				v_ivecaseclosurefromid := iveccr_notifications.fromsecurityusersid;
				v_ivecaseclosuretoid := iveccr_notifications.tosecurityusersid;
				vs_tep_approvalstatus := iveccr_notifications.tep_approvalstatus;

			   vs_notification_txt := 'It''s been past 5 business Days. the Case closure review request, for the case ('|| vl_servicecasenumber ||') , needs to be Approved by IVE team' ;
					
				
				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'v_ivecaseclosurereviewid >> %',v_ivecaseclosurereviewid;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_ivecaseclosurefromid >> %',v_ivecaseclosurefromid;
				RAISE NOTICE 'v_ivecaseclosuretoid >> %',v_ivecaseclosuretoid;
				RAISE NOTICE 'vs_tep_approvalstatus >> %',vs_tep_approvalstatus;

			IF (v_ivecaseclosurefromid is not null and v_ivecaseclosuretoid is not null) THEN	
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_ivecaseclosurefromid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						v_ivecaseclosurefromid, now(), v_ivecaseclosurefromid, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, v_ivecaseclosurereviewid, NULL, 'CW'
					)

				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_ivecaseclosurefromid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
			end if ;

			IF v_ivecaseclosuretoid is not null THEN	
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_ivecaseclosuretoid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						v_ivecaseclosuretoid, now(), v_ivecaseclosuretoid, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, v_ivecaseclosurereviewid, NULL, 'CW'
					)

				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_ivecaseclosuretoid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
			else 

/*To notifications for the all the ive supervisors for unassigned cases */
 		FOR iveccr_all_assgn IN 
			select up.securityusersid from userprofile up 
				inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
   				inner join teammember tm on tm.teammemberid = tma.teammemberid 
			where up.teamtypekey = 'CW' and tm.roletypekey = 'IVESV'
			loop


			insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), iveccr_all_assgn.securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						 iveccr_all_assgn.securityusersid, now(),  iveccr_all_assgn.securityusersid, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, v_ivecaseclosurereviewid, NULL, 'CW'
					)
				
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid,  iveccr_all_assgn.securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);

					RAISE NOTICE 'v_ivecaseclosuretoid unassigned cases>> %',v_ivecaseclosuretoid;

					
					end loop;


			end if ;


					
			end loop;	
			close iveccr_phnotifications_refcur;

		END IF;


		-- end of IVECCR		
		
		-- B-120424 - Quick Add Person
		DROP TABLE IF EXISTS ttb_quickaddperson CASCADE;
		CREATE TEMPORARY TABLE ttb_quickaddperson
			(	quickpersonid uuid,
				securityusersid uuid,
				notification_txt varchar(500),
				effectivedate date,
				expirationdate date,
				case_type character varying,
				case_number character varying,
				case_id character varying
			) ;


		vs_user_id := 'cwadmin';
		vd_expirationdate := NULL;
		vd_effectivedate := ad_run_dt;
		-- v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;
					
		IF lower(as_notification_type) = 'quickaddperson' OR lower(as_notification_type) = 'all' THEN

			OPEN cur_quickaddperson_refcur FOR
				select qpr.quickpersonid, 
					qpr.objecttype, 
					qpr.intakenumber, 
					isr.intakeserviceid,
					isr.servicerequestnumber,
					qpr.firstname || ' ' || qpr.lastname as person_nm,
					(case when (qpr.insertedon::date + INTERVAL '7 day')::date  = ad_run_dt::date then
						7 -- '7 day'
					 when (qpr.insertedon::date + INTERVAL '14 day')::date = ad_run_dt::date then
						14 -- '14 day'
					 end ) as quickperson_days
				from cjams.quickperson qpr
					inner join intakedastaging ids on ids.intakenumber =  qpr.intakenumber
							and ids.activeflag  = 1
							and coalesce(ids.teamtypekey, 'CW')= 'CW'
					left outer join intakeservicerequest isr on qpr.intakenumber = isr.intakenumber
						and isr.activeflag = 1
				where qpr.activeflag = 1 
					and qpr.personid is null
					and (
							(qpr.insertedon::date + INTERVAL '7 day')::date = ad_run_dt::date 
							or
							(qpr.insertedon::date + INTERVAL '14 day')::date = ad_run_dt::date
						) 
						and (isr.teamtypekey is null or isr.teamtypekey = 'CW')
				;
			loop
				fetch cur_quickaddperson_refcur into cur_quickaddperson ;
				exit when not found;
			
				v_quickpersonid := cur_quickaddperson.quickpersonid;
				v_objecttype := cur_quickaddperson.objecttype;
				v_objectnumber := cur_quickaddperson.intakenumber;
				v_cps_id := cur_quickaddperson.intakeserviceid;
				v_cps_number := cur_quickaddperson.servicerequestnumber;
				vs_person_nm := cur_quickaddperson.person_nm;
				v_quickperson_days := cur_quickaddperson.quickperson_days;
				
				IF v_quickperson_days = 7 THEN
					vd_expirationdate := vd_effectivedate + interval '7 days';
				 ELSE 
					vd_expirationdate := null;
					--vd_expirationdate := vd_effectivedate + interval '14 days'; ???
				END IF;
				
				vs_notification_txt := 'Unidentified Quick Add card for "' || vs_person_nm || '" in this case needs to be updated, searched, and converted to a client.';
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				IF v_cps_id is not null THEN
					-- CPS
					OPEN cur_fam_chld_assgn_refcur FOR
						select lower(ca.responsibilitytypekey) as responsibilitytypekey,
							ca.toworkeridno,
							up.supervisorid 
						from caseassignment ca  
							join county c on c.countyid::character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = v_cps_id::uuid
							and lower(ca.responsibilitytypekey) = 'family'
							and ca.activeflag = 1
							and ca.enddate is null 
						order by ca.responsibilitytypekey desc
						;
					loop
						fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
						exit when not found;
				
						v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
						v_supervisorid := cur_fam_chld_assgn.supervisorid;
						v_objecttype := 'servicerequest' ;
						 
						-- Family/Child Worker
						Insert into ttb_quickaddperson
							( 	quickpersonid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_type, case_number, case_id
							)
						values
							( 	v_quickpersonid, v_toworkeridno, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_objecttype, v_cps_number, v_cps_id 
							);
							
						-- Family/Child Supervisor
						Insert into ttb_quickaddperson
							( 	quickpersonid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_type, case_number, case_id
							)
						values
							( 	v_quickpersonid, v_supervisorid, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_objecttype, v_cps_number, v_cps_id 
							);
							
					end loop;
					close cur_fam_chld_assgn_refcur;
				ELSE
					-- Intake 
					OPEN cur_fam_chld_assgn_refcur FOR
						select ru.fromsecurityusersid as toworkeridno,
							ru.tosecurityusersid as supervisorid
						from routing ru
						where ru.eventcode = 'INTR' -- Intake Review
							and ru.objectid = v_objectnumber -- Intake Number
						;
					loop
						fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
						exit when not found;
				
						v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
						v_supervisorid := cur_fam_chld_assgn.supervisorid;
					
						-- Family/Child Worker
						Insert into ttb_quickaddperson
							( 	quickpersonid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_type, case_number, case_id
							)
						values
							( 	v_quickpersonid, v_toworkeridno, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_objecttype, v_objectnumber, v_objectnumber 
							);
							
						-- Family/Child Supervisor
						Insert into ttb_quickaddperson
							( 	quickpersonid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_type, case_number, case_id
							)
						values
							( 	v_quickpersonid, v_supervisorid, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_objecttype, v_objectnumber, v_objectnumber 
							);
					
					end loop;
					close cur_fam_chld_assgn_refcur;
				END IF;	
			end loop;	
			close cur_quickaddperson_refcur;
			
			-- Create Notifications
			RAISE NOTICE 'Final Quick Add Person Notifications';
			
			OPEN cur_quickaddperson_temp_refcur FOR
				select distinct quickpersonid, 
					securityusersid, 
					notification_txt, 
					effectivedate, 
					expirationdate, 
					case_type, 
					case_number,
					case_id
				from ttb_quickaddperson 
				order by effectivedate, 
					case_number ;
			loop
				fetch cur_quickaddperson_temp_refcur into cur_quickaddperson_temp;
				exit when not found;

				v_quickpersonid := cur_quickaddperson_temp.quickpersonid;
				v_securityusersid := cur_quickaddperson_temp.securityusersid;
				vs_notification_txt := cur_quickaddperson_temp.notification_txt;
				vd_effectivedate := cur_quickaddperson_temp.effectivedate;
				vd_expirationdate := cur_quickaddperson_temp.expirationdate;
				v_objecttype := cur_quickaddperson_temp.case_type;
				v_objectnumber := cur_quickaddperson_temp.case_number;
				v_case_id := cur_quickaddperson_temp.case_id;
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', v_case_id, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, 'QK-PRN', v_objecttype, 
						v_objectnumber, v_quickpersonid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
							
			end loop;
			close cur_quickaddperson_temp_refcur;
		END IF;
		
		
		-- B-123939
		DROP TABLE IF EXISTS ttb_cfe_placement CASCADE;
		CREATE TEMPORARY TABLE ttb_cfe_placement
			(	placementid uuid,
				personid uuid,
				securityusersid uuid,
				notification_txt varchar(500),
				effectivedate date,
				expirationdate date,
				case_type character varying,
				case_number character varying,
				case_id character varying
			) ;
			
		IF lower(as_notification_type) = 'cfeplacement' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;

			-- RAISE NOTICE 'ad_run_dt  >> %',ad_run_dt;

			-- Get CfE Differential Board Rates End Date - CIDM-8046/B-178498
			select end_dt,
				to_char(end_dt, 'Mon DDth YYYY')
			into vd_cfe_diff_end_date,
				vs_cfe_diff_end_date
			from tb_fiscal_category_master 
			where fiscal_category_id = 174
				and delete_sw = 'N' ;

			OPEN cur_cfe_placement_refcur FOR
				select pl.placementid,
					pl.personid,
				   '(CJAMS PID ' || (pr.cjamspid)::character varying || ') ' || pr.firstname || ' ' || pr.lastname as client_nm,
				   pl.servicecaseid,
				   pl.case_id
				from tb_placement pl
					join person pr on pr.cjamspid = pl.client_id
				where pl.placement_structure_id = 525
					and pl.entry_dt is not null 
					and pl.exit_dt is null 
					and pl.approval_status_cd  = '3047' 
					and coalesce (pl.void_sw, 'N') <> 'Y'
					and (case when ad_run_dt = vd_cfe_diff_end_date::date then
							true
						 else 		 
							(pr.dob + interval '18 years')::date = ad_run_dt
						 end) ;
			loop
				fetch cur_cfe_placement_refcur into cur_cfe_placement;
				exit when not found;

				v_placementid := cur_cfe_placement.placementid;
				v_personid := cur_cfe_placement.personid;
				vs_client_nm := cur_cfe_placement.client_nm;
				v_servicecaseid := cur_cfe_placement.servicecaseid;
				vl_servicecasenumber := cur_cfe_placement.case_id;
				vs_objecttype = 'servicecase';			
							
				vs_notification_txt := vs_client_nm || '''s Placement with the "CfE Resource Home" provider needs to be exited as the maximum date reached due to either one of the following reasons.' || chr(10) ||
				'(Maximum period to utilize CfE funds reached - ' || vs_cfe_diff_end_date || ' (or) Child attained 18th Birthday.)' ; 
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_fam_chld_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
						and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
					exit when not found;

					vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;
					
					
					-- Family/Child Worker
					Insert into ttb_cfe_placement
						( 	placementid, personid, securityusersid, notification_txt, 
							effectivedate, expirationdate, case_type, case_number, case_id
						)
					values
						( 	v_placementid, v_personid, v_toworkeridno, vs_notification_txt, 
							vd_effectivedate, vd_expirationdate, vs_objecttype, vl_servicecasenumber, v_servicecaseid 
						);
						
					-- Family/Child Supervisor
					Insert into ttb_cfe_placement
						( 	placementid, personid, securityusersid, notification_txt, 
							effectivedate, expirationdate, case_type, case_number, case_id
						)
					values
						( 	v_placementid, v_personid, v_supervisorid, vs_notification_txt, 
							vd_effectivedate, vd_expirationdate, vs_objecttype, vl_servicecasenumber, v_servicecaseid 
						);

				end loop;
				close cur_fam_chld_assgn_refcur;	
			end loop;		
			close cur_cfe_placement_refcur ;			

			-- Create Notifications
			RAISE NOTICE 'Final CfE Placement Notifications';
			
			OPEN cur_cfe_placement_temp_refcur FOR
				select distinct placementid, 
					personid, 
					securityusersid, 
					notification_txt, 
					effectivedate, 
					expirationdate, 
					case_type, 
					case_number, 
					case_id			
				from ttb_cfe_placement ;
			loop
				fetch cur_cfe_placement_temp_refcur into cur_cfe_placement_temp;
				exit when not found;

				v_placementid := cur_cfe_placement_temp.placementid;
				v_personid := cur_cfe_placement_temp.personid;
				v_securityusersid := cur_cfe_placement_temp.securityusersid;
				vs_notification_txt := cur_cfe_placement_temp.notification_txt;
				vd_effectivedate := cur_cfe_placement_temp.effectivedate;
				vd_expirationdate := cur_cfe_placement_temp.expirationdate;
				v_case_type := cur_cfe_placement_temp.case_type;
				vl_servicecasenumber := cur_cfe_placement_temp.case_number;
				v_servicecaseid := cur_cfe_placement_temp.case_id;
				-- vs_user_id := v_securityusersid;
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, 'cfe-Placement', v_case_type, 
						vl_servicecasenumber, v_placementid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
							
			end loop;
			close cur_cfe_placement_temp_refcur;
			
			delete from ttb_cfe_placement;	
				
		END IF;	


        -- CIDM-10366 B-216159 EBP Missing Data Short Term Fix
		IF lower(as_notification_type) = 'openebpserviceplan' OR lower(as_notification_type) = 'all' THEN
		     select * into vs_ebp_message from sp_cw_ebp_serviceplan_usernotifications('openebpserviceplan', ad_run_dt);	
		END IF;	

-- B-207674  Restrictions on Placements following Kinship Regulation Deployment 
    IF lower(as_notification_type) = 'openkinplacement' OR lower(as_notification_type) = 'all' THEN
     	select * into vs_kinship_message from sp_cw_kinship_placement_usernotifications('openkinplacement', ad_run_dt);
	end if; 			
		
		-- CIDM-6268 / B-129401
		-- To Re-Start the On Hold Education Alerts 
		RAISE NOTICE 'Re-Start the On Hold Education Alerts';
		vs_user_id := 'cwadmin';
		
		OPEN cur_reset_education_alert_refcur FOR
			select 'H' as alteraction_type, 
				pl.placementid as objectid, 
				pl.personid 
			from routing rt,
				placement pl
			where rt.objectid = pl.placementid::character varying
				and pl.activeflag = 1
				and rt.activeflag = 1
				and rt.eventcode = 'PLTR'
				and rt.routingstatustypeid = '16'
				and rt.isreviewrequest = true
				and rt.insertedon::date = ad_run_dt::date
				and ( select count(*) 
						from cjams.personeducationalertactions eda
					 where eda.personid = pl.personid
						and eda.activeflag = 1
						and ( eda.startdate is not null and eda.startdate <= ad_run_dt::date )
						and ( eda.enddate is null or eda.enddate > ad_run_dt::date )
						and eda.actiontype = 'H' 
					) > 0
				group by pl.placementid, pl.personid
				having  count(*) = 1
			union all
			select 'S' as alteraction_type, 
				ped.personeducationid as objectid, 
				ped.personid 
			from personeducation ped 
			where ped.activeflag = 1
				and ped.insertedon::date = ad_run_dt::date
				and ( select count(*) 
						from cjams.personeducationalertactions eda
					 where eda.personid = ped.personid
						and eda.activeflag = 1
						and ( eda.startdate is not null and eda.startdate <= ad_run_dt::date )
						and ( eda.enddate is null or eda.enddate > ad_run_dt::date )
						and eda.actiontype = 'S' 
					) > 0
			order by alteraction_type	;
		loop
			fetch cur_reset_education_alert_refcur into cur_reset_education_alert;
			exit when not found;

			vs_alteraction_type := cur_reset_education_alert.alteraction_type;
			vu_objectid := cur_reset_education_alert.objectid;
			v_personid := cur_reset_education_alert.personid;
			vs_message := null; 
			
			if vs_alteraction_type = 'H' then -- "Hold education alerts"
				vs_message := 'New Placement/Living Arrangement was created for this client.';
			else -- 'S' "Stop All Education Alerts"
				vs_message := 'New Education record was created for this client.';
			end if;
			
			update personeducationalertactions
			set enddate = ad_run_dt::date,
				startdate = (case when startdate > ad_run_dt::date then ad_run_dt::date else startdate end),
				endreason = vs_message,
				updatedby = vs_user_id, 
				updatedon = now()
			where personid = v_personid
				and ( startdate is not null and startdate <= ad_run_dt::date )
				and ( enddate is null or enddate > ad_run_dt::date )
				and actiontype = vs_alteraction_type ;
				
		end loop;
		close cur_reset_education_alert_refcur;	
				
			
		-- B-85071
		DROP TABLE IF EXISTS ttb_edu_bid CASCADE;
		CREATE TEMPORARY TABLE ttb_edu_bid
			(	transactiontype character varying, 
				objectid uuid,
				startdate date,
				securityusersid uuid,
				notification_txt varchar(500),
				effectivedate date,
				expirationdate date,
				case_type character varying,
				case_number character varying,
				case_id uuid
			) ;
			
		IF lower(as_notification_type) = 'edubid' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			
			-- RAISE NOTICE 'ad_run_dt  >> %',ad_run_dt;
			
			-- For Removal			
			OPEN cur_edu_bid_removal_refcur FOR
				select rm.intakeservreqchildremovalid as objectid
					, rm.removaldate::date as removaldate
					, pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm
					, (case when rm.servicecaseid is not null then
							'servicecase'
					   else
							'servicerequest'
					   end) as case_type
					, coalesce(sc.servicecasenumber, irs.servicerequestnumber) as case_number
					, coalesce(rm.servicecaseid, rm.intakeserviceid) as case_id
				from intakeservreqchildremoval rm 
					join person pr on pr.personid = rm.personid 
					left join intakeservicerequest irs on irs.intakeserviceid = rm.intakeserviceid 
					left join servicecase sc on sc.servicecaseid = rm.servicecaseid 
				where rm.activeflag = 1
					and pr.activeflag = 1
					and rm.removaldate is not null
					and rm.exitdate is null
					and (select count(*)
							from routing rur 
						 where rur.objectid = rm.intakeservreqchildremovalid::character varying
							and rur.eventcode = 'CHRR'
							and rur.activeflag = 1
							and rur.routingstatustypeid = '16'
						) > 0
					and rm.insertedon::date + interval '4 days' <= ad_run_dt
					and ( select count(*)
						  from personeducation pe
							/*
							CROSS JOIN LATERAL
							json_to_recordset((pe.bestdetermination ->> 'bestDeterminationList')::json) 
								as t (	"placementid" uuid,
										"determinationvalue" integer,
										"placementdate" date,
										"updatedon" timestamp,
										"updatedby" character varying
									  )	
							*/		  
						where pe.personid = rm.personid
							and pe.activeflag = 1
							-- and t.updatedon >= rm.insertedon
							and pe.updatedon >= rm.insertedon
						) = 0
					-- CIDM-6268/B-129401
					and (select count(*) 
							from cjams.personeducationalertactions eda
						where eda.personid = rm.personid
							and eda.activeflag = 1
							and ( eda.startdate is not null and eda.startdate::date <= current_date ) -- ad_run_dt::date
							and ( eda.enddate is null or eda.enddate::date > current_date ) -- ad_run_dt::date
							and eda.actiontype in ('H','S')
						) = 0	
				order by rm.insertedon desc ;
			loop
				fetch cur_edu_bid_removal_refcur into cur_edu_bid_removal ;
				exit when not found;
				
				vu_objectid := cur_edu_bid_removal.objectid;
				v_removaldate := cur_edu_bid_removal.removaldate;
				vs_client_nm := cur_edu_bid_removal.client_nm;
				v_case_type := cur_edu_bid_removal.case_type;
				vl_casenumber := cur_edu_bid_removal.case_number;
				vu_case_id := cur_edu_bid_removal.case_id;		
				
				-- vs_notification_txt := 'Child ' || vs_client_nm || ' entered Out of Home on ' || To_char(v_removaldate, 'MM/DD/YYYY') || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Best Interest Determination and Education entries are not updated yet.';
				vs_notification_txt := 'Child ' || vs_client_nm || ' entered Out of Home on ' || To_char(v_removaldate, 'MM/DD/YYYY') || '. The Best Interest Determination and Education entries are not updated yet.';
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_fam_chld_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = vu_case_id
						and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
					exit when not found;

					vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;
					
					
					-- Family/Child Worker
					Insert into ttb_edu_bid
						(	transactiontype, objectid, startdate, securityusersid, notification_txt,
							effectivedate, expirationdate, case_type, case_number, case_id 
						) 
					values
						( 	'removal', vu_objectid, v_removaldate, v_toworkeridno, vs_notification_txt, 
							vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
						);
						
					-- Family/Child Supervisor
					Insert into ttb_edu_bid
						(	transactiontype, objectid, startdate, securityusersid, notification_txt,
							effectivedate, expirationdate, case_type, case_number, case_id 
						) 
					values
						( 	'removal', vu_objectid, v_removaldate, v_supervisorid, vs_notification_txt, 
							vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
						);

				end loop;
				close cur_fam_chld_assgn_refcur;	
				
				-- PENDING 
				-- SSA Policy Staff role Users
				-- ????????????????????? --
				
			end loop;		
			close cur_edu_bid_removal_refcur ;	

			-- For Placement (Newly Approved)
			OPEN cur_edu_bid_person_refcur FOR
				select distinct pl.personid 
					from placement pl
				where pl.activeflag = 1
					and pl.placementid 
						in (  select distinct ro.objectid::uuid
								from routing ro
							  where ro.eventcode = 'PLTR'
								and ro.activeflag = 1
								and ro.routingstatustypeid = '16'
								and insertedon::date = ad_run_dt
							)
					and coalesce(( select lower(dispositioncode) 
									from servicecasedisposition 
								  where servicecaseid  = pl.servicecaseid
									and activeflag  = 1
								  order by statusdate desc
								  limit 1 
								),'') <> 'closed' 
					-- CIDM-6268/B-129401
					and (select count(*) 
							from cjams.personeducationalertactions eda
						where eda.personid = pl.personid
							and eda.activeflag = 1
							and ( eda.startdate is not null and eda.startdate::date <= current_date ) -- ad_run_dt::date
							and ( eda.enddate is null or eda.enddate::date > current_date ) -- ad_run_dt::date
							and eda.actiontype in ('H','S')
						) = 0			
				;
			loop
				fetch cur_edu_bid_person_refcur into cur_edu_bid_person ;
				exit when not found;	
				
				v_personid := cur_edu_bid_person.personid;
				-- RAISE NOTICE 'v_personid  >> %',v_personid;
				
				-- Intitial Values 
				vl_edu_count := 0;
				vd_placement_entry_dt := null;
				vd_placement_exit_dt := null;
				vl_edu_det_value := null;
				vu_objectid := null;
				v_case_type := null;
				vl_casenumber := null;
				vu_case_id := null;
				vs_client_nm := null;
				vs_exittypekey := null; 
				vs_send_notification := 'N';
				vl_plcc_edu_cnt := 0;
				
				-- Get client's latest Placement
				select pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm,
					pl.placementid as objectid,
					pl.startdatetime::date, 
					pl.enddatetime::date,
					'servicecase' as case_type,
					sc.servicecasenumber as case_number,
					pl.servicecaseid as case_id,
					coalesce(pl.exittypekey,'') as exittypekey -- PLCC
				into vs_client_nm,
					vu_objectid,
					vd_placement_entry_dt,
					vd_placement_exit_dt,
					v_case_type,
					vl_casenumber,
					vu_case_id,
					vs_exittypekey
				from placement pl
					join person pr on pr.personid = pl.personid 
					join servicecase sc on sc.servicecaseid = pl.servicecaseid 
				where pl.activeflag = 1
				  and pr.activeflag = 1
				  and pl.personid = v_personid
				  and coalesce(pl.isvoided, 0) <> 1
				  and ( select count(*)
						  from routing ro
						where ro.objectid = pl.placementid::character varying
						  and ro.eventcode = 'PLTR'
						  and ro.activeflag = 1
						  and ro.routingstatustypeid = '16'
						  and ro.insertedon::date = ad_run_dt
					  ) > 0
				  and coalesce(( select lower(dispositioncode) 
									from servicecasedisposition 
								  where servicecaseid  = pl.servicecaseid
									and activeflag  = 1
								  order by statusdate desc
								  limit 1 
								),'') <> 'closed' 	  
				order by pl.startdatetime desc
				limit 1 ;
				
				-- RAISE NOTICE 'vu_case_id  >> %',vu_case_id;
				
				select cjams.nextbusinessday(vd_placement_entry_dt::date, 5::integer)
				into vd_enrty_plus_five ;
				
				-- IF vd_enrty_plus_five <= ad_run_dt THEN -- 5 days check
				select count(*)
					into vl_edu_count
				from personeducation ped 
				where ped.personid = v_personid
					and ped.activeflag = 1
					and coalesce(ped.startdate, ped.effectivedate)::date
						between vd_placement_entry_dt::date and vd_enrty_plus_five::date
							-- and cjams.nextbusinessday(vd_placement_entry_dt::date, 5::integer) 
				;
				
				IF vl_edu_count > 0 and vd_placement_exit_dt is null THEN
					-- Found an Education record within the placement Start Date + 5 Business Days.
				ELSE
					IF vs_exittypekey = 'PLCC' THEN
						select count(*)
							into vl_plcc_edu_cnt
							from personeducation ped 
						where ped.personid = v_personid
							and ped.enddate::date = vd_placement_exit_dt
							and ped.activeflag = 1 ;
						
						IF vl_plcc_edu_cnt > 0 THEN
							-- Found an Education record with end date same as the placement exit date
						ELSE
							vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Education entries need to be updated.';
							vs_send_notification := 'Y';
						END IF;		
					ELSE
						IF vl_edu_count > 0  THEN
							-- Found an Education record within the placement Start Date + 5 Business Days.
						ELSE	
							-- Look for recent Education record's Best Interest Determination
							SELECT t.determinationvalue
								into vl_edu_det_value
							FROM
								personeducation pe
								CROSS JOIN LATERAL
								json_to_recordset((pe.bestdetermination ->> 'bestDeterminationList')::json) 
									as t (	"placementid" uuid,
											"determinationvalue" integer,
											"placementdate" date,
											"updatedon" timestamp,
											"updatedby" character varying
										  )	
							where pe.personid = v_personid
								and pe.activeflag = 1
								and t.placementdate::date >= vd_placement_entry_dt::date	
							order by coalesce(pe.startdate, pe.effectivedate)::date desc 
							limit 1;
							
							IF vl_edu_det_value is null THEN -- Education BID Not Found
								-- Send Notification
								-- IF vs_exittypekey = 'PLCC' THEN
								--	vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Education entries need to be updated.';
								-- ELSE
									vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Best Interest Determination and Education entries need to be updated.';
								--END IF;	
								vs_send_notification := 'Y';
							ELSE
								IF vl_edu_det_value = 0 THEN -- Remain in same school
									-- Found an Education record was updated as "Remain in same school"
								ELSEIF vl_edu_det_value = 1 THEN -- Change school
									
									select count(*)
										into vl_edu_count
									from personeducation ped 
									where ped.personid = v_personid
										and ped.activeflag = 1
										and coalesce(ped.startdate, ped.effectivedate)::date
											>= vd_placement_entry_dt::date ;
											
									If vl_edu_count > 0 then
										-- Found an Education record was updated as "Change in school"
									else
									
									
										-- Send Notification
										-- vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Education entries need to be updated.';
										vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Education entries need to be updated.';
										vs_send_notification := 'Y';
									end if;	 
								END IF;
							END IF;
						END IF;	
					END IF;			
					
					vs_transactiontype := (case when vd_placement_exit_dt is not null then
													'placement_updt'	
											   else
													'placement_new'
											   end);		
				END IF;
				-- END IF; -- 5 days check
				
				-- RAISE NOTICE 'vs_transactiontype  >> %',vs_transactiontype;
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				IF vs_send_notification = 'Y' THEN
					OPEN cur_fam_chld_assgn_refcur FOR
						select lower(ca.responsibilitytypekey) as responsibilitytypekey,
							ca.toworkeridno,
							up.supervisorid 
						from caseassignment ca  
							join county c on c.countyid::character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = vu_case_id
							and lower(ca.responsibilitytypekey) in ('family', 'child')
							and ca.activeflag = 1
							and ca.enddate is null 
						order by ca.responsibilitytypekey desc;

					loop
						fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
						exit when not found;

						vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
						v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
						v_supervisorid := cur_fam_chld_assgn.supervisorid;
						
						-- RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
						
						-- Family/Child Worker
						Insert into ttb_edu_bid
							(	transactiontype, objectid, startdate, securityusersid, notification_txt,
								effectivedate, expirationdate, case_type, case_number, case_id 
							) 
						values
							( 	vs_transactiontype, vu_objectid, vd_placement_entry_dt, v_toworkeridno, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
							);
						
						-- RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;						
						
						-- Family/Child Supervisor
						Insert into ttb_edu_bid
							(	transactiontype, objectid, startdate, securityusersid, notification_txt,
								effectivedate, expirationdate, case_type, case_number, case_id 
							) 
						values
							( 	vs_transactiontype, vu_objectid, vd_placement_entry_dt, v_supervisorid, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
							);

						-- RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;						
					end loop;
					close cur_fam_chld_assgn_refcur;
					
					-- PENDING 
					-- SSA Policy Staff role Users
					-- ????????????????????? --
				
				END IF;	
			end loop;		
			close cur_edu_bid_person_refcur ;
			
			OPEN cur_edu_bid_placement_refcur FOR
				select pl.placementid as objectid,
					pl.personid,
					pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm,
					pl.startdatetime::date as placement_entry_dt, 
					pl.enddatetime::date as placement_exit_dt,
					'servicecase' as case_type,
					sc.servicecasenumber as case_number,
					pl.servicecaseid as case_id,
					coalesce(pl.exittypekey,'') as exittypekey, -- PLCC
					un.old_id,
					( select count(*)
						from intakeservreqchildremoval rm
					where rm.intakeservreqchildremovalid = pl.intakeservreqchildremovalid
						and rm.removaldate is not null
						and rm.exitdate is null
						and rm.activeflag = 1 
					) as active_removal
				from usernotification un,
					placement pl,
					servicecase sc,
					person pr
				where un.entityid = pl.placementid 
					and un.insertedon::date = ad_run_dt - interval '1 Day' 
					and un.old_id in ('edu-plc-new-bid', 'edu-plc-updt-bid')
					and pl.servicecaseid = sc.servicecaseid 
					and pr.personid = pl.personid
					and un.activeflag = 1 
					and pl.activeflag = 1
					and sc.activeflag = 1
					and pr.activeflag = 1 
					and coalesce(( select lower(dispositioncode) 
									from servicecasedisposition 
								  where servicecaseid  = pl.servicecaseid
									and activeflag  = 1
								  order by statusdate desc
								  limit 1 
								),'') <> 'closed' 
					-- CIDM-6268/B-129401
					and (select count(*) 
							from cjams.personeducationalertactions eda
						where eda.personid = pl.personid
							and eda.activeflag = 1
							and ( eda.startdate is not null and eda.startdate::date <= current_date ) -- ad_run_dt::date
							and ( eda.enddate is null or eda.enddate::date > current_date ) -- ad_run_dt::date
							and eda.actiontype in ('H','S')
						) = 0				
				;
			Loop		
				fetch cur_edu_bid_placement_refcur into cur_edu_bid_placement ;
				exit when not found;
				
				-- Intitial Values 
				vu_objectid := null;
				v_personid := null;
				vl_edu_count := 0;
				vd_placement_entry_dt := null;
				vd_placement_exit_dt := null;
				vl_edu_det_value := null;
				v_case_type := null;
				vl_casenumber := null;
				vu_case_id := null;
				vs_client_nm := null;
				vs_exittypekey := null;
				vs_send_notification := 'N';
				vs_old_id := null;
				vl_edu_active_removal := 0;
				
				vu_objectid := cur_edu_bid_placement.objectid;
				v_personid := cur_edu_bid_placement.personid;
				vs_client_nm := cur_edu_bid_placement.client_nm; -- CDM-22731
				vd_placement_entry_dt := cur_edu_bid_placement.placement_entry_dt;
				vd_placement_exit_dt := cur_edu_bid_placement.placement_exit_dt;
				v_case_type := cur_edu_bid_placement.case_type;
				vl_casenumber := cur_edu_bid_placement.case_number;
				vu_case_id := cur_edu_bid_placement.case_id;		
				vs_exittypekey := cur_edu_bid_placement.exittypekey;		
				vs_old_id := cur_edu_bid_placement.old_id ;
				vl_edu_active_removal := cur_edu_bid_placement.active_removal ;
				
				select cjams.nextbusinessday(vd_placement_entry_dt::date, 5::integer)
				into vd_enrty_plus_five ;
				
				select count(*)
					into vl_edu_count
				from personeducation ped 
				where ped.personid = v_personid
					and ped.activeflag = 1
					and coalesce(ped.startdate, ped.effectivedate)::date
						between vd_placement_entry_dt::date and vd_enrty_plus_five::date
							-- and cjams.nextbusinessday(vd_placement_entry_dt::date, 5::integer) 
					;
					
				IF vl_edu_count > 0 and vs_exittypekey <> 'PLCC' THEN
					-- Found an Education record within the placement Start Date + 5 Business Days.
				ELSE
					IF vs_exittypekey = 'PLCC' THEN
						select count(*)
							into vl_plcc_edu_cnt
							from personeducation ped 
						where ped.personid = v_personid
							and ped.enddate::date = vd_placement_exit_dt
							and ped.activeflag = 1 ;
						
						IF vl_plcc_edu_cnt > 0 THEN
							-- Found an Education record with end date same as the placement exit date
						ELSE
							vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Education entries need to be updated.';
							vs_send_notification := 'Y';
						END IF;		
					ELSE
						IF vl_edu_active_removal = 0 OR vl_edu_count > 0 THEN
							-- Closed Removal 
							-- OR
							-- Found an Education record within the placement Start Date + 5 Business Days.
						ELSE	
							-- Look for recent Education record for Best Interest Determination
							SELECT t.determinationvalue
								into vl_edu_det_value
							FROM
								personeducation pe
								CROSS JOIN LATERAL
								json_to_recordset((pe.bestdetermination ->> 'bestDeterminationList')::json) 
									as t (	"placementid" uuid,
											"determinationvalue" integer,
											"placementdate" date,
											"updatedon" timestamp,
											"updatedby" character varying
										  )	
							where pe.personid = v_personid
								and pe.activeflag = 1
								and t.placementdate::date >= vd_placement_entry_dt::date	
							order by coalesce(pe.startdate, pe.effectivedate)::date desc 
							limit 1;
							
							IF vl_edu_det_value is null THEN
								-- Send Notification
								IF vs_exittypekey = 'PLCC' THEN
									-- vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Education entries need to be updated.';
									vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Education entries need to be updated.';
								ELSE
									-- vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Best Interest Determination and Education entries need to be updated.';
									vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Best Interest Determination and Education entries need to be updated.';
								END IF;
								vs_send_notification := 'Y';
							ELSE
								IF vl_edu_det_value = 0 THEN -- Remain in same school
									-- Found an Education record was updated as "Remain in same school"
								ELSEIF vl_edu_det_value = 1 THEN -- Change school
									
									select count(*)
										into vl_edu_count
									from personeducation ped 
									where ped.personid = v_personid
										and ped.activeflag = 1
										and coalesce(ped.startdate, ped.effectivedate)::date
											>= vd_placement_entry_dt::date ;
											
									If vl_edu_count > 0 then
										-- Found an Education record was updated as "Change in school"
									else
									
										-- Send Notification
										-- vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Education entries need to be updated.';
										vs_notification_txt := 'There is a Placement Change for the Child ' || vs_client_nm || '. The Education entries need to be updated.';
										vs_send_notification := 'Y';
									end if;	
								END IF;
							END IF;
						END IF;	
					END IF;
					
					vs_transactiontype := (case when vs_old_id = 'edu-plc-updt-bid'then
												'placement_updt'	
										   else -- 'edu-plc-new-bid' 
												'placement_new'
										   end);
					
				END IF;
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				IF vs_send_notification = 'Y' THEN
					OPEN cur_fam_chld_assgn_refcur FOR
						select lower(ca.responsibilitytypekey) as responsibilitytypekey,
							ca.toworkeridno,
							up.supervisorid 
						from caseassignment ca  
							join county c on c.countyid::character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = vu_case_id
							and lower(ca.responsibilitytypekey) in ('family', 'child')
							and ca.activeflag = 1
							and ca.enddate is null 
						order by ca.responsibilitytypekey desc;

					loop
						fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
						exit when not found;

						vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
						v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
						v_supervisorid := cur_fam_chld_assgn.supervisorid;
						
						-- Family/Child Worker
						Insert into ttb_edu_bid
							(	transactiontype, objectid, startdate, securityusersid, notification_txt,
								effectivedate, expirationdate, case_type, case_number, case_id 
							) 
						values
							( 	vs_transactiontype, vu_objectid, vd_placement_entry_dt, v_toworkeridno, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
							);
							
						-- Family/Child Supervisor
						Insert into ttb_edu_bid
							(	transactiontype, objectid, startdate, securityusersid, notification_txt,
								effectivedate, expirationdate, case_type, case_number, case_id 
							) 
						values
							( 	vs_transactiontype, vu_objectid, vd_placement_entry_dt, v_supervisorid, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
							);

					end loop;
					close cur_fam_chld_assgn_refcur;
					
					-- PENDING 
					-- SSA Policy Staff role Users
					-- ????????????????????? --
				
				END IF;	
			end loop;		
			close cur_edu_bid_placement_refcur ;
			
			-- Create Notifications
			RAISE NOTICE 'Final Education Best Interest Determination Notifications';
			
			OPEN cur_edu_bid_temp_refcur FOR
				select distinct transactiontype, 
					objectid, 
					-- startdate, 
					securityusersid, 
					notification_txt,
					effectivedate, 
					expirationdate, 
					case_type, 
					case_number, 
					case_id 		
				from ttb_edu_bid ;
			loop
				fetch cur_edu_bid_temp_refcur into cur_edu_bid_temp;
				exit when not found;

				vs_transactiontype := cur_edu_bid_temp.transactiontype;
				vu_objectid := cur_edu_bid_temp.objectid;
				v_securityusersid := cur_edu_bid_temp.securityusersid;							
				vs_notification_txt := cur_edu_bid_temp.notification_txt;
				vl_casenumber := cur_edu_bid_temp.case_number;
				vu_case_id := cur_edu_bid_temp.case_id;
				v_case_type := cur_edu_bid_temp.case_type;
				
				IF NOT EXISTS (
				select 1 
					from cjams.usernotification 
				where securityusersid = v_securityusersid::character varying 
					and objectcasenumber = vl_casenumber::character varying 
					and DATE(insertedon) = DATE(now()) 
					and activeflag =1 
					and subject = vs_notification_txt::character varying 
				) THEN 				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', vu_case_id, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, 
						(case when vs_transactiontype = 'removal' then 
							'edu-rm-bid' 
						when vs_transactiontype = 'placement_new' then 	
							'edu-plc-new-bid' 
						else 
							'edu-plc-updt-bid' 
						end), 
						v_case_type, 
						vl_casenumber, vu_objectid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
				END IF;					
			end loop;
			close cur_edu_bid_temp_refcur;
			
			delete from ttb_edu_bid;
		END IF;	

		-- Permanency Plan changes
        DROP TABLE IF EXISTS ttb_permanency_bid CASCADE;
        CREATE TEMPORARY TABLE ttb_permanency_bid
	(	transactiontype character varying, 
		objectid uuid,
		startdate date,
		securityusersid uuid,
		notification_txt varchar(500),
		effectivedate date,
		expirationdate date,
		case_type character varying,
		case_number character varying,
		case_id uuid
	) ;
	
        IF lower(as_notification_type) = 'ppbid' OR lower(as_notification_type) = 'all' THEN
	vs_user_id := 'cwadmin';
	vd_expirationdate := NULL;
	vd_effectivedate := ad_run_dt;
	
	-- RAISE NOTICE 'ad_run_dt  >> %',ad_run_dt;
	
	-- For Removal			
	OPEN cur_pp_bid_removal_refcur FOR
		select rm.intakeservreqchildremovalid as objectid
			, rm.removaldate::date as removaldate
			, pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm
			, (case when rm.servicecaseid is not null then
					'servicecase'
			   else
					'servicerequest'
			   end) as case_type
			, coalesce(sc.servicecasenumber, irs.servicerequestnumber) as case_number
			, coalesce(rm.servicecaseid, rm.intakeserviceid) as case_id
		from intakeservreqchildremoval rm 
			join person pr on pr.personid = rm.personid 
			left join intakeservicerequest irs on irs.intakeserviceid = rm.intakeserviceid 
			left join servicecase sc on sc.servicecaseid = rm.servicecaseid 
		where rm.activeflag = 1
			and pr.activeflag = 1
			and rm.removaldate is not null
			and rm.exitdate is null
			and (select count(*)
					from routing rur 
				 where rur.objectid = rm.intakeservreqchildremovalid::character varying
					and rur.eventcode = 'CHRR'
					and rur.activeflag = 1
					and rur.routingstatustypeid = '16'
				) > 0
			 and rm.removaldate::date + interval '60 days' <= ad_run_dt
			 and (	select count(*)
						from permanencyplan p2
					where p2.intakeservicerequestactorid 
						 in (select isra1.intakeservicerequestactorid 
								from intakeservicerequestactor isra1 
							 where isra1.personid = rm.personid
							) 
						and p2.servicecaseid = rm.servicecaseid	
						and p2.activeflag = 1 
						and p2.establisheddate::date >= rm.removaldate::date 
				)= 0 -- 60 days
		order by rm.insertedon desc ;
	loop
		fetch cur_pp_bid_removal_refcur into cur_pp_bid_removal ;
		exit when not found;
		
		vu_objectid := cur_pp_bid_removal.objectid;
		v_removaldate := cur_pp_bid_removal.removaldate;
		vs_client_nm := cur_pp_bid_removal.client_nm;
		v_case_type := cur_pp_bid_removal.case_type;
		vl_casenumber := cur_pp_bid_removal.case_number;
		vu_case_id := cur_pp_bid_removal.case_id;		
		
		-- vs_notification_txt := 'Child ' || vs_client_nm || ' entered Out of Home on ' || To_char(v_removaldate, 'MM/DD/YYYY') || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Best Interest Determination and Education entries are not updated yet.';
		vs_notification_txt := 'Out of compliance! Client ' || vs_client_nm || ' have Child Removal over 60 days but there is no Initial Permanency Plan added. Please take immediate action.';
		
		-- Get Family and Child assigned worker(s) and their Supervisor(s) 
		OPEN cur_fam_chld_assgn_refcur FOR
			select lower(ca.responsibilitytypekey) as responsibilitytypekey,
				ca.toworkeridno,
				up.supervisorid 
			from caseassignment ca  
				join county c on c.countyid::character varying = ca.toldssid::character varying
				join userprofile up on up.securityusersid = ca.toworkeridno
					and up.activeflag  = 1
			where ca.objectid = vu_case_id
				and lower(ca.responsibilitytypekey) in ('family', 'child')
				and ca.activeflag = 1
				and ca.enddate is null 
			order by ca.responsibilitytypekey desc;

		loop
			fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
			exit when not found;

			vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
			v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
			v_supervisorid := cur_fam_chld_assgn.supervisorid;
			
			
			-- -- Family/Child Worker
			Insert into ttb_permanency_bid
				(	transactiontype, objectid, startdate, securityusersid, notification_txt,
					effectivedate, expirationdate, case_type, case_number, case_id 
				) 
			values
				( 	'removal', vu_objectid, v_removaldate, v_toworkeridno, vs_notification_txt, 
					vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
				);
				
			-- Family/Child Supervisor
			Insert into ttb_permanency_bid
				(	transactiontype, objectid, startdate, securityusersid, notification_txt,
					effectivedate, expirationdate, case_type, case_number, case_id 
				) 
			values
				( 	'removal', vu_objectid, v_removaldate, v_supervisorid, vs_notification_txt, 
					vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
				);

		end loop;
		close cur_fam_chld_assgn_refcur;	
		
	end loop;		
	close cur_pp_bid_removal_refcur ;	

	-- Create Notifications
	RAISE NOTICE 'Permanency Plan notifications';
	
	OPEN cur_pp_bid_temp_refcur FOR
		select distinct transactiontype, 
			objectid, 
			-- startdate, 
			securityusersid, 
			notification_txt,
			effectivedate, 
			expirationdate, 
			case_type, 
			case_number, 
			case_id 		
		from ttb_permanency_bid ;
	loop
		fetch cur_pp_bid_temp_refcur into cur_pp_bid_temp;
		exit when not found;

		vs_transactiontype := cur_pp_bid_temp.transactiontype;
		vu_objectid := cur_pp_bid_temp.objectid;
		v_securityusersid := cur_pp_bid_temp.securityusersid;							
		vs_notification_txt := cur_pp_bid_temp.notification_txt;
		vl_casenumber := cur_pp_bid_temp.case_number;
		vu_case_id := cur_pp_bid_temp.case_id;
		v_case_type := cur_pp_bid_temp.case_type;
		
		insert into cjams.usernotification
			(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
				url, subject, priorityleveltypekey, "body", hasattachments, 
				updatedby, updatedon, insertedby, insertedon, effectivedate, 
				expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
				isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
				objectcasenumber, entityid, isdeleted, teamtypekey
			)
		values
			(	gen_random_uuid(), v_securityusersid, 'System', vu_case_id, 1, 
				NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
				vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
				vd_expirationdate, NULL, NULL, NULL, NULL, 
				false, false, NULL, 
				'PP-rm-bid', 
				v_case_type, 
				vl_casenumber, vu_objectid, NULL, 'CW'
			)
		RETURNING "usernotificationid" INTO  v_usernotificationid; 

		insert into cjams.usernotificationmap
			(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
				isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
				activeflag, teammemberid, insertedby, updatedby, insertedon, 
				updatedon, fromsecurityusersid, old_id, isdeleted
			)
		values
			( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
				NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
				1, NULL, vs_user_id, vs_user_id, now(), 
				now(), NULL, NULL, NULL
			);
					
					
	end loop;
    	close cur_pp_bid_temp_refcur;
	
	   delete from ttb_permanency_bid;
        END IF;	

			-- placement-living arrangement palceholder
        DROP TABLE IF EXISTS ttb_living_bid CASCADE;
        CREATE TEMPORARY TABLE ttb_living_bid
	(	transactiontype character varying, 
		objectid uuid,
		startdate date,
		securityusersid uuid,
		notification_txt varchar(500),
		effectivedate date,
		expirationdate date,
		case_type character varying,
		case_number character varying,
		case_id uuid
	) ;
	
        IF lower(as_notification_type) = 'labid' OR lower(as_notification_type) = 'all' THEN
	vs_user_id := 'cwadmin';
	vd_expirationdate := NULL;
	vd_effectivedate := ad_run_dt;
	
	-- RAISE NOTICE 'ad_run_dt  >> %',ad_run_dt;
	
	-- For Removal			
	OPEN cur_la_bid_removal_refcur FOR
		select rm.placementid as objectid
            , rm.startdatetime::date as removaldate
            , pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm
            , (case when rm.servicecaseid is not null then
                    'servicecase'
               else
                    'servicerequest'
               end) as case_type
            , coalesce(sc.servicecasenumber, irs.servicerequestnumber) as case_number
            , coalesce(rm.servicecaseid, rm.intakeserviceid) as case_id
        from placement rm 
            join person pr on pr.personid = rm.personid 
            join livingarrangement la on la.placementid = rm.placementid
            left join intakeservicerequest irs on irs.intakeserviceid = rm.intakeserviceid 
            left join servicecase sc on sc.servicecaseid = rm.servicecaseid
        where rm.activeflag = 1
            and pr.activeflag = 1
            and rm.startdatetime is not null
            and rm.enddatetime is null
            and la.livingarrangementtypekey in ('FCH')
            and (select count(*)
                    from routing rur 
                 where rur.objectid = rm.placementid::character varying
                    and rur.eventcode = 'PLTR'
                    and rur.activeflag = 1
                    and rur.routingstatustypeid = '16'
                ) > 0
			 and (rm.startdatetime::date + interval '30 days' = ad_run_dt 
			 		or rm.startdatetime::date + interval '37 days' = ad_run_dt 
					or ( extract(epoch from age(ad_run_dt::date, rm.startdatetime::date::date)/ 86400)::integer > 37 
						and 
						mod((extract(epoch from age(ad_run_dt::date, (rm.startdatetime::date + interval '37 days'))/ 86400)::integer)::integer, 15) = 0
						)
			 )
			-- 60 days
		order by rm.insertedon desc ;
	loop
		fetch cur_la_bid_removal_refcur into cur_la_bid_removal ;
		exit when not found;
		
		vu_objectid := cur_la_bid_removal.objectid;
		v_removaldate := cur_la_bid_removal.removaldate;
		vs_client_nm := cur_la_bid_removal.client_nm;
		v_case_type := cur_la_bid_removal.case_type;
		vl_casenumber := cur_la_bid_removal.case_number;
		vu_case_id := cur_la_bid_removal.case_id;		
		
		-- vs_notification_txt := 'Child ' || vs_client_nm || ' entered Out of Home on ' || To_char(v_removaldate, 'MM/DD/YYYY') || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Best Interest Determination and Education entries are not updated yet.';
		vs_notification_txt := 'Review the living arrangement for this case and verify that Foster Care - Home or Foster Care - Non-foster home setting is still the best description of this childs circumstances.';
		
		-- Get Family and Child assigned worker(s) and their Supervisor(s) 
		OPEN cur_fam_chld_assgn_refcur FOR
			select lower(ca.responsibilitytypekey) as responsibilitytypekey,
				ca.toworkeridno,
				up.supervisorid 
			from caseassignment ca  
				join county c on c.countyid::character varying = ca.toldssid::character varying
				join userprofile up on up.securityusersid = ca.toworkeridno
					and up.activeflag  = 1
			where ca.objectid = vu_case_id
				and lower(ca.responsibilitytypekey) in ('family', 'child')
				and ca.activeflag = 1
				and ca.enddate is null 
			order by ca.responsibilitytypekey desc;

		loop
			fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
			exit when not found;

			vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
			v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
			v_supervisorid := cur_fam_chld_assgn.supervisorid;
			
			
			-- Family/Child Worker
			Insert into ttb_living_bid
				(	transactiontype, objectid, startdate, securityusersid, notification_txt,
					effectivedate, expirationdate, case_type, case_number, case_id 
				) 
			values
				( 	'livingArrangement', vu_objectid, v_removaldate, v_toworkeridno, vs_notification_txt, 
					vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
				);
				
			-- Family/Child Supervisor
			Insert into ttb_living_bid
				(	transactiontype, objectid, startdate, securityusersid, notification_txt,
					effectivedate, expirationdate, case_type, case_number, case_id 
				) 
			values
				( 	'livingArrangement', vu_objectid, v_removaldate, v_supervisorid, vs_notification_txt, 
					vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
				);

		end loop;
		close cur_fam_chld_assgn_refcur;	
		
	end loop;		
	close cur_la_bid_removal_refcur ;	

	-- Create Notifications
	RAISE NOTICE 'Living Arrangment notifications';
	
	OPEN cur_la_bid_temp_refcur FOR
		select distinct transactiontype, 
			objectid, 
			-- startdate, 
			securityusersid, 
			notification_txt,
			effectivedate, 
			expirationdate, 
			case_type, 
			case_number, 
			case_id 		
		from ttb_living_bid ;
	loop
		fetch cur_la_bid_temp_refcur into cur_la_bid_temp;
		exit when not found;

		vs_transactiontype := cur_la_bid_temp.transactiontype;
		vu_objectid := cur_la_bid_temp.objectid;
		v_securityusersid := cur_la_bid_temp.securityusersid;							
		vs_notification_txt := cur_la_bid_temp.notification_txt;
		vl_casenumber := cur_la_bid_temp.case_number;
		vu_case_id := cur_la_bid_temp.case_id;
		v_case_type := cur_la_bid_temp.case_type;
		
		insert into cjams.usernotification
			(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
				url, subject, priorityleveltypekey, "body", hasattachments, 
				updatedby, updatedon, insertedby, insertedon, effectivedate, 
				expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
				isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
				objectcasenumber, entityid, isdeleted, teamtypekey
			)
		values
			(	gen_random_uuid(), v_securityusersid, 'System', vu_case_id, 1, 
				NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
				vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
				vd_expirationdate, NULL, NULL, NULL, NULL, 
				false, false, NULL, 
				'la-rm-bid', 
				v_case_type, 
				vl_casenumber, vu_objectid, NULL, 'CW'
			)
		RETURNING "usernotificationid" INTO  v_usernotificationid; 

		insert into cjams.usernotificationmap
			(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
				isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
				activeflag, teammemberid, insertedby, updatedby, insertedon, 
				updatedon, fromsecurityusersid, old_id, isdeleted
			)
		values
			( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
				NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
				1, NULL, vs_user_id, vs_user_id, now(), 
				now(), NULL, NULL, NULL
			);
					
					
	end loop;
    	close cur_la_bid_temp_refcur;
	
	   delete from ttb_living_bid;
END IF;


-- CIDM-10434 / B-220037 Foster care 
IF lower(as_notification_type) = 'lafcnfhs' OR lower(as_notification_type) = 'all' THEN
	vs_user_id := 'cwadmin';
	vd_expirationdate := NULL;
	vd_effectivedate := ad_run_dt;
	
	-- RAISE NOTICE 'ad_run_dt  >> %',ad_run_dt;
	
	-- For Removal			
	OPEN cur_la_bid_removal_refcur FOR
		select rm.placementid as objectid
            , rm.startdatetime::date as removaldate
            , pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm
            , (case when rm.servicecaseid is not null then
                    'servicecase'
               else
                    'servicerequest'
               end) as case_type
            , coalesce(sc.servicecasenumber, irs.servicerequestnumber) as case_number
            , coalesce(rm.servicecaseid, rm.intakeserviceid) as case_id
        from placement rm 
            join person pr on pr.personid = rm.personid 
            join livingarrangement la on la.placementid = rm.placementid
            left join intakeservicerequest irs on irs.intakeserviceid = rm.intakeserviceid 
            left join servicecase sc on sc.servicecaseid = rm.servicecaseid
        where rm.activeflag = 1
            and pr.activeflag = 1
            and rm.startdatetime is not null
            and rm.enddatetime is null
            and la.livingarrangementtypekey in ('FCNFHS')
            and (select count(*)
                    from routing rur 
                 where rur.objectid = rm.placementid::character varying
                    and rur.eventcode = 'PLTR'
                    and rur.activeflag = 1
                    and rur.routingstatustypeid = '16'
                ) > 0
			 and (  ad_run_dt >= rm.startdatetime::date + interval '7 days' 
					or extract(epoch from age(ad_run_dt::date, rm.startdatetime::date::date)/ 86400)::integer > 7 	
			 )
			-- 60 days
		order by rm.insertedon desc ;
	loop
		fetch cur_la_bid_removal_refcur into cur_la_bid_removal ;
		exit when not found;
		
		vu_objectid := cur_la_bid_removal.objectid;
		v_removaldate := cur_la_bid_removal.removaldate;
		vs_client_nm := cur_la_bid_removal.client_nm;
		v_case_type := cur_la_bid_removal.case_type;
		vl_casenumber := cur_la_bid_removal.case_number;
		vu_case_id := cur_la_bid_removal.case_id;		
		
		-- vs_notification_txt := 'Child ' || vs_client_nm || ' entered Out of Home on ' || To_char(v_removaldate, 'MM/DD/YYYY') || ' in Case Number ' || To_char(vl_servicecasenumber) || '. The Best Interest Determination and Education entries are not updated yet.';
		vs_notification_txt := 'A youth is currently in a temporary living arrangement of a hotel, office or youth shelter. Please move the youth (' || vs_client_nm ||  ') to a placement as soon as possible. Refer to SSA#25-01 for further guidance.';
		
		-- Get Family and Child assigned worker(s) and their Supervisor(s) 
		OPEN cur_fam_chld_assgn_refcur FOR
			select lower(ca.responsibilitytypekey) as responsibilitytypekey,
				ca.toworkeridno,
				up.supervisorid 
			from caseassignment ca  
				join county c on c.countyid::character varying = ca.toldssid::character varying
				join userprofile up on up.securityusersid = ca.toworkeridno
					and up.activeflag  = 1
			where ca.objectid = vu_case_id
				and lower(ca.responsibilitytypekey) in ('family', 'child')
				and ca.activeflag = 1
				and ca.enddate is null 
			order by ca.responsibilitytypekey desc;

		loop
			fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
			exit when not found;

			vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
			v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
			v_supervisorid := cur_fam_chld_assgn.supervisorid;
			
			
			-- Family/Child Worker
			Insert into ttb_living_bid
				(	transactiontype, objectid, startdate, securityusersid, notification_txt,
					effectivedate, expirationdate, case_type, case_number, case_id 
				) 
			values
				( 	'livingArrangement', vu_objectid, v_removaldate, v_toworkeridno, vs_notification_txt, 
					vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
				);
				
			-- Family/Child Supervisor
			Insert into ttb_living_bid
				(	transactiontype, objectid, startdate, securityusersid, notification_txt,
					effectivedate, expirationdate, case_type, case_number, case_id 
				) 
			values
				( 	'livingArrangement', vu_objectid, v_removaldate, v_supervisorid, vs_notification_txt, 
					vd_effectivedate, vd_expirationdate, v_case_type, vl_casenumber, vu_case_id 
				);

		end loop;
		close cur_fam_chld_assgn_refcur;	
		
	end loop;		
	close cur_la_bid_removal_refcur ;	

	-- Create Notifications
	RAISE NOTICE 'Living Arrangment notifications';
	
	OPEN cur_la_bid_temp_refcur FOR
		select distinct transactiontype, 
			objectid, 
			-- startdate, 
			securityusersid, 
			notification_txt,
			effectivedate, 
			expirationdate, 
			case_type, 
			case_number, 
			case_id 		
		from ttb_living_bid ;
	loop
		fetch cur_la_bid_temp_refcur into cur_la_bid_temp;
		exit when not found;

		vs_transactiontype := cur_la_bid_temp.transactiontype;
		vu_objectid := cur_la_bid_temp.objectid;
		v_securityusersid := cur_la_bid_temp.securityusersid;							
		vs_notification_txt := cur_la_bid_temp.notification_txt;
		vl_casenumber := cur_la_bid_temp.case_number;
		vu_case_id := cur_la_bid_temp.case_id;
		v_case_type := cur_la_bid_temp.case_type;
		
		insert into cjams.usernotification
			(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
				url, subject, priorityleveltypekey, "body", hasattachments, 
				updatedby, updatedon, insertedby, insertedon, effectivedate, 
				expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
				isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
				objectcasenumber, entityid, isdeleted, teamtypekey
			)
		values
			(	gen_random_uuid(), v_securityusersid, 'System', vu_case_id, 1, 
				NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
				vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
				vd_expirationdate, NULL, NULL, NULL, NULL, 
				false, false, NULL, 
				'la-fcnfhs-bid', 
				v_case_type, 
				vl_casenumber, vu_objectid, NULL, 'CW'
			)
		RETURNING "usernotificationid" INTO  v_usernotificationid; 

		insert into cjams.usernotificationmap
			(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
				isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
				activeflag, teammemberid, insertedby, updatedby, insertedon, 
				updatedon, fromsecurityusersid, old_id, isdeleted
			)
		values
			( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
				NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
				1, NULL, vs_user_id, vs_user_id, now(), 
				now(), NULL, NULL, NULL
			);
					
					
	end loop;
    	close cur_la_bid_temp_refcur;
	
	   delete from ttb_living_bid;
END IF;	

		
		-- B-115575
		DROP TABLE IF EXISTS ttb_donot_expung CASCADE;
		CREATE TEMPORARY TABLE ttb_donot_expung
			(	expungementid uuid, 
				securityusersid uuid,
				notification_txt varchar(500),
				effectivedate date,
				expirationdate date,
				cps_number character varying,
				intakeserviceid uuid
			) ;
				
		IF lower(as_notification_type) = 'donotexpung' OR lower(as_notification_type) = 'all' THEN
			OPEN cur_donot_expunge_refcur FOR
				select distinct ex.investigationfindingid 
					from expungement ex 
				where ex.donotexpunge = true
					and ex.activeflag = 1 
					-- and ex.updatedon::date = ad_run_dt::date	
					and (	select count(*)
								from caseassignment cas 
							where cas.objectid  = 
								(	select distinct isr.intakeserviceid 
									from investigationallegationmaltreators im 
										inner join intakeservicerequestactor isra 
											on isra.intakeservicerequestactorid = im.intakeservicerequestactorid 
												and isra.activeflag = 1
										inner join investigationallegation ia 
											on ia.investigationallegationid = im.investigationallegationid 
												and ia.activeflag =1
										inner join allegation il
											on il.allegationid = ia.allegationid
												and il.activeflag = 1
										inner join investigationmaltreatmentactor ima 
											on ima.maltreatmentid = ia.maltreatmentid 
												and ima.activeflag =1
										inner join intakeservicerequestactor isra1 
											on isra1.intakeservicerequestactorid = ima.intakeservicerequestactorid 
												and isra1.activeflag = 1		
										inner join intakeservicerequest isr 
											on isr.intakeserviceid = isra.intakeserviceid
												and isr.activeflag = 1
										inner join investigationfinding inf 
											on ia.investigationallegationid = inf.investigationallegationid 
												and inf.activeflag = 1  
										inner join investigation iv 
											on iv.intakeserviceid = isr.intakeserviceid 
												 and iv.activeflag = 1
									where im.activeflag = 1
										and coalesce(im.overrideapprflag, 2) <> 0
										and coalesce(im.overridefindingtypekey,inf.investigationfindingtypekey) IN ('RO','UD','ID')
										-- AND im.finalizeddate IS NOT NULL
										-- AND isra.spexpungementflag IS null
										and inf.investigationfindingid = ex.investigationfindingid
									)
								and cas.activeflag = 1
								and cas.enddate is null
								and ( select count(*)
									  from team t 
										join teammember tm on tm.teamid = t.teamid 
											and tm.activeflag = 1 
										join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
											and tma.activeflag = 1 
										join muser mu on mu.securityusersid = tma.securityusersid 
											and mu.activeflag = 1 
										join rolemapping rm on rm.principalid::int = mu.id 
											and rm.activeflag = 1 
											and rm.teamtypekey = 'CW'
										join county c on c.countyid::character varying = t.countyid 
										join userresource ur on ur.userid = mu.id 
											and ur.activeflag = 1
										join role r on r.id = rm.roleid::int
											and r.activeflag = 1
										join userprofile up on up.securityusersid = mu.securityusersid 
											and up.activeflag = 1
									where rm.roleid = 3500 --  Appeal Coordinator,CW (APPEALCO)
										and up.securityusersid = cas.toworkeridno
								) > 0
							) > 0				
					;
			loop
				fetch cur_donot_expunge_refcur into cur_donot_expunge;
				exit when not found;
				
				vu_intakeserviceid := NULL;
				vu_investigationfindingid := NULL;
				vb_donotexpunge := NULL;
				vs_cps_id := NULL;
				vt_cps_receivedon := NULL;
				vu_alleged_maltreator := NULL;
				vd_expung_date := NULL;
				vs_subsequent_vs_cps_id := NULL;
				vd_subsequent_expung_date := NULL;
				
				vu_investigationfindingid := cur_donot_expunge.investigationfindingid;
				
				select expungementid,
					donotexpunge
				into vu_expungementid,
					vb_donotexpunge
				from expungement  
				where activeflag = 1
					and investigationfindingid = vu_investigationfindingid
				order by insertedon desc	
				limit 1;
				
				IF vb_donotexpunge = TRUE THEN
					select isr.intakeserviceid,
						isr.servicerequestnumber, 
						isra.personid,
						iv.insertedon,
						CASE COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey)
							WHEN 'RO' THEN (iv.insertedon + (2 * INTERVAL '1 years'))::DATE 
							WHEN 'UD' THEN (iv.insertedon + (5 * INTERVAL '1 years'))::DATE 
							WHEN 'ID' THEN (iv.insertedon + (25 * INTERVAL '1 years'))::DATE 
						END AS expungement_forecast_date
					into vu_intakeserviceid, 
						vs_cps_id,
						vu_alleged_maltreator,
						vt_cps_receivedon,
						vd_expung_date
					from investigationallegationmaltreators im 
						inner join intakeservicerequestactor isra 
							on isra.intakeservicerequestactorid = im.intakeservicerequestactorid 
								and isra.activeflag = 1
						inner join investigationallegation ia 
							on ia.investigationallegationid = im.investigationallegationid 
								and ia.activeflag =1
						inner join allegation il
							on il.allegationid = ia.allegationid
								and il.activeflag = 1
						inner join investigationmaltreatmentactor ima 
							on ima.maltreatmentid = ia.maltreatmentid 
								and ima.activeflag =1
						inner join intakeservicerequestactor isra1 
							on isra1.intakeservicerequestactorid = ima.intakeservicerequestactorid 
								and isra1.activeflag = 1		
						inner join intakeservicerequest isr 
							on isr.intakeserviceid = isra.intakeserviceid
								and isr.activeflag = 1
						inner join investigationfinding inf 
							on ia.investigationallegationid = inf.investigationallegationid 
								and inf.activeflag = 1  
						inner join investigation iv 
							on iv.intakeserviceid = isr.intakeserviceid 
								 and iv.activeflag = 1
					where im.activeflag = 1
						and coalesce(im.overrideapprflag, 2) <> 0
						and coalesce(im.overridefindingtypekey,inf.investigationfindingtypekey) IN ('RO','UD','ID')
						-- AND im.finalizeddate IS NOT NULL
						-- AND isra.spexpungementflag IS null
						and inf.investigationfindingid = vu_investigationfindingid ;
						
					-- Look for the subsequent (if any)	
					select isr.servicerequestnumber, 
						CASE COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey)
							WHEN 'RO' THEN (iv.insertedon + (2 * INTERVAL '1 years'))::DATE 
							WHEN 'UD' THEN (iv.insertedon + (5 * INTERVAL '1 years'))::DATE 
							WHEN 'ID' THEN (iv.insertedon + (25 * INTERVAL '1 years'))::DATE 
						END AS subsequent_expung_date
					into vs_subsequent_vs_cps_id,
						vd_subsequent_expung_date		
					from investigationallegationmaltreators im 
						inner join intakeservicerequestactor isra 
							on isra.intakeservicerequestactorid = im.intakeservicerequestactorid 
								and isra.activeflag = 1
						inner join investigationallegation ia 
							on ia.investigationallegationid = im.investigationallegationid 
								and ia.activeflag =1
						inner join allegation il
							on il.allegationid = ia.allegationid
								and il.activeflag = 1
						inner join investigationmaltreatmentactor ima 
							on ima.maltreatmentid = ia.maltreatmentid 
								and ima.activeflag =1
						inner join intakeservicerequestactor isra1 
							on isra1.intakeservicerequestactorid = ima.intakeservicerequestactorid 
								and isra1.activeflag = 1		
						inner join intakeservicerequest isr 
							on isr.intakeserviceid = isra.intakeserviceid
								and isr.activeflag = 1
						inner join investigationfinding inf 
							on ia.investigationallegationid = inf.investigationallegationid 
								and inf.activeflag = 1  
						inner join investigation iv 
							on iv.intakeserviceid = isr.intakeserviceid 
								 and iv.activeflag = 1
					where im.activeflag = 1
						and coalesce(im.overrideapprflag, 2) <> 0
						and coalesce(im.overridefindingtypekey,inf.investigationfindingtypekey) IN ('RO','UD','ID')
						-- AND im.finalizeddate IS NOT NULL
						-- AND isra.spexpungementflag IS null
						and isr.intakeserviceid <> vu_intakeserviceid
						-- and inf.investigationfindingid <> vu_investigationfindingid
						and isra.personid = vu_alleged_maltreator
						and iv.insertedon > vt_cps_receivedon 
						and iv.insertedon::date <= vd_expung_date::date	
					;
						
					-- If the record is past the Expungement due date then send a notification 
					-- RAISE NOTICE 'vs_subsequent_vs_cps_id  >> %',vs_subsequent_vs_cps_id;
					-- RAISE NOTICE 'vs_cps_id  >> %',vs_cps_id;
					
					IF vs_subsequent_vs_cps_id is null and vd_expung_date::date + interval '1 day'  = ad_run_dt::date THEN
						vs_notification_txt := 'Investigation is past the Expungement Date. Please review and take any necessary action.';
						
						OPEN cur_admin_assgn_refcur FOR
							select cas.toworkeridno 
								from caseassignment cas 
							where cas.objectid  = vu_intakeserviceid
								and cas.activeflag = 1
								and cas.enddate is null
								and ( select count(*)
									  from team t 
										join teammember tm on tm.teamid = t.teamid 
											and tm.activeflag = 1 
										join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
											and tma.activeflag = 1 
										join muser mu on mu.securityusersid = tma.securityusersid 
											and mu.activeflag = 1 
										join rolemapping rm on rm.principalid::int = mu.id 
											and rm.activeflag = 1 
											and rm.teamtypekey = 'CW'
										join county c on c.countyid::character varying = t.countyid 
										join userresource ur on ur.userid = mu.id 
											and ur.activeflag = 1
										join role r on r.id = rm.roleid::int
											and r.activeflag = 1
										join userprofile up on up.securityusersid = mu.securityusersid 
											and up.activeflag = 1
									where rm.roleid = 3500 --  Appeal Coordinator,CW (APPEALCO)
										and up.securityusersid = cas.toworkeridno
								) > 0
							;
						loop
							fetch cur_admin_assgn_refcur into cur_admin_assgn;
							exit when not found;
					
							v_toworkeridno := cur_admin_assgn.toworkeridno;
							
							-- RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
							
							-- Appeal Coordinator
							Insert into ttb_donot_expung
								( 	expungementid, securityusersid, notification_txt, 
									effectivedate, expirationdate, cps_number, intakeserviceid 
								)
							values
								( 	vu_expungementid, v_toworkeridno, vs_notification_txt, 
									vd_effectivedate, vd_expirationdate, vs_cps_id, vu_intakeserviceid 
								);
								
						end loop;
						close cur_admin_assgn_refcur;
					ELSE
						-- Subsequent Found - Do nothing
					END IF;	
				ELSE
					-- Not Do Not Expunge Case - Do nothing
				END IF;
			end loop;
			close cur_donot_expunge_refcur;
			
			-- Create Notifications
			RAISE NOTICE 'Final Do Not Expunge Notifications';
			
			OPEN cur_donot_expunge_temp_refcur FOR
				select distinct expungementid, 
					securityusersid,
					notification_txt,
					effectivedate,
					expirationdate,
					cps_number,
					intakeserviceid
				from ttb_donot_expung ;
			loop
				fetch cur_donot_expunge_temp_refcur into cur_donot_expunge_temp;
				exit when not found;

				vu_expungementid := cur_donot_expunge_temp.expungementid;
				v_securityusersid := cur_donot_expunge_temp.securityusersid;							
				vs_notification_txt := cur_donot_expunge_temp.notification_txt;
				vd_effectivedate := cur_donot_expunge_temp.effectivedate;
				vd_expirationdate := cur_donot_expunge_temp.expirationdate;
				vs_cps_id := cur_donot_expunge_temp.cps_number;
				vu_intakeserviceid := cur_donot_expunge_temp.intakeserviceid;
				
				-- RAISE NOTICE 'vu_expungementid  >> %',vu_expungementid;
				
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', vu_intakeserviceid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, 'donot-expung', 
						'servicerequest', vs_cps_id, vu_expungementid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
			end loop;
			close cur_donot_expunge_temp_refcur;
			
			delete from ttb_donot_expung;
		END IF;
		
		-- B-85070
		DROP TABLE IF EXISTS ttb_quarterly_alerts CASCADE;
		CREATE TEMPORARY TABLE ttb_quarterly_alerts
			(	personprogramid uuid,
				securityusersid uuid,
				notification_txt varchar(500),
				effectivedate date,
				expirationdate date,
				case_number bigint,
				servicecaseid uuid
			) ;
				
		IF lower(as_notification_type) = 'qtrlyalerts' OR lower(as_notification_type) = 'all' THEN
			IF date_part('day', ad_run_dt::date) = 15 
				AND date_part('month', ad_run_dt::date) in ( 8, 11, 2, 6 )  THEN
				
				OPEN cur_qtrlyalerts_refcur FOR
					select pa.personprogramid,
						sc.servicecaseid,
						sc.servicecasenumber,
						pr.personid,
						pr.cjamspid,
						'/ Client ' || pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_name
					from personprogramarea pa,
						person pr,
						servicecase sc	
					where pa.personid = pr.personid
						and pa.objectid = sc.servicecaseid::character varying
						and pa.programkey = 'OOH'
						and pa.startdate is not null
						and pa.enddate is null
						and pa.activeflag = 1
						and pr.activeflag = 1
						-- CIDM-6268/B-129401
						and (select count(*) 
								from cjams.personeducationalertactions eda
							where eda.personid = pr.personid
								and eda.activeflag = 1
								and ( eda.startdate is not null and eda.startdate::date <= current_date ) -- ad_run_dt::date
								and ( eda.enddate is null or eda.enddate::date > current_date ) -- ad_run_dt::date
								and eda.actiontype in ('H','S')
							) = 0
						-- Unit Test
						-- and sc.servicecaseid = '01afd2c0-35c3-41b0-9ce0-d525444450d5'
					;	
				loop
					fetch cur_qtrlyalerts_refcur into cur_qtrlyalerts;
					exit when not found;
				
					vu_personprogramid := cur_qtrlyalerts.personprogramid;
					v_servicecaseid := cur_qtrlyalerts.servicecaseid;
					vl_servicecasenumber := cur_qtrlyalerts.servicecasenumber;
					v_personid := cur_qtrlyalerts.personid;
					v_client_id := cur_qtrlyalerts.cjamspid;
					vs_client_nm := cur_qtrlyalerts.client_name;
					
				
					-- On Aug 15th: Please update the Education Information for the start of this School Year.
					-- On Nov 15th: Please update the Education Information for this Quarter and upload the report card.
					-- On Feb 15th: Please update the Education Information for this Quarter and upload the report card.
					-- On June 15th: Please update the Education Information for the end of this School Year. Also upload the report card.

					IF date_part('month', ad_run_dt::date)  = 8 THEN
						vs_notification_txt := vs_client_nm || ' Please update the Education Information for the start of this School Year.' ;
					ELSEIF date_part('month', ad_run_dt::date)  = 6 THEN 
						vs_notification_txt := vs_client_nm || ' Please update the Education Information for the end of this School Year. Also upload the report card.' ;						
					ELSE --  11 and 2
						vs_notification_txt := vs_client_nm || ' Please update the Education Information for this Quarter and upload the report card.' ;
					END IF;	
					
					-- Get Family and Child assigned worker(s) and their Supervisor(s) 
					OPEN cur_fam_chld_assgn_refcur FOR
						select lower(ca.responsibilitytypekey) as responsibilitytypekey,
							ca.toworkeridno,
							up.supervisorid 
						from caseassignment ca  
							join county c on c.countyid::character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = v_servicecaseid
							and lower(ca.responsibilitytypekey) in ('family', 'child')
							and ca.activeflag = 1
							and ca.enddate is null 
						order by ca.responsibilitytypekey desc;

					loop
						fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
						exit when not found;
				
						vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
						v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
						v_supervisorid := cur_fam_chld_assgn.supervisorid;
						
						-- Family/Child Worker
						Insert into ttb_quarterly_alerts
							( 	personprogramid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_number, servicecaseid 
							)
						values
							( 	vu_personprogramid, v_toworkeridno, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
							);
							
						-- Family/Child Supervisor
						Insert into ttb_quarterly_alerts
							( 	personprogramid, securityusersid, notification_txt, 
								effectivedate, expirationdate, case_number, servicecaseid 
							)
						values
							(	vu_personprogramid, v_supervisorid, vs_notification_txt, 
								vd_effectivedate, vd_expirationdate, vl_servicecasenumber, v_servicecaseid 
							);	
					
					end loop;
					close cur_fam_chld_assgn_refcur;
				end loop;	
				close cur_qtrlyalerts_refcur;
				
				-- Create Notifications
				RAISE NOTICE 'Final Quarterly Alerts Notifications';
				
				OPEN cur_qtrlyalerts_temp_refcur FOR
					select distinct personprogramid, 
						securityusersid, 
						notification_txt, 
						effectivedate, 
						expirationdate, 
						case_number, 
						servicecaseid 				
					from ttb_quarterly_alerts 
					order by personprogramid;
				loop
					fetch cur_qtrlyalerts_temp_refcur into cur_qtrlyalerts_temp;
					exit when not found;

					vu_personprogramid := cur_qtrlyalerts_temp.personprogramid;
					v_securityusersid := cur_qtrlyalerts_temp.securityusersid;
					vs_notification_txt := cur_qtrlyalerts_temp.notification_txt;
					vd_effectivedate := cur_qtrlyalerts_temp.effectivedate;
					vd_expirationdate := cur_qtrlyalerts_temp.expirationdate;
					vl_servicecasenumber := cur_qtrlyalerts_temp.case_number;
					v_servicecaseid := cur_qtrlyalerts_temp.servicecaseid;
					vs_user_id := v_securityusersid;
					
					insert into cjams.usernotification
						(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
							url, subject, priorityleveltypekey, "body", hasattachments, 
							updatedby, updatedon, insertedby, insertedon, effectivedate, 
							expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
							isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
							objectcasenumber, entityid, isdeleted, teamtypekey
						)
					values
						(	gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
							NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
							vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
							vd_expirationdate, NULL, NULL, NULL, NULL, 
							false, false, NULL, 'qtr-alrt', 'servicecase', 
							vl_servicecasenumber, vu_personprogramid, NULL, 'CW'
						)
					RETURNING "usernotificationid" INTO  v_usernotificationid; 

					insert into cjams.usernotificationmap
						(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
							isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
							activeflag, teammemberid, insertedby, updatedby, insertedon, 
							updatedon, fromsecurityusersid, old_id, isdeleted
						)
					values
						( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
							NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
							1, NULL, vs_user_id, vs_user_id, now(), 
							now(), NULL, NULL, NULL
						);
				end loop;
				close cur_qtrlyalerts_temp_refcur;
				
				delete from ttb_quarterly_alerts;
			END IF;	
		END IF;	

		delete from TTB_LA_RUNAWAYS;	
		-- delete from ttb_removals;	
		
		-- CIDM-5024
		IF lower(as_notification_type) = 'posc' OR lower(as_notification_type) = 'all' THEN
			DROP TABLE IF EXISTS ttb_posc CASCADE;
			CREATE TEMPORARY TABLE ttb_posc
				(	notification_type varchar(50),
					servicecaseid uuid,
					securityusersid uuid,
					notification_txt varchar(500),
					-- effectivedate date,
					-- expirationdate date,
					case_number bigint
				) ;
					
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
		
			OPEN cur_posc00_refcur FOR
				select distinct isr.servicecaseid 
				from routing ru,
					intakeservicerequest isr,
					-- intakeservicerequestactor iac,
					person pr
				where ru.objectid = isr.intakenumber 
					-- and isr.intakeserviceid = iac.intakeserviceid 
					-- and iac.personid = pr.personid
					and isr.intakenumber = pr.substanceexposednewbornsourceid
					and ru.eventcode = 'INTR'
					and ru.activeflag = 1
					and pr.activeflag = 1
					and ru.routingstatustypeid = 2 -- Accepted
					and ru.updatedon::date = ad_run_dt::date
					and isr.activeflag = 0 -- Risk-of-Harm (SEN) cases 
					and isr.teamtypekey = 'CW'
					and pr.substanceexposednewbornflag = 1 
				;
				
				-- Old 
				/*
				select distinct isr.servicecaseid 
				from routing ru,
					intakeservicerequest isr,
					intakeservicerequestactor iac,
					personrole prl,
					person pr
				where ru.objectid = isr.intakenumber 
					and isr.intakeserviceid = iac.intakeserviceid 
					and iac.intakeserviceid = prl.intakeserviceid
					and iac.personid = prl.personid
					and prl.personid  = pr.personid
					and ru.eventcode = 'INTR'
					and ru.activeflag = 1
					and ru.routingstatustypeid = 2 -- Accepted
					and ru.updatedon::date = ad_run_dt::date
					and isr.activeflag = 0 -- Risk-of-Harm (SEN) cases 
					and isr.teamtypekey = 'CW'
					and ( prl.drugexposednewbornflag = 1 
							or 
						  pr.substanceexposednewbornflag = 1 
						 ) ; 
				*/ 
			loop
				fetch cur_posc00_refcur into cur_posc00;
				exit when not found;

				v_servicecaseid := cur_posc00.servicecaseid;
				
				select sc.servicecasenumber
					into vl_servicecasenumber
				from servicecase sc 
				where sc.servicecaseid = v_servicecaseid ;
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_fam_chld_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid, 
						up.fullname
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
						and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
					exit when not found;

					vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;
					vs_toworker_name := cur_fam_chld_assgn.fullname ;
					
					vs_notification_txt = 'is a ROH, SEN case created and assigned to Worker ' || vs_toworker_name || '.' 
						|| ' Case Worker have 30 Business days to complete the POSC.' ;
		 
					-- Family/Child/Admin Worker
					Insert into ttb_posc
						( 	notification_type, servicecaseid, securityusersid, notification_txt, 
							case_number
						)
					values
						( 	'POSC00', v_servicecaseid, v_toworkeridno, vs_notification_txt, 
							vl_servicecasenumber
						);
						
					-- Family/Child Supervisor
					IF v_supervisorid is not null THEN
						Insert into ttb_posc
							( 	notification_type, servicecaseid, securityusersid, notification_txt, 
								case_number
							)
						values
							( 	'POSC00', v_servicecaseid, v_supervisorid, vs_notification_txt, 
								vl_servicecasenumber
							);	
					END IF;
				end loop;
				close cur_fam_chld_assgn_refcur;	
			end loop;
			close cur_posc00_refcur;	
			
			-- 7th day, 15th day, 24 Hours prior to 30th day and 31st Day
			OPEN cur_posc_next_refcur FOR						
				select distinct sc.servicecaseid, 
					sc.servicecasenumber,
					 ( case when cjams.nextbusinessday(un.insertedon::date, 15::integer)::date = ad_run_dt::date then	 
							'POSC15'
						when cjams.nextbusinessday(un.insertedon::date, 23::integer)::date = ad_run_dt::date then
							'POSC07' 
						when (cjams.nextbusinessday(un.insertedon::date, 30::integer)::date - interval '2 Day')::date = ad_run_dt::date then
							'POSC24PR'
						when cjams.nextbusinessday(un.insertedon::date, 31::integer)::date = ad_run_dt::date then
							'POSC31'
					   end
					  ) as notification_type
				from usernotification un,
					servicecase sc
				where un.objectid = sc.servicecaseid::character varying 
					and un.old_id = 'POSC00'
				and ( 
						cjams.nextbusinessday(un.insertedon::date, 15::integer)::date = ad_run_dt::date	 
						or
						cjams.nextbusinessday(un.insertedon::date, 23::integer)::date = ad_run_dt::date
						or
						(cjams.nextbusinessday(un.insertedon::date, 30::integer)::date - interval '2 Day')::date = ad_run_dt::date
						or 
						cjams.nextbusinessday(un.insertedon::date, 31::integer)::date = ad_run_dt::date
					)  
				and sc.activeflag = 1
				and ( select count(*)
						from cjams.safecareplan sfp
					  where sfp.objectid = sc.servicecaseid::character varying
						and sfp.activeflag = 1
						and sfp.approvalstatus = '16'
					) = 0 ;		
			loop
				fetch cur_posc_next_refcur into cur_posc_next;
				exit when not found;

				v_servicecaseid := cur_posc_next.servicecaseid;
				vl_servicecasenumber := cur_posc_next.servicecasenumber;
				v_notification_type := cur_posc_next.notification_type;
				
				vu_safecareplanid := null;
				vs_approvalstatus := null;
				vs_posc_sen_client := null;
				
				-- Check Plan Of Safe Care (POSC) 
				select sfp.safecareplanid,
					sfp.approvalstatus
				into vu_safecareplanid, 
					vs_approvalstatus
				from cjams.safecareplan sfp
			    where sfp.objectid = v_servicecaseid::character varying
					and sfp.activeflag = 1
				order by sfp.insertedon desc
				limit 1;
				
				OPEN cur_posc_sen_clients_refcur FOR 
					select distinct pr.cjamspid || ' ' || pr.lastname || ' ' || pr.firstname as persondetails
					from intakeservicerequestactor iac,
						personrole prl,
						person pr
					where iac.servicecaseid  = v_servicecaseid
						and iac.intakeserviceid = prl.intakeserviceid
						and iac.personid = prl.personid
						and pr.personid = prl.personid
						and iac.activeflag = 1
						and prl.activeflag = 1
						and pr.activeflag = 1
						and ( prl.drugexposednewbornflag = 1 
								or 
							  pr.substanceexposednewbornflag = 1 
							 );
				loop
					fetch cur_posc_sen_clients_refcur into cur_posc_sen_client;
					exit when not found;

					if vs_posc_sen_client is null then
						vs_posc_sen_client := cur_posc_sen_client.persondetails;
					else
						vs_posc_sen_client := vs_posc_sen_client || ', ' || cur_posc_sen_client.persondetails;
					end if;
				end loop;
				close cur_posc_sen_clients_refcur;	
				
				-- Get Family and Child assigned worker(s) and their Supervisor(s) 
				OPEN cur_fam_chld_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid, 
						up.fullname
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
						and lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
					exit when not found;

					vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;
					vs_toworker_name := cur_fam_chld_assgn.fullname ;
					
					if v_notification_type = 'POSC31' then
						vs_notification_txt := 'POSC is not completed in case # ' || (vl_servicecasenumber)::character varying
							|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. 30 Working Days Elapsed.'; 
					else 	
						if vu_safecareplanid is null Then
							-- POSC is missing
							if v_notification_type = 'POSC15' then
								vs_notification_txt := 'POSC is not Completed by the Worker and Submitted to Supervisor in case # ' || (vl_servicecasenumber)::character varying 
									|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. Worker has only 15 Calendar Days left to complete the POSC.';
							elseif v_notification_type = 'POSC07' then
								vs_notification_txt := 'POSC is not Completed by the Worker and Submitted to Supervisor in case # ' || (vl_servicecasenumber)::character varying  
									|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. Worker has only 7 Calendar Days left to complete the POSC.';		
							else -- 'POSC24PR'
								vs_notification_txt := 'POSC is not Completed by the Worker and Submitted to Supervisor in case # ' || (vl_servicecasenumber)::character varying 
									|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. Worker has only 24 Hours left to complete the POSC.';
							end if;		
						else
							-- POSC is pending - vs_approvalstatus = 15
							if v_notification_type = 'POSC15' then
								vs_notification_txt := 'POSC is Completed by the Worker and Submitted to Supervisor for approval but the POSC is not yet approved by Supervisor in case # ' || (vl_servicecasenumber)::character varying  
									|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. Worker has only 15 Calendar Days left to complete the POSC.';
							elseif v_notification_type = 'POSC07' then
								vs_notification_txt := 'POSC is Completed by the Worker and Submitted to Supervisor for approval but the POSC is not yet approved by Supervisor in case # ' || (vl_servicecasenumber)::character varying 
									|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. Worker has only 7 Calendar Days left to complete the POSC.';		
							else -- 'POSC24PR'
								vs_notification_txt := 'POSC is Completed by the Worker and Submitted to Supervisor for approval but the POSC is not yet approved by Supervisor in case # ' || (vl_servicecasenumber)::character varying  
									|| ' for Child CJAMS PID # ' || vs_posc_sen_client || '. Worker has only 24 Hours left to complete the POSC.';
							end if;
						end if;
					end if;
		 
					-- Family/Child/Admin Worker
					Insert into ttb_posc
						( 	notification_type, servicecaseid, securityusersid, notification_txt, 
							case_number
						)
					values
						( 	v_notification_type, v_servicecaseid, v_toworkeridno, vs_notification_txt, 
							vl_servicecasenumber
						);
						
					-- Family/Child Supervisor
					IF v_supervisorid is not null THEN
						Insert into ttb_posc
							( 	notification_type, servicecaseid, securityusersid, notification_txt, 
								case_number
							)
						values
							( 	v_notification_type, v_servicecaseid, v_supervisorid, vs_notification_txt, 
								vl_servicecasenumber
							);	
					END IF;
				end loop;
				close cur_fam_chld_assgn_refcur;			
			end loop;
			close cur_posc_next_refcur;	
			
			-- Create Notifications
			RAISE NOTICE 'Final Plan Of Safe Care (POSC) Notifications';
			
			OPEN cur_ttb_posc_refcur FOR
				select distinct notification_type,
					servicecaseid,
					securityusersid,
					notification_txt,
					-- effectivedate,
					-- expirationdate,
					case_number
				from ttb_posc 
				where notification_txt is not null
				order by case_number;
			loop
				fetch cur_ttb_posc_refcur into cur_ttb_posc;
				exit when not found;

				v_notification_type := cur_ttb_posc.notification_type;
				v_servicecaseid := cur_ttb_posc.servicecaseid;
				v_securityusersid := cur_ttb_posc.securityusersid;
				vs_notification_txt := cur_ttb_posc.notification_txt;
				vl_servicecasenumber := cur_ttb_posc.case_number;
				
				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				RAISE NOTICE 'vs_notification_txt >> %',vs_notification_txt;
				
				-- RAISE NOTICE 'v_securityusersid >> %', v_securityusersid;					
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, NULL, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
			end loop;
			close cur_ttb_posc_refcur;				
		END IF;
		
		-- CIDM-5447/B-144171
		IF lower(as_notification_type) = 'responsetimer' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			
			DROP TABLE IF EXISTS ttb_responsetimer CASCADE;
			CREATE TEMPORARY TABLE ttb_responsetimer
				(	notification_type varchar(50),
					intakeserviceid uuid,
					case_number character varying,
					notification_txt varchar(500),
					securityusersid uuid
				) ;
			
			OPEN cur_responsetimer_refcur FOR
				select 'skip_1' as notification_type,
					ctm.intakeserviceid,
					isr.servicerequestnumber,
					isr.responsetimer  
				from cpsresponsetimeractions ctm,
					intakeservicerequest isr 
				where ctm.intakeserviceid = isr.intakeserviceid 
				and ctm.activeflag = 1
				and isr.activeflag = 1
					and lower(ctm.cpsresponsetimeractiontype) = 'skip 1'
					and ctm.insertedon::date + interval  '24 hours' = ad_run_dt::date
				union all
				select 'skip_2' as notification_type,
					ctm.intakeserviceid,
					isr.servicerequestnumber,
					isr.responsetimer  
				from cpsresponsetimeractions ctm,
					intakeservicerequest isr 
				where ctm.intakeserviceid = isr.intakeserviceid 
				and ctm.activeflag = 1
				and isr.activeflag = 1
					and lower(ctm.cpsresponsetimeractiontype) = 'skip 2'
					and ctm.insertedon::date + interval  '5 days' = ad_run_dt::date
				union all 	
				select 'first_notice' as notification_type,
					isr.intakeserviceid,
					isr.servicerequestnumber,
					isr.responsetimer
				from intakeservicerequest isr
				where isr.activeflag = 1
				and isr.teamtypekey  = 'CW'
				and isr.actiontype in ( 'IR', 'AR' )
				and (select a.intakeserreqstatustypeid::uuid 
						from intakeservicerequestdispositioncode a 
					where a.intakeserviceid = isr.intakeserviceid 
						and a.activeflag  = 1
					order by insertedon  desc
					limit 1 )
						not in (	'7995cecb-062d-406c-8ea9-b1da4b1877d8', -- Completed
									'642f18b0-ef6e-4d4b-9871-acc0734f3f5a' -- Closed
							   ) 
				and (select count(*)
						from caseassignment ca  
					 where ca.objectid = isr.intakeserviceid
						and lower(ca.responsibilitytypekey) = 'family'
						and ca.activeflag = 1
						and ca.enddate is null 
					) > 0
				;
			loop
				fetch cur_responsetimer_refcur into cur_responsetimer;
				exit when not found;
				
				v_notification_type := cur_responsetimer.notification_type;
				vu_intakeserviceid := cur_responsetimer.intakeserviceid;
				v_cps_id := cur_responsetimer.servicerequestnumber;
				vt_responsetimer := cur_responsetimer.responsetimer;
				
				IF v_notification_type = 'skip_1' THEN
					vs_notification_txt := 'Legislative Required Reporting: Late or Incomplete Initial Contact (2nd notice).';
				ELSEIF  v_notification_type = 'skip_2' THEN
					vs_notification_txt := 'Legislative Required Reporting: Late or Incomplete Initial Contact (3rd/Final notice).';
				ELSE
					vs_notification_txt := 'Legislative Required Reporting: Late or Incomplete Initial Contact (1st notice).';				
				END IF;	
				
				-- Pending Response Timer check
				vs_malt_type := NULL; 
				vs_responsetimer_status := NULL; 
				vt_responsetimer_duedate := NULL;
				vb_generate_notifications := false;
				
				select rsp.malt_type,
					rsp.responsetimer_status,
					rsp.responsetimer_duedate
				from cjams.getresponsetimerdetails(vu_intakeserviceid::uuid, 'responsetimer_status'::character varying) as rsp
				into vs_malt_type,
					vs_responsetimer_status,
					vt_responsetimer_duedate ;
				
				IF lower(vs_responsetimer_status) = 'running' or lower(vs_responsetimer_status) = 'delay' THEN 				
					IF v_notification_type = 'first_notice'	THEN
						IF vt_responsetimer_duedate::date + interval '7 days' = ad_run_dt::date THEN
							vb_generate_notifications := True;
						ELSE
							vb_generate_notifications := False;
						END IF;	
					ELSE
						vb_generate_notifications := True;
					END IF;
				
					IF vb_generate_notifications = True THEN
						-- Get Family and Child assigned worker(s) and their Supervisor(s) 
						OPEN cur_fam_chld_assgn_refcur FOR
							select lower(ca.responsibilitytypekey) as responsibilitytypekey,
								ca.toworkeridno,
								up.supervisorid, 
								up.fullname
							from caseassignment ca  
								join county c on c.countyid::character varying = ca.toldssid::character varying
								join userprofile up on up.securityusersid = ca.toworkeridno
									and up.activeflag  = 1
							where ca.objectid = vu_intakeserviceid
								and lower(ca.responsibilitytypekey) = 'family'
								and ca.activeflag = 1
								and ca.enddate is null 
							order by ca.responsibilitytypekey desc;

						loop
							fetch cur_fam_chld_assgn_refcur into cur_fam_chld_assgn;
							exit when not found;

							vs_responsibilitytypekey := cur_fam_chld_assgn.responsibilitytypekey;
							v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
							v_supervisorid := cur_fam_chld_assgn.supervisorid;
							vs_toworker_name := cur_fam_chld_assgn.fullname ;
							
							-- Family/Child/Admin Worker
							Insert into ttb_responsetimer
								( 	notification_type, intakeserviceid, securityusersid, notification_txt, 
									case_number
								)
							values
								( 	v_notification_type, vu_intakeserviceid, v_toworkeridno, vs_notification_txt, 
									v_cps_id
								);
								
							-- Family/Child Supervisor
							IF v_supervisorid is not null THEN
								Insert into ttb_responsetimer
									( 	notification_type, intakeserviceid, securityusersid, notification_txt, 
										case_number
									)
								values
									( 	v_notification_type, vu_intakeserviceid, v_supervisorid, vs_notification_txt, 
										v_cps_id
									);	
							END IF;
						end loop;
						close cur_fam_chld_assgn_refcur;	
					END IF;	
				END IF;
			end loop;
			close cur_responsetimer_refcur;			
				
			-- Create Notifications
			RAISE NOTICE 'Final Response Timer Notifications';
			
			OPEN cur_ttb_responsetimer_refcur FOR
				select distinct notification_type,
					intakeserviceid,
					securityusersid,
					notification_txt,
					-- effectivedate,
					-- expirationdate,
					case_number
				from ttb_responsetimer 
				order by case_number;
			loop
				fetch cur_ttb_responsetimer_refcur into cur_ttb_responsetimer ;
				exit when not found;

				v_notification_type := cur_ttb_responsetimer.notification_type;
				vu_intakeserviceid := cur_ttb_responsetimer.intakeserviceid;
				v_securityusersid := cur_ttb_responsetimer.securityusersid;
				vs_notification_txt := cur_ttb_responsetimer.notification_txt;
				v_cps_id := cur_ttb_responsetimer.case_number;
				
				-- RAISE NOTICE 'v_securityusersid >> %', v_securityusersid;					
				insert into cjams.usernotification
					(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(	gen_random_uuid(), v_securityusersid, 'System', vu_intakeserviceid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicerequest', 
						v_cps_id, NULL, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
			end loop;
			close cur_ttb_responsetimer_refcur;	
		END IF;
		
		-- QI assessment userstory
		-- B-135292 -- start of QI Assessment 7th day notification
		--QI assessment start
		DROP TABLE IF EXISTS ttb_qinotifications CASCADE;
		CREATE TEMPORARY TABLE ttb_qinotifications
		(   notification_type varchar(50),
			placementid uuid,
			intakeservicerequestactorid uuid,
			securityusersid uuid,
			notification_txt varchar(500),
			case_number bigint,
			servicecaseid uuid
		) ;

		IF lower(as_notification_type) = 'qiassessmentnotification' OR lower(as_notification_type) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;

			OPEN qicur_qinotifications_refcur FOR
				select Distinct 'QRTP02' as notification_type,
    un.insertedon,
    un.objectid as servicecaseid,
    un.objectcasenumber as servicecasenumber,
    ac.intakeservicerequestactorid,
    btrim(un.old_id) as old_id,
    un.subject as vs_notification_txt
-- select un.*
from usernotification un,
    assessment a,
    assessmentactor ac 
where a.assessmentid = un.entityid
    and a.assessmentid = ac.assessmentid 
    and mod((extract(epoch from age(ad_run_dt::date, (un.insertedon::date + interval '7 days'))/ 86400)::integer)::integer, 7) = 0 
	and un.insertedon::date <> ad_run_dt::date
    and un.old_id = 'QRTP01'
    and un.activeflag =1
    and a.activeflag =1
    and ac.activeflag =1
    --no active petitions       
     and (                                               
         select count(*) 
         from intakeservicerequestpetition isrp
         join intakeservicerequestpetitionactor isrpa 
             on isrpa.intakeservicerequestpetitionid = isrp.intakeservicerequestpetitionid
         join intakeservicerequestactor isra 
             on isra.intakeservicerequestactorid = isrpa.intakeservicerequestactorid 
                 and isra.intakeservicerequestactorid = ac.intakeservicerequestactorid
         where isrp.servicecaseid::character varying  = un.objectid 
             and isrp.petitiontypekey ='QRTP' and isrp.activeflag = 1
     ) = 0 
    --no active qrtp placement 
    and
        (select count(*)
            from placement pl                        
                join assessment asmnt on asmnt.assessmentid = a.assessmentid
        where pl.personid=asmnt.personid
            and pl.service_id=11410  --11410 is QRTP provider service
            and pl.enddatetime is NULL
            and coalesce(pl.isvoided, 0) <> 1
            and ( select count(*)
                    from routing ro
                    where ro.objectid = pl.placementid::character varying
                    and ro.eventcode = 'PLTR'
                    and ro.activeflag = 1
                    and ro.routingstatustypeid = '16'
                    -- and ro.insertedon::date = ad_run_dt
                ) > 0
      )> 0;
					
							  
			loop
				fetch qicur_qinotifications_refcur into qicur_notifications;
				exit when not found;

				v_notification_type := qicur_notifications.notification_type;
				v_intakeservicerequestactorid := qicur_notifications.intakeservicerequestactorid;
				v_servicecaseid := qicur_notifications.servicecaseid;
				vl_servicecasenumber := qicur_notifications.servicecasenumber;
				vs_notification_txt := qicur_notifications.vs_notification_txt;

				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservicerequestactorid >> %',v_intakeservicerequestactorid;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				RAISE NOTICE 'QRTP01 >> %',vl_servicecasenumber;
				
				--vs_notification_txt := un.subject;
				
				RAISE NOTICE 'vs_notification_txt >> %',vs_notification_txt;


				-- Get Child assigned worker(s) and their Supervisor(s) 
				OPEN qicur_all_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
					--  and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

					RAISE NOTICE 'checkresult  >> %',v_supervisorid;

				loop
					fetch qicur_all_assgn_refcur into qicur_all_assgn;
					exit when not found;

					vs_responsibilitytypekey := qicur_all_assgn.responsibilitytypekey;
					v_toworkeridno := qicur_all_assgn.toworkeridno;
					v_supervisorid := qicur_all_assgn.supervisorid;
					
					
					RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
					RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
					RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;

					
					-- Family/Child Worker
					Insert into ttb_qinotifications
						(   notification_type, placementid, securityusersid, notification_txt, 
							case_number, servicecaseid 
						)
					values
						(   v_notification_type, v_placementid, v_toworkeridno, vs_notification_txt, 
							vl_servicecasenumber, v_servicecaseid 
						);
						
					-- Family/Child Supervisor
					IF v_supervisorid is not null THEN
						Insert into ttb_qinotifications
							(   notification_type, placementid, securityusersid, notification_txt, 
								case_number, servicecaseid 
							)
						values
							(   v_notification_type, v_placementid, v_supervisorid, vs_notification_txt, 
								vl_servicecasenumber, v_servicecaseid 
							);  
					END IF;
				end loop;
				close qicur_all_assgn_refcur;
					
			end loop;   
			close qicur_qinotifications_refcur;

			-- Create Notifications
			-- RAISE NOTICE '7th day Notifications';

			OPEN qicur_qinotif_temp_refcur FOR
			 select distinct notification_type,
				 intakeservicerequestactorid, 
				 securityusersid, 
				 notification_txt, 
				 case_number,
				 servicecaseid               
			 from ttb_qinotifications 
			 order by notification_type;
			loop
				fetch qicur_qinotif_temp_refcur into qicur_qinotif_temp;
				exit when not found;

				v_notification_type := qicur_qinotif_temp.notification_type;
				v_intakeservicerequestactorid := qicur_qinotif_temp.intakeservicerequestactorid;
				v_securityusersid := qicur_qinotif_temp.securityusersid;
				vs_notification_txt := qicur_qinotif_temp.notification_txt;
				vl_servicecasenumber := qicur_qinotif_temp.case_number;
				v_servicecaseid := qicur_qinotif_temp.servicecaseid;


				RAISE NOTICE 'v_notification_type  >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservicerequestactorid  >> %',v_intakeservicerequestactorid;
				RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
				RAISE NOTICE 'vs_notification_txt  >> %',vs_notification_txt;
				RAISE NOTICE 'vl_servicecasenumber  >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid  >> %',v_servicecaseid;


				insert into cjams.usernotification
				 (   usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
					 url, subject, priorityleveltypekey, "body", hasattachments, 
					 updatedby, updatedon, insertedby, insertedon, effectivedate, 
					 expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
					 isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
					 objectcasenumber, entityid, isdeleted, teamtypekey
				 )
				values
				 (   gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
					 NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
					 vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
					 vd_expirationdate, NULL, NULL, NULL, NULL, 
					 false, false, NULL, v_notification_type, 'servicecase', 
					 vl_servicecasenumber, v_placementid, NULL, 'CW'
				 )
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
				 (   usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
					 isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
					 activeflag, teammemberid, insertedby, updatedby, insertedon, 
					 updatedon, fromsecurityusersid, old_id, isdeleted
				 )
				values
				 (   gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
					 NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
					 1, NULL, vs_user_id, vs_user_id, now(), 
					 now(), NULL, NULL, NULL
				 );
						
						
			end loop;
			close qicur_qinotif_temp_refcur;

			delete from ttb_qinotifications;    

			--End of QI Assessment 7th day notification

			--Start QI assessment- Petition deniend by court wweekly notification-- B-135292 -- start of QI Assessment 7th day notification
			DROP TABLE IF EXISTS ttb_qinotifications CASCADE;
			CREATE TEMPORARY TABLE ttb_qinotifications
			(   notification_type varchar(50),
				securityusersid uuid,
				notification_txt varchar(500),
				case_number bigint,
				servicecaseid uuid
			) ;

			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;

			OPEN qicur_qinotifications_refcur FOR
				select 'QRCT02' as notification_type,
					un.insertedon,
					un.objectid as servicecaseid,
					un.objectcasenumber as servicecasenumber,
					un.subject as notificationtext,
					btrim(un.old_id) as old_id
					from usernotification un,
					person pr
				where pr.personid = un.entityid
					and mod((extract(epoch from age(ad_run_dt::date, (un.insertedon::date + interval '7 days'))/ 86400)::integer)::integer, 7) = 0 
					and un.insertedon::date <> ad_run_dt::date
					and un.old_id = 'QRCT01'
					and un.activeflag =1
					--no active petitions       
					   
					--no active qrtp placement 
					and
						(select pl.placementid 
						from placement pl						
						where pl.personid=pr.personid
						and pl.service_id= 11410 --11410 is QRTP provider service
						and pl.enddatetime is NULL
						and coalesce(pl.isvoided, 0) <> 1
						and ( select count(*)
							from routing ro
							where ro.objectid = pl.placementid::character varying
							and ro.eventcode = 'PLTR'
							and ro.activeflag = 1
							and ro.routingstatustypeid = '16'
							-- and ro.insertedon::date = ad_run_dt
						) > 0) is NOT NULL 
					  --added for courtorder
					  and coalesce((select( case when ct.qrtpapproval ='2' then 1 else 0 end)
					from intakeservreqcourtorder ct
						join servicecase sc on sc.servicecaseid = ct.servicecaseid
							and sc.activeflag = 1
						join intakeservicerequestactor isr 
							on isr.intakeservicerequestactorid = ct.intakeservicerequestactorid
					where ct.qrtpapproval is not null
						and ct.servicecaseid = un.objectid::uuid
						and isr.personid = pr.personid
					 --order by ct.updatedon desc limit 1 ),0) = 0
						order by ct.courtorderdate  desc limit 1 ),0) = 1;

					
							  
			loop
				fetch qicur_qinotifications_refcur into qicur_notifications;
				exit when not found;

				v_notification_type := qicur_notifications.notification_type;
				v_servicecaseid := qicur_notifications.servicecaseid;
				vl_servicecasenumber := qicur_notifications.servicecasenumber;
				vs_notification_txt :=qicur_notifications.notificationtext;
				
				
				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservicerequestactorid >> %',v_intakeservicerequestactorid;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;
				
				--vs_notification_txt := un.subject;
				
				RAISE NOTICE 'vs_notification_txtcourt >> %',vs_notification_txt;


				-- Get Child assigned worker(s) and their Supervisor(s) 
				OPEN qicur_all_assgn_refcur FOR
					select lower(ca.responsibilitytypekey) as responsibilitytypekey,
						ca.toworkeridno,
						up.supervisorid 
					from caseassignment ca  
						join county c on c.countyid::character varying = ca.toldssid::character varying
						join userprofile up on up.securityusersid = ca.toworkeridno
							and up.activeflag  = 1
					where ca.objectid = v_servicecaseid
					--  and lower(ca.responsibilitytypekey) in ('family', 'child')
						and ca.activeflag = 1
						and ca.enddate is null 
					order by ca.responsibilitytypekey desc;

				loop
					fetch qicur_all_assgn_refcur into qicur_all_assgn;
					exit when not found;

					vs_responsibilitytypekey := qicur_all_assgn.responsibilitytypekey;
					v_toworkeridno := qicur_all_assgn.toworkeridno;
					v_supervisorid := qicur_all_assgn.supervisorid;
					
					
					RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
					RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
					RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;
					
					-- Family/Child Worker
					Insert into ttb_qinotifications
						(   notification_type, securityusersid, notification_txt, 
							case_number, servicecaseid 
						)
					values
						(   v_notification_type, v_toworkeridno, vs_notification_txt, 
							vl_servicecasenumber, v_servicecaseid 
						);
						
					-- Family/Child Supervisor
					IF v_supervisorid is not null THEN
						Insert into ttb_qinotifications
							(   notification_type, securityusersid, notification_txt, 
								case_number, servicecaseid 
							)
						values
							(   v_notification_type, v_supervisorid, vs_notification_txt, 
								vl_servicecasenumber, v_servicecaseid 
							);  
					END IF;
				end loop;
				close qicur_all_assgn_refcur;
					
			end loop;   
			close qicur_qinotifications_refcur;

			-- Create Notifications
			-- RAISE NOTICE '7th day Notifications';

			OPEN qicur_qinotif_temp_refcur FOR
				select distinct notification_type,
				   --intakeservicerequestactorid, 
					 securityusersid, 
					 notification_txt, 
					 case_number,
					 servicecaseid               
				 from ttb_qinotifications 
				 order by notification_type;
			loop
			fetch qicur_qinotif_temp_refcur into qicur_qinotif_temp;
			exit when not found;

				v_notification_type := qicur_qinotif_temp.notification_type;
				--v_intakeservicerequestactorid := qicur_qinotif_temp.intakeservicerequestactorid;
				v_securityusersid := qicur_qinotif_temp.securityusersid;
				vs_notification_txt := qicur_qinotif_temp.notification_txt;
				vl_servicecasenumber := qicur_qinotif_temp.case_number;
				v_servicecaseid := qicur_qinotif_temp.servicecaseid;


				RAISE NOTICE 'v_notification_type  >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservicerequestactorid  >> %',v_intakeservicerequestactorid;
				RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
				RAISE NOTICE 'vs_notification_txt  >> %',vs_notification_txt;
				RAISE NOTICE 'vl_servicecasenumber  >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid  >> %',v_servicecaseid;


				insert into cjams.usernotification
					 (   usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						 url, subject, priorityleveltypekey, "body", hasattachments, 
						 updatedby, updatedon, insertedby, insertedon, effectivedate, 
						 expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						 isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						 objectcasenumber, entityid, isdeleted, teamtypekey
					 )
				values
					 (   gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						 NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						 vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						 vd_expirationdate, NULL, NULL, NULL, NULL, 
						 false, false, NULL, v_notification_type, 'servicecase', 
						 vl_servicecasenumber, NULL, NULL, 'CW'
					 )
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					 (   usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						 isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						 activeflag, teammemberid, insertedby, updatedby, insertedon, 
						 updatedon, fromsecurityusersid, old_id, isdeleted
					 )
				values
					 (   gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						 NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						 1, NULL, vs_user_id, vs_user_id, now(), 
						 now(), NULL, NULL, NULL
					 );
							
							
				end loop;
				close qicur_qinotif_temp_refcur;

			delete from ttb_qinotifications;    
			-- end petition denied by court 

			-- B-135292 -- start of QI Assessment 5th and 11th month notification
			DROP TABLE IF EXISTS ttb_qinotifications CASCADE;
			CREATE TEMPORARY TABLE ttb_qinotifications
				(   notification_type varchar(50),
					 placementid uuid,
					securityusersid uuid,
					notification_txt varchar(500),
					case_number bigint,
					servicecaseid uuid
				) ;
			
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;
			v_current_timestamp := (ad_run_dt::date || ' ' || current_time)::timestamp ;


			OPEN qicur_qinotifications_refcur FOR
				select (case when f_age(ad_run_dt::date, pr.dob) <= 12 then 
						'QRTP05'
					else
						'QRTP11'
					end) as notification_type,
					pl.servicecaseid as servicecaseid,
					sc.servicecasenumber as servicecasenumber,
					pr.cjamspid, 
					pr.dob,
					pl.startdatetime,
					pl.placementid,
					f_age(ad_run_dt::date, pr.dob)::integer as client_age,
					 pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying as client_nm
				from placement pl
					join person pr on pr.personid = pl.personid 
					 join servicecase sc on sc.servicecaseid =pl.servicecaseid
				where pl.activeflag = 1
				and pr.activeflag = 1
				and pl.service_id  = 11410 -- --11410 is QRTP provider service
				and pl.startdatetime::date is not null
				and pl.enddatetime is null 
				and coalesce(pl.isvoided, 0) <> 1
				and ( select count(*)
						from routing ro
						where ro.objectid = pl.placementid::character varying
						and ro.eventcode = 'PLTR'
					and ro.activeflag = 1
					and ro.routingstatustypeid = '16'
				) > 0
				-- QI initial assessment is completed
				and (select count(*) from assessment ast  where 
				ast.personid  =pr.personid 
				and ast.assessmenttemplateid  ='1d51c065-7733-4ff9-8a9b-7667019c86ca' 
				and ast.assessmentstatustypekey ='Completed' 
				and ast.activeflag  =1
				and ast.objectid  =pl.servicecaseid) > 0
				--no court order denial
				and coalesce((select( case when ct.qrtpapproval ='2' then 1 else 0 end)
					from intakeservreqcourtorder ct
						join servicecase sc on sc.servicecaseid = ct.servicecaseid
							and sc.activeflag = 1
						join intakeservicerequestactor isr 
							on isr.intakeservicerequestactorid = ct.intakeservicerequestactorid
					where ct.qrtpapproval is not null
						and ct.servicecaseid = pl.servicecaseid
						and isr.personid = pr.personid
					-- order by ct.updatedon desc limit 1
						order by ct.courtorderdate  desc limit 1 ),0) = 0
				--
				/*
				and (case when f_age(ad_run_dt::date, pr.dob) <= 12 then 
							(pl.startdatetime::date + interval '5 months')::date
						else
							(pl.startdatetime::date + interval '11 months')::date
					end) = ad_run_dt  
				*/
				;                
			loop
				 fetch qicur_qinotifications_refcur into qicur_notifications;
				 exit when not found;

				 v_notification_type := qicur_notifications.notification_type;
				-- v_intakeservicerequestactorid := qicur_notifications.intakeservicerequestactorid;
				 v_servicecaseid := qicur_notifications.servicecaseid;
				 vl_servicecasenumber := qicur_notifications.servicecasenumber;
				 vd_placement_entry_ts := qicur_notifications.startdatetime ;
				 vl_client_age := qicur_notifications.client_age ;
				 v_placementid := qicur_notifications.placementid;
				 v_personname :=qicur_notifications.client_nm;
			
				RAISE NOTICE 'v_notification_type >> %',v_notification_type;
				RAISE NOTICE 'v_intakeservicerequestactorid >> %',v_intakeservicerequestactorid;
				RAISE NOTICE 'v_servicecaseid >> %',v_servicecaseid;
				RAISE NOTICE 'vl_servicecasenumber >> %',vl_servicecasenumber;

				vs_notification_txt := 'Re-assessment of QI Assessment must be done for ' || v_personname ;
				

				vd_qrtp_date := NULL;

				if vl_client_age <= 12 then
                   
				select qrtp_date into vd_qrtp_date
					
					from (
					select int_date::date - interval '1 month' as qrtp_date
						from (
						select DATE(vd_placement_entry_ts) + (interval '6' month * generate_series(0,month_count::int)) as int_date
						from (
						select extract(year from diff) * 12 + extract(month from diff) + 12 as month_count
						from (
							select age(current_timestamp, vd_placement_entry_ts::timestamp ) as diff 
						) td
						) t
						) a
					) tab 
					where tab.qrtp_date::date = ad_run_dt::date;
					
                else
                    select qrtp_date into vd_qrtp_date
					
					from (
					select int_date::date - interval '1 month' as qrtp_date
						from (
						select DATE(vd_placement_entry_ts) + (interval '12' month * generate_series(0,month_count::int)) as int_date
						from (
						select extract(year from diff) * 12 + extract(month from diff) + 12 as month_count
						from (
							select age(current_timestamp, vd_placement_entry_ts::timestamp ) as diff 
						) td
						) t
						) a
					) tab 
					where tab.qrtp_date::date = ad_run_dt::date;
                end if;
			
				RAISE NOTICE 'vd_qrtp_date >> %',vd_qrtp_date;
				if vd_qrtp_date is not null then
				
					OPEN qicur_all_assgn_refcur FOR
						select lower(ca.responsibilitytypekey) as responsibilitytypekey,
							ca.toworkeridno,
							up.supervisorid 
						from caseassignment ca  
						--	join county c on c.countyid::character varying = ca.toldssid::character varying
							join userprofile up on up.securityusersid = ca.toworkeridno
								and up.activeflag  = 1
						where ca.objectid = v_servicecaseid
						--  and lower(ca.responsibilitytypekey) in ('family', 'child')
							and ca.activeflag = 1
							and ca.enddate is null 
						order by ca.responsibilitytypekey desc;

					loop
						fetch qicur_all_assgn_refcur into qicur_all_assgn;
						exit when not found;
				
						vs_responsibilitytypekey := qicur_all_assgn.responsibilitytypekey;
						v_toworkeridno := qicur_all_assgn.toworkeridno;
						v_supervisorid := qicur_all_assgn.supervisorid;
						
						
						RAISE NOTICE 'vs_responsibilitytypekey  >> %',vs_responsibilitytypekey;
						RAISE NOTICE 'v_toworkeridno  >> %',v_toworkeridno;
						RAISE NOTICE 'v_supervisorid  >> %',v_supervisorid;
						
						-- Family/Child Worker
						Insert into ttb_qinotifications
							(   notification_type, placementid, securityusersid, notification_txt, 
								case_number, servicecaseid 
							)
						values
							(   v_notification_type, v_placementid, v_toworkeridno, vs_notification_txt, 
								vl_servicecasenumber, v_servicecaseid 
							);
							
						-- Family/Child Supervisor
						IF v_supervisorid is not null THEN
							Insert into ttb_qinotifications
								(   notification_type, placementid, securityusersid, notification_txt, 
									case_number, servicecaseid 
								)
							values
								(   v_notification_type, v_placementid, v_supervisorid, vs_notification_txt, 
									vl_servicecasenumber, v_servicecaseid 
								);  
						END IF;
					end loop;
					close qicur_all_assgn_refcur;
				END IF;  

			end loop;   
			close qicur_qinotifications_refcur;

			-- Create Notifications
			RAISE NOTICE '5th and 11th month Notifications';
			
			OPEN qicur_qinotif_temp_refcur FOR
				select distinct notification_type,
					placementid, 
					securityusersid, 
					notification_txt, 
					case_number,
					servicecaseid               
				from ttb_qinotifications 
				order by notification_type;
			loop
				fetch qicur_qinotif_temp_refcur into qicur_qinotif_temp;
				exit when not found;

				v_notification_type := qicur_qinotif_temp.notification_type;
				v_placementid := qicur_qinotif_temp.placementid;
				v_securityusersid := qicur_qinotif_temp.securityusersid;
				vs_notification_txt := qicur_qinotif_temp.notification_txt;
				vl_servicecasenumber := qicur_qinotif_temp.case_number;
				v_servicecaseid := qicur_qinotif_temp.servicecaseid;
				
				RAISE NOTICE 'v_notification_type  >> %',v_notification_type;
			   -- RAISE NOTICE 'v_intakeservicerequestactorid  >> %',v_intakeservicerequestactorid;
				RAISE NOTICE 'v_securityusersid  >> %',v_securityusersid;
				RAISE NOTICE 'vs_notification_txt  >> %',vs_notification_txt;
				RAISE NOTICE 'vl_servicecasenumber  >> %',vl_servicecasenumber;
				RAISE NOTICE 'v_servicecaseid  >> %',v_servicecaseid;
				
				
				insert into cjams.usernotification
					(   usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
						url, subject, priorityleveltypekey, "body", hasattachments, 
						updatedby, updatedon, insertedby, insertedon, effectivedate, 
						expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
						isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
						objectcasenumber, entityid, isdeleted, teamtypekey
					)
				values
					(   gen_random_uuid(), v_securityusersid, 'System', v_servicecaseid, 1, 
						NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
						vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
						vd_expirationdate, NULL, NULL, NULL, NULL, 
						false, false, NULL, v_notification_type, 'servicecase', 
						vl_servicecasenumber, v_placementid, NULL, 'CW'
					)
				RETURNING "usernotificationid" INTO  v_usernotificationid; 

				insert into cjams.usernotificationmap
					(   usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
						isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
						activeflag, teammemberid, insertedby, updatedby, insertedon, 
						updatedon, fromsecurityusersid, old_id, isdeleted
					)
				values
					(   gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
						NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
						1, NULL, vs_user_id, vs_user_id, now(), 
						now(), NULL, NULL, NULL
					);
							
			end loop;
			close qicur_qinotif_temp_refcur;
			
			delete from ttb_qinotifications;    
		END IF;
		--QI assessment ends
		
		
		
	END LOOP;	
	-- v_batch_rundate - End
		
	-- B-108967 & B-113025
	IF lower(as_notification_type) = 'suspension' OR lower(as_notification_type) = 'all' THEN
		vs_user_id := 'cwadmin';
		vd_expirationdate := NULL;
		vd_effectivedate := ad_run_dt;
		
		DROP TABLE IF EXISTS ttb_ooh_suspensions CASCADE;
		CREATE TEMPORARY TABLE ttb_ooh_suspensions
			(	notification_type varchar(1),
				suspensionid uuid,
				caseid uuid,
				case_number bigint,
				notification_txt varchar(500),
				securityusersid uuid,
				personid uuid
			) ;
			
		
		OPEN cur_gap_supension_refcur FOR
			select distinct gs.gapsuspensionid,
				g.servicecaseid, 
				sc.servicecasenumber,
				'Child ' || p.firstname || ' ' || p.lastname ||
				' / CJAMS PID ' || (p.cjamspid)::character varying
				|| ' has re-entered foster care. Please send a Notification of intent letter to Terminate Guardianship.'
				as notification_tx,
				p.personid
			from gapsuspension gs,
				guardianship g,
				gapagreement ga,
				permanencyplan pp,
				intakeservicerequestactor isra,
				person p,
				servicecase sc
			where gs.gapid = g.gapid 
				and ga.gapid = g.gapid
				and pp.permanencyplanid = g.permanencyplanid
				and isra.intakeservicerequestactorid = pp.intakeservicerequestactorid
				and p.personid = isra.personid
				and sc.servicecaseid = g.servicecaseid
				and gs.suspensionreasontypekey = 'COHP'
				and gs.startdate is not null
				and gs.enddate is null
				-- and gs.startdate::date + interval '60 days' = ad_run_dt::date
				and gs.activeflag = 1
				and g.activeflag = 1
				and ga.activeflag = 1
				and pp.activeflag = 1
				and isra.activeflag = 1
				and p.activeflag = 1
				and sc.activeflag = 1
				and ga.enddate::date > current_date 
				and ( select count(*)
						from intakeservreqchildremoval rm,
							routing ru
					  where rm.intakeservreqchildremovalid::character varying = ru.objectid 
						and rm.personid = p.personid
						and rm.removaldate is not null
						and rm.exitdate is null
						and rm.removaldate::date + interval '60 days' = ad_run_dt::date
						and ru.eventcode  = 'CHRR'
						and ru.routingstatustypeid = 16
						and rm.activeflag = 1
						and ru.activeflag = 1
					) > 0
				;
		loop
			fetch cur_gap_supension_refcur into cur_gap_supension;
			exit when not found;

			v_suspensionid := cur_gap_supension.gapsuspensionid;
			v_caseid := cur_gap_supension.servicecaseid;
			vl_casenumber := cur_gap_supension.servicecasenumber;
			vs_notification_txt := cur_gap_supension.notification_tx;
			v_personid := cur_gap_supension.personid;
			
			-- Guardianship Case Worker
			vs_securityusersid := null;
			
			select ca.toworkeridno,
				c.statecountycode
			into vs_securityusersid, 
				vs_statecountycode
			from caseassignment ca  
				join county c on c.countyid::character varying = ca.toldssid::character varying
				join userprofile up on up.securityusersid = ca.toworkeridno
					and up.activeflag  = 1
			where ca.objectid = v_caseid
				and lower(ca.responsibilitytypekey) = 'family'
				and ca.activeflag = 1
				and ca.enddate is null 
			order by ca.startdate desc, 
				coalesce(ca.enddate, current_date) desc
			limit 1 ;
			
			IF vs_securityusersid is not null THEN  
				Insert into ttb_ooh_suspensions
					( 	notification_type, suspensionid, caseid, 
						case_number, notification_txt, securityusersid
					)
				values
					( 	'G', v_suspensionid, v_caseid,
						vl_casenumber, vs_notification_txt, vs_securityusersid::uuid
					);
			END IF;
				
			-- Finance Supervisors
			OPEN cur_finance_sup_refcur FOR
				select securityusersid
					from cjams.v_userprofile 
				where userteamtype = 'FNS'
					and roletypekey = 'FNSFS'
					and statecountycode = vs_statecountycode
					and teamkey = 'CW' ;
			loop
				fetch cur_finance_sup_refcur into cur_finance_sup;
				exit when not found;

				vs_fin_supervisorid := cur_finance_sup.securityusersid;
				
				Insert into ttb_ooh_suspensions
					( 	notification_type, suspensionid, caseid, 
						case_number, notification_txt, securityusersid
					)
				values
					( 	'G', v_suspensionid, v_caseid,
						vl_casenumber, vs_notification_txt, vs_fin_supervisorid::uuid
					);
			end loop;
			close cur_finance_sup_refcur;
			
			-- IV-E Supervisors	
			OPEN cur_ive_sup_refcur FOR
				select distinct userid
				from cjams.getroutingusers
					(	null::character varying, 
						'IVEADOP'::character varying, 
						NULL::uuid
					);
			loop
				fetch cur_ive_sup_refcur into cur_ive_sup;
				exit when not found;

				vs_ive_supervisorid := cur_ive_sup.userid;
				
				Insert into ttb_ooh_suspensions
					( 	notification_type, suspensionid, caseid, 
						case_number, notification_txt, securityusersid
					)
				values
					( 	'G', v_suspensionid, v_caseid,
						vl_casenumber, vs_notification_txt, vs_ive_supervisorid::uuid
					);
			end loop;
			close cur_ive_sup_refcur;	
			
			-- Removal (Foster Care) Case Worker
			select rm.servicecaseid
				into v_servicecaseid	
			from intakeservreqchildremoval rm,
				routing ru
			where rm.intakeservreqchildremovalid::character varying = ru.objectid 
				and rm.personid = v_personid
				and rm.removaldate is not null
				and rm.exitdate is null
				and rm.removaldate::date + interval '60 days' = ad_run_dt::date
				and ru.eventcode  = 'CHRR'
				and ru.routingstatustypeid = 16
				and rm.activeflag = 1
				and ru.activeflag = 1
			order by rm.insertedon desc
			limit 1;	
			
			IF v_servicecaseid is not null THEN
				select ca.toworkeridno
					into vs_rem_caseworkerid
				from caseassignment ca  
					join county c on c.countyid::character varying = ca.toldssid::character varying
					join userprofile up on up.securityusersid = ca.toworkeridno
						and up.activeflag  = 1
				where ca.objectid = v_servicecaseid
					and lower(ca.responsibilitytypekey) = 'family'
					and ca.activeflag = 1
					and ca.enddate is null 
				order by ca.startdate desc, 
					coalesce(ca.enddate, current_date) desc
				limit 1 ;
			END IF; 
			
			IF vs_rem_caseworkerid is not null THEN
				Insert into ttb_ooh_suspensions
					( 	notification_type, suspensionid, caseid, 
						case_number, notification_txt, securityusersid
					)
				values
					( 	'G', v_suspensionid, v_caseid,
						vl_casenumber, vs_notification_txt, vs_rem_caseworkerid::uuid
					);
			END IF;
			
		end loop;
		close cur_gap_supension_refcur;
		
		-- Create Notifications
		RAISE NOTICE 'Final OOH Suspensions';		
		OPEN cur_suspensions_refcur FOR
			select distinct notification_type, 
				suspensionid, 
				caseid, 
				case_number, 
				notification_txt, 
				securityusersid
			from ttb_ooh_suspensions 
			order by notification_type;
		loop
			fetch cur_suspensions_refcur into cur_suspensions;
			exit when not found;

			v_notification_type := cur_suspensions.notification_type;
			v_entityid := cur_suspensions.suspensionid;
			v_caseid := cur_suspensions.caseid;
			vl_casenumber := cur_suspensions.case_number;
			vs_notification_txt := cur_suspensions.notification_txt;
			v_securityusersid := cur_suspensions.securityusersid;
			
			IF v_notification_type = 'G' THEN
				vs_objecttype := 'servicecase';
			ELSE
				vs_objecttype := 'adoptioncase';
			END IF;			
				
			v_usernotificationid := NULL;
			
			insert into cjams.usernotification
				(	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
					url, subject, priorityleveltypekey, "body", hasattachments, 
					updatedby, updatedon, insertedby, insertedon, effectivedate, 
					expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
					isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
					objectcasenumber, entityid, isdeleted, teamtypekey
				)
			values
				(	gen_random_uuid(), v_securityusersid, 'System', v_caseid, 1, 
					NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
					vs_user_id, now(), vs_user_id, now(),  vd_effectivedate, 
					vd_expirationdate, NULL, NULL, NULL, NULL, 
					false, false, NULL, 'RMSUP60', vs_objecttype, 
					vl_casenumber, v_entityid, NULL, 'CW'
				)
			RETURNING "usernotificationid" INTO  v_usernotificationid; 

			insert into cjams.usernotificationmap
				(	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
					isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
					activeflag, teammemberid, insertedby, updatedby, insertedon, 
					updatedon, fromsecurityusersid, old_id, isdeleted
				)
			values
				( 	gen_random_uuid(), v_usernotificationid, v_securityusersid, NULL, NULL, 
					NULL, NULL, false, vd_expirationdate, vd_effectivedate, 
					1, NULL, vs_user_id, vs_user_id, now(), 
					now(), NULL, NULL, NULL
				);
						
		end loop;
		close cur_suspensions_refcur;
	END IF;
	
	-- CIDM-10354 -- Update task status from open to pending if due date is past today
	IF lower(as_notification_type) = 'activitytaskupdate' OR lower(as_notification_type) = 'all' THEN
		update Activitytask actvt set activitytaskstatustypekey = 'CRInProgress', updatedby = 'batchUpdate',updatedon = now()
		where actvt.activitytaskstatustypekey ='CROpen' and actvt.duedate < current_date; 

		-- Inserting recurring task for existing child removal for Mediation Pyschotropic and Health Disorder.
		PERFORM spcreateactiontaskfromdailyjobforexistingchildremoval();
	End if;

 

	DROP TABLE IF EXISTS TTB_LA_RUNAWAYS CASCADE;	
	DROP TABLE IF EXISTS ttb_removals CASCADE;	
	DROP TABLE IF EXISTS ttb_ooh_suspensions CASCADE;	
	DROP TABLE IF EXISTS ttb_quickaddperson CASCADE; -- B-120424
	DROP TABLE IF EXISTS ttb_cfe_placement CASCADE;	
	DROP TABLE IF EXISTS ttb_edu_bid CASCADE;	
	DROP TABLE IF EXISTS ttb_donot_expung CASCADE;	
	DROP TABLE IF EXISTS ttb_quarterly_alerts CASCADE;	
	DROP TABLE IF EXISTS tmp_batch_run CASCADE;	
	DROP TABLE IF EXISTS ttb_posc CASCADE;	
	DROP TABLE IF EXISTS ttb_responsetimer CASCADE;	
	DROP TABLE IF EXISTS ttb_phnotifications CASCADE;
	
	-- B-108258	
	select cjams.sp_cw_autocaseclosure() into vl_sql_code;
	
	-- CIDM-5758/B-137390
	vl_sql_code := NULL;
	vs_message := NULL;
	
	select a.al_sqlcode, a.as_mess
		from cjams.sp_update_historic_sen_person_flag(null::date, NULL::character varying ) a 
	into vl_sql_code, vs_message ;

	IF lower(as_notification_type) = 'all'  THEN
    	select  * from sp_cw_person_usernotifications('all'::character varying, null::date) into v_youth_parenting_child_status;
	END IF;
	-- CIDM-10983 - ICWA notifications - 90 day reminder for Unknown ICWA Status update.
	IF lower(as_notification_type) = 'icwa' THEN
		select  * from sp_cw_person_usernotifications('icwa'::character varying, current_date) into v_youth_parenting_child_status;
	END IF;

	-- CIDM-11333 - Investigation Case Closure Notifications
	IF lower(as_notification_type) = 'java-batch-email-notification' or lower(as_notification_type) = 'all' then
		select cjams.sp_cw_java_batch_email_notification('java-batch-email-notification') into v_case_closure;
	END IF;

	Return 1;
  END;

$function$
;