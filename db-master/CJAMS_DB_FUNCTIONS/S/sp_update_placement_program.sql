CREATE OR REPLACE FUNCTION cjams.sp_update_placement_program(al_placement_id bigint, al_old_program_id bigint, al_new_program_id bigint, ad_placement_entry_date date, as_request_user_id character varying, as_approver_user_id character varying, OUT al_sqlcode integer, OUT as_mess character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 02/08/2021
-- SP to update the Placement Contract Program 
-- Exit the current placement & create new placement for single Placement or all Placements under that program

-- Revision(s)
-- 03/15/2021 Vineet Tirodkar - To add condition for current placement entry <= ad_placement_entry_date
-- 03/19/2021 Vineet Tirodkar - Modifications to from/to security user id logic for the routing (approval) table 
-- 05/10/2021 Vineet Tirodkar - Modifications for Provider schema changes (B-102023)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------
DECLARE sqlcode int default 0;

DECLARE vl_active_plc integer;
DECLARE vl_vacancy integer;
DECLARE vl_active_placements integer;
DECLARE vl_row_cnt integer;
DECLARE vl_placement_exit_day integer;
DECLARE vl_service_id integer;
DECLARE vl_site_cnt integer;

DECLARE vl_case_id bigint;
DECLARE vl_placement_id bigint;
DECLARE vl_new_placement_id bigint;
DECLARE vl_contract_program_id bigint;
DECLARE vl_provider_id bigint;

DECLARE vs_proceed_sw char(1);
DECLARE vs_placement_update_sw char(1) default 'N';
DECLARE vs_cursor_sql varchar(12000);

DECLARE vd_entry_month_first_day date; 

DECLARE vu_placementid uuid; 
DECLARE vu_new_placement_id uuid;
DECLARE vu_personid uuid; 
DECLARE vu_servicecaseid uuid; 
DECLARE vu_teamid uuid; 
DECLARE vu_request_user_id uuid;
DECLARE vu_approver_user_id uuid;
				
DECLARE	vd_entry_dt Date;

cur_placement_refcur REFCURSOR;
cur_placement record;


BEGIN
	IF as_request_user_id is null THEN
		as_request_user_id  := 'CaseWorker';
		vu_teamid = '452febf8-428b-4836-b8e2-9125ace6307b'::uuid ; -- MDTHINK CJAMS
	ELSE
		select teamid 
			into vu_teamid
		from v_userprofile 
		where securityusersid = as_request_user_id ;
		
	END IF;	
	IF as_approver_user_id is null THEN
		as_approver_user_id  := 'CaseSupervisor';
	END IF;	
	 
	-- INITIAL VALUES
	vs_proceed_sw := 'Y'; 
	al_sqlcode := 0 ;
	as_mess := 'Success';
	
	IF ad_placement_entry_date is null THEN
		vs_proceed_sw := 'N' ;
		al_sqlcode := -1;
		as_mess := 'Placement Change Date is missing.';
	END IF;
	
	-- Check if the call is for single Placement change or all Placements 
	IF vs_proceed_sw = 'Y' THEN
		IF al_placement_id is not null THEN
		
			select count(*)
				into vl_active_plc
			from tb_placement 
			where delete_sw = 'N' 
				and entry_dt is not null 
				and entry_dt <= ad_placement_entry_date
				and exit_dt is null 
				and approval_status_cd = '3047'
				and coalesce(void_sw, 'N') <> 'Y'
				and placement_id = al_placement_id ;
			
			IF vl_active_plc = 0 THEN
				vs_proceed_sw := 'N' ;
				al_sqlcode := -1;
				as_mess := 'This Placement is no more active in CJAMS.';
			ELSE
				-- Check if the new program is having vacancy 
				vl_vacancy := 0 ;
				
				select coalesce(vacancy_no, 0) 	
					into vl_vacancy
				from tb_contract_program
				where program_id = al_new_program_id
					and delete_sw = 'N'	
					and program_status_cd = '3625' ;
				
				IF vl_vacancy = 0 THEN
					vs_proceed_sw := 'N';
					al_sqlcode := -1;
					as_mess := 'The new program is not having any vacancy.';
				ELSE
					vs_proceed_sw := 'Y' ;
					vs_cursor_sql :=   
						' select placementid, personid, servicecaseid, '||
						'        entry_dt, case_id, placement_id, contract_program_id, provider_id '|| 
						'	from tb_placement '|| 
						' where delete_sw = ''N'' '|| 
						'	and entry_dt is not null '|| 
						'   and entry_dt <= '''|| to_char(ad_placement_entry_date, 'YYYY-MM-DD') ||''' '
						'	and exit_dt is null '|| 
						'	and approval_status_cd = ''3047'' '|| 
						'	and coalesce(void_sw, ''N'') <> ''Y'' '|| 
						'   and contract_program_id is not null '||
						'	and placement_id = '|| (al_placement_id)::character varying ;

						vl_row_cnt := 1;                                                                  
				END IF;	
			END IF;	
		ELSE
			IF al_old_program_id is not null and al_new_program_id is not null THEN
				-- Get the count of active placements under old program
				vl_active_placements := 0 ;
				
				select count(*) 
						into vl_active_placements
					from tb_placement
				where delete_sw = 'N'
					and entry_dt is not null
					and entry_dt <= ad_placement_entry_date
					and exit_dt is null
					and approval_status_cd = '3047'
					and coalesce(void_sw, 'N') <> 'Y'
					and contract_program_id = al_old_program_id ;

				-- Check if the new program is having vacancy 
				vl_vacancy := 0 ;
				
				select coalesce(vacancy_no, 0) 	
					into vl_vacancy
				from tb_contract_program
				where program_id = al_new_program_id
					and delete_sw = 'N'	
					and program_status_cd = '3625' ;
			
			
				-- Check if the new program is having vacancies > Active Placements  
				IF vl_vacancy < vl_active_placements THEN
					vs_proceed_sw := 'N';
					al_sqlcode := -1;
					as_mess := 'The new program is not having enough vacancies to accommodate all active placements from old program.';
				ELSE
					vs_proceed_sw := 'Y' ;
					
					vs_cursor_sql :=   
					' select placementid, personid, servicecaseid, '||
					'        entry_dt, case_id, placement_id, contract_program_id, provider_id '|| 
					'	from tb_placement '|| 
					'where delete_sw = ''N'' '|| 
					'	and entry_dt is not null '|| 
					'   and entry_dt <= '''|| to_char(ad_placement_entry_date, 'YYYY-MM-DD') ||''' '
					'	and exit_dt is null '|| 
					'	and approval_status_cd = ''3047'' '|| 
					'	and coalesce(void_sw, ''N'') <> ''Y'' '|| 
					'	and contract_program_id = '|| (al_old_program_id)::character varying ||' '||
					'   order by placement_id ';

					select count(*)
						into vl_row_cnt                                                                   
					from tb_placement
					where delete_sw = 'N'
						and entry_dt is not null
						and entry_dt <= ad_placement_entry_date
						and exit_dt is null
						and approval_status_cd = '3047'
						and coalesce(void_sw, 'N') <> 'Y'
						and contract_program_id = al_old_program_id ;
				END IF;
				
			ELSE
				vs_proceed_sw := 'N' ;
				al_sqlcode := -1;
				as_mess := 'Old Program ID and/or New Program ID is missing.';
			END IF;
		END IF;
	END IF;
	
	IF vs_proceed_sw = 'Y' THEN
		OPEN cur_placement_refcur FOR EXECUTE vs_cursor_sql;
													
		loop EXIT WHEN vl_row_cnt = 0::bigint ;     
			vu_placementid := null; 
			vu_personid := null; 
			vu_servicecaseid  := null;
			vd_entry_dt := null;
			vl_case_id := null;
			vl_placement_id := null;
			vl_contract_program_id := null;
			vl_provider_id := null;
	
			FETCH cur_placement_refcur 
			INTO vu_placementid, 
				vu_personid, 
				vu_servicecaseid, 
				vd_entry_dt,
				vl_case_id,
				vl_placement_id,
				vl_contract_program_id,
				vl_provider_id	;
					
			RAISE NOTICE 'vu_placementid >>%', vu_placementid;
			RAISE NOTICE 'vu_personid >>%', vu_personid;
			RAISE NOTICE 'vu_servicecaseid >>%', vu_servicecaseid;
			RAISE NOTICE 'vd_entry_dt >>%', vd_entry_dt;
			RAISE NOTICE 'vl_case_id >>%', vl_case_id;
			RAISE NOTICE 'vl_placement_id >>%', vl_placement_id;
			RAISE NOTICE 'vl_contract_program_id >>%', vl_contract_program_id;
			RAISE NOTICE 'vl_provider_id >>%', vl_provider_id;
			
			-- Verfiy if the new Program is havign the same Provider Site
			select count(*)
				into vl_site_cnt
			from tb_prov_program_sites 
			where program_id = al_new_program_id
				and site_id = vl_provider_id
				and delete_sw = 'N' ; 
			
			IF vl_site_cnt = 0 THEN
				vs_proceed_sw := 'N' ;
				al_sqlcode := -1;
				as_mess := 'The New Program is not having Site Provider ID: ' || (vl_provider_id)::character varying;
			END IF;	
			
			IF vs_proceed_sw = 'Y' THEN
				-- Get Approval requestor & approver
				select ca.toworkeridno,
					   up.supervisorid,
					   vu.teamid 
				into vu_request_user_id, 
					vu_approver_user_id,
					vu_teamid	   
				from caseassignment ca,
					cjams.userprofile up,
					cjams.v_userprofile vu 
				where ca.toworkeridno = up.securityusersid 
					and ca.toworkeridno = vu.securityusersid 
					and ca.objectid = (select servicecaseid 
										from cjams.servicecase 
									 where servicecasenumber = vl_case_id )
					and lower(ca.responsibilitytypekey) = 'family'
					and ca.activeflag = 1
					and up.activeflag = 1
				order by ca.insertedon desc
				limit 1 ;
				
				/*
				select ru.fromsecurityusersid, 
					ru.tosecurityusersid,
					ru.teamid	
				into vu_approver_user_id,
					vu_request_user_id, 
					vu_teamid
				from cjams.routing ru 
				where ru.objectid = vu_placementid::character varying 
					and ru.activeflag  = 1
					and ru.routingstatustypeid = '16'	
					and ru.toroleid not in ('IVESP', 'IVESV') ;
				*/
				IF vu_request_user_id is not null THEN
					as_request_user_id := vu_request_user_id;
				ELSE
					as_request_user_id  := 'CaseWorker';
				END IF;
				
				IF vu_approver_user_id is not null THEN
					as_approver_user_id := vu_approver_user_id;
				ELSE
					as_approver_user_id  := 'CaseSupervisor';
				END IF;
				  
				IF vu_teamid is null THEN
					vu_teamid := '452febf8-428b-4836-b8e2-9125ace6307b'::uuid ; -- MDTHINK CJAMS
				END IF;
				
				RAISE NOTICE 'as_request_user_id >>%', as_request_user_id;
				RAISE NOTICE 'as_approver_user_id >>%', as_approver_user_id;
				RAISE NOTICE 'vu_teamid >>%', vu_teamid;
				
				-- Current Placement Updates - START
				---------------------------------
				-- Insert into placementrevision 
				INSERT INTO cjams.placementrevision
					(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
						exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
						approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
						updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
						voidremarks, enddate, endtime, exittypekey, remarks, 
						isvoided, voiddate, requestedby, requesteddate, approvedby, 
						approveddate, etl_userid, etl_load_date, ischangepreadoptive
					)
				select gen_random_uuid(), placementid, now(), startdatetime, starttime, 
					ad_placement_entry_date, '00:00'::time, null , 'CIPO', '',
					'3045', null, null, now(), as_request_user_id,
					now(), as_approver_user_id, 0, alternateid, null,
					NULL, NULL, NULL, 'CIP', '',
					'0', null, as_request_user_id, now(), as_approver_user_id,
					now(), null, null, null
				from placement
				where placementid = vu_placementid::uuid ;

				INSERT INTO cjams.placementrevision
					(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
						exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
						approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
						updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
						voidremarks, enddate, endtime, exittypekey, remarks, 
						isvoided, voiddate, requestedby, requesteddate, approvedby, 
						approveddate, etl_userid, etl_load_date, ischangepreadoptive
					)
				select gen_random_uuid(), placementid, now(), startdatetime, starttime, 
					ad_placement_entry_date, '00:00'::time, null , 'CIPO', '',
					'3047', now(), null, now(), as_request_user_id,
					now(), as_approver_user_id, 1, alternateid, null,
					NULL, NULL, NULL, 'CIP', '',
					'0', null,as_request_user_id, now(), as_approver_user_id,
					now(), null, null, null
				from placement
				where placementid = vu_placementid::uuid ;

				
				-- Insert into routing
				INSERT INTO cjams.routing
					(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
						insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
						remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
						old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
						etl_load_date, entityid, reassignnotes
					)
				VALUES
					(	gen_random_uuid(), 'PLTR', as_approver_user_id, NULL, NULL, 
						'CWSP', 'IVESV', vu_placementid, 16, 1, 
						as_approver_user_id, now(), as_approver_user_id, now(), false, 
						NULL, NULL, NULL, vl_case_id, NULL, 
						NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL
					);
						
				INSERT INTO cjams.routing
					(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
						insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
						remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
						old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
						etl_load_date, entityid, reassignnotes
					)
				VALUES
					(	gen_random_uuid(), 'PLTR', as_request_user_id, as_approver_user_id, vu_teamid, 
						'CWSP', 'CWCW', vu_placementid, 16, 1, 
						as_request_user_id, now(), as_approver_user_id, now(), true, 
						'', NULL, 'Child Placement Approved', vl_case_id, NULL, 
						NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL
					);
					
				INSERT INTO cjams.routing
					(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
						insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
						remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
						old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
						etl_load_date, entityid, reassignnotes
					)
				VALUES
					(	gen_random_uuid(), 'PLTR', as_request_user_id, as_approver_user_id, vu_teamid, 
						'CWSP', 'CWCW', vu_placementid, 15, 0, 
						as_request_user_id, now(), as_approver_user_id, now(), true, 
						'', NULL, 'Placement Exit Submitted for review', vl_case_id, 'Servicecase', 
						NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL
					);	

				
				-- Update placement 
				update placement 
					set enddatetime = ad_placement_entry_date, 
						endtime = '00:00'::time, 
						exitreasontypekey = 'CIPO', 
						exittypekey = 'CIP', 
						voidapprovaldate = now(), 
						updatedby = as_approver_user_id, 
						updatedon = now()
				where placementid = vu_placementid ;

				/*
				-- Update provider vacancy (+ve)
				update tb_contract_program
					set vacancy_no = vacancy_no + 1,
						update_user_id = as_approver_user_id, 
						update_ts = now()
				where program_id = vl_contract_program_id
					and delete_sw = 'N' ;
				*/
	 
				-- Placement Validations	
				select date_trunc('month', vd_entry_dt)::date 
					into vd_entry_month_first_day ;

				update tb_placement_validation
					set delete_sw = 'Y',
						update_ts = now(),
						update_user_id = as_request_user_id
				where placement_id = vl_placement_id
					and delete_sw = 'N'
					and coalesce(validation_status_cd, '') <> '1750'
					and validation_start_dt < vd_entry_month_first_day ;

				select date_part('day', ad_placement_entry_date::date)::integer
					into vl_placement_exit_day ;
					
				if vl_placement_exit_day = 1 then	
					update tb_placement_validation
						set delete_sw = 'Y',
							update_ts = now(),
							update_user_id = as_request_user_id
					where placement_id = vl_placement_id
						and delete_sw = 'N'
						and coalesce(validation_status_cd, '') <> '1750'
						and validation_start_dt >= ad_placement_entry_date; 
				else
					update tb_placement_validation
						set delete_sw = 'Y',
							update_ts = now(),
							update_user_id = as_request_user_id
					where placement_id = vl_placement_id
						and delete_sw = 'N'
						and coalesce(validation_status_cd, '') <> '1750'
						and validation_start_dt > ad_placement_entry_date; 
				end if;		
				-- Current Placement Updates - END			
				
				
				-- New placement - START
				---------------------------------
				select ps.service_id
					into vl_service_id
				from tb_provider_services ps,
					tb_services sv
				where ps.service_id = sv.service_id
					and ps.delete_sw = 'N'
					and sv.delete_sw = 'N'
					and sv.structure_service_cd = 'P'
					and ps.program_id = al_new_program_id
				order by ps.create_ts desc
				limit 1 ;
					
				
				select gen_random_uuid() into vu_new_placement_id; 
				
				-- Insert into placement 
				INSERT INTO cjams.placement
					(	placementid, providerid, intakeserviceid, intakeservicerequestactorid, startdatetime, 
						enddatetime, remarks, statustypekey, activeflag, effectivedate, 
						insertedby, insertedon, updatedby, updatedon, old_id, 
						exitreasontypekey, placementadmissionclassificationkey, placementadmissiontypekey, parentorg, addate, 
						adtime, releasedate, detainer, placementadmissionauthorizationtypekey, placementprimaryadmissionreasontypekey, 
						placementprimaryapprovedalttypekey, jlocation, jcounty, fieldworker, certifiedad, 
						resourceworker, county, isprovidertyperesidential, isoperatedbydjs, lrstatus, 
						cop, istempplacement, actvwrkrfldrtypecode, actvwrkrfldridno, admissionauthcode, 
						admissioncriteriacode, detentionalternativecode, detentionalternativeindc, homecountycode, orgidno, 
						placecaseidno, placementsummarykey, placestatuscode, plcmntsmrykeyold, portedtohttmstamp, 
						releasecategorycode, releasetonametext, removalreasoncode, removaltime, servicemastercode, 
						servicetypecode, unitkey, whereaboutscode, admissiontime, emankletidno, 
						emfmdidno, eventdttmkey, eventidno, placementdate, projectedreleasedate, 
						servicemsatercode, exittypekey, isvoided, voidreasontypekey, voidremarks, 
						voiddate, intakeservreqchildremovalid, servicecaseid, placementtypekey, service_id, 
						comarrate_id, starttime, endtime, providersentdate, providerdesc, 
						responseacceptedkey, rejectreasonkey, isssaapproval, ifcapprovaldate, -- alternateid, 
						altproviderid, intakenumber, personid, providerorganizationid, contractprogramid, 
						facilityid, medicaidpaidflag, entrytime, otherservices, exittime, 
						overunderflag, approvalstatustypekey, placementstructureid, voidflag, exittypetypekey, 
						courtorderedflag, icpcapprovedflag, shortlistid, paymentheaderid, placementchangedate, 
						fiscalcategorytypekey, ratestructureid, conversionflag, origplacementid, datavalidflag, 
						voidapprovalstatustypekey, voidapprovaldate, tfcifcconversionflag, caseid, fk_id, 
						releasenotetext, clientmergeid, ischildplacedoutside, etl_userid, 
						etl_load_date, islapsesinplacement, typeoflapses, ischangepreadoptive
					)
				SELECT vu_new_placement_id, providerid, intakeserviceid, intakeservicerequestactorid, ad_placement_entry_date, 
					null, null, statustypekey, 1, now(), 
					as_request_user_id, now(), as_request_user_id, now(), null, 
					null, placementadmissionclassificationkey, placementadmissiontypekey, parentorg, addate, 
					adtime, null, detainer, placementadmissionauthorizationtypekey, placementprimaryadmissionreasontypekey, 
					placementprimaryapprovedalttypekey, jlocation, jcounty, fieldworker, certifiedad, 
					resourceworker, county, isprovidertyperesidential, isoperatedbydjs, lrstatus, 
					cop, istempplacement, actvwrkrfldrtypecode, actvwrkrfldridno, admissionauthcode, 
					admissioncriteriacode, detentionalternativecode, detentionalternativeindc, homecountycode, orgidno, 
					placecaseidno, placementsummarykey, placestatuscode, plcmntsmrykeyold, portedtohttmstamp, 
					releasecategorycode, releasetonametext, removalreasoncode, removaltime, servicemastercode, 
					servicetypecode, unitkey, whereaboutscode, admissiontime, emankletidno, 
					emfmdidno, eventdttmkey, eventidno, placementdate, projectedreleasedate, 
					servicemsatercode, null, 0, voidreasontypekey, voidremarks, 
					voiddate, intakeservreqchildremovalid, servicecaseid, placementtypekey, vl_service_id, 
					comarrate_id, now()::time, null, providersentdate, providerdesc, 
					responseacceptedkey, rejectreasonkey, isssaapproval, ifcapprovaldate, -- alternateid, 
					altproviderid, intakenumber, personid, providerorganizationid, al_new_program_id, 
					facilityid, medicaidpaidflag, entrytime, otherservices, exittime, 
					overunderflag, approvalstatustypekey, placementstructureid, voidflag, exittypetypekey, 
					courtorderedflag, icpcapprovedflag, shortlistid, null, null, 
					fiscalcategorytypekey, ratestructureid, conversionflag, origplacementid, datavalidflag, 
					voidapprovalstatustypekey, now(), tfcifcconversionflag, caseid, fk_id, 
					releasenotetext, clientmergeid, ischildplacedoutside, null, null, 
					islapsesinplacement, typeoflapses, ischangepreadoptive
				FROM cjams.placement
				WHERE placementid = vu_placementid 
				RETURNING "alternateid"  INTO vl_new_placement_id;
				
				-- Insert into placementrevision 
				INSERT INTO cjams.placementrevision
					(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
						exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
						approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
						updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
						voidremarks, enddate, endtime, exittypekey, remarks, 
						isvoided, voiddate, requestedby, requesteddate, approvedby, 
						approveddate, etl_userid, etl_load_date, ischangepreadoptive
					)
				VALUES
					(	gen_random_uuid(), vu_new_placement_id, now(), ad_placement_entry_date, '00:00'::time, 
						NULL, NULL, NULL, NULL, '', 
						'3045', NULL, '1', now(), as_request_user_id, 
						now(), as_approver_user_id, 0, vl_new_placement_id, NULL, 
						NULL, NULL, NULL, NULL, ' ', 
						0, NULL, as_request_user_id, now(), as_approver_user_id, 
						now(), NULL, NULL, NULL
					);
				
				
				
				INSERT INTO cjams.placementrevision
					(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
						exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
						approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
						updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
						voidremarks, enddate, endtime, exittypekey, remarks, 
						isvoided, voiddate, requestedby, requesteddate, approvedby, 
						approveddate, etl_userid, etl_load_date, ischangepreadoptive
					)
				VALUES
					(	gen_random_uuid(), vu_new_placement_id, now(), ad_placement_entry_date, '00:00'::time, 
						NULL, NULL, NULL, NULL, '', 
						'3047', now(), '1', now(), as_request_user_id, 
						now(), as_approver_user_id, 1, vl_new_placement_id, NULL, 
						NULL, NULL, NULL, NULL, ' ', 
						0, NULL, as_request_user_id, NOW(), as_approver_user_id, 
						now(), NULL, NULL, NULL
					);

				-- Insert into routing
				INSERT INTO cjams.routing
					(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
						insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
						remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
						old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
						etl_load_date, entityid, reassignnotes
					)
				VALUES
					(	gen_random_uuid(), 'PLTR', as_approver_user_id, NULL, NULL, 
						'CWSP', 'IVESV', vu_new_placement_id, 16, 1, 
						as_approver_user_id, now(), as_approver_user_id, now(), false, 
						NULL, NULL, NULL, vl_case_id, NULL, 
						NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL
					);
						
				INSERT INTO cjams.routing
					(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
						insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
						remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
						old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
						etl_load_date, entityid, reassignnotes
					)
				VALUES
					(	gen_random_uuid(), 'PLTR', as_request_user_id, as_approver_user_id, vu_teamid, 
						'CWSP', 'CWCW', vu_new_placement_id, 16, 1, 
						as_request_user_id, now(), as_approver_user_id, now(), true, 
						'', NULL, 'Child Placement Approved', vl_case_id, NULL, 
						NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL
					);
					
				INSERT INTO cjams.routing
					(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
						insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
						remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
						old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
						etl_load_date, entityid, reassignnotes
					)
				VALUES
					(	gen_random_uuid(), 'PLTR', as_request_user_id, as_approver_user_id, vu_teamid, 
						'CWSP', 'CWCW', vu_new_placement_id, 15, 0, 
						as_request_user_id, now(), as_approver_user_id, now(), true, 
						'', NULL, 'Provider placement submitted for review', vl_case_id, 'Servicecase', 
						NULL, NULL, NULL, NULL, NULL, 
						NULL, NULL, NULL
					);	
				
				/*
				-- Update provider vacancy (-ve)
				update tb_contract_program
					set vacancy_no = vacancy_no - 1,
						update_user_id = as_approver_user_id, 
						update_ts = now()
				where program_id = al_new_program_id
					and delete_sw = 'N' ;
				*/
				-- New placement - END
				
				IF vs_placement_update_sw = 'N' THEN
					vs_placement_update_sw := 'Y';
				END IF;
			END IF;
						
			vl_row_cnt := vl_row_cnt  - 1;      
		END loop;                               
		CLOSE cur_placement_refcur ;   
	END IF;
	
	IF vs_placement_update_sw = 'Y' THEN
		-- Update Old Program Vacancy 
		update tb_contract_program
			set update_ts = now(),
				update_user_id = as_approver_user_id,
				vacancy_no = contract_beds_no
					- ( select count(*)
						from cjams.tb_placement tp  
					  where delete_sw = 'N'
						and entry_dt is not null
						and exit_dt is null
						and coalesce(void_sw, 'N') <> 'Y' 
						and approval_status_cd = '3047'
						and contract_program_id = al_old_program_id
					) 
		where program_id = al_old_program_id
		  and delete_sw = 'N' ;
		  
		-- Update New Program Vacancy 
		update tb_contract_program
			set update_ts = now(),
				update_user_id = as_approver_user_id,
				vacancy_no = contract_beds_no
					- ( select count(*)
						from cjams.tb_placement tp  
					  where delete_sw = 'N'
						and entry_dt is not null
						and exit_dt is null
						and coalesce(void_sw, 'N') <> 'Y' 
						and approval_status_cd = '3047'
						and contract_program_id = al_new_program_id
					) 
		where program_id = al_new_program_id
		  and delete_sw = 'N' ;  
		  
	END IF;
	
	-- al_sqlcode := 0;
	-- as_mess := 'Success';
	  
END;

$function$
;
