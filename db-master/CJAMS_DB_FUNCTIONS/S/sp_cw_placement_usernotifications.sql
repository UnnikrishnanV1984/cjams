DROP FUNCTION IF EXISTS cjams.sp_cw_kinship_placement_usernotifications(notificationType varchar, ad_run_dt timestamp);
CREATE OR REPLACE FUNCTION cjams.sp_cw_kinship_placement_usernotifications(notificationType varchar, ad_run_dt timestamp)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- B-207674  Restrictions on Placements following Kinship Regulation Deployment - Veera Nadimpalli 11/01/2024
-- B-207674  Restrictions on Placements following Kinship Regulation Deployment
		 --	 Removed Hardcoded Dates to fetch from settings table  - Anil Dharni 12/03/2024
		 --  Deleted the if condition to validate the restricted dates   - Anil Dharni 12/13/2024


------------------------------------------------------------------------------------------------------------	
 
    DECLARE

returnStatus text;

cur_kin_placement record;
cur_kin_placement_refcur REFCURSOR;

cur_kin_placement_temp record;
cur_kin_placement_temp_refcur REFCURSOR;

cur_fam_chld_assgn record;
cur_fam_chld_assgn_refcur REFCURSOR;
vs_user_id varchar(50) DEFAULT 'cwadmin';
vd_expirationdate date;
vd_effectivedate date;
v_placementid uuid;
v_personid uuid;
vs_client_nm varchar(150);
v_servicecaseid uuid;
vl_servicecasenumber bigint;
vs_objecttype character varying;
vs_notification_txt varchar(500);
v_securityusersid uuid;
v_case_type character varying;
v_usernotificationid uuid;
v_toworkeridno uuid;
v_supervisorid uuid;
vd_restricted_end_dt	DATE;
vd_kinship_start_dt		DATE;

    BEGIN

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
		
		SELECT settingvalue::date
			INTO vd_restricted_end_dt
		FROM cjams.settings 
		WHERE lower(settingname) = lower('KRD_enddate') 
			AND activeflag = 1;

		SELECT settingvalue::date
			INTO vd_kinship_start_dt
		FROM cjams.settings 
		WHERE lower(settingname) = lower('KRD_startdate') 
			AND activeflag = 1;

        -- B-207674  Restrictions on Placements following Kinship Regulation Deployment 
		IF lower(notificationType) = 'openkinplacement' OR lower(notificationType) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;


			OPEN cur_kin_placement_refcur FOR
			select pl.placementid,
					pl.personid,
				   '(CJAMS PID ' || (pr.cjamspid)::character varying || ') ' || pr.firstname || ' ' || pr.lastname as client_nm,
				   pl.servicecaseid,
				   sc.servicecasenumber
				from placement pl
			   Join person pr on pr.personid = pl.personid
			   inner join servicecase sc on sc.servicecaseid = pl.servicecaseid and sc.activeflag = 1
			   where pl.service_id = 9 and pl.activeflag = 1 and pl.enddatetime is null  
			    AND (pl.isvoided is null or  pl.isvoided = 0);

			loop
				fetch cur_kin_placement_refcur into cur_kin_placement;
				exit when not found;

				v_placementid := cur_kin_placement.placementid;
				v_personid := cur_kin_placement.personid;
				vs_client_nm := cur_kin_placement.client_nm;
				v_servicecaseid := cur_kin_placement.servicecaseid;
				vl_servicecasenumber := cur_kin_placement.servicecasenumber;
				vs_objecttype = 'servicecase';			

				  -- Add validation for restricted end date and kinship start date
				vs_notification_txt := vs_client_nm || 
					' Restricted Relative placements are not valid later than ' ||
					TO_CHAR(vd_restricted_end_dt, 'MM-DD-YYYY') || 
					'. Please enter a valid placement exit date. A Kinship Home placement must be opened for the child for any dates on or after ' ||
					TO_CHAR(vd_kinship_start_dt, 'MM-DD-YYYY') || 
					' in order for the kinship caregiver to continue to receive payment.';
	
				
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
			close cur_kin_placement_refcur ;			

			-- Create Notifications
			RAISE NOTICE 'Kinship Placement Notifications';
			
			OPEN cur_kin_placement_temp_refcur FOR
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
				fetch cur_kin_placement_temp_refcur into cur_kin_placement_temp;
				exit when not found;

				v_placementid := cur_kin_placement_temp.placementid;
				v_personid := cur_kin_placement_temp.personid;
				v_securityusersid := cur_kin_placement_temp.securityusersid;
				vs_notification_txt := cur_kin_placement_temp.notification_txt;
				vd_effectivedate := cur_kin_placement_temp.effectivedate;
				vd_expirationdate := cur_kin_placement_temp.expirationdate;
				v_case_type := cur_kin_placement_temp.case_type;
				vl_servicecasenumber := cur_kin_placement_temp.case_number;
				v_servicecaseid := cur_kin_placement_temp.case_id;
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
						false, false, NULL, 'Restricted-Placement', v_case_type, 
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
			close cur_kin_placement_temp_refcur;
			
			delete from ttb_cfe_placement;	
				
		END IF;		



	    returnStatus:= 'Success';
	    RETURN returnStatus;
    END;
$function$
;