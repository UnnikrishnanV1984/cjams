DROP FUNCTION IF EXISTS cjams.sp_cw_ive_usernotifications(notificationType varchar, ad_run_dt timestamp);
CREATE OR REPLACE FUNCTION cjams.sp_cw_ive_usernotifications(notificationType varchar, ad_run_dt timestamp)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 07/17/2024 - Kapila Mandhadi -- Sending user notifications to IVE supervisors and assigned specialist (B-199095)
-- 09/17/2024 - Anil Dharni -- From name change and not considering empty records based on servicecaseid
-- 07/23/2025 -Manasa Kasula  CIDM-10626: Ive alert notification implementation 
-- 05/07/2026 - Surya Arigela CIDM-11293: IVE auto approval for all Eligible Reimbursable to ineligible for child age falls between 18 to 21
-- 08/03/2026 - Surya Arigela CIDM-11636: Auto Approval (sp_ive_auto_ineligible_approval) batch has not run in PROD
------------------------------------------------------------------------------------------------------------	
 
    DECLARE
        returnStatus text;
		v_usernotificationid uuid;
		v_batch_matching_record RECORD;
        v_supervisorid RECORD;
        v_date timestamp;
       	inserted_eligibility_ids int4[] := '{}';
        v_sp_ive_alerts_notification_info RECORD;
        vs_notification_txt Varchar;
        v_notificationresponse character varying;
        v_auto_approval_response RECORD;
    BEGIN
		v_date:= now();
		IF lower(notificationType) in ('all', 'refppcourtorder') then
            FOR v_batch_matching_record in (
                WITH matching_record AS (
                select  
                tce.client_id,
                tce.start_dt,
                tce.end_dt,
                tce.eligibility_id,
                tce.case_id,
                ( select sc.servicecaseid  from servicecase sc where sc.servicecasenumber = tce.case_id::character varying ) as servicecaseid,
            	pr.personid,
            	pr.firstname || ' ' || pr.lastname as client_name,
                coalesce((SELECT to_char(isrco.courtorderdate::date, 'MM/DD/YYYY')
                    FROM intakeservreqcourtorder isrco 
                        join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1
                        join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid and isrch.activeflag = 1 
                        join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
                        join person per on per.personid = isra.personid AND per.activeflag = 1    
                        join intakeservreqcourtorderdetails iscod on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid 
                    where isrco.activeflag = 1 
                        AND isrcr.removalid = tce.removal_id  
                        AND per.cjamspid = tce.client_id 
                        AND iscod.checklistid = '34993888-d849-4774-a5c0-6aa25a2b9a42' 
                        AND iscod.checklisttypekey = 'COLANG' 
                        AND iscod.activeflag = 1 
                        AND iscod.isselected = 1
                    order by isrco.courtorderdate::date desc
                    limit 1), 'N/A') as refppDate
                from tb_client_eligibility tce
                    join person pr on pr.cjamspid = tce.client_id  
                    join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.removaltypekey = 'JD'
                where btrim(tce.eligibility_type_cd) = '2931'
                    AND btrim(tce.eligibility_status_cd) = '2913'
                    AND tce.delete_sw = 'N' and tce.start_dt::date < (CURRENT_DATE - INTERVAL '1 year')::date
                    AND (tce.end_dt IS null or 
                    end_dt::date >= ((date_trunc('month', ad_run_dt::date) + interval '1 month')::date  - interval '24 months')::date)
                    and (
                        SELECT COUNT(isrcr.removalid) FROM intakeservreqcourtorder isrco 
                        join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1
                        join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid and isrch.activeflag = 1 
                        join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
                        join person per on per.personid = isra.personid AND per.activeflag = 1    
                        join intakeservreqcourtorderdetails iscod on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid 
                        where isrco.activeflag = 1 and isrco.courtorderdate::date BETWEEN (CURRENT_DATE - INTERVAL '1 year')::date AND CURRENT_DATE::date
                        AND isrcr.removalid = tce.removal_id  AND per.cjamspid = tce.client_id 
                        AND iscod.checklistid = '34993888-d849-4774-a5c0-6aa25a2b9a42' AND iscod.checklisttypekey = 'COLANG' AND iscod.activeflag = 1 AND iscod.isselected = 1
                    ) = 0 
                )
                select v1.securityusersid, v1.client_id, v1.servicecaseid, v1.refppDate, v1.eligibility_id, v1.start_dt, v1.end_dt, v1.case_id, v1.client_name
                from (select up.securityusersid, mr.client_id, mr.servicecaseid, mr.refppDate, mr.eligibility_id, mr.start_dt, mr.end_dt, mr.case_id, mr.client_name from routing r 
                join placement p on r.objectid ::character varying = p.placementid:: character varying
                join userprofile up on up.securityusersid = r.tosecurityusersid
                join person p2 on p2.personid = p.personid
                join matching_record mr on mr.client_id = p2.cjamspid 
                where r.activeflag=1 and r.eventcode= 'PLTR' and r.routingstatustypeid::text ='70' and r.toroleid in ('IVESP', 'IVEEA')
                ) as v1 where v1.servicecaseid IS NOT NULL
                )
                loop
                    INSERT INTO usernotification 
                    (	securityusersid,usernotificationtypekey,
                        objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,
                        updatedon,insertedby,insertedon,effectivedate,ismailsent, objectcasenumber, teamtypekey, entityid, old_id
                    )
                    VALUES 
                    (	v_batch_matching_record.securityusersid, 'System', 
                        v_batch_matching_record.servicecaseid, 1, 'Reasonable Efforts to Finalize the Permanency plan have not been made 12 months from the last REFPP date ' || v_batch_matching_record.refppDate || 
                        ' for client ' || v_batch_matching_record.client_name || ' / CJAMS PID ' || v_batch_matching_record.client_id || ' in case '  || v_batch_matching_record.case_id || ' ahence the system have updated the IVE Eligibility status from Eligible Reimbursable to Eligible Non-Reimbursable', 'High', 'IVE Eligibility History', false, 'cwadmin',
                        v_date, 'cwadmin', v_date, v_date, false, v_batch_matching_record.case_id, 'CW', v_batch_matching_record.servicecaseid,'refppcourtorder'
                    ) RETURNING "usernotificationid" INTO  v_usernotificationid;
            
                    INSERT INTO usernotificationmap
                    (	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
                        effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
                    )
                    VALUES 
                    (	v_usernotificationid, null, v_batch_matching_record.securityusersid, false,
                        v_date, 1, 'cwadmin', v_date, 'cwadmin', v_date
                    );
					if not v_batch_matching_record.eligibility_id = ANY(inserted_eligibility_ids) then
	                    INSERT INTO tb_eligibility_period
	                    (eligibility_period_id, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw)
	                    VALUES(nextval('seq_tb_eligibility_period')::integer, null, null, '2912', v_batch_matching_record.eligibility_id, now(), 'cwadmin', now(), 'cwadmin', 'N'::bpchar, '', v_date, 'AA');
	                   
	                   	inserted_eligibility_ids := array_append(inserted_eligibility_ids, v_batch_matching_record.eligibility_id);
					end if;
                    UPDATE tb_client_eligibility tbc
                    SET eligibility_status_cd='2912', update_ts = now(), update_user_id = 'cwadmin'
                    WHERE tbc.eligibility_id = v_batch_matching_record.eligibility_id;

                FOR v_supervisorid IN
                    select up.securityusersid from userprofile up 
                    inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
                    inner join teammember tm on tm.teammemberid = tma.teammemberid 
                    where up.teamtypekey = 'CW' and tm.roletypekey = 'IVESV'
                    loop
                        INSERT INTO usernotification 
                        (	securityusersid,usernotificationtypekey,
                            objectid,activeflag,subject,priorityleveltypekey,body,isexternalentity,updatedby,
                            updatedon,insertedby,insertedon,effectivedate,ismailsent, objectcasenumber, teamtypekey, entityid, old_id
                        )
                        VALUES 
                        (	v_supervisorid.securityusersid, 'System', 
                            v_batch_matching_record.servicecaseid, 1, 'Reasonable Efforts to Finalize the Permanency plan have not been made 12 months from the last REFPP date ' || v_batch_matching_record.refppDate || 
                            ' for client ' || v_batch_matching_record.client_name || ' / CJAMS PID ' || v_batch_matching_record.client_id || ' in case ' || v_batch_matching_record.case_id || ' hence the system have updated the IVE Eligibility status from Eligible Reimbursable to Eligible Non-Reimbursable ', 'High', 'IVE Eligibility History', false, 'cwadmin',
                            v_date, 'cwadmin',v_date,v_date,false, v_batch_matching_record.case_id, 'CW', v_batch_matching_record.servicecaseid, 'refppcourtorder'
                        ) RETURNING "usernotificationid" INTO  v_usernotificationid;
                        INSERT INTO usernotificationmap
                        (	usernotificationid,fromsecurityusersid,tosecurityusersid,isread,
                            effectivedate,activeflag,updatedby,updatedon,insertedby,insertedon
                        )
                        VALUES 
                        (	v_usernotificationid, null, v_supervisorid.securityusersid, false,
                            v_date, 1, 'cwadmin',v_date, 'cwadmin',v_date
                        );
                    end loop;
                end loop;
        END IF;
        IF lower(notificationType) in ('all', 'redetalert') then
            FOR v_sp_ive_alerts_notification_info IN
                select * from sp_ive_alerts_notification_info()
            loop
                vs_notification_txt := v_sp_ive_alerts_notification_info.program_type || ' Redetermination for review period ' || v_sp_ive_alerts_notification_info.review_period ||
                        ' for client ' || v_sp_ive_alerts_notification_info.client_name || ' / CJAMS PID ' || v_sp_ive_alerts_notification_info.client_id || ' is due by '  || v_sp_ive_alerts_notification_info.due_date;

                IF v_sp_ive_alerts_notification_info.assigned_specialist is not null and v_sp_ive_alerts_notification_info.assigned_supervisor is not null then 

                    select * into v_notificationresponse  from send_notification(v_sp_ive_alerts_notification_info.assigned_specialist, 'cwadmin', v_sp_ive_alerts_notification_info.assigned_specialist, 
							'System'::character varying, 'High'::character varying, vs_notification_txt::character varying, vs_notification_txt::text,v_sp_ive_alerts_notification_info.caseid::character varying, false,v_sp_ive_alerts_notification_info.caseid::uuid);	


                    select * into v_notificationresponse  from send_notification(v_sp_ive_alerts_notification_info.assigned_supervisor, 'cwadmin', v_sp_ive_alerts_notification_info.assigned_supervisor, 
                    'System'::character varying, 'High'::character varying, vs_notification_txt::character varying, vs_notification_txt::text,v_sp_ive_alerts_notification_info.caseid::character varying, false,v_sp_ive_alerts_notification_info.caseid::uuid);	

                END IF ; 

                IF v_sp_ive_alerts_notification_info.assigned_specialist is null and v_sp_ive_alerts_notification_info.assigned_supervisor is null then 

                    FOR v_supervisorid IN
                        select up.securityusersid from userprofile up 
                        inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
                        inner join teammember tm on tm.teammemberid = tma.teammemberid 
                        where up.teamtypekey = 'CW' and tm.roletypekey = 'IVESV'
                    loop

                        select * into v_notificationresponse  from send_notification(v_supervisorid.securityusersid, 'cwadmin', v_supervisorid.securityusersid, 
                        'System'::character varying, 'High'::character varying, vs_notification_txt::character varying, vs_notification_txt::text,v_sp_ive_alerts_notification_info.caseid::character varying, false,v_sp_ive_alerts_notification_info.caseid::uuid);	

                    END loop;

                END IF;
            END loop;
        END IF;

    IF lower(notificationType) IN ('all', 'auto_approval') THEN

        SELECT *
        INTO v_auto_approval_response
        FROM cjams.sp_ive_auto_ineligible_approval(ad_run_dt);

        RAISE NOTICE 'sp_ive_auto_ineligible_approval response: success=%, sqlcode=%, message=%',
            v_auto_approval_response.vs_success_sw,
            v_auto_approval_response.vl_output_sqlcode,
            v_auto_approval_response.vs_message;

    END IF;

	    returnStatus:= 'Success';
	    RETURN returnStatus;
    END;
$function$
;