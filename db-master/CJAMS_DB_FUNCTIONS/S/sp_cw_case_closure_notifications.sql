CREATE OR REPLACE FUNCTION cjams.sp_cw_case_closure_notifications()
RETURNS text
LANGUAGE plpgsql
AS $function$
/* 
-- 07/08/2026 - Raghavendra Puli - CIDM-11333 - Investigation Case Closure Notifications on 45 day & 53 day.
*/
DECLARE
  v_case record;
  v_usernotficationexist uuid;
  v_usernotificationid uuid;
  v_supervisornotficationexist uuid;
  v_supervisornotificationid uuid;
  v_subjecttext character varying;
  v_days_remaining integer;
  v_email_subject text;
  v_email_body text;
BEGIN
  RAISE NOTICE 'Case Closure Notification Process STARTED at %', now();
  
  FOR v_case IN
    --------------------------------------------------------------------------------------------------------------
    -- Driving Query
    -- Creating temporary result-set (base_data, ranked_assignments) using WITH for CTE (Common Table Expression).
    -- These temporary result-sets are used in the main select query.
    --------------------------------------------------------------------------------------------------------------
    WITH base_data AS (
      SELECT 
        isr.reporteddate,
        isr.intakeservreqtypeid,
        isr.intakeserviceid,
        isr.servicerequestnumber,
        ((isr.reporteddate::date + 60) - now()::date) AS days_remaining
      FROM intakeservicerequest isr
      WHERE isr.activeflag = 1
        AND isr.teamtypekey = 'CW'
        AND isr.actiontype = 'IR'
        AND (
          SELECT a.intakeserreqstatustypeid::uuid 
          FROM intakeservicerequestdispositioncode a 
          WHERE a.intakeserviceid = isr.intakeserviceid 
            AND a.activeflag = 1
          ORDER BY insertedon DESC
          LIMIT 1 
        ) NOT IN (
          '7995cecb-062d-406c-8ea9-b1da4b1877d8', -- Completed
          '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'  -- Closed
        )
        AND EXISTS (
          SELECT 1
          FROM caseassignment ca  
          WHERE ca.objectid = isr.intakeserviceid
            AND lower(ca.responsibilitytypekey) = 'family'
            AND ca.activeflag = 1
            AND ca.enddate IS NULL
        )
        AND (
          ((isr.reporteddate::date + 60) - now()::date) = 15 
          OR ((isr.reporteddate::date + 60) - now()::date) = 7
        )
    ),
    ranked_assignments AS (
      SELECT 
        bd.*,
        ca.toworkeridno,
        ROW_NUMBER() OVER (
          PARTITION BY bd.intakeserviceid 
          ORDER BY 
            CASE WHEN ca.enddate IS NULL THEN 0 ELSE 1 END,
            ca.startdate DESC
        ) AS rn
      FROM base_data bd
      LEFT JOIN caseassignment ca  
        ON ca.objectid = bd.intakeserviceid  
       AND ca.activeflag = 1
    )
    SELECT 
      ra.*,
      up_worker.email AS worker_email,
      up_worker.supervisorid,
      up_supervisor.email AS supervisor_email
    FROM ranked_assignments ra
    LEFT JOIN userprofile up_worker
      ON up_worker.securityusersid = ra.toworkeridno AND up_worker.activeflag = 1
    LEFT JOIN userprofile up_supervisor
      ON up_supervisor.securityusersid = up_worker.supervisorid AND up_supervisor.activeflag = 1
    WHERE ra.rn = 1
  LOOP

    v_days_remaining := v_case.days_remaining;

    IF v_days_remaining = 15 THEN
      v_subjecttext := '45-Day Closure Alert Review requirements for Case Closure.';
    ELSIF v_days_remaining = 7 THEN
      v_subjecttext := '53-Day Closure Alert Review requirements for Case Closure.';
    ELSE
      CONTINUE;
    END IF;

    v_email_subject := 'Case Notification [' || v_case.servicerequestnumber || '] - ' ||
      CASE WHEN v_days_remaining = 15 THEN '45-Day Closure Reminder' ELSE '53-Day Closure Reminder' END;

    v_email_body := 'Hello,<br/><br/>' ||
      'This is an automated notification that <b>Case #' || v_case.servicerequestnumber || 
      ' <a href="https://cw.cjams.mdthink.maryland.gov/">LINK</a></b> has entered its required ' ||
      CASE WHEN v_days_remaining = 15 THEN '45-day' ELSE '53-day' END ||
      ' closure window and is to be closed by 60 days.<br/><br/>' ||
      'To remain compliant with system requirements, please ensure all final documentation is submitted ' ||
      'and the case is officially closed by the deadline.<br/><br/>' ||
      'This is a system generated email, please do not respond.<br/><br/>' ||
      '-- CJAMS';

    ------------------------------------------------------------------------
    -- CASE WORKER EXECUTION FLOW
    ------------------------------------------------------------------------
    SELECT usernotificationid INTO v_usernotficationexist 
    FROM usernotification 
    WHERE objectid = v_case.servicerequestnumber
      AND securityusersid = v_case.toworkeridno 
      AND subject = v_subjecttext 
      AND insertedon::date = now()::date
      AND activeflag = 1;

    IF v_usernotficationexist IS NULL THEN
      INSERT INTO usernotification (
        securityusersid, usernotificationtypekey, objectid, activeflag,
        subject, priorityleveltypekey, body, updatedby, updatedon, 
        insertedby, insertedon, effectivedate, teamtypekey, objecttype,
        objectcasenumber, isexternalentity
      ) VALUES (
        v_case.toworkeridno, 'System', v_case.servicerequestnumber, 1,
        v_subjecttext, 'High', v_subjecttext, v_case.toworkeridno, NOW(), 
        v_case.toworkeridno, NOW(), NOW(), 'CW', 'cps', v_case.servicerequestnumber, FALSE
      ) RETURNING usernotificationid INTO v_usernotificationid;

      INSERT INTO usernotificationmap (
        usernotificationid, tosecurityusersid, fromsecurityusersid,
        isread, effectivedate, activeflag, updatedby, updatedon, insertedby, insertedon
      ) VALUES (
        v_usernotificationid, v_case.toworkeridno, 'System',
        FALSE, NOW(), 1, v_case.toworkeridno, NOW(), v_case.toworkeridno, NOW()
      );

      INSERT INTO cjams.emailjavabatchnotify (
        objecttype, objectid, toemail, body, subject,
        insertedon, insertedby, updatedon, updatedby, emailstatus, activeflag
      ) VALUES (
        'cps_ir_case_closure_reminder', v_case.intakeserviceid, v_case.worker_email, v_email_body, v_email_subject,
        NOW(), v_case.toworkeridno, NOW(), v_case.toworkeridno, NULL, 1
      );
    END IF;
    
    ------------------------------------------------------------------------
    -- SUPERVISOR EXECUTION FLOW
    ------------------------------------------------------------------------
    SELECT usernotificationid INTO v_supervisornotficationexist 
    FROM usernotification 
    WHERE objectid = v_case.servicerequestnumber
      AND securityusersid = v_case.supervisorid 
      AND subject = v_subjecttext 
      AND insertedon::date = now()::date
      AND activeflag = 1;

    IF v_case.supervisorid IS NOT NULL AND v_supervisornotficationexist IS NULL THEN
      INSERT INTO usernotification (
        securityusersid, usernotificationtypekey, objectid, activeflag,
        subject, priorityleveltypekey, body, updatedby, updatedon, 
        insertedby, insertedon, effectivedate, teamtypekey, objecttype,
        objectcasenumber, isexternalentity
      ) VALUES (
        v_case.supervisorid, 'System', v_case.servicerequestnumber, 1,
        v_subjecttext, 'High', v_subjecttext, v_case.supervisorid, NOW(), 
        v_case.supervisorid, NOW(), NOW(), 'CW', 'cps', v_case.servicerequestnumber, FALSE
      ) RETURNING usernotificationid INTO v_supervisornotificationid;

      INSERT INTO usernotificationmap (
        usernotificationid, tosecurityusersid, fromsecurityusersid,
        isread, effectivedate, activeflag, updatedby, updatedon, insertedby, insertedon
      ) VALUES (
        v_supervisornotificationid, v_case.supervisorid, 'System',
        FALSE, NOW(), 1, v_case.supervisorid, NOW(), v_case.supervisorid, NOW()
      );

      INSERT INTO cjams.emailjavabatchnotify (
        objecttype, objectid, toemail, body, subject,
        insertedon, insertedby, updatedon, updatedby, emailstatus, activeflag
      ) VALUES (
        'cps_ir_case_closure_reminder', v_case.intakeserviceid, v_case.supervisor_email, v_email_body, v_email_subject, 
        NOW(), v_case.supervisorid, NOW(), v_case.supervisorid, NULL, 1
      );
    END IF;

  END LOOP;   
  RAISE NOTICE 'Case Closure Notification Process COMPLETED at %', now();

  RETURN 'SUCCESS';

END;
$function$;