CREATE OR REPLACE FUNCTION cjams.sp_cw_person_usernotifications(as_notification_type character varying, ad_run_dt date)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$                                                                                                                            
/* 
-- 07/12/2024 - Charan - Bell notification to add Relationship to at least one child as a Caregiver. 
-- 11/03/2025 - Anil Kumar Dharni - Foster Guardianship Checklist notifications.
-- 01/07/2026 - Yogeshvar Senthilkumar - ICWA notifications - 90 day reminder for Unknown ICWA Status update.
-- 01/30/2026 - Yogeshvar Senthilkumar - ICWA notifications - add notifications for admin case workers
*/
DECLARE
  v_old_id_key varchar(50) := 'ICWA-Status';
  v_run_date date := COALESCE(ad_run_dt, current_date);

  cur_caregiver_refcur REFCURSOR;
  cur_caregiver record;
  v_usernotificationid uuid;
  vs_user_id varchar(50) DEFAULT 'cwadmin';
  cur record;
  vs_notification_txt varchar(500);
BEGIN
  IF lower(as_notification_type) IN ('icwa', 'all') THEN
    RAISE NOTICE 'ICWA Reminder Notifications Bulk Process STARTED at %', now();

    CREATE TEMP TABLE tmp_icwa_targets ON COMMIT DROP AS
    WITH RecentAudit AS (
        SELECT distinct p.personid
        FROM cjams.person p
        CROSS JOIN LATERAL (
            SELECT pa.personjson ->> 'icwaunderdefinition' as historical_status
            FROM cjams.personauditlog pa
            WHERE pa.personid = p.personid
            AND pa.activeflag = 1
            AND pa.insertedon <= v_run_date - INTERVAL '90 days'
            ORDER BY pa.insertedon DESC 
            LIMIT 1
        ) audit_check 
        WHERE p.activeflag = 1 
        and p.icwastatusinquiry = 'YES'
        AND p.icwaunderdefinition = 'UNKNOWN'
        AND audit_check.historical_status = 'UNKNOWN'
    ),
    Assignments AS (
        SELECT DISTINCT
            'servicecase' AS case_type, sc.servicecasenumber AS casenumber, ac.personid,
            ac.servicecaseid::varchar AS obj_id, ca.toworkeridno AS worker_id, u.supervisorid,
            p.firstname || ' ' || p.lastname AS clientname, p.cjamspid AS clientid
        FROM cjams.person p
        JOIN RecentAudit ra ON p.personid = ra.personid
        JOIN cjams.intakeservicerequestactor ac ON p.personid = ac.personid AND ac.activeflag = 1
        JOIN cjams.servicecase sc ON ac.servicecaseid = sc.servicecaseid AND sc.activeflag = 1
        JOIN cjams.caseassignment ca ON sc.servicecaseid = ca.objectid 
            AND lower(ca.responsibilitytypekey) in ('family', 'child', 'administrative')
            AND ca.activeflag = 1 AND ca.enddate IS NULL
        JOIN cjams.userprofile u ON u.securityusersid = ca.toworkeridno
        WHERE p.icwaunderdefinition = 'UNKNOWN' AND p.activeflag = 1
        UNION 
        SELECT DISTINCT 
            'servicerequest' AS case_type, isr.servicerequestnumber AS casenumber, a.personid,
            a.intakeserviceid::varchar AS obj_id, ca.toworkeridno AS worker_id, u.supervisorid,
            p.firstname || ' ' || p.lastname AS clientname, p.cjamspid AS clientid
        FROM cjams.person p
        JOIN RecentAudit ra ON p.personid = ra.personid
        JOIN cjams.intakeservicerequestactor a ON a.personid = p.personid AND a.activeflag = 1
        JOIN cjams.intakeservicerequest isr ON a.intakeserviceid = isr.intakeserviceid AND isr.activeflag = 1
        JOIN cjams.caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 AND ca.enddate IS NULL
        JOIN cjams.userprofile u ON u.securityusersid = ca.toworkeridno
        WHERE p.icwaunderdefinition = 'UNKNOWN' AND p.activeflag = 1
          AND NOT EXISTS (
              SELECT 1 FROM cjams.intakeservicerequestdispositioncode d 
              WHERE d.intakeserviceid = isr.intakeserviceid 
              AND d.intakeserreqstatustypeid IN ('7995cecb-062d-406c-8ea9-b1da4b1877d8', '642f18b0-ef6e-4d4b-9871-acc0734f3f5a')
          )
        UNION
        select distinct 'intake' AS case_type, i.intakenumber AS casenumber, a.personid,
        i.intakenumber AS obj_id, u.securityusersid AS worker_id, u.supervisorid,
        p.firstname || ' ' || p.lastname AS clientname, p.cjamspid AS clientid
        FROM cjams.person p
        JOIN RecentAudit ra ON p.personid = ra.personid
        JOIN cjams.intakeservicerequestactor a ON a.personid = p.personid AND a.activeflag = 1
        join cjams.intakedastaging i on i.intakenumber = a.intakenumber and i.activeflag = 1
        JOIN intakeDAStatus ITDS ON ITDS.intakenumber = i.intakenumber AND ITDS.activeflag =1 AND ITDS.teamtypekey = 'CW'
        JOIN cjams.userprofile u ON u.securityusersid::varchar = i.intakeuser
        WHERE p.icwaunderdefinition = 'UNKNOWN' AND p.activeflag = 1 and itds.intakenumber not ilike 'cw%'
        and (itds.status is null or not exists
            (select 1 from routing r where r.objectid  = itds.intakenumber and 
            ((r.routingstatustypeid in (2,21) and r.activeflag = 1 ) or r.routingstatustypeid = 8))
        ) and not exists (select 1 from intakesnapshot ins where ins.intakenumber = itds.intakenumber 
            and ins.activeflag = 1)    
    )
    SELECT * FROM Assignments;

    RAISE NOTICE 'ICWA Perons/Cases identified for notification: %', (SELECT COUNT(*) FROM tmp_icwa_targets);

    -- Daily Notifications - Deactivate existing notifications for these persons
    UPDATE cjams.usernotification SET activeflag = 0, updatedon = now()
    WHERE old_id = v_old_id_key AND activeflag = 1
      AND entityid IN (SELECT personid FROM tmp_icwa_targets);

    UPDATE cjams.usernotificationmap SET activeflag = 0, updatedon = now()
    WHERE activeflag = 1 AND usernotificationid IN (
        SELECT usernotificationid FROM cjams.usernotification 
        WHERE old_id = v_old_id_key AND entityid IN (SELECT personid FROM tmp_icwa_targets)
    );

    RAISE NOTICE 'ICWA Previous notifications deactivated. Adding new notifications...';

    WITH distinct_notifications AS (
        SELECT worker_id AS target_user, obj_id, case_type, casenumber, personid, clientname, clientid FROM tmp_icwa_targets
        UNION
        SELECT supervisorid AS target_user, obj_id, case_type, casenumber, personid, clientname, clientid FROM tmp_icwa_targets
    ),
    inserted_rows AS (
        INSERT INTO cjams.usernotification (
            usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
            subject, priorityleveltypekey, body, updatedby, updatedon, insertedby, insertedon, 
            effectivedate, ismailsent, objecttype, objectcasenumber, entityid, teamtypekey, 
            isexternalentity, old_id
        )
        SELECT 
            gen_random_uuid(), target_user, 'System', obj_id, 1, 
            'Please update ' || clientname || ' (' || clientid || ') person profile ICWA status based on the ICWA Inquiry Response.', 
            'High', 'Update ICWA status based on Inquiry Response.', 'CW-Admin', now(), 
            'CW-Admin', now(), now(), FALSE, case_type, casenumber, personid, 'CW', FALSE, v_old_id_key
        FROM distinct_notifications
        RETURNING usernotificationid, securityusersid
    )
    INSERT INTO cjams.usernotificationmap (
        usernotificationmapid, usernotificationid, tosecurityusersid, isread, activeflag, insertedby, updatedby, insertedon, updatedon
    )
    SELECT gen_random_uuid(), usernotificationid, securityusersid, FALSE, 1, 'CW-Admin', 'CW-Admin', now(), now()
    FROM inserted_rows;

    RAISE NOTICE 'ICWA Reminder Notifications Bulk Process FINISHED.';
  END IF;

  IF lower(as_notification_type) = 'all' or lower(as_notification_type) = 'youth_parenting_status' THEN
    OPEN cur_caregiver_refcur FOR
      select distinct 'servicecase' as case_type, sc.servicecasenumber as casenumber, p.personid,
      ac.servicecaseid,ca.toworkeridno, u.supervisorid
    , ' Youth (Child name Youth/CJAMD PID: ' || p.firstname || ' ' || p.lastname || '/' || p.cjamspid || 
    ') Currently Parenting. Please add the Child(ren) as part of the case ' ||  sc.servicecasenumber || 
    ' and identify the Relationship to at least one child as Caregiver.' as message
    from actor ac
      join personsexualinfo psx on ac.personid = psx.personid and psx.activeflag = 1
      join person p on psx.personid = p.personid and p.activeflag = 1
      join servicecase sc on  ac.servicecaseid = sc.servicecaseid and sc.activeflag = 1
      join caseassignment ca on ca.objectid = sc.servicecaseid 
        and lower(ca.responsibilitytypekey)= 'family'
        and ca.activeflag = 1
        and ca.enddate is null
      join userprofile u on u.securityusersid = ca.toworkeridno  
    where coalesce(psx.currentlyparenting, false) = true -- Youth Currently parenting the child?
      -- Not a Caregiver 
      and (select count(*) 
          from actorrelationship ar
        where ar.activeflag=1 
          and ar.intakeservicerequestactorid 
            in (
              SELECT ira.intakeservicerequestactorid 
                FROM intakeservicerequestactor ira
              where ira.activeflag=1
                and ira.servicecaseid = sc.servicecaseid  
              ) 
        and ar.caregiverflag = 1
        and ar.person1id = ac.personid
        ) = 0 
        and coalesce(( select lower(dispositioncode) 
                from servicecasedisposition 
                where servicecaseid  = sc.servicecaseid
                and activeflag  = 1
                order by statusdate desc
                limit 1 
              ),'') <> 'closed'
    union all		
    select distinct 'servicecase' as case_type, sc.servicecasenumber as casenumber, p.personid,
      ac.servicecaseid,ca.toworkeridno, u.supervisorid
    , ' Youth (Child name Youth/CJAMD PID: ' || p.firstname || ' ' || p.lastname || '/' || p.cjamspid || 
    ') Currently Parenting. Please add the Child(ren) as part of the case ' ||  sc.servicecasenumber || 
    ' and identify the Relationship to at least one child as Caregiver.' as message
    from actor ac
      join personsexualinfo psx on ac.personid = psx.personid and psx.activeflag = 1
      join person p on psx.personid = p.personid and p.activeflag = 1
      join servicecase sc on  ac.servicecaseid = sc.servicecaseid and sc.activeflag = 1
      join intakeservicerequestactor isr on isr.servicecaseid = sc.servicecaseid 
        and isr.personid = p.personid 
        and isr.activeflag = 1	
      join caseassignment ca on ca.objectid = sc.servicecaseid 
        and lower(ca.responsibilitytypekey) = 'child'
        and ca.activeflag = 1
        and ca.enddate is null
      join caseassignmentactor acr on acr.caseassignmentid = ca.caseassignmentid 	
        and acr.intakeservicerequestactorid = isr.intakeservicerequestactorid 
        and acr.activeflag = 1
      join userprofile u on u.securityusersid = ca.toworkeridno  
    where coalesce(psx.currentlyparenting, false) = true -- Youth Currently parenting the child?
      -- Not a Caregiver 
      and (select count(*) 
          from actorrelationship ar
        where ar.activeflag=1 
          and ar.intakeservicerequestactorid 
            in (
              SELECT ira.intakeservicerequestactorid 
                FROM intakeservicerequestactor ira
              where ira.activeflag=1
                and ira.servicecaseid = sc.servicecaseid  
              ) 
        and ar.caregiverflag = 1
        and ar.person1id = ac.personid
        ) = 0 
        and coalesce(( select lower(dispositioncode) 
                from servicecasedisposition 
                where servicecaseid  = sc.servicecaseid
                and activeflag  = 1
                order by statusdate desc
                limit 1 
              ),'') <> 'closed'

    union all 
    select distinct 'servicerequest' as case_type, isr.servicerequestnumber as casenumber, p.personid,
    isr.intakeserviceid,ca.toworkeridno, u.supervisorid
    , ' Youth (Child name Youth/CJAMD PID: ' || p.firstname || ' ' || p.lastname || '/' || p.cjamspid || 
    ') Currently Parenting. Please add the Child(ren) as part of the case ' ||  isr.servicerequestnumber || 
    ' and identify the Relationship to at least one child as Caregiver.' as message
    from actor ac
      join personsexualinfo psx on ac.personid = psx.personid and psx.activeflag = 1
      join person p on psx.personid = p.personid and p.activeflag = 1
      join intakeservicerequest isr on  ac.intakeserviceid  = isr.intakeserviceid 
        and isr.activeflag = 1
      join caseassignment ca on ca.objectid =  isr.intakeserviceid 
        and lower(ca.responsibilitytypekey) = 'family'
        and ca.activeflag = 1
        and ca.enddate is null
      join userprofile u on u.securityusersid = ca.toworkeridno  
    where coalesce(psx.currentlyparenting, false) = true -- Youth Currently parenting the child?
      -- Not a Caregiver 
      and (select count(*) 
          from actorrelationship ar
        where ar.activeflag=1 
          and ar.intakeservicerequestactorid 
            in (
              SELECT ira.intakeservicerequestactorid 
                FROM intakeservicerequestactor ira
              where ira.activeflag=1
                and ira.intakeserviceid  = isr.intakeserviceid  
              ) 
        and ar.caregiverflag = 1
        and ar.person1id = ac.personid
        ) = 0 
        and (select a.intakeserreqstatustypeid::uuid 
            from intakeservicerequestdispositioncode a 
          where a.intakeserviceid = isr.intakeserviceid 
            and a.activeflag  = 1
          order by insertedon  desc
          limit 1 )
            not in ( '7995cecb-062d-406c-8ea9-b1da4b1877d8', -- Completed
                '642f18b0-ef6e-4d4b-9871-acc0734f3f5a' -- Closed
                ) ;
    loop
      fetch cur_caregiver_refcur into cur_caregiver;
      exit when not found;

      -- Case worker
      if cur_caregiver.toworkeridno is not null  then
      
        insert into cjams.usernotification
          (	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
            url, subject, priorityleveltypekey, "body", hasattachments, 
            updatedby, updatedon, insertedby, insertedon, effectivedate, 
            expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
            isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
            objectcasenumber, entityid, isdeleted, teamtypekey
          )
        values
          (	gen_random_uuid(), cur_caregiver.toworkeridno, 'System', cur_caregiver.servicecaseid, 1, 
            NULL, cur_caregiver.message, 'High', cur_caregiver.message, NULL, 
            vs_user_id, now(), vs_user_id, now(), now(), 
            NULL, NULL, NULL, NULL, NULL, 
            null, false, NULL, 'P-Caregiver', cur_caregiver.case_type, 
            cur_caregiver.casenumber, cur_caregiver.personid, NULL, 'CW'
          )
        RETURNING "usernotificationid" INTO  v_usernotificationid; 

        insert into cjams.usernotificationmap
          (	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
            isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
            activeflag, teammemberid, insertedby, updatedby, insertedon, 
            updatedon, fromsecurityusersid, old_id, isdeleted
          )
        values
          ( 	gen_random_uuid(), v_usernotificationid, cur_caregiver.toworkeridno, NULL, NULL, 
            NULL, NULL, false, null, null, 
            1, NULL, vs_user_id, vs_user_id, now(), 
            now(), NULL, NULL, NULL
          );
      end if; 
          
      -- supervisor
      if cur_caregiver.supervisorid is not null  then
      
        if ( select count(*)
            from cjams.usernotification
            where old_id = 'P-Caregiver'
              and securityusersid = cur_caregiver.supervisorid
              and objectcasenumber = cur_caregiver.casenumber
              and entityid = cur_caregiver.personid
              and activeflag = 1
              and insertedon::date = current_date
          ) = 0 then	
          
      
            insert into cjams.usernotification
              (	usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
                url, subject, priorityleveltypekey, "body", hasattachments, 
                updatedby, updatedon, insertedby, insertedon, effectivedate, 
                expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
                isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
                objectcasenumber, entityid, isdeleted, teamtypekey
              )
            values
              (	gen_random_uuid(), cur_caregiver.supervisorid, 'System', cur_caregiver.servicecaseid, 1, 
                NULL, cur_caregiver.message, 'High', cur_caregiver.message, NULL, 
                vs_user_id, now(), vs_user_id, now(), now(), 
                NULL, NULL, NULL, NULL, NULL, 
                null, false, NULL, 'P-Caregiver', cur_caregiver.case_type, 
                cur_caregiver.casenumber, cur_caregiver.personid, NULL, 'CW'
              )
            RETURNING "usernotificationid" INTO  v_usernotificationid; 

            insert into cjams.usernotificationmap
              (	usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied, 
                isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
                activeflag, teammemberid, insertedby, updatedby, insertedon, 
                updatedon, fromsecurityusersid, old_id, isdeleted
              )
            values
              ( 	gen_random_uuid(), v_usernotificationid, cur_caregiver.supervisorid, NULL, NULL, 
                NULL, NULL, false, null, null, 
                1, NULL, vs_user_id, vs_user_id, now(), 
                now(), NULL, NULL, NULL
              );
        end if;	
      end if;
            
    end loop;
    close cur_caregiver_refcur;
  -- ============================================================
  -- ADDRESS REMINDERS: send at 30 days before 18th/21st birthdays
  -- Condition: Address TBD is checked OR placement name is missing
  -- Recipients: Caseworker + Supervisor on the service case
  -- ============================================================
    DROP TABLE IF EXISTS ttb_ytp_addr CASCADE;
    CREATE TEMP TABLE ttb_ytp_addr (
      personid uuid, servicecaseid uuid, casenumber character varying,
      toworkeridno character varying, supervisorid character varying, turn varchar(4)
    );

    -- When DOB+18y-30d = run date AND address TBD or placement name missing
    INSERT INTO ttb_ytp_addr (personid, servicecaseid, casenumber, toworkeridno, supervisorid, turn)
    SELECT DISTINCT
      p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid, '18'
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE (p.dob + interval '18 years' - interval '30 days')::date = COALESCE(ad_run_dt, current_date)::date
      AND p.activeflag = 1
      AND (
        COALESCE( (ytp.newfcgschecklistjson->>'isAddressTbd')::boolean, false ) = true
        OR NULLIF(btrim(ytp.newfcgschecklistjson->>'placementName'), '') IS NULL
      );

    -- When DOB+21y-30d = run date AND address TBD or placement name missing
    INSERT INTO ttb_ytp_addr (personid, servicecaseid, casenumber, toworkeridno, supervisorid, turn)
    SELECT DISTINCT
      p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid, '21'
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE (p.dob + interval '21 years' - interval '30 days')::date = COALESCE(ad_run_dt, current_date)::date
      AND p.activeflag = 1
      AND (
        COALESCE( (ytp.newfcgschecklistjson->>'isAddressTbd')::boolean, false ) = true
        OR NULLIF(btrim(ytp.newfcgschecklistjson->>'placementName'), '') IS NULL
      );

    FOR cur IN
      SELECT DISTINCT personid, servicecaseid, casenumber, toworkeridno AS sid, turn FROM ttb_ytp_addr
      UNION ALL
      SELECT DISTINCT personid, servicecaseid, casenumber, supervisorid AS sid, turn FROM ttb_ytp_addr WHERE supervisorid IS NOT NULL
    LOOP
      IF cur.sid IS NOT NULL THEN
        vs_notification_txt :=
          CASE WHEN cur.turn = '18'
            THEN 'Client "' || (SELECT firstname || ' ' || lastname FROM person WHERE personid=cur.personid) ||
                '" will turn 18 in 30 days. We have noticed that the address where the youth will be living as an adult has not been updated. Please provide the updated information if available.'
            ELSE 'Client "' || (SELECT firstname || ' ' || lastname FROM person WHERE personid=cur.personid) ||
                '" will turn 21 in 30 days. We have noticed that the address where the youth will be living as an adult has not been updated. Please provide the updated information if available.'
          END;

        INSERT INTO cjams.usernotification
        ( usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag,
          url, subject, priorityleveltypekey, "body", hasattachments,
          updatedby, updatedon, insertedby, insertedon, effectivedate,
          expirationdate, "timestamp", teammemberid, isread, attachmentlocation,
          isexternalentity, ismailsent, mailsentdate, old_id, objecttype,
          objectcasenumber, entityid, isdeleted, teamtypekey )
        VALUES
        ( gen_random_uuid(), cur.sid, 'System', cur.servicecaseid, 1,
          NULL, vs_notification_txt, 'High', vs_notification_txt, NULL,
          vs_user_id, now(), vs_user_id, now(), now(),
          NULL, NULL, NULL, NULL, NULL,
          false, false, NULL, CASE WHEN cur.turn='18' THEN 'YTP_ADDR18_30' ELSE 'YTP_ADDR21_30' END, 'servicecase',
          cur.casenumber, cur.personid, NULL, 'CW')
        RETURNING usernotificationid INTO v_usernotificationid;

        INSERT INTO cjams.usernotificationmap
        ( usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied,
          isforwarded, iscarboncopy, isread, expirationdate, effectivedate,
          activeflag, teammemberid, insertedby, updatedby, insertedon,
          updatedon, fromsecurityusersid, old_id, isdeleted )
        VALUES
        ( gen_random_uuid(), v_usernotificationid, cur.sid, NULL, NULL,
          NULL, NULL, false, NULL, NULL,
          1, NULL, vs_user_id, vs_user_id, now(), now(), NULL, NULL, NULL );
      END IF;
    END LOOP;

    DROP TABLE IF EXISTS ttb_ytp_addr;

  -- ======================================================================
  -- DDA CHECKS (6 months prior)
  -- A) 6m pre-18: if DDA Application Status is unanswered (ddaServices NULL/empty)
  -- B) 6m pre-21: if DDA unanswered OR Adult Guardianship Petition filing date missing
  -- Recipients: Caseworker + Supervisor on the service case
  -- ======================================================================
    DROP TABLE IF EXISTS ttb_ytp_dda CASCADE;
    CREATE TEMP TABLE ttb_ytp_dda (
      personid uuid, servicecaseid uuid, casenumber character varying,
      toworkeridno character varying, supervisorid character varying, turn varchar(4), reason varchar(20)
    );

    -- 6m pre-18: DDA unanswered (ddaServices is NULL/empty)
    INSERT INTO ttb_ytp_dda (personid, servicecaseid, casenumber, toworkeridno, supervisorid, turn, reason)
    SELECT DISTINCT p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid, '18', 'DDA_UNANSWERED'
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE p.activeflag = 1
      AND (p.dob + interval '18 years' - interval '6 months')::date = COALESCE(ad_run_dt, current_date)::date
      AND NULLIF(btrim(ytp.newfcgschecklistjson->>'ddaServices'), '') IS NULL;

    -- 6m pre-21: DDA unanswered OR petition not filed (petitionFillingDate is NULL)
    INSERT INTO ttb_ytp_dda (personid, servicecaseid, casenumber, toworkeridno, supervisorid, turn, reason)
    SELECT DISTINCT p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid, '21',
          CASE
            WHEN NULLIF(btrim(ytp.newfcgschecklistjson->>'ddaServices'), '') IS NULL THEN 'DDA_UNANSWERED'
            WHEN (ytp.newfcgschecklistjson->>'petitionFillingDate') IS NULL THEN 'AGP_INCOMPLETE'
          END
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE p.activeflag = 1
      AND (p.dob + interval '21 years' - interval '6 months')::date = COALESCE(ad_run_dt, current_date)::date
      AND (
        NULLIF(btrim(ytp.newfcgschecklistjson->>'ddaServices'), '') IS NULL
        OR (ytp.newfcgschecklistjson->>'petitionFillingDate') IS NULL
      );

    FOR cur IN
      SELECT DISTINCT personid, servicecaseid, casenumber, toworkeridno AS sid, turn, reason FROM ttb_ytp_dda
      UNION ALL
      SELECT DISTINCT personid, servicecaseid, casenumber, supervisorid AS sid, turn, reason FROM ttb_ytp_dda WHERE supervisorid IS NOT NULL
    LOOP
      IF cur.sid IS NOT NULL THEN
        vs_notification_txt :=
          CASE
            WHEN cur.turn='18' AND cur.reason='DDA_UNANSWERED'
              THEN 'Please complete “Is the youth eligible for Developmental Disabilities Administration (DDA) Services?” before the 18th birthday.'
            WHEN cur.turn='21' AND cur.reason='DDA_UNANSWERED'
              THEN 'Reminder: Update the DDA Services Application/Eligibility before the 21st birthday.'
            WHEN cur.turn='21' AND cur.reason='AGP_INCOMPLETE'
              THEN 'Reminder: Complete the Adult Guardianship Petition (filing date missing) before the 21st birthday.'
          END;

        INSERT INTO cjams.usernotification
        ( usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag,
          url, subject, priorityleveltypekey, "body", hasattachments,
          updatedby, updatedon, insertedby, insertedon, effectivedate,
          expirationdate, "timestamp", teammemberid, isread, attachmentlocation,
          isexternalentity, ismailsent, mailsentdate, old_id, objecttype,
          objectcasenumber, entityid, isdeleted, teamtypekey )
        VALUES
        ( gen_random_uuid(), cur.sid, 'System', cur.servicecaseid, 1,
          NULL, vs_notification_txt, 'High', vs_notification_txt, NULL,
          vs_user_id, now(), vs_user_id, now(), now(),
          NULL, NULL, NULL, NULL, NULL,
          false, false, NULL,
          CASE
            WHEN cur.turn='18' THEN 'YTP_DDA18_6M'
            WHEN cur.turn='21' AND cur.reason='DDA_UNANSWERED' THEN 'YTP_DDA21_6M'
            ELSE 'YTP_AGPET21_6M'
          END,
          'servicecase', cur.casenumber, cur.personid, NULL, 'CW')
        RETURNING usernotificationid INTO v_usernotificationid;

        INSERT INTO cjams.usernotificationmap
        ( usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied,
          isforwarded, iscarboncopy, isread, expirationdate, effectivedate,
          activeflag, teammemberid, insertedby, updatedby, insertedon,
          updatedon, fromsecurityusersid, old_id, isdeleted )
        VALUES
        ( gen_random_uuid(), v_usernotificationid, cur.sid, NULL, NULL,
          NULL, NULL, false, NULL, NULL,
          1, NULL, vs_user_id, vs_user_id, now(), now(), NULL, NULL, NULL );
      END IF;
    END LOOP;

    DROP TABLE IF EXISTS ttb_ytp_dda;

  -- ======================================================================
  -- DDA CHECKS (6 months prior)
  -- A) 6m pre-18: if DDA Application Status SKIP is answered and ddaServices is NULL)
  -- B) 6m pre-21: if DDA unanswered OR Adult Guardianship Petition filing date missing
  -- Recipients: Caseworker + Supervisor on the service case
  -- ======================================================================
    DROP TABLE IF EXISTS ttb_ytp_dda CASCADE;
    CREATE TEMP TABLE ttb_ytp_dda (
      personid uuid, servicecaseid uuid, casenumber character varying,
      toworkeridno character varying, supervisorid character varying, turn varchar(4), reason varchar(20)
    );

    -- 6m pre-18: DDA unanswered (ddaServices is NULL/empty)
    INSERT INTO ttb_ytp_dda (personid, servicecaseid, casenumber, toworkeridno, supervisorid, turn, reason)
    SELECT DISTINCT p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid, '18', 'DDA_UNANSWERED'
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE p.activeflag = 1
      AND (p.dob + interval '18 years' - interval '6 months')::date = COALESCE(ad_run_dt, current_date)::date
      and COALESCE( (ytp.newfcgschecklistjson->>'petitionSkip')::boolean, false ) = true
      AND NULLIF(btrim(ytp.newfcgschecklistjson->>'willGuardianProvideCare'), '') = '0'
      and (NULLIF(btrim(ytp.newfcgschecklistjson->>'isDdaServices'), '') <> 'eligible');

    -- 6m pre-21: DDA unanswered OR petition not filed (petitionFillingDate is NULL)
    INSERT INTO ttb_ytp_dda (personid, servicecaseid, casenumber, toworkeridno, supervisorid, turn, reason)
    SELECT DISTINCT p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid, '21',
          CASE
            WHEN NULLIF(btrim(ytp.newfcgschecklistjson->>'isDdaServices'), '') IS NULL THEN 'DDA_UNANSWERED'
            WHEN (ytp.newfcgschecklistjson->>'petitionSentToDssAttorneyOn') IS NULL THEN 'AGP_INCOMPLETE'
          END
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE p.activeflag = 1
      AND (p.dob + interval '21 years' - interval '6 months')::date = COALESCE(ad_run_dt, current_date)::date
      and COALESCE( (ytp.newfcgschecklistjson->>'petitionSkip')::boolean, false ) = true
      AND NULLIF(btrim(ytp.newfcgschecklistjson->>'willGuardianProvideCare'), '') = '0'
      and (NULLIF(btrim(ytp.newfcgschecklistjson->>'isDdaServices'), '') <> 'eligible');

    FOR cur IN
      SELECT DISTINCT personid, servicecaseid, casenumber, toworkeridno AS sid, turn, reason FROM ttb_ytp_dda
      UNION ALL
      SELECT DISTINCT personid, servicecaseid, casenumber, supervisorid AS sid, turn, reason FROM ttb_ytp_dda WHERE supervisorid IS NOT NULL
    LOOP
      IF cur.sid IS NOT NULL THEN
        vs_notification_txt :=
          CASE
            WHEN cur.turn='18' AND cur.reason='DDA_UNANSWERED'
              THEN 'Please complete “Is the youth eligible for Developmental Disabilities Administration (DDA) Services?” before the 18th birthday.'
            WHEN cur.turn='21' AND cur.reason='DDA_UNANSWERED'
              THEN 'Reminder: Update the DDA Services Application/Eligibility before the 21st birthday.'
            WHEN cur.turn='21' AND cur.reason='AGP_INCOMPLETE'
              THEN 'Reminder: Complete the Adult Guardianship Petition (filing date missing) before the 21st birthday.'
          END;

        INSERT INTO cjams.usernotification
        ( usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag,
          url, subject, priorityleveltypekey, "body", hasattachments,
          updatedby, updatedon, insertedby, insertedon, effectivedate,
          expirationdate, "timestamp", teammemberid, isread, attachmentlocation,
          isexternalentity, ismailsent, mailsentdate, old_id, objecttype,
          objectcasenumber, entityid, isdeleted, teamtypekey )
        VALUES
        ( gen_random_uuid(), cur.sid, 'System', cur.servicecaseid, 1,
          NULL, vs_notification_txt, 'High', vs_notification_txt, NULL,
          vs_user_id, now(), vs_user_id, now(), now(),
          NULL, NULL, NULL, NULL, NULL,
          false, false, NULL,
          CASE
            WHEN cur.turn='18' THEN 'YTP_DDA18_6M'
            WHEN cur.turn='21' AND cur.reason='DDA_UNANSWERED' THEN 'YTP_DDA21_6M'
            ELSE 'YTP_AGPET21_6M'
          END,
          'servicecase', cur.casenumber, cur.personid, NULL, 'CW')
        RETURNING usernotificationid INTO v_usernotificationid;

        INSERT INTO cjams.usernotificationmap
        ( usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied,
          isforwarded, iscarboncopy, isread, expirationdate, effectivedate,
          activeflag, teammemberid, insertedby, updatedby, insertedon,
          updatedon, fromsecurityusersid, old_id, isdeleted )
        VALUES
        ( gen_random_uuid(), v_usernotificationid, cur.sid, NULL, NULL,
          NULL, NULL, false, NULL, NULL,
          1, NULL, vs_user_id, vs_user_id, now(), now(), NULL, NULL, NULL );
      END IF;
    END LOOP;

    DROP TABLE IF EXISTS ttb_ytp_dda;

  -- ==================================================================================
  -- DDA ANNUAL REMINDER
  -- Condition: ddaServices in ('started','not started') and each 365 days since initial
  -- anchor (ddaStatusInitialDate if present, else ytp.updatedon)
  -- Recipients: Caseworker + Supervisor on the service case
  -- ==================================================================================
    DROP TABLE IF EXISTS ttb_ytp_dda_annual CASCADE;
    CREATE TEMP TABLE ttb_ytp_dda_annual (
      personid uuid, servicecaseid uuid, casenumber character varying,
      toworkeridno character varying, supervisorid character varying
    );

    INSERT INTO ttb_ytp_dda_annual (personid, servicecaseid, casenumber, toworkeridno, supervisorid)
    SELECT DISTINCT p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL 
      AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE p.activeflag = 1
      AND lower(ytp.newfcgschecklistjson->>'ddaServices') IN ('started','not started')
      AND (
        COALESCE(ad_run_dt, current_date) - COALESCE(NULLIF(ytp.newfcgschecklistjson->>'ddaStatusInitialDate','')::date, ytp.updatedon::date) >= 0
      );

    FOR cur IN
      SELECT personid, servicecaseid, casenumber, toworkeridno AS sid FROM ttb_ytp_dda_annual
      UNION ALL
      SELECT personid, servicecaseid, casenumber, supervisorid AS sid FROM ttb_ytp_dda_annual WHERE supervisorid IS NOT NULL
    LOOP
      IF cur.sid IS NOT NULL THEN
        vs_notification_txt :=
          'Developmental Disabilities Administration (DDA) Services Application Status needs to be updated for the Youth "' ||
          (SELECT firstname || ' ' || lastname FROM person WHERE personid=cur.personid) ||
          '" CJAMS PID (' || (SELECT cjamspid FROM person WHERE personid=cur.personid) || ').';

        INSERT INTO cjams.usernotification
        ( usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag,
          url, subject, priorityleveltypekey, "body", hasattachments,
          updatedby, updatedon, insertedby, insertedon, effectivedate,
          expirationdate, "timestamp", teammemberid, isread, attachmentlocation,
          isexternalentity, ismailsent, mailsentdate, old_id, objecttype,
          objectcasenumber, entityid, isdeleted, teamtypekey )
        VALUES
        ( gen_random_uuid(), cur.sid, 'System', cur.servicecaseid, 1,
          NULL, vs_notification_txt, 'High', vs_notification_txt, NULL,
          vs_user_id, now(), vs_user_id, now(), now(),
          NULL, NULL, NULL, NULL, NULL,
          false, false, NULL, 'YTP_DDA_ANNUAL', 'servicecase',
          cur.casenumber, cur.personid, NULL, 'CW')
        RETURNING usernotificationid INTO v_usernotificationid;

        INSERT INTO cjams.usernotificationmap
        ( usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied,
          isforwarded, iscarboncopy, isread, expirationdate, effectivedate,
          activeflag, teammemberid, insertedby, updatedby, insertedon,
          updatedon, fromsecurityusersid, old_id, isdeleted )
        VALUES
        ( gen_random_uuid(), v_usernotificationid, cur.sid, NULL, NULL,
          NULL, NULL, false, NULL, NULL,
          1, NULL, vs_user_id, vs_user_id, now(), now(), NULL, NULL, NULL );
      END IF;
    END LOOP;

    DROP TABLE IF EXISTS ttb_ytp_dda_annual;


  -- ============================================================
  -- SSI ELIGIBLE REVISIT: 7 months prior to 18th birthday
  -- Condition: ssi = 'eligible'
  -- Recipients: Caseworker + Supervisor on the service case
  -- ============================================================
    DROP TABLE IF EXISTS ttb_ssi18 CASCADE;
    CREATE TEMP TABLE ttb_ssi18 (
      personid uuid, servicecaseid uuid, casenumber character varying,
      toworkeridno character varying, supervisorid character varying
    );

    INSERT INTO ttb_ssi18 (personid, servicecaseid, casenumber, toworkeridno, supervisorid)
    SELECT DISTINCT p.personid, sc.servicecaseid, sc.servicecasenumber, ca.toworkeridno, up.supervisorid
    FROM person p
    JOIN actor ac ON ac.personid = p.personid AND ac.activeflag = 1
    JOIN servicecase sc ON sc.servicecaseid = ac.servicecaseid AND sc.activeflag = 1
    JOIN caseassignment ca ON ca.objectid = sc.servicecaseid AND ca.activeflag = 1 AND ca.enddate IS NULL AND lower(ca.responsibilitytypekey) IN ('family','child')
    JOIN userprofile up ON up.securityusersid = ca.toworkeridno AND up.activeflag = 1
    INNER JOIN youthtransitionplan ytp ON ytp.clientid = p.personid
    WHERE p.activeflag = 1
      AND (p.dob + interval '18 years' - interval '7 months')::date = COALESCE(ad_run_dt, current_date)::date
      AND lower(ytp.newfcgschecklistjson->>'ssi') = 'eligible';

    FOR cur IN
      SELECT personid, servicecaseid, casenumber, toworkeridno AS sid FROM ttb_ssi18
      UNION ALL
      SELECT personid, servicecaseid, casenumber, supervisorid AS sid FROM ttb_ssi18 WHERE supervisorid IS NOT NULL
    LOOP
      IF cur.sid IS NOT NULL THEN
        vs_notification_txt := 'Reminder: Youth''s SSI eligibility needs to be revisited before the 18th birthday.';

        INSERT INTO cjams.usernotification
        ( usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag,
          url, subject, priorityleveltypekey, "body", hasattachments,
          updatedby, updatedon, insertedby, insertedon, effectivedate,
          expirationdate, "timestamp", teammemberid, isread, attachmentlocation,
          isexternalentity, ismailsent, mailsentdate, old_id, objecttype,
          objectcasenumber, entityid, isdeleted, teamtypekey )
        VALUES
        ( gen_random_uuid(), cur.sid, 'System', cur.servicecaseid, 1,
          NULL, vs_notification_txt, 'High', vs_notification_txt, NULL,
          vs_user_id, now(), vs_user_id, now(), now(),
          NULL, NULL, NULL, NULL, NULL,
          false, false, NULL, 'SSI_18_7M', 'servicecase',
          cur.casenumber, cur.personid, NULL, 'CW')
        RETURNING usernotificationid INTO v_usernotificationid;

        INSERT INTO cjams.usernotificationmap
        ( usernotificationmapid, usernotificationid, tosecurityusersid, parentusernotificationmapid, isreplied,
          isforwarded, iscarboncopy, isread, expirationdate, effectivedate,
          activeflag, teammemberid, insertedby, updatedby, insertedon,
          updatedon, fromsecurityusersid, old_id, isdeleted )
        VALUES
        ( gen_random_uuid(), v_usernotificationid, cur.sid, NULL, NULL,
          NULL, NULL, false, NULL, NULL,
          1, NULL, vs_user_id, vs_user_id, now(), now(), NULL, NULL, NULL );
      END IF;
    END LOOP;

    DROP TABLE IF EXISTS ttb_ssi18;
  END IF;

  RETURN 'success';

  EXCEPTION 
    WHEN OTHERS THEN
      RAISE NOTICE 'Error in ICWA Bulk Process: %', SQLERRM;
      RETURN 'failure';
END;
$function$;