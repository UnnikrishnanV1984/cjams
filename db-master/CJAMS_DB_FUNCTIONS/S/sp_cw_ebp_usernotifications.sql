DROP FUNCTION IF EXISTS cjams.sp_cw_ebp_serviceplan_usernotifications(notificationType varchar, ad_run_dt timestamp);
CREATE OR REPLACE FUNCTION cjams.sp_cw_ebp_serviceplan_usernotifications(notificationType varchar, ad_run_dt timestamp)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 04/14/2025 - Veera Nadimpalli CIDM-10366 B-216159 EBP Missing Data Short Term Fix - V2
------------------------------------------------------------------------------------------------------------	
 
    DECLARE

returnStatus text;

cur_ebp_serviceplan record;
cur_ebp_serviceplan_refcur REFCURSOR;

cur_ebp_serviceplan_temp record;
cur_ebp_serviceplan_temp_refcur REFCURSOR;

cur_fam_chld_assgn record;
cur_fam_chld_assgn_refcur REFCURSOR;
vs_user_id varchar(50) DEFAULT 'cwadmin';
vd_expirationdate date;
vd_effectivedate date;
v_placementid uuid;
v_personid character varying;
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

    BEGIN

        DROP TABLE IF EXISTS ttb_cfe_placement CASCADE;
		CREATE TEMPORARY TABLE ttb_cfe_placement
			(	placementid uuid,
				personid character varying,
				securityusersid uuid,
				notification_txt varchar(500),
				effectivedate date,
				expirationdate date,
				case_type character varying,
				case_number character varying,
				case_id character varying
			) ;

        -- -- CIDM-10366 B-216159 EBP Missing Data Short Term Fix
		IF lower(notificationType) = 'openebpserviceplan' OR lower(notificationType) = 'all' THEN
			vs_user_id := 'cwadmin';
			vd_expirationdate := NULL;
			vd_effectivedate := ad_run_dt;


			OPEN cur_ebp_serviceplan_refcur FOR

                select a.*, p.firstname || ' ' || p.lastname as client_nm  from (
                  WITH valid_snapshots AS (
				SELECT 
					s2.*,
					s.serviceplanid,
					sc.servicecaseid,
					sc.servicecasenumber,
					s2.snapshotdata::json->'involvedpersons' AS involvedpersons
				FROM serviceplan s
				JOIN snapshothist s2 
					ON s2.objectid = s.serviceplanid::varchar 
					AND s2.activeflag = 1
					AND s2.approvalstatus = 'Approved'
				JOIN servicecase sc 
					ON sc.servicecaseid = s.objectid::uuid 
					AND sc.activeflag = 1 
					AND btrim(lower(sc.statustypekey)) NOT IN ('closed') 
					WHERE s.activeflag = 1
					AND json_typeof(s2.snapshotdata::json->'involvedpersons') = 'array'
				)
				SELECT 
				vs.serviceplanid,
				vs.servicecaseid,
				vs.servicecasenumber,
				ip->>'id' AS id,
				(ip->'ebp')->>'isebpreferralmade' AS isebpreferralmade,
				(ip->'ebp')->>'utilized' AS utilized
				FROM valid_snapshots vs
				JOIN LATERAL json_array_elements(vs.involvedpersons) AS ip ON TRUE
				WHERE ip->'ebp' IS NOT NULL
                ) a, person p 
                where a.isebpreferralmade = 'Yes' and a.utilized = 'Yes' and p.cjamspid = a.id::bigint and
               ((select count(*) from tb_service_log tsl
                 join tb_provider_services AS TPS ON TPS.provider_service_id = TSL.provider_service_id AND TSL.provider_service_id IS NOT null
                 JOIN tb_services AS TSR ON TSR.service_id = TPS.service_id 
                where client_id = a.id::bigint and  TSL.delete_sw='N' and btrim(lower(TSR.service_nm)) like '%ebp%') = 0);



			loop
				fetch cur_ebp_serviceplan_refcur into cur_ebp_serviceplan;
				exit when not found;

				v_placementid := cur_ebp_serviceplan.serviceplanid;
				v_personid := cur_ebp_serviceplan.id;
				vs_client_nm := cur_ebp_serviceplan.client_nm;
				v_servicecaseid := cur_ebp_serviceplan.servicecaseid;
				vl_servicecasenumber := cur_ebp_serviceplan.servicecasenumber;
				vs_objecttype = 'servicecase';	
							
				vs_notification_txt :=  ' All EBP’s are required to have a service log to be completed for the Client '  || vs_client_nm || ' / CJAMS PID ' || (v_personid)::character varying || ' with the service plan.' ; 
				
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

					v_toworkeridno := cur_fam_chld_assgn.toworkeridno;
					v_supervisorid := cur_fam_chld_assgn.supervisorid;

					RAISE NOTICE 'v_toworkeridno >> %', v_toworkeridno;
						
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
			close cur_ebp_serviceplan_refcur ;			

			-- Create Notifications
			RAISE NOTICE 'Open EBP Service Plan Notifications';
			
			OPEN cur_ebp_serviceplan_temp_refcur FOR
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
				fetch cur_ebp_serviceplan_temp_refcur into cur_ebp_serviceplan_temp;
				exit when not found;

				v_placementid := cur_ebp_serviceplan_temp.placementid;
				v_personid := cur_ebp_serviceplan_temp.personid;
				v_securityusersid := cur_ebp_serviceplan_temp.securityusersid;
				vs_notification_txt := cur_ebp_serviceplan_temp.notification_txt;
				vd_effectivedate := cur_ebp_serviceplan_temp.effectivedate;
				vd_expirationdate := cur_ebp_serviceplan_temp.expirationdate;
				v_case_type := cur_ebp_serviceplan_temp.case_type;
				vl_servicecasenumber := cur_ebp_serviceplan_temp.case_number;
				v_servicecaseid := cur_ebp_serviceplan_temp.case_id;
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
						false, false, NULL, 'EBP-Open-Service-Plan', v_case_type, 
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
			close cur_ebp_serviceplan_temp_refcur;
			
			delete from ttb_cfe_placement;	
				
		END IF;		



	    returnStatus:= 'Success';
	    RETURN returnStatus;
    END;
$function$
;