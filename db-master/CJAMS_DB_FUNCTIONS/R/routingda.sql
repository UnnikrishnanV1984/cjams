DROP FUNCTION IF EXISTS cjams.routingda(appeventcode character varying, intake_service_req_id uuid, fromuserid character varying, v_assignedsecurityid character varying, v_responsibilitytypekey character varying, j_assignfolder json , isnotifyuser boolean );
DROP FUNCTION IF EXISTS cjams.routingda(appeventcode character varying, intake_service_req_id uuid, fromuserid character varying, v_assignedsecurityid character varying, v_responsibilitytypekey character varying, j_assignfolder json , isnotifyuser boolean, v_assignlater boolean );
CREATE OR REPLACE FUNCTION cjams.routingda(appeventcode character varying, intake_service_req_id uuid, fromuserid character varying, v_assignedsecurityid json, v_responsibilitytypekey character varying, j_assignfolder json DEFAULT '{}'::json, isnotifyuser boolean DEFAULT true, v_assignlater boolean DEFAULT false)
 RETURNS routeda_temp_type
 LANGUAGE plpgsql
AS $function$

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 10/10/2024 Kapila Mandhadi/Manasa Kasula - CJAMS - Caseworker/Supervisor assignments (CIDM-9543)
--3/7/2024 Sai Teja Chintha- Supervisor approval issues(CIDM-10234)
-- 02/11/2026 - Veera - CIDM-11127 - long running Query tunning
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

DECLARE 
result routeda_temp_type;
 
 
v_teamid uuid;
v_investigationid uuid;
v_intakesecurityid character varying;
v_usernotificationid uuid;
v_createduser character varying;
v_servicetype character varying;
 
v_fromroletypekey  character varying;
v_toroletypekey  character varying;
v_team_member_id  uuid;

v_fromrolesupervisor bool;
v_torolesupervisor bool;
v_status  int;
v_routingid uuid;
v_isavailable int ;
v_intakenumber character varying;
v_date timestamp without time zone;
v_notifystatus character varying;
v_metadata json;
v_auditlog  character varying;
v_auditlogassign character varying;
v_datypeid  uuid;
v_dasubtypeid  uuid;
v_roletypecode character varying;
s_Actmsg  character varying;
v_teamtypekey character varying;

v_foldertypekey character varying;
v_folderreasontypekey character varying;
v_folderopendatetime timestamp without time zone;
v_foldernotes text;
--teamtypekey character varying;
v_servicerequestnumber character varying;
v_focuspersonname character varying;
v_focuspersonid uuid;
v_alertnotes character varying;
v_savepersonalert character varying;
v_servicerequestno character varying;
v_routingdata character varying;
v_message character varying;
v_fromuserrole character varying;
v_icjprobationcount bigint;
v_actiontype character varying;
v_personid uuid;
v_fromteamid uuid;
l_accepteddate timestamp without time zone;
l_inserteddate timestamp without time zone;
l_fromldssid uuid;
l_toldssid uuid;
l_record RECORD;
i json;
l_child json;
v_caseassignmentid uuid;

BEGIN

v_date:= now() ;

v_foldertypekey := j_assignfolder->>'foldertypekey';
v_folderreasontypekey := j_assignfolder->>'folderreasontypekey';
v_folderopendatetime := (j_assignfolder->>'folderopendatetime')::timestamp;
v_foldernotes := j_assignfolder->>'foldernotes';

CREATE TEMP TABLE IF NOT EXISTS
Temp_insert_person_program_area (
personprogramid uuid
) ON COMMIT DROP;

v_status:= 4; /*Default routed status assigned*/
RAISE NOTICE 'Status: 1 %', v_status;
v_servicerequestno:='';

    /*Intake service request raised user and da type*/
    SELECT a.insertedby, b.intakeservreqtypekey, a.intakeservreqtypeid, a.intakeservicerequestclassid,
           teamtypekey, servicerequestnumber, actiontype, intakenumber, a.insertedon
    INTO v_intakesecurityid, v_servicetype, v_datypeid, v_dasubtypeid, v_teamtypekey, 
         v_servicerequestno, v_actiontype, v_intakenumber, l_inserteddate 
    FROM intakeservicerequest AS a 
    JOIN intakeservicerequesttype AS b ON a.intakeservreqtypeid = b.intakeservreqtypeid 
    WHERE intakeserviceid = intake_service_req_id;

    SELECT investigationid INTO v_investigationid FROM investigation WHERE intakeserviceid = intake_service_req_id;
    
    SELECT updatedon INTO l_accepteddate FROM routing 
    WHERE routingstatustypeid = 2 AND activeflag = 1 AND eventcode ='INTR' 
    AND objectid = v_intakenumber;

    /*Assigned user team details*/
    SELECT roletypekey, teamid, countyid INTO v_fromroletypekey, v_fromteamid, l_fromldssid 
    FROM v_userprofile where securityusersid = fromuserid;

    /*Logged in user role details*/ 
    IF l_fromldssid is NULL THEN 
        SELECT tm.teamid, t.countyid INTO v_fromteamid, l_fromldssid
        FROM getteam(fromuserid) as tm;

        SELECT role.roletypekey INTO v_fromroletypekey 
        FROM rolemapping rm
        JOIN role ON role.id = rm.roleid AND role.activeflag = 1 
        JOIN muser ON muser.id = rm.principalid::int AND muser.activeflag = 1 AND rm.activeflag = 1 AND rm.teamtypekey = 'CW'
        WHERE muser.securityusersid = fromuserid;
    END IF;

    -- Moved static user lookup OUTSIDE the loop
    SELECT (lastname ||',' || firstname) INTO v_createduser 
    FROM userprofile 
    WHERE SecurityUsersId = fromuserid AND activeflag = 1;

    /*Routing to user*/
    FOR i IN SELECT * FROM Json_array_elements(v_assignedsecurityid::json) LOOP

        /*Get caseworker name for Notification*/
        SELECT (lastname ||',' || firstname) INTO result.caseworker_name 
        FROM userprofile WHERE SecurityUsersId = (i->>'userid') AND activeflag = 1;

        /* fetch data for multiple county assignment */
        SELECT teamid, loadnumber, roletypekey, teamname, teammemberid, isupervisor, countyid
        INTO v_teamid, result.loadnumber, v_toroletypekey, result.teamname, v_team_member_id, v_torolesupervisor, l_toldssid
        FROM v_userprofile vup WHERE vup.securityusersid = (i->>'userid') AND vup.countyid = l_fromldssid 
        LIMIT 1;

RAISE NOTICE 'v teamid: %', v_teamid;
RAISE NOTICE 'v team_member_id: %', v_team_member_id;
RAISE NOTICE 'l fromldssid: %', l_fromldssid;
RAISE NOTICE 'v assignedsecurityid: %',  (i->>'userid');
        /* fetch data if county condition is not fetched data */
        IF v_teamid is NULL THEN
            SELECT tm.teamid, tm.loadnumber, t.teamname, tm.teammemberid, coalesce(isupervisor,false), t.countyid
            INTO v_teamid ,result.loadnumber, result.teamname, v_team_member_id, v_torolesupervisor, l_toldssid
            FROM teammemberassignment tma 
            INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
            INNER JOIN team t ON t.teamid = tm.teamid AND t.activeflag =1
            INNER JOIN teammemberroletype tmrt ON tmrt.roletypekey = tm.roletypekey 
            WHERE tma.SecurityUsersId = (i->>'userid') AND tma.activeflag=1 
            LIMIT 1;

            SELECT role.roletypekey INTO v_toroletypekey 
            FROM rolemapping rm
            JOIN role ON role.id = rm.roleid AND role.activeflag = 1 
            JOIN muser ON muser.id = rm.principalid::int AND muser.activeflag = 1 AND rm.activeflag = 1 AND rm.teamtypekey = 'CW'
            WHERE muser.securityusersid = (i->>'userid');
        END IF;

        /*Assigned user roletypecode*/
        SELECT rt.roletypecode INTO v_roletypecode 
        FROM role R 
        INNER JOIN roletype rt ON rt.shortname = r.name AND rt.activeflag =1
        WHERE r.roletypekey = v_toroletypekey AND r.activeflag =1 
        LIMIT 1;
        
RAISE NOTICE 'v teamid: %', v_teamid;
RAISE NOTICE 'v team_member_id: %', v_team_member_id;
RAISE NOTICE 'l fromldssid: %', l_fromldssid;
RAISE NOTICE 'v assignedsecurityid: %',  (i->>'userid');        

 IF (coalesce(v_torolesupervisor, false) = true) THEN
            SELECT routingid, 1 INTO v_routingid, v_isavailable 
            FROM routing r WHERE tosecurityusersid = fromuserid 
            AND activeflag =1
            AND r.objectid = intake_service_req_id :: character varying
            ORDER BY insertedon desc limit 1;
                
            IF (coalesce(v_isavailable,0) = 0 ) THEN
                SELECT routingid, 1 INTO v_routingid, v_isavailable
                FROM routing r WHERE tosecurityusersid = fromuserid 
                AND activeflag = 1
                AND r.objectid = v_intakenumber
                ORDER BY insertedon desc limit 1;
            END IF;

            SELECT coalesce(tmrt.isupervisor,false) INTO v_fromrolesupervisor 
            FROM routing r
            INNER JOIN teammemberroletype tmrt ON tmrt.roletypekey = r.fromroleid 
            WHERE r.routingid = v_routingid;

            IF (coalesce(v_fromrolesupervisor,false) = true AND coalesce(v_torolesupervisor,false) = true ) THEN
                IF (fromuserid <> (i->>'userid')) THEN
                    UPDATE routing SET routingstatustypeid = 9, activeflag = 0, updatedon = v_date
                    WHERE routingid = v_routingid;
                    v_status:= 9;
                ELSIF (fromuserid = (i->>'userid')) THEN
                    UPDATE routing SET routingstatustypeid = 2, activeflag = 0, updatedon = v_date
                    WHERE routingid = v_routingid;
                    v_status:= 4;
                END IF;
            ELSE
            -- UPDATE routing SET routingstatustypeid =2,activeflag =0  ,
            --                      updatedon= v_date
            -- WHERE routingid = v_routingid; --CIDM-10234
                v_status:= 9; /*Routed to Supervisor status*/
            END IF;    
        END IF;
    
        /*Routing to user*/
        IF (v_roletypecode = 'CW' and v_assignlater = false ) THEN
            INSERT INTO routing(
                eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
                fromroleid, toroleid,objectid , routingstatustypeid,
                insertedby, updatedby, servicerequestnumber)
            VALUES(appeventcode, fromuserid, (i->>'userid'), v_teamid,
                v_fromroletypekey, v_toroletypekey, intake_service_req_id, v_status,
                fromuserid, fromuserid, v_servicerequestno);
        END IF;

        UPDATE caseassignment SET enddate = now()::date, updatedby = fromuserid, updatedon = now() 
        WHERE (fromworkeridno=fromuserid or toworkeridno=fromuserid) 
        AND objectid= intake_service_req_id AND objecttypekey = 'servicerequest' 
        AND enddate IS NULL AND responsibilitytypekey= (i->>'responsibilitytypekey')::character varying
        AND toworkeridno = (i->>'userid');

        UPDATE caseassignment SET enddate = now()::date, updatedby = fromuserid, updatedon = now() 
        WHERE objectid= intake_service_req_id AND objecttypekey = 'servicerequest' 
        AND enddate IS NULL AND responsibilitytypekey= (i->>'responsibilitytypekey')::character varying
        AND lower(responsibilitytypekey) = 'family';
            
        INSERT INTO caseassignment
        (fromworkeridno, toworkeridno, effectivetime, effectivedate, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, fromteamid, toteamid, startdate, fromldssid, toldssid, assignmenttype, assigndate)
        VALUES(fromuserid, (i->>'userid'), now(), now(), fromuserid, fromuserid, now(), now(), 'servicerequest', intake_service_req_id, (i->>'responsibilitytypekey'), v_fromteamid, v_teamid, now(), l_fromldssid, l_toldssid, 'W', now()::date)
        RETURNING "caseassignmentid" INTO v_caseassignmentid;

        IF lower((i->>'responsibilitytypekey')) not in ('family', 'administrative') THEN
            FOR l_child IN SELECT * FROM json_array_elements((i->>'child')::json) LOOP
                INSERT INTO caseassignmentactor (
                    caseassignmentid, intakeservicerequestactorid, activeflag, insertedby, updatedby, insertedon, updatedon)
                VALUES(v_caseassignmentid, (l_child ->>'intakeservicerequestactorid')::uuid, 1, fromuserid, fromuserid, now(), now());
            END LOOP;    
        END IF; 

        /*NOTIFICATION */ 
        IF(isnotifyuser=true) THEN
            SELECT send_notification INTO v_notifystatus FROM send_notification(
                fromuserid, fromuserid, (i->>'userid'),
                'System', 'Normal', 'Case #'||v_intakenumber|| ' Routed to '|| result.caseworker_name ,
                'Case #'||v_intakenumber|| ' Routed to '|| result.caseworker_name ,
                cast(intake_service_req_id as character varying));
            
            SELECT count(1) INTO v_icjprobationcount 
            FROM intakeservicerequest ins 
            JOIN intakeservicerequesttype inst ON inst.intakeservreqtypeid = ins.intakeservreqtypeid AND inst.activeflag=1
            JOIN servicerequestsubtype sst ON sst.servicerequestsubtypeid = ins.intakeservicerequestclassid AND sst.activeflag=1
            WHERE ins.intakeserviceid = intake_service_req_id 
            AND sst.classkey IN ('ICJ Receiving Re-Entry','ICJ Receiving Probation')
            AND inst.intakeservreqtypekey='Interstate Compact';

            SELECT r.roletypekey INTO v_fromuserrole 
            FROM muser mu 
            JOIN rolemapping rm ON rm.principalid = mu.id::character varying AND rm.activeflag=1
            JOIN "role" r ON r.id = rm.roleid AND r.activeflag=1
            WHERE mu.securityusersid = fromuserid LIMIT 1;

            IF(v_icjprobationcount > 0 and v_fromuserrole='') THEN
                v_message = 'New case ('|| v_intakenumber||') is assigned by '|| v_createduser ||' (Note : Home Evaluation Report form VIII needs to be completed in 30 days.)';
            ELSE
                v_message = 'New case ('|| v_intakenumber||') is assigned by '|| v_createduser ;
            END IF;

            SELECT send_notification INTO v_notifystatus FROM send_notification( 
                (i->>'userid'), fromuserid, (i->>'userid'),
                'System', 'Normal', v_message, v_message,
                cast(intake_service_req_id as character varying));
    
            /*AUDIT LOG */   
            SELECT json_agg(e) FROM (SELECT result.caseworker_name caseworkername, result.loadnumber loadnumber, v_intakenumber intakenumber, result.teamname teamname)e INTO v_metadata;

            SELECT auditlog INTO v_auditlog FROM auditlog(
                'IR','Case #'||v_intakenumber|| ' Routed to '|| result.caseworker_name,null,v_intakenumber,null,
                v_intakesecurityid, v_metadata, null, true, false, false);
        
            SELECT auditlog INTO v_auditlogassign FROM auditlog(
                'IR', 'New case ('|| v_intakenumber||') is assigned by '|| v_createduser,null,v_intakenumber,null,
                v_intakesecurityid, v_metadata, null, true, false, false);
        END IF;         
        
        -- DJS folder 
        UPDATE intakeservicerequest SET foldertypekey = v_foldertypekey, folderreasontypekey = v_folderreasontypekey,
        folderopendatetime = v_folderopendatetime , foldernotes = v_foldernotes 
        WHERE intakeserviceid = intake_service_req_id;

        IF v_teamtypekey = 'DJS' THEN
            SELECT ISR.servicerequestnumber, IDAS.raname, IDAS.focuspersonid 
            INTO v_servicerequestnumber, v_focuspersonname, v_focuspersonid 
            FROM intakeservicerequest as ISR
            JOIN intakeservicerequestcourtaction as ISRCA ON ISRCA.intakenumber = ISR.intakenumber AND ISRCA.activeflag = 1
            JOIN intakeservicerequestcourtordertypeconfig as ISRCOTC ON ISRCOTC.intakeservicerequestcourtactionid = ISRCA.intakeservicerequestcourtactionid AND ISRCOTC.activeflag=1
            JOIN intakedastaging as IDAS ON IDAS.intakenumber = ISR.intakenumber AND IDAS.activeflag = 1
            WHERE ISR.intakeserviceid = intake_service_req_id AND ISRCOTC.courtordertypekey = 'PS' AND ISR.activeflag = 1
            LIMIT 1;
                    
            IF ((cast(v_servicerequestnumber as character varying)!='') and (cast(v_focuspersonname as character varying)!='') and (cast(v_focuspersonid as character varying)!='')) THEN
                v_alertnotes = 'Safety Plan Initiative is set for '||v_focuspersonname ||'  in Case '||  v_servicerequestnumber;
                SELECT savepersonalert INTO v_savepersonalert FROM savepersonalert('YSPL'::character varying,'Active'::character varying,now()::timestamp without time zone,v_alertnotes,v_focuspersonid,fromuserid);
            END IF;
        END IF;

        IF (coalesce(v_torolesupervisor,false) = false) THEN
    
            /* DSDS ACTION TASK GOAL DETAILS(Create action tasks) */
            SELECT createinvestigation INTO s_Actmsg FROM createinvestigation(
                v_datypeid, v_dasubtypeid, v_investigationid,
                (i->>'userid'), v_roletypecode, v_teamtypekey); 
            
            INSERT INTO areateammemberservicerequest(
                activeflag, teammemberid, intakeserviceid, 
                routingstatustypekey,securityusersid, routedby, insertedby, insertedon)
            VALUES (1, v_team_member_id, intake_service_req_id, 
                'New', (i->>'userid'), NULL, fromuserid, v_date);

            INSERT INTO intakeservicerequestuseraccess(
                activeflag, securityusersid, intakeserviceid, insertedby)
            VALUES (1, (i->>'userid'), intake_service_req_id, fromuserid);

            /*Routing details updated into service request */
            IF (v_roletypecode = 'CW' and v_assignlater = false ) THEN
                UPDATE intakeservicerequest SET isrouted = true, routedon = v_date,
                isaccepted = true, accepteddate = v_date, 
                routedusersid = (i->>'userid'), responsibilitytypekey = (i->>'responsibilitytypekey'), updatedon = now(), updatedby = fromuserid  
                WHERE intakeserviceid = intake_service_req_id;
            END IF;
        END IF;   

        IF (coalesce(v_torolesupervisor,false) = true and v_assignlater = false and fromuserid = (i->>'userid')) THEN
            UPDATE intakeservicerequest SET isrouted=true, routedon = v_date,
            routedusersid = (i->>'userid'), responsibilitytypekey = (i->>'responsibilitytypekey')  
            WHERE intakeserviceid = intake_service_req_id;
        END IF;
        
    END LOOP;
    
--D-21732: @Simar - Objecttypekey needs to be servicerequest to match conversion and application
WITH temp_ids AS ( 
        INSERT INTO personprogramarea 
        (personid, programkey, subprogramkey, objecttypekey, objectid, startdate, insertedby, updatedby, entityid, datatransferflag, sourcetype)  
        SELECT 
            a.personid, 'CPS', v_actiontype, 'servicerequest', intake_service_req_id, COALESCE(l_accepteddate,l_inserteddate)::date, fromuserid, fromuserid, v_servicerequestno, 'A', 'CW'
        FROM actor a 
        WHERE a.intakeserviceid = intake_service_req_id AND a.activeflag=1 
        AND a.personid NOT IN (
            SELECT personid FROM personprogramarea WHERE programkey='CPS' AND objecttypekey = 'servicerequest' AND objectid::uuid = intake_service_req_id 
        )
        RETURNING personprogramid 
    )
    INSERT INTO Temp_insert_person_program_area SELECT personprogramid FROM temp_ids;

    WITH temp_ids1 AS (
        UPDATE personprogramarea SET subprogramkey = v_actiontype, updatedon = now(), updatedby = fromuserid 
        WHERE personid IN (
            SELECT personid FROM personprogramarea WHERE programkey='CPS' AND objecttypekey = 'servicerequest' AND objectid::uuid = intake_service_req_id
        )
        AND programkey='CPS' AND objecttypekey = 'servicerequest' AND objectid::uuid = intake_service_req_id AND subprogramkey != v_actiontype 
        RETURNING personprogramid
    )
    INSERT INTO Temp_insert_person_program_area SELECT personprogramid FROM temp_ids1;

    -- FIX: Changed alias from l_record to t to avoid variable conflict
    INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
    SELECT 
        t.personprogramid, 
        'PRGMAREA', 
        'systemupdate10', 
        (SELECT row_to_json(p) FROM personprogramarea p WHERE p.personprogramid = t.personprogramid), 
        now(), 
        fromuserid
    FROM Temp_insert_person_program_area t;

    -- Drop handled by ON COMMIT DROP, or explicit drop if preferred
    DROP TABLE IF EXISTS Temp_insert_person_program_area;

    SELECT proglist INTO result.programarea FROM (
        SELECT json_agg(json_build_object('personid',personid, 'personprogramid', personprogramid)) proglist
        FROM personprogramarea 
        WHERE objectid = intake_service_req_id::character varying
    ) v;
        
RETURN result;
END;

$function$
;