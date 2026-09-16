DROP FUNCTION IF EXISTS cjams.getdatimeline( uuid);
DROP FUNCTION IF EXISTS cjams.getdatimeline( uuid,integer,character varying);
DROP FUNCTION IF EXISTS cjams.getdatimeline( uuid,integer,character varying, integer);
DROP FUNCTION IF EXISTS cjams.getdatimeline( uuid,integer, integer);

CREATE OR REPLACE FUNCTION cjams.getdatimeline(v_intakeserviceid uuid, v_isExpungementSuperUser integer DEFAULT 0, isexpunged integer DEFAULT 0::integer)
 RETURNS TABLE(intaketype integer, trantype character varying, intakeserviceid uuid, servicerequestnumber character varying, insertedon timestamp without time zone, assignedto text, assignedby text)
 LANGUAGE plpgsql
AS $function$
DECLARE
        v_isexpunged integer;
BEGIN

    v_isexpunged := 0;
    IF v_isExpungementSuperUser= 1 THEN
        v_isexpunged := isexpunged;
    END IF;
    
    IF v_isexpunged = 1 THEN 
        --------------------------------------------------------------------
        -- FULLY EXPUNGED: use only ENCR tables + decryption
        --------------------------------------------------------------------
        RETURN QUERY 
        /*INTAKE TIMELINE INFO*/
        SELECT  1 as intaketype
                , 'intake'::character varying trantype
                , isr.intakeserviceid as intakeserviceid
                , null as servicerequestnumber
                , isr.reporteddate transdate 
                , up.firstname ||' ' || up.lastname as AssignedTo
                , NULL::text  as assignedby 
        FROM    expunge.intakeservicerequest_expunge isr  
                INNER JOIN  expunge.intakedastatus_expunge ids ON ids.intakenumber  = isr.intakenumber   AND ids.activeflag = 1
                LEFT JOIN userprofile up   ON up.securityusersid = ids.intakeuser 
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1
        UNION ALL 
        /*CPS/NON-CPS CASE TIMELINE INFO*/
        SELECT   2 as intaketype
                , 'servicerequest'::character varying trantype
                , isr.intakeserviceid
                , isr.servicerequestnumber
                , ca.startdate 
                , up1.firstname || '  ' || up1.lastname as  assignedto 
                , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    expunge.intakeservicerequest_expunge  isr 
                INNER JOIN  caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 
                INNER JOIN  UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
                INNER JOIN  UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1 
        UNION ALL
        /*REMOVAL CASE TIMELINE INFO*/
        SELECT   3 as intaketype
                , 'removal' ::character varying trantype
                , cr.intakeserviceid
                , '':: character varying 
                , to_char(((to_char(cr.removaldate ,'MM/dd/yyyy')::TEXT||' ' || to_char(cr.removaltime ,'HH24:MI:SS'):: TEXT))::"timestamp", 'MM/dd/yyyy HH24:MI:SS')::timestamp
                , concat_ws(' ',p.firstname,p.middlename,p.lastname) personname
                , '':: character varying
        FROM    intakeservreqchildremoval cr  
                INNER JOIN expunge.intakeservicerequestactor_expunge isra ON isra.intakeservicerequestactorid = cr.intakeservicerequestactorid AND isra.activeflag = 1
                INNER JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
        WHERE   cr.intakeserviceid = v_intakeserviceid  AND cr.activeflag = 1 
        /*CASE COMPLETED TIMELINE INFO*/
        UNION ALL
        (SELECT      4 as intaketype 
                    , 'casecompleted'::character varying trantype
                    , idc.intakeserviceid
                    , isr.servicerequestnumber
                    , r.insertedon 
                    , up1.firstname || '  ' || up1.lastname as  assignedto 
                    , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    intakeservicerequestdispositioncode idc
                INNER JOIN  intakeserreqstatustype st ON st.intakeserreqstatustypeid = idc.intakeserreqstatustypeid AND st.activeflag = 1
                            AND intakeserreqstatustypekey='Completed'
                INNER JOIN  routing r ON r.objectid = idc.intakeservicerequestdispositioncodeid::CHARACTER VARYING  AND r.eventcode ='INDR' AND r.routingstatustypeid = 16
                INNER JOIN  userprofile up1 ON up1.securityusersid = r.tosecurityusersid
                INNER JOIN  userprofile up2 ON up2.securityusersid = r.fromsecurityusersid 
                INNER JOIN expunge.intakeservicerequest_expunge isr ON isr.intakeserviceid = idc.intakeserviceid AND isr.activeflag = 1 
        WHERE idc.intakeserviceid = v_intakeserviceid LIMIT 1)        
        /*APPEAL TIMELINE INFO*/
        UNION ALL 
        SELECT      5 as intaketype 
                    , 'appeal'::character varying trantype
                    , isr.intakeserviceid
                    , isr.servicerequestnumber
                    , r.insertedon 
                    , up1.firstname || '  ' || up1.lastname as  assignedto 
                    , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    expunge.intakeservicerequest_expunge isr
                INNER JOIN  routing r ON r.objectid = isr.intakeserviceid::CHARACTER VARYING  AND r.eventcode ='APPL'
                            AND r.routingstatustypeid = 15 AND r.toroleid ='CWAPPEALCO'
                INNER JOIN  userprofile up1 ON up1.securityusersid = r.tosecurityusersid
                INNER JOIN  userprofile up2 ON up2.securityusersid = r.fromsecurityusersid  
        WHERE isr.intakeserviceid = v_intakeserviceid AND isr.activeflag = 1 
        UNION ALL
        /*ASSIGNMENT END TIMELINE INFO*/
        SELECT   6 as intaketype
                , 'assignmentend'::character varying trantype
                , isr.intakeserviceid
                , isr.servicerequestnumber
                , ca.enddate 
                , up1.firstname || '  ' || up1.lastname as  assignedto 
                , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    expunge.intakeservicerequest_expunge  isr 
                INNER JOIN  caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 AND ca.enddate IS NOT NULL 
                INNER JOIN  UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
                INNER JOIN  UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1 
        
        ORDER BY  transdate ASC;

   ELSIF v_isExpungementSuperUser= 1 AND  v_isexpunged = 2 THEN 
        --------------------------------------------------------------------
        -- PARTIALLY EXPUNGED: include BOTH normal + ENCR rows
        --------------------------------------------------------------------
        RETURN QUERY 
        /*INTAKE TIMELINE INFO - NORMAL*/
        SELECT  1 as intaketype
                , 'intake'::character varying trantype
                , isr.intakeserviceid as intakeserviceid
                , null as servicerequestnumber
                , isr.reporteddate transdate 
                , up.firstname ||' ' || up.lastname as AssignedTo
                , NULL::text  as assignedby 
        FROM    intakeservicerequest isr  
                INNER JOIN  intakedastatus ids ON ids.intakenumber = isr.intakenumber AND ids.activeflag = 1
                LEFT JOIN userprofile up   ON up.securityusersid =  ids.intakeuser 
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1
        UNION ALL 
        /*INTAKE TIMELINE INFO - ENCR*/
        SELECT  1 as intaketype
                , 'intake'::character varying trantype
                , isr.intakeserviceid as intakeserviceid
                , null as servicerequestnumber
                , isr.reporteddate transdate 
                , up.firstname ||' ' || up.lastname as AssignedTo
                , NULL::text  as assignedby 
        FROM    expunge.intakeservicerequest_expunge isr  
                INNER JOIN  expunge.intakedastatus_expunge ids ON ids.intakenumber = isr.intakenumber  AND ids.activeflag = 1
                LEFT JOIN userprofile up   ON up.securityusersid =   ids.intakeuser 
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1
        UNION ALL 
        /*CPS/NON-CPS CASE TIMELINE INFO - NORMAL*/
        SELECT   2 as intaketype
                , 'servicerequest'::character varying trantype
                , isr.intakeserviceid
                , isr.servicerequestnumber
                , ca.startdate 
                , up1.firstname || '  ' || up1.lastname as  assignedto 
                , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    IntakeserviceRequest  isr 
                INNER JOIN  caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 
                INNER JOIN  UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
                INNER JOIN  UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1 
        UNION ALL
        /*CPS/NON-CPS CASE TIMELINE INFO - ENCR*/
        SELECT   2 as intaketype
                , 'servicerequest'::character varying trantype
                , isr.intakeserviceid
                , isr.servicerequestnumber
                , ca.startdate 
                , up1.firstname || '  ' || up1.lastname as  assignedto 
                , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    expunge.intakeservicerequest_expunge  isr 
                INNER JOIN  caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 
                INNER JOIN  UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
                INNER JOIN  UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1 
        UNION ALL
        /*REMOVAL CASE TIMELINE INFO - NORMAL*/
        SELECT   3 as intaketype
                , 'removal' ::character varying trantype
                , cr.intakeserviceid
                , '':: character varying 
                , to_char(((to_char(cr.removaldate ,'MM/dd/yyyy')::TEXT||' ' || to_char(cr.removaltime ,'HH24:MI:SS'):: TEXT))::"timestamp", 'MM/dd/yyyy HH24:MI:SS')::timestamp
                , concat_ws(' ',p.firstname,p.middlename,p.lastname) personname
                , '':: character varying
        FROM    intakeservreqchildremoval cr  
                INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = cr.intakeservicerequestactorid AND isra.activeflag = 1
                INNER JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
        WHERE   cr.intakeserviceid = v_intakeserviceid  AND cr.activeflag = 1 
        UNION ALL
        /*REMOVAL CASE TIMELINE INFO - ENCR*/
        SELECT   3 as intaketype
                , 'removal' ::character varying trantype
                , cr.intakeserviceid
                , '':: character varying 
                , to_char(((to_char(cr.removaldate ,'MM/dd/yyyy')::TEXT||' ' || to_char(cr.removaltime ,'HH24:MI:SS'):: TEXT))::"timestamp", 'MM/dd/yyyy HH24:MI:SS')::timestamp
                , concat_ws(' ',p.firstname,p.middlename,p.lastname) personname
                , '':: character varying
        FROM    intakeservreqchildremoval cr  
                INNER JOIN expunge.intakeservicerequestactor_expunge isra ON isra.intakeservicerequestactorid = cr.intakeservicerequestactorid AND isra.activeflag = 1
                INNER JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
        WHERE   cr.intakeserviceid = v_intakeserviceid  AND cr.activeflag = 1 
        /*CASE COMPLETED TIMELINE INFO - NORMAL*/
        UNION ALL
        (SELECT      4 as intaketype 
                    , 'casecompleted'::character varying trantype
                    , idc.intakeserviceid
                    , isr.servicerequestnumber
                    , r.insertedon 
                    , up1.firstname || '  ' || up1.lastname as  assignedto 
                    , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    intakeservicerequestdispositioncode idc
                INNER JOIN  intakeserreqstatustype st ON st.intakeserreqstatustypeid = idc.intakeserreqstatustypeid AND st.activeflag = 1
                            AND intakeserreqstatustypekey='Completed'
                INNER JOIN  routing r ON r.objectid = idc.intakeservicerequestdispositioncodeid::CHARACTER VARYING  AND r.eventcode ='INDR' AND r.routingstatustypeid = 16
                INNER JOIN  userprofile up1 ON up1.securityusersid = r.tosecurityusersid
                INNER JOIN  userprofile up2 ON up2.securityusersid = r.fromsecurityusersid 
                INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = idc.intakeserviceid AND isr.activeflag = 1 
        WHERE idc.intakeserviceid = v_intakeserviceid LIMIT 1)
        /*CASE COMPLETED TIMELINE INFO - ENCR*/
        UNION ALL
        (SELECT      4 as intaketype 
                    , 'casecompleted'::character varying trantype
                    , idc.intakeserviceid
                    , isr.servicerequestnumber
                    , r.insertedon 
                    , up1.firstname || '  ' || up1.lastname as  assignedto 
                    , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    intakeservicerequestdispositioncode idc
                INNER JOIN  intakeserreqstatustype st ON st.intakeserreqstatustypeid = idc.intakeserreqstatustypeid AND st.activeflag = 1
                            AND intakeserreqstatustypekey='Completed'
                INNER JOIN  routing r ON r.objectid = idc.intakeservicerequestdispositioncodeid::CHARACTER VARYING  AND r.eventcode ='INDR' AND r.routingstatustypeid = 16
                INNER JOIN  userprofile up1 ON up1.securityusersid = r.tosecurityusersid
                INNER JOIN  userprofile up2 ON up2.securityusersid = r.fromsecurityusersid 
                INNER JOIN expunge.intakeservicerequest_expunge isr ON isr.intakeserviceid = idc.intakeserviceid AND isr.activeflag = 1 
        WHERE idc.intakeserviceid = v_intakeserviceid LIMIT 1)
        /*APPEAL TIMELINE INFO - NORMAL*/
        UNION ALL 
        SELECT      5 as intaketype 
                    , 'appeal'::character varying trantype
                    , isr.intakeserviceid
                    , isr.servicerequestnumber
                    , r.insertedon 
                    , up1.firstname || '  ' || up1.lastname as  assignedto 
                    , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    intakeservicerequest isr
                INNER JOIN  routing r ON r.objectid = isr.intakeserviceid::CHARACTER VARYING  AND r.eventcode ='APPL'
                            AND r.routingstatustypeid = 15 AND r.toroleid ='CWAPPEALCO'
                INNER JOIN  userprofile up1 ON up1.securityusersid = r.tosecurityusersid
                INNER JOIN  userprofile up2 ON up2.securityusersid = r.fromsecurityusersid  
        WHERE isr.intakeserviceid = v_intakeserviceid AND isr.activeflag = 1 
        /*APPEAL TIMELINE INFO - ENCR*/
        UNION ALL 
        SELECT      5 as intaketype 
                    , 'appeal'::character varying trantype
                    , isr.intakeserviceid
                    , isr.servicerequestnumber
                    , r.insertedon 
                    , up1.firstname || '  ' || up1.lastname as  assignedto 
                    , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    expunge.intakeservicerequest_expunge isr
                INNER JOIN  routing r ON r.objectid = isr.intakeserviceid::CHARACTER VARYING  AND r.eventcode ='APPL'
                            AND r.routingstatustypeid = 15 AND r.toroleid ='CWAPPEALCO'
                INNER JOIN  userprofile up1 ON up1.securityusersid = r.tosecurityusersid
                INNER JOIN  userprofile up2 ON up2.securityusersid = r.fromsecurityusersid  
        WHERE isr.intakeserviceid = v_intakeserviceid AND isr.activeflag = 1 
        UNION ALL
        /*ASSIGNMENT END TIMELINE INFO - NORMAL*/
        SELECT   6 as intaketype
                , 'assignmentend'::character varying trantype
                , isr.intakeserviceid
                , isr.servicerequestnumber
                , ca.enddate 
                , up1.firstname || '  ' || up1.lastname as  assignedto 
                , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    IntakeserviceRequest  isr 
                INNER JOIN  caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 AND ca.enddate IS NOT NULL 
                INNER JOIN  UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
                INNER JOIN  UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1 
        UNION ALL
        /*ASSIGNMENT END TIMELINE INFO - ENCR*/
        SELECT   6 as intaketype
                , 'assignmentend'::character varying trantype
                , isr.intakeserviceid
                , isr.servicerequestnumber
                , ca.enddate 
                , up1.firstname || '  ' || up1.lastname as  assignedto 
                , up2.firstname || '  ' || up2.lastname as assignedby 
        FROM    expunge.intakeservicerequest_expunge  isr 
                INNER JOIN  caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 AND ca.enddate IS NOT NULL 
                INNER JOIN  UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
                INNER JOIN  UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
        WHERE   isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1 
        
        ORDER BY  transdate ASC;

    ELSE

    RETURN QUERY 
	/*INTAKE TIMELINE INFO*/
	SELECT 	1 as intaketype
			, 'intake'::character varying trantype
			, isr.intakeserviceid as intakeserviceid
			, null as servicerequestnumber
			, isr.reporteddate transdate 
			, up.firstname ||' ' || up.lastname as AssignedTo
			, NULL::text  as assignedby 
	FROM 	intakeservicerequest isr  
			INNER JOIN  intakedastatus ids ON ids.intakenumber = isr.intakenumber  AND ids.activeflag = 1
			LEFT JOIN userprofile up   ON up.securityusersid = ids.intakeuser 
	WHERE 	isr.intakeserviceid = v_intakeserviceid   AND isr.activeflag = 1
	UNION ALL 
	/*CPS/NON-CPS CASE TIMELINE INFO*/
	SELECT	 2 as intaketype
			, 'servicerequest'::character varying trantype
			, isr.intakeserviceid
			, isr.servicerequestnumber
			, ca.startdate 
			, up1.firstname || '  ' || up1.lastname as  assignedto 
			, up2.firstname || '  ' || up2.lastname as assignedby 
	FROM 	IntakeserviceRequest  isr 
			INNER JOIN 	caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 
			INNER JOIN 	UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
			INNER JOIN 	UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
	WHERE 	isr.intakeserviceid = v_intakeserviceid 	AND isr.activeflag = 1 
	UNION ALL
	/*REMOVAL CASE TIMELINE INFO*/
	SELECT 	 3 as intaketype
			, 'removal' ::character varying trantype
			, cr.intakeserviceid
			, '':: character varying 
	 		, to_char(((to_char(cr.removaldate ,'MM/dd/yyyy')::TEXT||' ' || to_char(cr.removaltime ,'HH24:MI:SS'):: TEXT))::"timestamp", 'MM/dd/yyyy HH24:MI:SS')::timestamp
  			, concat_ws(' ',p.firstname,p.middlename,p.lastname) personname
			, '':: character varying
	FROM 	intakeservreqchildremoval cr  
			INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = cr.intakeservicerequestactorid AND isra.activeflag = 1
			INNER JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
	WHERE 	cr.intakeserviceid = v_intakeserviceid 	AND cr.activeflag = 1 
	/*CASE COMPLETED TIMELINE INFO*/
	UNION ALL
	(SELECT 		 4 as intaketype 
				, 'casecompleted'::character varying trantype
				, idc.intakeserviceid
				, isr.servicerequestnumber
				, r.insertedon 
				, up1.firstname || '  ' || up1.lastname as  assignedto 
				, up2.firstname || '  ' || up2.lastname as assignedby 
	FROM 	intakeservicerequestdispositioncode idc
			INNER JOIN 	intakeserreqstatustype st ON st.intakeserreqstatustypeid = idc.intakeserreqstatustypeid AND st.activeflag = 1
						AND intakeserreqstatustypekey='Completed'
			INNER JOIN 	routing r ON r.objectid = idc.intakeservicerequestdispositioncodeid::CHARACTER VARYING  AND r.eventcode ='INDR' AND r.routingstatustypeid = 16
			INNER JOIN 	userprofile up1 ON up1.securityusersid = r.tosecurityusersid
			INNER JOIN 	userprofile up2 ON up2.securityusersid = r.fromsecurityusersid 
			INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = idc.intakeserviceid AND isr.activeflag = 1 
	WHERE idc.intakeserviceid = v_intakeserviceid LIMIT 1)		
	/*APPEAL TIMELINE INFO*/
	UNION ALL 
	SELECT 		 5 as intaketype 
				, 'appeal'::character varying trantype
				, isr.intakeserviceid
				, isr.servicerequestnumber
				, r.insertedon 
				, up1.firstname || '  ' || up1.lastname as  assignedto 
				, up2.firstname || '  ' || up2.lastname as assignedby 
	FROM 	intakeservicerequest isr
			INNER JOIN 	routing r ON r.objectid = isr.intakeserviceid::CHARACTER VARYING  AND r.eventcode ='APPL'
						AND r.routingstatustypeid = 15 AND r.toroleid ='CWAPPEALCO'
			INNER JOIN 	userprofile up1 ON up1.securityusersid = r.tosecurityusersid
			INNER JOIN 	userprofile up2 ON up2.securityusersid = r.fromsecurityusersid  
	WHERE isr.intakeserviceid =v_intakeserviceid AND isr.activeflag = 1 
	UNION ALL
	/*ASSIGNMENT END TIMELINE INFO*/
	SELECT	 6 as intaketype
			, 'assignmentend'::character varying trantype
			, isr.intakeserviceid
			, isr.servicerequestnumber
			, ca.enddate 
			, up1.firstname || '  ' || up1.lastname as  assignedto 
			, up2.firstname || '  ' || up2.lastname as assignedby 
	FROM 	IntakeserviceRequest  isr 
			INNER JOIN 	caseassignment ca ON ca.objectid = isr.intakeserviceid AND ca.activeflag = 1 AND ca.enddate IS NOT NULL 
			INNER JOIN 	UserProfile up1 ON up1.securityusersid = ca.toworkeridno  
			INNER JOIN 	UserProfile up2 ON up2.securityusersid = ca.fromworkeridno  
	WHERE 	isr.intakeserviceid = v_intakeserviceid 	AND isr.activeflag = 1 
	
	ORDER BY  transdate ASC;

    END IF;
END;
$function$
;
