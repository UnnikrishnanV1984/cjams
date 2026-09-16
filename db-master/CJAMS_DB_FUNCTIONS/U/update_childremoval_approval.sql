DROP FUNCTION IF EXISTS cjams.update_childremoval_approval(v_intakeservreqchildremovalid uuid, v_input json, user_id uuid, v_status character varying);
CREATE OR REPLACE FUNCTION cjams.update_childremoval_approval(v_intakeservreqchildremovalid uuid, v_input json, user_id uuid, v_status character varying)
 RETURNS TABLE(message character varying, code integer)
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------
-- Revision(s)
-- 08/30/2021 - Vineet Tirodkar - To add notification for Child Removal/Placement correction (B-96794)
-- 09/08/2021 - Vineet Tirodkar - To add System Generated Suspension on GAP / Adoption (B-108967 & B-113025)
-- 03/04/2022 - Vineet Tirodkar - To add new notification for Education Best Interest Determination (CIDM-4302/B-85071)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 02/15/2024 - Sundeep kiran Anugolu - To update ive case closure for reopen case (CIDM-8350/B-185252)
-- CIDM-10101 - To update start date in tb_client_eligibility table - Veera 02/12/2025
-- 04/16/2024 - Sreekanth Marrikanti - - Closing legal custody on child removal exit (B-188635)
--01/06/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10008-b-210234) 
-- 05/13/2025 - Naveenkumar Chemutu - Insert tasks on child removal approval. MedicationPsychotropic & HealthDisorder Action Alerts tasks. (CIDM-10354)
-- 05/27/2025 - Naveenkumar Chemutu - Added removal exit date parameter to create task function (CIDM-10354)
-- 06/26/2025 - Naveenkumar Chemutu - Added user id parameter to create task function for audit (CIDM-10354)
-- 07/22/2025-- Umasankar Raavi- Added column 'showcontactpage' to track save from GoTo Contact button
-- 08/03/2025 - Yogeshvar - Coalesce New removal date and Old removal date to get effective removal date for action task creation (CIDM-11295)
------------------------------------------------------------------------ 
DECLARE 
	v_record record;
	v_routingid uuid;
	
	vd_new_removaldate date;
    vd_old_removaldate date;
	vd_effective_removaldate date;
	vd_new_exitdate date;
    vd_effectivedate date;
	vd_expirationdate date;
	v_current_timestamp timestamp;
	vd_removaldate date;
	
	v_personid uuid;
	v_servicecaseid uuid;
	v_toworkeridno uuid;
	v_supervisorid uuid;
	v_securityusersid uuid;
	v_usernotificationid uuid;
	
	vl_rem_approval_cnt integer;
	vl_placement_cnt integer;
	vl_client_id bigint;
	vl_servicecasenumber bigint;
	
	v_notification_type varchar(50);
	vs_RM00_notification char(1) default 'N'; 
	vs_notification_txt varchar(500);
	vs_notification_txt_edu_bid character varying;
	vs_client_nm varchar(150);
	vs_responsibilitytypekey varchar(50);
	vs_user_id varchar(50) DEFAULT 'cwadmin';
					
	cur_fam_chld_assgn record;
	cur_fam_chld_assgn_refcur REFCURSOR;

	cur_removal_temp record; 
	cur_removal_temp_refcur REFCURSOR;

	v_ivecaseclosurereviewid uuid;
	v_ccrstatus varchar(50);

	v_removalid bigint;
	vl_tce_start_dt_cnt integer;

BEGIN
		
		
		IF($4 = 'Approved') THEN 
		
			-- Check if this is Removal Creation Approval (1st Supervisory Approval) 
			select count(*)
				into vl_rem_approval_cnt
			from routing ro 
			where ro.objectid = $1::character varying
				and ro.eventcode  = 'CHRR'
				and ro.routingstatustypeid = 16
				and ro.activeflag = 1 ;
			
			-- User notification Check 
			-- Get new Removal Date 
			select rmh.removaldate::date,
					rmh.exitdate::date 
				into vd_new_removaldate,
					vd_new_exitdate
			from intakeservreqchildremoval_history rmh 
			where rmh.intakeservreqchildremovalid = $1 
				and rmh."rowtype" = 'REVISION' 
				and rmh.activeflag = 1 
			order by rmh.updatedon desc 
			limit 1;

			-- Get current Removal Date 
			select rm.removaldate::date ,
				rm.personid , rm.removalid
			into vd_old_removaldate,
				v_personid, v_removalid
			from intakeservreqchildremoval rm
			where rm.intakeservreqchildremovalid = $1
				and rm.activeflag = 1 ;

			vd_effective_removaldate := coalesce(vd_new_removaldate, vd_old_removaldate);

			select count(*) into vl_tce_start_dt_cnt
			from tb_client_eligibility tce 
			where tce.eligibility_type_cd = '2931' and tce.delete_sw = 'N' and tce.removal_id = v_removalid and tce.start_dt is null ;	
						
			-- RAISE NOTICE 'vd_new_removaldate >> %', vd_new_removaldate;
			-- RAISE NOTICE 'vd_old_removaldate >> %', vd_old_removaldate;			
			
			IF vd_new_removaldate is not null and vd_new_removaldate <> vd_old_removaldate THEN
				select count(*) 
					into vl_placement_cnt
				from placement pl
				where pl.activeflag = 1
					and pl.personid = v_personid
					and pl.startdatetime::date = vd_new_removaldate::date
					and coalesce(pl.isvoided, 0) <> 1 ;
				
				-- RAISE NOTICE 'vl_placement_cnt >> %', vl_placement_cnt;
				
				IF vl_placement_cnt = 0 then
					-- Generate RM00
					vs_RM00_notification := 'Y';
				END if;
			END IF;	
			
			-- Update the revision record to intakeservreqchildremoval table 
			FOR v_record IN 
				(SELECT * 
					FROM intakeservreqchildremoval_history 
				 WHERE intakeservreqchildremovalid = $1 
					and "rowtype" = 'REVISION' 
					and activeflag =  1 
				ORDER BY updatedon desc 
				LIMIT 1)
			LOOP
			
				UPDATE intakeservreqchildremoval 
				SET intakeservicerequestactorid  = v_record.intakeservicerequestactorid, 
					rmvdfrmisractorid = v_record.rmvdfrmisractorid,
					personid = v_record.personid,
					agencytypekey = v_record.agencytypekey,
					fathername = v_record.fathername,
					mothername = v_record.mothername,
					rmvdfrmpersonname = v_record.rmvdfrmpersonname,
					removaladd1 = v_record.removaladd1,
					removaladd2 = v_record.removaladd2,
					removalzip = v_record.removalzip,
					removalstatecd = v_record.removalstatecd,
					removalcity = v_record.removalcity,
					removaldate = v_record.removaldate,
					removaltime = v_record.removaltime,
					familystructuretypekey = v_record.familystructuretypekey,
					primarycaregiverid = v_record.primarycaregiverid,
					vpabegindate = v_record.vpabegindate,
					agencysigneddate = v_record.agencysigneddate,
					isbothparentssigned = v_record.isbothparentssigned,
					reasonableeffortsmade = v_record.reasonableeffortsmade,
					childfactorsentry = v_record.childfactorsentry,
					removaltypekey = v_record.removaltypekey,
					environmentatremovalkey = v_record.environmentatremovalkey,
					primarycaregiveractorid = v_record.primarycaregiveractorid,
					seccaregiveractorid = v_record.seccaregiveractorid,
					seccaregiveradd = v_record.seccaregiveradd,
					primarycaregiveradd = v_record.primarycaregiveradd,
					isverifiedreporteradd = v_record.isverifiedreporteradd,
					isverifiedcaregiver1add = v_record.isverifiedcaregiver1add,
					isverifiedcaregiver2add = v_record.isverifiedcaregiver2add,
					relativeactorid = v_record.relativeactorid,
					isdisability = v_record.isdisability,
					servicecaseid = v_record.servicecaseid,
					vpaenddate = v_record.vpaenddate,
					vpayouthsigneddate = v_record.vpayouthsigneddate,
					vpaparentssigneddate = v_record.vpaparentssigneddate,
					parent2signeddate = v_record.parent2signeddate,
					comments = v_record.comments,
					specifiedrelativedatechildlastlivedwith = v_record.specifiedrelativedatechildlastlivedwith,
					specifiedrelativename = v_record.specifiedrelativename,
					showcontactpage =v_record.showcontactpage,
					parent2comments = v_record.parent2comments,
					returntime = v_record.returntime,
					returndate = v_record.returndate,
					childphysicalremovaladdress = v_record.childphysicalremovaladdress,
					ischildphysicalremovaladdressverified = v_record.ischildphysicalremovaladdressverified,
					isuploadedmanually = v_record.isuploadedmanually,
					isshelterauthcompleted = v_record.isshelterauthcompleted,
					ischildaddressasprimaryaddress  = v_record.ischildaddressasprimaryaddress ,
					parent1id  = v_record.parent1id,
					parent2id  = v_record.parent2id,
					guardianid = v_record.guardianid,
					vpaguardiansigneddate = v_record.vpaguardiansigneddate,
					volrelinquishment = v_record.volrelinquishment,
					removalexitreason = v_record.removalexitreason,
					exitdate = v_record.exitdate,
					returntransts = v_record.returntransts,
					updatedby = $3,
					updatedon = now(),
					removalcircumstances = v_record.removalcircumstances,
					transferagency = v_record.transferagency,
					otherpublicagency = v_record.otherpublicagency,
					locationofadoption = v_record.locationofadoption,
					justification = v_record.justification,
					childremovalluggage=v_record.childremovalluggage ,
	                luggageprovided =v_record.luggageprovided ,
	                luggagecomments =v_record.luggagecomments ,	
                    placementdisposableortrashbag= v_record.placementdisposableortrashbag,
					luggageupdatedby =v_record.luggageupdatedby,
	                luggageupdatedon = v_record.luggageupdatedon 
				WHERE intakeservreqchildremovalid = $1;
			
				-- Remove the revision record
				UPDATE intakeservreqchildremoval_history 
				SET activeflag  = 0, 
					updatedby = $3,
					updatedon = now()
				WHERE intakeservreqchildremovalhistoryid = v_record.intakeservreqchildremovalhistoryid;

			END LOOP;


-- CIDM-10101 - To update start date in tb_client_eligibility table
			if(vl_tce_start_dt_cnt >= 1 ) then
                update tb_client_eligibility tce set start_dt = vd_effective_removaldate , update_user_id = $3, update_ts = now() where removal_id = v_removalid and
				tce.eligibility_type_cd = '2931' and tce.delete_sw = 'N' and tce.start_dt is null ;
			end if; 


			-- Ive Case Closure to reset for reopen case when removal is added
			select iccr.ivecaseclosurereviewid, sd.intakeserreqstatustypekey into v_ivecaseclosurereviewid , v_ccrstatus
			from intakeservreqchildremoval isrcr 
			inner join ivecaseclosurereview iccr on iccr.objectid=isrcr.servicecaseid and iccr.ivereviewstatus not in ('CCR_Reopened') and iccr.activeflag=1
			inner join servicecasedisposition sd on sd.servicecaseid=iccr.objectid
			where isrcr.intakeservreqchildremovalid = $1 and isrcr.activeflag = 1
			order by sd.insertedon desc limit 1;
			
			if((v_ivecaseclosurereviewid is not null ) and v_ccrstatus='Reopen' and (vd_new_exitdate is null)) then
				UPDATE cjams.ivecaseclosurereview
				SET ivereviewstatus='CCR_Reopened', activeflag=0
				WHERE ivecaseclosurereviewid=v_ivecaseclosurereviewid;
			
				UPDATE cjams.routing
				SET activeflag=0
				WHERE objectid=v_ivecaseclosurereviewid::character varying and eventcode='IVECCR';
			end if;
			-- ive Case Closure End		
			
			-- RAISE NOTICE 'vs_RM00_notification >> %', vs_RM00_notification;	
			
			IF vs_RM00_notification = 'Y' OR vl_rem_approval_cnt = 1 THEN
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
					
					
				select 'RM00' as notification_type,
					pr.cjamspid,
					pr.firstname || ' ' || pr.lastname as client_nm,
					rm.servicecaseid, 
					sc.servicecasenumber,
					rm.removaldate::date as removaldate
				into vs_notification_txt,
					vl_client_id,
					vs_client_nm,
					v_servicecaseid,
					vl_servicecasenumber,
					vd_removaldate
				from intakeservreqchildremoval rm,
					person pr,
					servicecase sc 
				where rm.personid = pr.personid 
					and rm.servicecaseid  = sc.servicecaseid 
					and rm.intakeservreqchildremovalid = $1
					and rm.activeflag = 1 ;
	
				vs_notification_txt := 'Child Removal Episode is updated for the Child ' || vs_client_nm || ' / Child CJAMS PID ' || (vl_client_id)::character varying || ', Please make sure the Placement and Living arrangement are adjusted accordingly.' ;	
				
				-- B-85071
				-- vs_notification_txt_edu_bid := 'Child ' || vs_client_nm || ' / CJAMS PID ' || to_char(vl_client_id) || ' entered Out of Home on ' || To_char(vd_removaldate, 'MM/DD/YYYY') || ' in Case Number ' || To_char(vl_servicecasenumber) || '. Please Complete Best Interest Determination and Education entries as required.';
				vs_notification_txt_edu_bid := 'Child ' || vs_client_nm || ' / CJAMS PID ' || (vl_client_id)::character varying || ' entered Out of Home on ' || To_char(vd_removaldate, 'MM/DD/YYYY') || '. Please Complete Best Interest Determination and Education entries as required.';
				
				-- RAISE NOTICE 'vs_notification_txt >> %', vs_notification_txt;					
				
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
					
					IF vs_RM00_notification = 'Y' THEN
						-- Family/Child Worker
						Insert into ttb_removals
							( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
								case_number, servicecaseid
							)
						values
							( 	'RM00', $1, v_toworkeridno, vs_notification_txt, 
								vl_servicecasenumber, v_servicecaseid
							);
							
						-- Family/Child Supervisor
						IF v_supervisorid is not null THEN
							Insert into ttb_removals
								( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
									case_number, servicecaseid
								)
							values
								(	'RM00', $1, v_supervisorid, vs_notification_txt, 
									vl_servicecasenumber, v_servicecaseid
								);	
						END IF;
					END IF; 
					
					-- B-85071 only for Case workers	
					IF vl_rem_approval_cnt = 1 THEN
						Insert into ttb_removals
							( 	notification_type, intakeservreqchildremovalid, securityusersid, notification_txt, 
								case_number, servicecaseid
							)
						values
							( 	'edu-rm-app-bid', $1, v_toworkeridno, vs_notification_txt_edu_bid, 
								vl_servicecasenumber, v_servicecaseid
							);	
					END IF;	
				end loop;
				close cur_fam_chld_assgn_refcur;	
				
				-- Create Notifications
				-- RAISE NOTICE 'Final Removal Notifications';
				
				vs_user_id := user_id::character varying;
				vd_effectivedate := current_date;
				vd_expirationdate := NULL;
				v_current_timestamp := (current_date::date || ' ' || current_time)::timestamp ;
			
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
					
				DROP TABLE IF EXISTS ttb_removals CASCADE;		
			END IF;
			
			-- Call to check for GAP or Adoption Suspension (B-108967 & B-113025)
			
			IF vl_rem_approval_cnt = 1 and vd_new_exitdate is null THEN
				PERFORM cjams.sp_susbsidy_suspension( v_personid::uuid,
													  v_intakeservreqchildremovalid::uuid,
													  vd_effective_removaldate::date,
													  user_id::uuid
													 ) ;
			END IF;

			-- Insert tasks on child removal approval. MedicationPsychotropic & HealthDisorder Action Alerts tasks. (CIDM-10354)
				PERFORM cjams.spcreateactiontaskforchildremoval( v_personid::uuid,
														v_intakeservreqchildremovalid::uuid,
														vd_effective_removaldate::date,vd_new_exitdate::date,user_id::uuid );
		ELSIF($4 = 'Rejected') THEN

			-- Change to the previsous status
			SELECT routingid INTO v_routingid 
			FROM routing r 
			WHERE objectid = $1::character varying AND routingstatustypeid NOT IN (15) 
			ORDER BY insertedon DESC OFFSET 1 LIMIT 1;

			IF(v_routingid is not null) THEN
				UPDATE routing 
				SET activeflag  = 0, 
					updatedby = $3,
					updatedon = now()
				WHERE objectid = $1::character varying; 
			
				UPDATE routing 
				SET activeflag  = 1, 
					updatedby = $3,
					updatedon = now()
				WHERE routingid = v_routingid; 
			END IF;
			
		
			-- Remove the revision record on rejection
			UPDATE intakeservreqchildremoval_history 
			SET activeflag  = 0, 
				updatedby = $3,
				updatedon = now(),
				routingstatustypeid = 17
			WHERE intakeservreqchildremovalid = $1 and "rowtype" = 'REVISION';
		
		END IF;
	
		-- Insert a History
		INSERT INTO intakeservreqchildremoval_history 
        SELECT gen_random_uuid ()
                , $2::json 
                , 'HISTORY'::character varying
                , *
        FROM intakeservreqchildremoval 
        WHERE intakeservreqchildremovalid = $1;
		
	
	RETURN QUERY
		SELECT 'success'::character varying, 200;

END;	

$function$