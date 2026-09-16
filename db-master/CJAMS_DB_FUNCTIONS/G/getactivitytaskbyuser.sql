DROP FUNCTION If exists cjams.getactivitytaskbyuser(userid character varying, pageno integer, pagesize integer, filterdatetype character varying);
CREATE OR REPLACE FUNCTION cjams.getactivitytaskbyuser(userid character varying, pageno integer, pagesize integer, filterdatetype character varying, v_searchobj json DEFAULT NULL::json, v_sortorder character varying DEFAULT NULL::character varying, v_sortcolumn character varying DEFAULT NULL::character varying, taskstatus character varying DEFAULT NULL::character varying)
 RETURNS TABLE(count bigint, opencount bigint, completedcount bigint, inprogresscount bigint, activityid uuid, activitytaskid uuid, actvityname text, duedate timestamp without time zone, task character varying, required boolean, assignedon timestamp without time zone, taskstatustype character varying, completeddate timestamp without time zone, activitytasktypekey character varying, insertedon timestamp without time zone, assignloadnumber character varying, location character varying, outofoffice boolean, activitytaskstatustypekey character varying, activitytaskdispositiontypekey character varying, taskdescription text, startdatetime timestamp without time zone, enddatetime timestamp without time zone, intakeserviceid uuid, servicecaseid uuid, servicerequestnumber character varying, legalguardian text, duestatus text)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/28/2023 Chandra/Palani - Performance tuning (CIDM-7579)
-- 07/28/2023 Chandra/Palani - Performance tuning (CIDM-7912)
-- 01/05/2025 B-208477 - Vamshikrishna.byreddy (CIDM-10057)
-- 04/10/2025 B-208462 - Naveenkumar Chemutu (CIDM-10354)
-- 05/12/2025 B-220037 - Charansai Bodapati (CIDM-10434)
-- 06/13/2025 B-208462 - Naveenkumar Chemutu (CIDM-10354) - Hiding first task in grid for existing OOH
-- 01/08/2026 Narendra - Performance tuning 
------------------------------------------------------------------------------------------------------------
DECLARE 
v_pageoffset int;
v_pagenumber int;
v_DateFrom TIMESTAMP;                        
v_DateTo TIMESTAMP;
v_casenumber character varying;
v_headofhousehold character varying;
v_task character varying;
v_duedate character varying;
v_status character varying;
 
begin
v_casenumber := v_searchObj ->> 'Case Numebr';
v_headofhousehold := v_searchObj ->> 'Head of Household';
v_task:= v_searchObj ->> 'Task';
v_duedate := v_searchObj ->> 'Due Date';
v_status := v_searchObj ->> 'Status';
	
v_pagenumber := pageno-1;
v_pageoffset = v_pagenumber * pagesize;

    IF filterdatetype = 'Nex30' THEN
        SELECT now() INTO v_DateFrom ;
        SELECT now() + interval '30' DAY INTO v_DateTo;
    END IF;
    IF filterdatetype = 'Nex60' THEN
        SELECT now() INTO v_DateFrom ;
        SELECT now() + interval '60' DAY INTO v_DateTo;
    END IF;
    IF filterdatetype = 'Nex90' THEN
        SELECT now() INTO v_DateFrom ;
        SELECT now() + interval '90' DAY INTO v_DateTo;
    END IF;
    IF filterdatetype = 'Prev30' THEN
        SELECT now() INTO v_DateTo ;
        SELECT now() - interval '30' DAY INTO v_DateFrom;
    END IF;
    IF filterdatetype = 'Prev60' THEN
        SELECT now() INTO v_DateTo;
        SELECT now() - interval '60' DAY INTO v_DateFrom;
    END IF;
    IF filterdatetype = 'Prev90' THEN
        SELECT now() INTO v_DateTo ;
        SELECT now() - interval '90' DAY INTO v_DateFrom;
    END IF;
   
     
 RETURN QUERY
	
select count(1) over() as "count",
 COUNT(*) FILTER (WHERE fin_result.taskstatustype  = 'Open') OVER () AS opencount,
 COUNT(*) FILTER (WHERE fin_result.taskstatustype  = 'Completed') OVER () AS completedcount,
 COUNT(*) FILTER (WHERE fin_result.taskstatustype  = 'Pending') OVER () AS inprogresscount,
fin_result.activityid,fin_result.activitytaskid,fin_result.actvityname,
fin_result.duedate,fin_result.task,fin_result.required,fin_result.assignedon,fin_result.taskstatustype,
fin_result.completeddate,fin_result.activitytasktypekey,fin_result.insertedon,fin_result.assignloadnumber,
fin_result.location,fin_result.outofoffice,fin_result.activitytaskstatustypekey,fin_result.activitytaskdispositiontypekey,
fin_result.taskdescription,fin_result.startdatetime,fin_result.enddatetime,
fin_result.intakeserviceid,fin_result.servicecaseid,fin_result.servicerequestnumber,fin_result.legalguardian,fin_result.duestatus 
from (
   
    select act.ActivityId,
        acttask.ActivityTaskId,
        act.description AS actvityname,
        acttask.duedate,
        acttask.name As task,
        acttask.Required,
        acttask.AssignedOn,        
        (CASE WHEN atst.typedescription = 'Closed' THEN 'Completed' WHEN atst.typedescription = 'In Progress' THEN 'Pending' ELSE atst.typedescription end) as taskstatustype, 
        acttask.completeddate,
        acttask.ActivityTaskTypeKey,
        acttask.insertedon,
        acttask.assignedto as assignloadnumber,
        acttask.location,
        acttask.outofoffice,
        acttask.ActivityTaskStatusTypeKey,
        acttask.ActivityTaskDispositionTypekey,
        acttask.description as taskdescription,
        acttask.startdatetime,
        acttask.enddatetime,
        ISR.intakeserviceid,
        NULL::uuid AS servicecaseid,
        ISR.servicerequestnumber,
        (SELECT concat(per.firstname , ' ' , per.lastname) 
         FROM intakeservicerequestactor isra 
         JOIN person per ON isra.personid = per.personid 
         WHERE isra.intakeserviceid = ISR.intakeserviceid 
         AND isra.activeflag = 1 AND isra.isheadofhousehold = true LIMIT 1) AS legalguardian,
         case WHEN atst.typedescription = 'Open' THEN 
            ((acttask.duedate::date - CURRENT_DATE)::int) || ' Days Remaining'
        WHEN atst.typedescription = 'In Progress' THEN 
            ((CURRENT_DATE - acttask.duedate::date)::int) || ' Days Overdue'
        WHEN atst.typedescription = 'Closed' THEN 
            'Satisfied on ' || TO_CHAR(acttask.completeddate, 'MM-DD-YYYY')        
    	END AS duestatus
    FROM intakeservicerequest AS ISR
    INNER JOIN intakeserreqstatustype AS ISRST ON ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid 
    AND ISRST.intakeserreqstatustypekey NOT IN ('Closed', 'Completed') AND ISRST.activeflag = 1
    INNER JOIN AreaTeamMemberServiceRequest  AS ATSR  ON ATSR.IntakeServiceId = ISR.IntakeServiceId 
    AND ATSR.ActiveFlag = 1
    INNER JOIN Investigation invst ON ISR.intakeserviceid = invst.intakeserviceid AND invst.activeflag = 1
    INNER JOIN Activity act ON invst.investigationid = act.objectid AND act.activeflag = 1
    INNER JOIN Activitytask acttask ON act.activityid = acttask.activityid  
    AND acttask.activeflag = 1 AND act.activeflag = 1 
    --AND acttask.activitytaskstatustypekey != 'InvClosed'
    INNER JOIN activitytaskstatustype atst ON acttask.activitytaskstatustypekey = atst.activitytaskstatustypekey 
    AND atst.activeflag = 1 AND acttask.activeflag = 1
    WHERE ATSR.TeamMemberId IN (
            SELECT TeamMemberId 
            FROM teammember tm
            INNER JOIN Team  AS T  ON  T.TeamId = TM.TeamId  
            WHERE T.countyid IN (
                SELECT distinct T.countyid 
                FROM TeamMemberAssignment AS TMA
                INNER JOIN TeamMember AS TM ON TM.TeamMemberId = TMA.TeamMemberId
                INNER JOIN Team AS T ON T.TeamId = TM.TeamId
                WHERE TMA.securityusersid = userid
            )
        )
    AND (v_DateFrom IS NULL OR date(acttask.duedate) BETWEEN CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE))  
   -- AND acttask.activitytaskstatustypekey = 'InvOpen'     
    AND ISR.intakeserviceid IN (
        SELECT distinct objectid 
        FROM caseassignment
        WHERE (fromworkeridno = userid OR toworkeridno = userid)
        AND (enddate IS NULL OR enddate > now())
    )
    AND ISR.activeflag = 1 AND ISR.teamtypekey = 'CW'
    
    union all
    
    
 select act.ActivityId,
        acttask.ActivityTaskId,
        act.description AS actvityname,
        acttask.duedate,
        acttask.name As task,
        acttask.Required,
        acttask.AssignedOn,        
        (CASE WHEN atst.typedescription = 'Closed' THEN 'Completed' WHEN atst.typedescription = 'In Progress' THEN 'Pending' ELSE atst.typedescription end) as taskstatustype, 
        acttask.completeddate,
        acttask.ActivityTaskTypeKey,
        acttask.insertedon,
        acttask.assignedto as assignloadnumber,
        acttask.location,
        acttask.outofoffice,
        acttask.ActivityTaskStatusTypeKey,
        acttask.ActivityTaskDispositionTypekey,
        acttask.description as taskdescription,
        acttask.startdatetime,
        acttask.enddatetime,      
         NULL::uuid AS intakeserviceid,        
		scc.servicecaseid, 
        scc.servicecasenumber AS servicerequestnumber,       
	    (SELECT INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname)) 
	        FROM person as P WHERE personid in (SELECT PersonId 
	        FROM actor 
	        WHERE ActorId IN (SELECT Actorid 
	     	FROM IntakeServiceRequestActor isar 
	        INNER JOIN servicecase sc 
	        ON sc.servicecaseid = isar.servicecaseid 
	        AND sc.activeflag =1 AND isar.activeflag = 1 
	        WHERE sc.servicecaseid = scc.servicecaseid::uuid 
	        AND isar.isheadofhousehold = true LIMIT 1))) AS legalguardian,  
         case WHEN atst.typedescription = 'Open' THEN 
            ((acttask.duedate::date - CURRENT_DATE)::int) || ' Days Remaining'
        WHEN atst.typedescription = 'In Progress' THEN 
            ((CURRENT_DATE - acttask.duedate::date)::int) || ' Days Overdue'
        WHEN atst.typedescription = 'Closed' THEN 
            'Satisfied on ' || TO_CHAR(acttask.completeddate, 'MM-DD-YYYY')        
    	END AS duestatus
    	
    from Intakeservreqchildremoval irl 
	INNER JOIN servicecase scc on scc.servicecaseid = irl.servicecaseid AND scc.activeflag = 1 
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid and irl.activeflag  = 1
	inner join person pr on pr.personid = isra.personid  AND pr.activeflag = 1 
 
    INNER JOIN Activity act ON irl.intakeservreqchildremovalid = act.objectid AND act.activeflag = 1
    INNER JOIN Activitytask acttask ON act.activityid = acttask.activityid  
    AND acttask.activeflag = 1 AND act.activeflag = 1 
    INNER JOIN activitytaskstatustype atst ON acttask.activitytaskstatustypekey = atst.activitytaskstatustypekey 
    AND atst.activeflag = 1 AND acttask.activeflag = 1    
    WHERE 
        irl.servicecaseid  IN (
        SELECT distinct objectid 
        FROM caseassignment
        WHERE (fromworkeridno = userid OR toworkeridno = userid)
        AND (enddate IS NULL OR enddate > now())
    )
     AND ((v_DateFrom IS NULL OR date(acttask.duedate) BETWEEN CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)) 
		   or acttask.ActivityTaskStatusTypeKey = 'CRInProgress')
    AND  
    (
		SELECT rs.typedescription 
		FROM routing r 
		INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag =1
		WHERE r.objectid = irl.intakeservreqchildremovalid :: character varying AND r.activeflag =1 order by r.insertedon desc limit 1 
	) = 'Approved' 
	AND irl.activeflag = 1 
    AND 
    irl.exitdate IS NULL 
    and scc.servicecasenumber IS NOT NULL 
    AND pr.personid in (
		select DISTINCT iscr.personid from intakeservicerequestactor  iscr
		where iscr.servicecaseid = scc.servicecaseid and iscr.activeflag = 1
		and iscr.intakeservicerequestpersontypekey in ('AV','CHILD','BIOCHILD','OTHERCHILD')
		)  
        and acttask."sequence" != 0 and acttask.description = 'MedicationPsychotropic'  

    UNION ALL

SELECT 
    NULL::uuid AS activityid,
    NULL::uuid AS activitytaskid,
    NULL::text AS actvityname,
    (rm.startdatetime::date + interval '7 days')::timestamp AS duedate,
    (pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || pr.cjamspid || ' - Youth is currently in a hotel, office or youth shelter living arrangement. Efforts are to continue to be made to move the youth to a placement as soon as possible. Please refer to policy SSA# 25-01 for further guidance.') AS task,
    NULL::boolean AS required,
    NULL::timestamp AS assignedon,
    CASE 
        WHEN (CURRENT_DATE - rm.startdatetime::date)::int <= 7 THEN 'Open'
        ELSE 'Pending'
    END AS taskstatustype,
    NULL::timestamp AS completeddate,
    NULL::text AS activitytasktypekey,
    NULL::timestamp AS insertedon,
    NULL::character varying AS assignloadnumber,
    NULL::character varying AS location,
    NULL::boolean AS outofoffice,
    NULL::text AS activitytaskstatustypekey,
    NULL::text AS activitytaskdispositiontypekey,
    NULL::text AS taskdescription,
    NULL::timestamp as startdatetime,
    NULL::timestamp AS enddatetime,
    rm.intakeserviceid,
    rm.servicecaseid,
    sc.servicecasenumber AS servicerequestnumber,
    (
        SELECT INITCAP(TRIM(p.firstname) || ' ' || TRIM(p.lastname))
        FROM person p
        WHERE p.personid IN (
            SELECT a.personid
            FROM actor a
            WHERE a.actorid IN (
                SELECT isar.actorid
                FROM intakeservicerequestactor isar
                INNER JOIN servicecase sc2 ON sc2.servicecaseid = isar.servicecaseid
                WHERE sc2.servicecaseid = rm.servicecaseid
                  AND isar.activeflag = 1
                  AND isar.isheadofhousehold = true
                LIMIT 1
            )
        )
    ) AS legalguardian,
    CASE 
        WHEN (CURRENT_DATE - rm.startdatetime::date)::int <= 7 THEN 
            (7 - (CURRENT_DATE - rm.startdatetime::date)::int) || ' Days Remaining'
        ELSE 
            ((CURRENT_DATE - (rm.startdatetime::date + interval '7 days')::date)::int) || ' Days Overdue'
    END AS duestatus
FROM placement rm
JOIN person pr ON pr.personid = rm.personid AND pr.activeflag = 1
/* Narendra - commented for performance tuning */ 
--added left join with case assignment and removed from sub query
INNER JOIN (
    SELECT DISTINCT objectid 
    FROM cjams.caseassignment 
    WHERE (fromworkeridno = userid OR toworkeridno = userid)
      AND (enddate IS NULL OR enddate > now())
      AND activeflag = 1
) ca ON rm.servicecaseid = ca.objectid
JOIN livingarrangement la ON la.placementid = rm.placementid
LEFT JOIN servicecase sc ON sc.servicecaseid = rm.servicecaseid
LEFT JOIN intakeservicerequest irs ON irs.intakeserviceid = rm.intakeserviceid
WHERE rm.activeflag = 1
 AND rm.enddatetime IS NULL
  AND rm.startdatetime IS NOT NULL
  AND la.livingarrangementtypekey = 'FCNFHS'
   /* Narendra - added for performance tuning */ 
--changed IN logic to EXISTS logic
 AND EXISTS (
        SELECT 1
        FROM cjams.routing rur 
        WHERE rur.objectid = rm.placementid::character varying  AND 
         rur.eventcode = 'PLTR'
          AND rur.activeflag = 1
          AND rur.routingstatustypeid = 16
      )
  AND EXISTS (
        SELECT 1 
        FROM cjams.intakeservicerequestactor iscr
        WHERE iscr.servicecaseid = sc.servicecaseid 
        and iscr.personid=pr.personid
          AND iscr.activeflag = 1
          AND iscr.intakeservicerequestpersontypekey IN ('AV','CHILD','BIOCHILD','OTHERCHILD')
  )
 /* Narendra - commented for performance tuning */ 
/*     and rm.servicecaseid  IN (
        SELECT distinct objectid 
        FROM caseassignment
        WHERE (fromworkeridno = userid OR toworkeridno = userid)
        AND (enddate IS NULL OR enddate > now()
        and activeflag =1)
  AND rm.enddatetime IS NULL
  AND rm.startdatetime IS NOT NULL
  AND la.livingarrangementtypekey = 'FCNFHS'
  AND (
        SELECT count(*)
        FROM routing rur 
        WHERE rur.objectid = rm.placementid::character varying
          AND rur.eventcode = 'PLTR'
          AND rur.activeflag = 1
          AND rur.routingstatustypeid = 16
      ) > 0
          AND pr.personid in (
        select DISTINCT iscr.personid from intakeservicerequestactor  iscr
        where iscr.servicecaseid = sc.servicecaseid and iscr.activeflag = 1
        and iscr.intakeservicerequestpersontypekey in ('AV','CHILD','BIOCHILD','OTHERCHILD')
        ) 
    ) */

	)
    as fin_result where
    (taskstatus is null or taskstatus = 'All' or fin_result.taskstatustype = taskstatus) and
    Case when v_casenumber is not null then fin_result.servicerequestnumber ilike '%' || v_casenumber  || '%'else true end
    and Case when v_headofhousehold is not null then fin_result.legalguardian ilike '%' || v_headofhousehold  || '%'else true end
    and Case when v_task is not null then fin_result.task ilike '%' || v_task  || '%'else true end
    and Case when v_duedate is not null then fin_result.duedate::date = v_duedate::date else true end
    and Case when v_status is not null then fin_result.taskstatustype ilike '%' || v_status  || '%'else true end
    group by
    fin_result.activityid,fin_result.activitytaskid,fin_result.actvityname,
	fin_result.duedate,fin_result.task,fin_result.required,fin_result.assignedon,fin_result.taskstatustype,
	fin_result.completeddate,fin_result.activitytasktypekey,fin_result.insertedon,fin_result.assignloadnumber,
	fin_result.location,fin_result.outofoffice,fin_result.activitytaskstatustypekey,fin_result.activitytaskdispositiontypekey,
	fin_result.taskdescription,fin_result.startdatetime,fin_result.enddatetime,
	fin_result.intakeserviceid,fin_result.servicecaseid,fin_result.servicerequestnumber,fin_result.legalguardian,fin_result.duestatus
    order by ( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Case Numebr' THEN fin_result.servicerequestnumber
        WHEN 'Head of Household' THEN fin_result.legalguardian
		WHEN 'Task' THEN fin_result.task 
		WHEN 'Due Date' THEN fin_result.duedate::character varying
		WHEN 'Status' THEN fin_result.taskstatustype end
		END) ASC NULLS last,
		 ( CASE v_sortorder
      WHEN 'desc' 
      THEN
        CASE v_sortcolumn 
         WHEN 'Case Numebr' THEN fin_result.servicerequestnumber
        WHEN 'Head of Household' THEN fin_result.legalguardian
		WHEN 'Task' THEN fin_result.task 
		WHEN 'Due Date' THEN fin_result.duedate::character varying
		WHEN 'Status' THEN fin_result.taskstatustype end
		END) DESC NULLS last
    
    LIMIT pagesize OFFSET v_pageoffset;

END;

$function$
;
