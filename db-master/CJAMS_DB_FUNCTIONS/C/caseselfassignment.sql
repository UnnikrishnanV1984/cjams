DROP FUNCTION IF EXISTS cjams.caseselfassignment(v_defectno character varying);
CREATE OR REPLACE FUNCTION cjams.caseselfassignment(v_defectno character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 10/29/2024 Manasa Kasula - CJAMS - Caseworker/Supervisor assignments (CIDM-9543)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

DECLARE 
v_userid UUID;
v_teamid uuid;
l_ldssid uuid;
i record;


BEGIN

    FOR  i IN select distinct isr.intakeserviceid, R.tosecurityusersid  from intakeservicerequest isr 
    inner join routing R on R.activeflag = 1 and ((R.objectid = isr.intakeserviceid::varchar and r.routingstatustypeid = 9) or 
    (routingstatustypeid in (2, 76) and r.objectid = ISR.intakenumber))
    INNER  JOIN  intakeserreqstatustype  irst  on  irst.intakeserreqstatustypeid  =  ISR.intakeserreqstatustypeid
    AND  irst.activeflag  =1  AND  lower(irst.Intakeserreqstatustypekey)  Not  in ('closed','rejected','completed')
    where coalesce(ISR.isrouted,false)  = false AND ISR.teamtypekey = 'CW'  
    AND  ISR.activeflag  =1 AND ISR.intakeservicerequestclassid <> '00000000-0000-0000-0000-000000000000' 
    and ISR.actiontype in ('IR','AR') and (select count(1) = 0 from caseassignment ca where ca.activeflag = 1 and ca.objectid = isr.intakeserviceid
    and ca.enddate is null and ca.responsibilitytypekey = 'family' )

    loop

        v_userid := i.tosecurityusersid;

        SELECT teamid, countyid
        INTO v_teamid, l_ldssid
        FROM v_userprofile vup WHERE vup.securityusersid =  v_userid::varchar;

        INSERT INTO caseassignment
        (fromworkeridno, toworkeridno, effectivetime,effectivedate, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid,responsibilitytypekey,fromteamid,toteamid,startdate,fromldssid,toldssid,assignmenttype,assigndate)
        VALUES( v_userid, v_userid,now(),now(), v_userid,v_defectno,now(),now(),'servicerequest',i.intakeserviceid,'family',v_teamid,v_teamid,now() ,l_ldssid,l_ldssid,'W',now()::date);
    
    END LOOP;

    FOR  i IN SELECT distinct coalesce(r.tosecurityusersid, sc.insertedby) as tosecurityusersid, sc.servicecaseid FROM servicecase sc
    inner JOIN routing r ON r.objectid = sc.servicecaseid::varchar AND r.activeflag =1  
    AND r.routingstatustypeid in (2, 9) AND  r.eventcode = 'SRVC'
    WHERE LOWER(sc.statustypekey) = 'open' AND sc.activeflag = 1
    and (select count(1) = 0 from caseassignment ca where ca.activeflag = 1 and ca.objectid = sc.servicecaseid
    and ca.enddate is null and ca.responsibilitytypekey = 'family')

    loop

        v_userid := i.tosecurityusersid;

        SELECT teamid, countyid
        INTO v_teamid, l_ldssid
        FROM v_userprofile vup WHERE vup.securityusersid =  v_userid::varchar;

        INSERT INTO caseassignment
        (fromworkeridno, toworkeridno, effectivetime,effectivedate, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid,responsibilitytypekey,fromteamid,toteamid,startdate,fromldssid,toldssid,assignmenttype,assigndate)
        VALUES( v_userid, v_userid,now(),now(), v_userid,v_defectno,now(),now(),'servicecase',i.servicecaseid,'family',v_teamid,v_teamid,now() ,l_ldssid,l_ldssid,'W',now()::date);
    
    END LOOP;

    return 'Success';

END;

$function$;