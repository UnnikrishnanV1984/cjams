    DROP FUNCTION IF EXISTS sp_crisp_notifications(vs_run_dt DATE, OUT success_sw character varying, OUT vl_output_sqlcode character varying);

    CREATE OR REPLACE FUNCTION sp_crisp_notifications(
        vs_run_dt DATE DEFAULT CURRENT_DATE,
        OUT success_sw character varying,
        OUT vl_output_sqlcode character varying
    )
    RETURNS record
    LANGUAGE plpgsql
    AS $function$
    -------------------------------------------------
    --Revision
    --09/05/2024 Sushma Bade - CIDM-9378 CRISP - person immunization screen
    --09/13/2024 Yogeshvar - CIDM-9413 CRISP - add source for notifications.
    -------------------------------------------------
    DECLARE
        VL_EXCEP_FLAG               INTEGER DEFAULT 0;
    BEGIN
        RAISE NOTICE 'START Time % ', timeofday();
        with crispnotifications_records as (
            SELECT distinct 'servicecase' as case_type, sc.servicecasenumber as casenumber, ac.personid,
                    ac.servicecaseid,ca.toworkeridno,
                    (select u.fullname from userprofile u where u.securityusersid = ca.toworkeridno and u.activeflag = 1) as caseworker,
                    u.supervisorid, 'family' as cwtype,
                    pr.firstname || ' ' || pr.lastname as clientname,
                    pr.cjamspid as clientid,
                    p.updatedon::date as updateddt
                from personimmunization p 
                inner join person pr on p.personid = pr.personid and pr.activeflag = 1
                join actor ac on ac.personid = p.personid and ac.activeflag = 1
                join servicecase sc on ac.servicecaseid  = sc.servicecaseid and sc.activeflag = 1
                join caseassignment ca on ca.objectid = sc.servicecaseid and lower(ca.responsibilitytypekey) = 'family' 
                    and ca.activeflag = 1 and ca.enddate is null
                join userprofile u on u.securityusersid = ca.toworkeridno
                where p.updatedby = 'CRISP_INBOUND'
                and p.updatedon::date = current_date
            union all
            SELECT distinct 'servicecase' as case_type, sc.servicecasenumber as casenumber, ac.personid,
                    ac.servicecaseid,ca.toworkeridno, 
                    (select u.fullname from userprofile u where u.securityusersid = ca.toworkeridno and u.activeflag = 1) as caseworker,
                    u.supervisorid, 'child' as cwtype, pr.firstname || ' ' || pr.lastname as clientname,
                    pr.cjamspid as clientid,
                    p.updatedon::date as updateddt
                from personimmunization p 
                inner join person pr on p.personid = pr.personid and pr.activeflag = 1
                join actor ac on ac.personid = p.personid and ac.activeflag = 1
                join servicecase sc on  ac.servicecaseid = sc.servicecaseid and sc.activeflag = 1
                join intakeservicerequestactor isr on isr.servicecaseid = sc.servicecaseid 
                    and isr.personid = ac.personid 
                    and isr.activeflag = 1	
                join caseassignment ca on ca.objectid = sc.servicecaseid 
                    and lower(ca.responsibilitytypekey) = 'child'
                    and ca.activeflag = 1
                    and ca.enddate is null
                join caseassignmentactor acr on acr.caseassignmentid = ca.caseassignmentid 	
                    and acr.intakeservicerequestactorid = isr.intakeservicerequestactorid 
                    and acr.activeflag = 1
                join userprofile u on u.securityusersid = ca.toworkeridno
                where p.updatedby = 'CRISP_INBOUND'
                and p.updatedon::date = current_date
            ),  
            load_crisp_notifications as (
                insert into usernotification (
                    usernotificationid, securityusersid, usernotificationtypekey, 
                    objectid, activeflag, url, 
                    subject, 
                    priorityleveltypekey, 
                    body, 
                    updatedby, updatedon, insertedby, insertedon, effectivedate,  
                    ismailsent, objecttype, 
                    objectcasenumber, entityid, teamtypekey, isexternalentity, source
                ) 
                select gen_random_uuid(), toworkeridno, 'System', 
                    servicecaseid, 1, null, 
                    'New immunization information has been received and updated for client ' || clientname || ' (' || clientid || ') on ' || to_char(updateddt, 'Mon DDth YYYY') || '. Please review to ensure the information is accurate.',
                    'High', 
                    'New immunization information has been received and updated for client ' || clientname || ' (' || clientid || ') on ' || to_char(updateddt, 'Mon DDth YYYY') || '. Please review to ensure the information is accurate.' ,
                    'CW-Admin', now(), 'CW-Admin', now(), now(),
                    false, case_type,
                    casenumber, personid, 'CW', true, 'CRISP'
                from crispnotifications_records
                union all
                select gen_random_uuid(), supervisorid, 'System', 
                    servicecaseid, 1, null, 
                    case 
                        when cwtype = 'child' then 
                            'New immunization information has been received and updated for client ' || clientname || ' (' || clientid || ') on ' || to_char(updateddt, 'Mon DDth YYYY') || '. The assigned child caseworker is ' || coalesce(caseworker, 'Unknown') ||  '. Please review to ensure the information is accurate.'
                        else 
                            'New immunization information has been received and updated for client ' || clientname || ' (' || clientid || ') on ' || to_char(updateddt, 'Mon DDth YYYY') || '. The assigned family caseworker is ' || coalesce(caseworker, 'Unknown')  || '. Please review to ensure the information is accurate.'
                    end,
                    'High',
                    case 
                        when cwtype = 'child' then 
                            'New immunization information has been received and updated for client ' || clientname || ' (' || clientid || ') on ' || to_char(updateddt, 'Mon DDth YYYY') || '. The assigned child caseworker is ' || coalesce(caseworker, 'Unknown') ||  '. Please review to ensure the information is accurate.'
                        else 
                            'New immunization information has been received and updated for client ' || clientname || ' (' || clientid || ') on ' || to_char(updateddt, 'Mon DDth YYYY') || '. The assigned family caseworker is ' || coalesce(caseworker, 'Unknown')  || '. Please review to ensure the information is accurate.'
                    end,
                    'CW-Admin', now(), 'CW-Admin', now(), now(),
                    false, case_type,
                    casenumber, personid, 'CW', true, 'CRISP'
                from crispnotifications_records
                returning usernotificationid, securityusersid
            )   insert into usernotificationmap (
                    usernotificationmapid, usernotificationid, tosecurityusersid, 
                    isread, activeflag, insertedby, updatedby, insertedon, updatedon
                ) select gen_random_uuid(), usernotificationid, securityusersid,
                    false, 1, 'CW-Admin', 'CW-Admin', now(), now()
                from load_crisp_notifications;

        RAISE NOTICE 'END Time % ', timeofday();
        IF  VL_EXCEP_FLAG != 1 THEN 
            success_sw := 'Y';
        else
            success_sw :='N';
        END IF;
        EXCEPTION WHEN OTHERS THEN
            VL_OUTPUT_SQLCODE := SQLERRM;
            success_sw := 'N';
            RAISE EXCEPTION 'Error processing sp_crisp_notifications %', VL_OUTPUT_SQLCODE;
        RETURN;
    END;
    $function$
    ;