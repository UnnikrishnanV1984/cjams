DROP FUNCTION if exists cjams.getdsdsactionsummarydtls(character varying, character varying);
DROP FUNCTION if exists cjams.getdsdsactionsummarydtls(character varying, character varying, character varying, integer);
DROP FUNCTION if exists cjams.getdsdsactionsummarydtls(character varying, character varying, character varying, integer, integer);
DROP FUNCTION if exists cjams.getdsdsactionsummarydtls(character varying, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getdsdsactionsummarydtls(servicereqnumber character varying, loginsecurityuserid character varying, isExpungementSuperUser integer DEFAULT 0,isexpunged integer DEFAULT 0::integer)
 RETURNS getdsdsactionsummarydtls_type
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 02/26/2022 Vineet Tirodkar - Modifications to get all active workers and thier Supervisors (CIDM-4296)
-- 05/23/2014 Amiya Pradhan - CPS Response Timer Update CIDM-8867: B-175011- Closing AR/IR cases without completed initial contact 
-- 09/08/2025 Veera Nadimpalli  - To get case county id CIDM-10751
-- 11/17/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
------------------------------------------------------------------------------------------------------------
DECLARE	
result_record getdsdsactionsummarydtls_type;
daStatusTypeId uuid;
v_intakeserviceid uuid;
v_intakeservreqinputtypeid uuid;
v_intakeserreqstatustypeid uuid;
v_intakeservicerequestclassid uuid;
v_IntakeServReqTypeId uuid;
v_DAType character varying;
v_DASubtype character varying;
v_FocusName	character varying;
v_FocusRole	character varying;
v_Identifier character varying;
v_ldReceivedDate TIMESTAMP(3);
v_Region VARCHAR(50);
v_County VARCHAR(50);
v_familyWorkerId character varying;
v_zip character varying;
v_status  character varying;                                   
v_disposition character varying;
v_AssignedTo character varying;
v_CompletedBy character varying;
v_duedateoffset int;
v_intakenumber character varying;
v_headofhousehold character varying;
l_assigncount bigint;
l_supervisorcount bigint;
v_isexpunged int;                                                                                                                                                 
v_intakeserviceid_exp uuid;

BEGIN

	v_isexpunged = 0;
	IF isExpungementSuperUser= 1 THEN
		v_isexpunged = isexpunged;
	END IF;

    RAISE NOTICE 'DEBUG 2: v_isexpunged=% for servicereqnumber=%', v_isexpunged, servicereqnumber;
    
    -- Determine fully / partial / normal expungement

    IF v_isexpunged = 1 THEN

            --------------------------------------------------------------------
            -- FULLY EXPUNGED CASE: existing ENCRYPTED logic (* tables)
            --------------------------------------------------------------------

            SELECT tm.loadnumber into result_record.da_loadnumber
            FROM userprofile u 
            INNER JOIN   teammemberassignment tma ON tma.SecurityUsersId =  u.SecurityUsersId AND tma.activeflag =1
            INNER JOIN  teammember tm on tm.teammemberid = tma.teammemberid AND tm.activeflag =1
            WHERE u.activeflag =1   AND u.SecurityUsersId = loginsecurityuserid;

            select 
            servicerequestnumber,
            ReportedDate,
            narrativeUpdatedDate,
            intakeservreqinputtypeid,
            intakeservreqtypeid,
            intakeservicerequestclassid,
            intakeserviceid,
            IntakeServReqTypeId,
            intakeserreqstatustypeid,
            Insertedon,
            intakenumber,
            intakenumber,
            countyid,
            hascisdata,
            (select  rt.typedescription  from  responsibilitytype  rt    where  rt.responsibilitytypekey  =  responsibilitytypekey  limit  1),
            (select concat_ws(' ',coalesce(per.firstname,null),coalesce(per.middlename,null),coalesce(per.lastname,null),coalesce(per.suffix,null) )  
                  from expunge.intakeservicerequestactor_expunge isra
                 join person per on per.personid = isra.personid and isra.activeflag = 1  
                 where  ISRA.intakeserviceid=v_intakeserviceid AND  isra.isheadofhousehold=true	 LIMIT 1),
            responsetimer,
            untimely

            into  
            result_record.DA_Number,  
            result_record.DA_ReceivedDate,
            result_record.narrativeUpdatedDate,
            result_record.DA_Communicationid,
            result_record.da_typeid,
            result_record.da_subtypeid,
            v_intakeserviceid ,
            v_IntakeServReqTypeId,
            daStatusTypeId,
            result_record.DA_insertedon,
            result_record.intakenumber,
            v_intakenumber,
            result_record.countyid,
            result_record.hascisdata,
            result_record.da_responsibilitytypekey,
            v_headofhousehold,
            result_record.da_responsetime,
            result_record.untimely
            from  expunge.IntakeServiceRequest_expunge  where  ServiceRequestNumber  =  servicereqnumber;  

            select teamtypekey into result_record.Teamtypekey from  Intakeagencypurpose where intakeservreqtypeid = result_record.da_typeid
                and activeflag =1; 

            select classkey into result_record.DA_Subtype from servicerequestsubtype where ServiceRequestSubTypeId = result_record.da_subtypeid;

            select intakeservreqtypekey into result_record.DA_Type from intakeservicerequesttype where IntakeServReqTypeId = v_IntakeServReqTypeId;
            
            select description into result_record.DA_Status from IntakeSerReqStatusType where IntakeSerReqStatusTypeId = daStatusTypeId;

            select Description into result_record.DA_Disposition from ServiceRequestTypeConfigDispositionCode where ServiceRequestTypeConfigIdDispostionId in (
            select ServiceRequestTypeConfigIdDispostionId from IntakeServiceRequestDispositionCode where IntakeServiceId = v_intakeserviceid and activeflag = 1 order by insertedon desc limit 1);

            select typedescription into result_record.DA_Role from ActorType where actortype in (
            select FocusRoletype from ServiceRequestTypeConfig where IntakeServReqTypeId = v_IntakeServReqTypeId 
            and ServiceRequestSubTypeId = result_record.da_subtypeid and ActiveFlag =1);

            select case when count(1) > 0  then 1 else 0 end into result_record.caseconnectsent  from routing where eventcode = 'SCCR' and servicerequestnumber = servicereqnumber and activeflag = 1;

            IF result_record.Teamtypekey = 'CW' then
                
                select INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
                CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename)
                               ELSE '' END),P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
                               into result_record.DA_Focus,result_record.da_focusProfilePhoto,
                result_record.persondob,result_record.assistpid,result_record.cjamspid ,result_record.persondod,result_record.personid
                from person as P where personid in (
                select PersonId from actor where ActorId in (
                select Actorid  from expunge.IntakeServiceRequestActor_expunge where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('LG') limit 1));
            
                Select coalesce(personidentifiervalue,null) into result_record.DA_Identifier  from PersonIdentifier where personid in (
                select PersonId from actor where ActorId in (
                select Actorid  from expunge.IntakeServiceRequestActor_expunge where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('LG') limit 1)) and personidentifiertypekey = 'DCN';

            ELSE
                select INITCAP(TRIM(P.lastname)||
                case when P.suffix IS NOT NULL AND P.suffix != '' then ' ' || P.suffix ELSE '' end  
                || ', '||TRIM(P.firstname) ||
                CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ' ' || TRIM(P.middlename)
                               ELSE '' END),P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
                               into result_record.DA_Focus,result_record.da_focusProfilePhoto,
                result_record.persondob,result_record.assistpid,result_record.cjamspid ,result_record.persondod,result_record.personid
                from person as P where personid in (
                select PersonId from actor where ActorId in (
                select Actorid  from expunge.IntakeServiceRequestActor_expunge where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('RA','RC', 'Youth') limit 1));
            
                
                Select coalesce(personidentifiervalue,null) into result_record.DA_Identifier  from PersonIdentifier where personid in (
                select PersonId from actor where ActorId in (
                select Actorid  from expunge.IntakeServiceRequestActor_expunge where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('RA','RC', 'Youth') limit 1)) and personidentifiertypekey = 'DCN';
            
            
            END IF;

            select  zipcode into result_record.DA_Zip from PersonAddress where PersonAddressId in  (
            select RoutingAddressId  from expunge.IntakeServiceRequestActor_expunge where intakeserviceid = v_intakeserviceid and RoutingAddressId IS NOT NULL);

            IF result_record.DA_Status = 'Closed' THEN
            select string_agg(TRIM(lastname) ||', ' ||TRIM(firstname),'|') into result_record.da_completedby from UserProfile where SecurityUsersId in (select SecurityUsersId from SecurityUsers where SecurityUsersId in (
            select SecurityUsersId from TeamMemberAssignment where TeamMemberId  in(select  TeamMemberId from AreaTeamMemberServiceRequest 
            where IntakeServiceId = v_intakeserviceid) and ActiveFlag = 1));
            END IF;

            select ca.toworkeridno, ca.toldssid  into v_familyWorkerId, result_record.DA_County  from caseassignment ca where ca.objectid = v_intakeserviceid and
                ca.responsibilitytypekey = 'family' and ca.activeflag = 1 and ca.enddate is NULL
            ORDER BY 
                ca.startdate DESC LIMIT 1;

            IF v_familyWorkerId is not null THEN
            
            SELECT CAST(u1.firstname||' '||u1.lastname AS character varying) into result_record.da_assignedto
            FROM	userprofile u1
            where
            u1.securityusersid = v_familyWorkerId and u1.activeflag = 1;
            
            ELSE
            
            SELECT  CAST(u1.firstname||' '||u1.lastname AS character varying) into result_record.da_assignedto
            FROM	routing r
                    LEFT JOIN userprofile u1 ON u1.securityusersid = r.tosecurityusersid AND r.activeflag = 1
            WHERE 
                    r.objectid = v_intakeserviceid::character varying
            ORDER BY 
                    r.insertedon DESC LIMIT 1;
            
            END IF;
                    
            SELECT count(DISTINCT supervisorid) into l_supervisorcount FROM v_userprofile WHERE securityusersid = loginsecurityuserid;

            IF l_supervisorcount > 1 THEN
                SELECT 
                    (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby 
                FROM v_userprofile vup
                WHERE vup.securityusersid = loginsecurityuserid and countyid in (
                    select fromldssid from caseassignment where toworkeridno = loginsecurityuserid
                    and objectid = v_intakeserviceid 
                    order by enddate NULLS FIRST ) limit 1;
            ELSIF l_supervisorcount = 1 THEN
                SELECT 
                    (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby
                FROM v_userprofile vup WHERE vup.securityusersid = loginsecurityuserid limit 1;
            ELSE 
                SELECT  
                    (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby
                FROM routing r 
                LEFT JOIN v_userprofile vup ON vup.securityusersid = r.fromsecurityusersid
                WHERE r.objectid = v_intakeserviceid::character varying ORDER BY r.insertedon DESC LIMIT 1;
            END IF;

            IF result_record.DA_Zip is not null THEN

            select apsregion into result_record.da_region from county where zipcode::character varying =  TRIM(result_record.DA_Zip);

            ELSIF result_record.DA_Zip is null and result_record.DA_County is not null THEN
            select apsregion into result_record.da_region from county where countyname =  result_record.DA_County;
            END IF;

            select investigationid,intakeserviceid into result_record.da_investigationid,result_record.intakeserviceid from expunge.investigation_expunge where intakeserviceid = v_intakeserviceid and activeflag=1;

            select duedateoffset into v_duedateoffset from servicerequesttypeconfig where intakeservreqtypeid  = v_IntakeServReqTypeId and servicerequestsubtypeid = result_record.da_subtypeid and activeflag =1 and category= 'Intake' limit 1;

             result_record.da_duedate:= result_record.DA_ReceivedDate::date +v_duedateoffset;

            result_record.da_daystogo:= result_record.da_duedate::date - current_date;

            IF result_record.da_daystogo < 0 THEN
            result_record.da_daystogo = 0;
            END IF;

            select groupnumber into result_record.da_groupnumber  from IntakeServiceRequestGroup where groupid in (select groupid from intakeservicerequestgroupdetails where intakeserviceid = v_intakeserviceid);
            
            select intakeservreqinputtypekey into result_record.DA_Communication from intakeservicerequestinputtype where intakeservreqinputtypeid = result_record.DA_Communicationid;

            select complaintid into result_record.DA_Complaintid from intakeservicerequestevaluation where objectid ::uuid = v_intakeserviceid;

            select (UP.lastname||', '||UP.firstname) into result_record.DA_IntakeWorker 
            from routing as R
            Join expunge.intakeservicerequest_expunge as ISR
                 On ISR.intakenumber = R.objectid
            Join userprofile as UP 
                 On UP.securityusersid = R.tosecurityusersid and UP.activeflag=1
             Where ISR.intakeserviceid = v_intakeserviceid
             	and R.toroleid  ='CWIW' 
            limit 1;
             
            select ischildsafe into result_record.da_unsafe from assessment where objectid ::uuid = v_intakeserviceid and activeflag=1;
            select reporterlastname || ', ' || reporterfirstname  as reportername 
            , reporterincidentdate , intakedaterecieved 
            into result_record.da_reportername
            , result_record.da_reporterincidentdate, result_record.da_intakedaterecieved
            from expunge.intakeservicerequest_expunge where intakeserviceid = v_intakeserviceid;

            SELECT 1 INTO result_record.isenablekinship from intakeservicerequestservice ISS 
            INNER JOIN intakeservicerequestsubservice ISST ON ISST.intakeservreqserviceid = ISS.intakeservreqserviceid AND ISST.activeflag =1 
            AND ISST.intakeservsubtypekey ='KN'
            WHERE ISS.activeflag =1 AND iss.intakeserviceid =v_intakeserviceid;
            result_record.isenablekinship:= coalesce(result_record.isenablekinship,0);

            select FT.foldertypekey,FT.description into result_record.foldertypekey,result_record.foldertypedescription from foldertype as FT
            Join expunge.intakeservicerequest_expunge as ISR
                 On ISR.foldertypekey = FT.foldertypekey
            Where ISR.intakeserviceid = v_intakeserviceid and FT.activeflag=1; 

            SELECT isrd.insertedon INTO result_record.case_closedate 
            FROM intakeservicerequestdispositioncode ISRD
                INNER JOIN  intakeserreqstatustype ISTT 
                    on ISRD.intakeserreqstatustypeid=ISTT.intakeserreqstatustypeid and ISTT.activeflag=1 and ISRD.activeflag=1
            where ISRD.intakeserviceid=v_intakeserviceid and ISTT.intakeserreqstatustypekey='Closed';

            SELECT sc.servicecasenumber,sc.servicecaseid 
            	INTO result_record.servicecasenumber,result_record.servicecaseid
            FROM servicecase sc
            LEFT JOIN expunge.intakeservicerequest_expunge isr ON isr.servicecaseid = sc.servicecaseid
            WHERE sc.activeflag=1 
            	and isr.intakeserviceid = v_intakeserviceid
           		-- AND isr.servicerequestnumber =servicereqnumber
           	;
                    
            IF COALESCE( result_record.servicecasenumber,'') <>'' THEN 
                result_record.caseconnectsent=2;
            END IF;
            result_record.caseconnectsent:= COALESCE(result_record.caseconnectsent,0);

            if(select count(1) >0 from intakeserreqrestitution inr where inr.intakeserviceid =v_intakeserviceid)
            then 
            result_record.isrestitution := true;
            else if (select count(1) >0 from intakeservicerequestcourthearing where intakenumber =v_intakenumber and hearingtypekey='Resti')
            then
            result_record.isrestitution := true;
            end if;
            end if;

            SELECT   json_agg(worker) INTO result_record.responsibleworkers
            FROM   (
              SELECT
                ca.responsibilitytypekey,
                ca.startdate::date,
                ca.enddate::date,
                up.firstname,
                up.lastname,
                up.email,
                (
                  SELECT
                    json_agg(e) as address
                  FROM
                    (
                      SELECT
                        upa.address,
                        upa.city,
                        upa.county,
                        upa.state,
                        upa.country,
                        upa.zipcode
                      FROM
                        userprofileaddress upa
                      where
                        upa.securityusersid = up.securityusersid
                    ) e
                ),
                (select upp.phonenumber from userprofilephonenumber upp where upp.securityusersid = up.securityusersid and upp.activeflag =1 limit 1)
                , up.supervisorid
                ,(select UP1.firstname || ' ' || UP1.lastname
                        from userprofile UP1
                    where up1.securityusersid = up.supervisorid	
                    ) as supervisorname
                FROM caseassignment ca
                    INNER JOIN userprofile up on up.securityusersid = ca.toworkeridno  
                        AND up.activeflag = 1
                WHERE ca.objectid = v_intakeserviceid
                    and ca.enddate is null 
                ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) DESC
            ) worker;

    ELSIF v_isexpunged = 2 THEN
        --------------------------------------------------------------------
        -- PARTIALLY EXPUNGED CASE: add UNIONs (normal + encr)
        --------------------------------------------------------------------
        SELECT tm.loadnumber into result_record.da_loadnumber
        FROM userprofile u
        INNER JOIN teammemberassignment tma ON tma.SecurityUsersId = u.SecurityUsersId AND tma.activeflag = 1
        INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag = 1
        WHERE u.activeflag = 1 AND u.SecurityUsersId = loginsecurityuserid;
        select
        isr.servicerequestnumber,
        isr.ReportedDate,
        isr.narrativeUpdatedDate,
        isr.intakeservreqinputtypeid,
        isr.intakeservreqtypeid,
        isr.intakeservicerequestclassid,
        isr.intakeserviceid,
        isr.IntakeServReqTypeId,
        isr.intakeserreqstatustypeid,
        isr.Insertedon,
        isr.intakenumber,
        isr.intakenumber,
        isr.countyid,
        isr.hascisdata,
        (select rt.typedescription from responsibilitytype rt where rt.responsibilitytypekey = isr.responsibilitytypekey limit 1),
        (
            select concat_ws(' ',coalesce(tab.firstname,null),
                coalesce(tab.middlename,null),
                coalesce(tab.lastname,null),
                coalesce(tab.suffix,null))
            from (
                select per.firstname, per.middlename, per.lastname, per.suffix
                from IntakeServiceRequestActor isra
                join person per on per.personid = isra.personid
                where isra.intakeserviceid = isr.intakeserviceid
                and isra.activeflag = 1
                and isra.isheadofhousehold = true
                union all
                select per.firstname, per.middlename, per.lastname, per.suffix
                from expunge.intakeservicerequestactor_expunge isra
                join person per on per.personid = isra.personid
                where isra.intakeserviceid = isr.intakeserviceid
                and isra.activeflag = 1
                and isra.isheadofhousehold = true
            ) tab
            LIMIT 1
        ),
        isr.responsetimer,
        isr.untimely
        into
        result_record.DA_Number,
        result_record.DA_ReceivedDate,
        result_record.narrativeUpdatedDate,
        result_record.DA_Communicationid,
        result_record.da_typeid,
        result_record.da_subtypeid,
        v_intakeserviceid,
        v_IntakeServReqTypeId,
        daStatusTypeId,
        result_record.DA_insertedon,
        result_record.intakenumber,
        v_intakenumber,
        result_record.countyid,
        result_record.hascisdata,
        result_record.da_responsibilitytypekey,
        v_headofhousehold,
        result_record.da_responsetime,
        result_record.untimely
        from  intakeServiceRequest isr where ServiceRequestNumber = servicereqnumber and activeflag  = 1;                                   

        select teamtypekey into result_record.Teamtypekey from  Intakeagencypurpose where intakeservreqtypeid = result_record.da_typeid
            and activeflag =1; 

        select classkey into result_record.DA_Subtype from servicerequestsubtype where ServiceRequestSubTypeId = result_record.da_subtypeid;

        select intakeservreqtypekey into result_record.DA_Type from intakeservicerequesttype where IntakeServReqTypeId = v_IntakeServReqTypeId;
                
        select description into result_record.DA_Status from IntakeSerReqStatusType where IntakeSerReqStatusTypeId = daStatusTypeId;

        select Description into result_record.DA_Disposition from ServiceRequestTypeConfigDispositionCode where ServiceRequestTypeConfigIdDispostionId in (
        select ServiceRequestTypeConfigIdDispostionId from IntakeServiceRequestDispositionCode where IntakeServiceId = v_intakeserviceid and activeflag = 1 order by insertedon desc limit 1);

        select typedescription into result_record.DA_Role from ActorType where actortype in (
        select FocusRoletype from ServiceRequestTypeConfig where IntakeServReqTypeId = v_IntakeServReqTypeId 
        and ServiceRequestSubTypeId = result_record.da_subtypeid and ActiveFlag =1);

        select case when count(1) > 0  then 1 else 0 end into result_record.caseconnectsent  from routing where eventcode = 'SCCR' and servicerequestnumber = servicereqnumber and activeflag = 1;

        IF result_record.Teamtypekey = 'CW' then
            
            select INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
            CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename)
            ELSE '' END),P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
            into result_record.DA_Focus,result_record.da_focusProfilePhoto,
            result_record.persondob,result_record.assistpid,result_record.cjamspid ,result_record.persondod,result_record.personid
            from person as P where personid in (
            select PersonId from actor where ActorId in (
            select ActorId from (
            select isra.ActorId
            from IntakeServiceRequestActor isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('LG')
            union all
            select isra.ActorId
            from expunge.IntakeServiceRequestActor_expunge isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('LG')
            ) x limit 1));
        
            Select coalesce(personidentifiervalue,null) into result_record.DA_Identifier  from PersonIdentifier where personid in (
            select PersonId from actor where ActorId in (
            select ActorId from (
            select isra.ActorId
            from IntakeServiceRequestActor isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('LG')
            union all
            select isra.ActorId
            from expunge.IntakeServiceRequestActor_expunge isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('LG')
            ) x limit 1)) and personidentifiertypekey = 'DCN';

        ELSE
            select INITCAP(TRIM(P.lastname)||
            case when P.suffix IS NOT NULL AND P.suffix != '' then ' ' || P.suffix ELSE '' end  
            || ', '||TRIM(P.firstname) ||
            CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ' ' || TRIM(P.middlename)
                        ELSE '' END),P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
                        into result_record.DA_Focus,result_record.da_focusProfilePhoto,
            result_record.persondob,result_record.assistpid,result_record.cjamspid ,result_record.persondod,result_record.personid
            from person as P where personid in (
            select PersonId from actor where ActorId in (
            select ActorId from (
            select isra.ActorId
            from IntakeServiceRequestActor isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('RA','RC', 'Youth')
            union all
            select isra.ActorId
            from expunge.IntakeServiceRequestActor_expunge isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('RA','RC', 'Youth')
            ) x limit 1));
        
            
            Select coalesce(personidentifiervalue,null) into result_record.DA_Identifier  from PersonIdentifier where personid in (
            select PersonId from actor where ActorId in (
            select ActorId from (
            select isra.ActorId
            from IntakeServiceRequestActor isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('RA','RC', 'Youth')
            union all
            select isra.ActorId
            from expunge.IntakeServiceRequestActor_expunge isra
            where isra.intakeserviceid = v_intakeserviceid and isra.intakeservicerequestpersontypekey in ('RA','RC', 'Youth')
            ) x limit 1)) and personidentifiertypekey = 'DCN';
        
        
        END IF;

        select  zipcode into result_record.DA_Zip from PersonAddress where PersonAddressId in  (
        select RoutingAddressId  from (
        select RoutingAddressId  from IntakeServiceRequestActor where intakeserviceid = v_intakeserviceid and RoutingAddressId IS NOT NULL
        union all
        select RoutingAddressId  from expunge.IntakeservicerequestActor_expunge where intakeserviceid = v_intakeserviceid and RoutingAddressId IS NOT NULL
        ) x);

        IF result_record.DA_Status = 'Closed' THEN
        select string_agg(TRIM(lastname) ||', ' ||TRIM(firstname),'|') into result_record.da_completedby from UserProfile where SecurityUsersId in (select SecurityUsersId from SecurityUsers where SecurityUsersId in (
        select SecurityUsersId from TeamMemberAssignment where TeamMemberId  in(select  TeamMemberId from AreaTeamMemberServiceRequest 
        where IntakeServiceId = v_intakeserviceid) and ActiveFlag = 1));
        END IF;

        select ca.toworkeridno, ca.toldssid  into v_familyWorkerId, result_record.DA_County  from caseassignment ca where ca.objectid = v_intakeserviceid and
            ca.responsibilitytypekey = 'family' and ca.activeflag = 1 and ca.enddate is NULL
        ORDER BY 
            ca.startdate DESC LIMIT 1;

        IF v_familyWorkerId is not null THEN
        
        SELECT CAST(u1.firstname||' '||u1.lastname AS character varying) into result_record.da_assignedto
        FROM	userprofile u1
        where
        u1.securityusersid = v_familyWorkerId and u1.activeflag = 1;
        
        ELSE
        
        SELECT  CAST(u1.firstname||' '||u1.lastname AS character varying) into result_record.da_assignedto
        FROM	routing r
                LEFT JOIN userprofile u1 ON u1.securityusersid = r.tosecurityusersid AND r.activeflag = 1
        WHERE 
                r.objectid = v_intakeserviceid::character varying
        ORDER BY 
                r.insertedon DESC LIMIT 1;
        
        END IF;
                
        SELECT count(DISTINCT supervisorid) into l_supervisorcount FROM v_userprofile WHERE securityusersid = loginsecurityuserid;

        IF l_supervisorcount > 1 THEN
            SELECT 
                (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby 
            FROM v_userprofile vup
            WHERE vup.securityusersid = loginsecurityuserid and countyid in (
                select fromldssid from caseassignment where toworkeridno = loginsecurityuserid
                and objectid = v_intakeserviceid 
                order by enddate NULLS FIRST ) limit 1;
        ELSIF l_supervisorcount = 1 THEN
            SELECT 
                (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby
            FROM v_userprofile vup WHERE vup.securityusersid = loginsecurityuserid limit 1;
        ELSE 
            SELECT  
                (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby
            FROM routing r 
            LEFT JOIN v_userprofile vup ON vup.securityusersid = r.fromsecurityusersid
            WHERE r.objectid = v_intakeserviceid::character varying ORDER BY r.insertedon DESC LIMIT 1;
        END IF;

        IF result_record.DA_Zip is not null THEN

        select apsregion into result_record.da_region from county where zipcode::character varying =  TRIM(result_record.DA_Zip);

        ELSIF result_record.DA_Zip is null and result_record.DA_County is not null THEN
        select apsregion into result_record.da_region from county where countyname =  result_record.DA_County;
        END IF;

        select investigationid,intakeserviceid into result_record.da_investigationid,result_record.intakeserviceid
        from (
        select investigationid,intakeserviceid from investigation where intakeserviceid = v_intakeserviceid and activeflag=1
        union all
        select investigationid,intakeserviceid from expunge.investigation_expunge where intakeserviceid = v_intakeserviceid and activeflag=1
        ) inv;

        select duedateoffset into v_duedateoffset from servicerequesttypeconfig where intakeservreqtypeid  = v_IntakeServReqTypeId and servicerequestsubtypeid = result_record.da_subtypeid and activeflag =1 and category= 'Intake' limit 1;

        result_record.da_duedate:= result_record.DA_ReceivedDate::date +v_duedateoffset;

        result_record.da_daystogo:= result_record.da_duedate::date - current_date;

        IF result_record.da_daystogo < 0 THEN
        result_record.da_daystogo = 0;
        END IF;

        select groupnumber into result_record.da_groupnumber  from IntakeServiceRequestGroup where groupid in (select groupid from intakeservicerequestgroupdetails where intakeserviceid = v_intakeserviceid);
        
        select intakeservreqinputtypekey into result_record.DA_Communication from intakeservicerequestinputtype where intakeservreqinputtypeid = result_record.DA_Communicationid;

        select complaintid into result_record.DA_Complaintid from intakeservicerequestevaluation where objectid ::uuid = v_intakeserviceid;

        select (UP.lastname||', '||UP.firstname) into result_record.DA_IntakeWorker from routing as R
        Join intakeservicerequest as ISR
            On ISR.intakenumber = R.objectid
        Join userprofile as UP 
            On UP.securityusersid = R.tosecurityusersid and UP.activeflag=1
        Where R.toroleid  ='CWIW'  limit 1;
        
        select ischildsafe into result_record.da_unsafe from assessment where objectid ::uuid = v_intakeserviceid and activeflag=1;
        select reporterlastname || ', ' || reporterfirstname as reportername 
        , reporterincidentdate , intakedaterecieved 
        into result_record.da_reportername
        , result_record.da_reporterincidentdate, result_record.da_intakedaterecieved
        from intakeservicerequest where intakeserviceid = v_intakeserviceid;

        SELECT 1 INTO result_record.isenablekinship from intakeservicerequestservice ISS 
        INNER JOIN intakeservicerequestsubservice ISST ON ISST.intakeservreqserviceid = ISS.intakeservreqserviceid AND ISST.activeflag =1 
        AND ISST.intakeservsubtypekey ='KN'
        WHERE ISS.activeflag =1 AND iss.intakeserviceid =v_intakeserviceid;
        result_record.isenablekinship:= coalesce(result_record.isenablekinship,0);

        select FT.foldertypekey,FT.description into result_record.foldertypekey,result_record.foldertypedescription from foldertype as FT
        Join intakeservicerequest as ISR
            On ISR.foldertypekey = FT.foldertypekey
        Where ISR.intakeserviceid = v_intakeserviceid and FT.activeflag=1; 

        SELECT isrd.insertedon INTO result_record.case_closedate 
        FROM intakeservicerequestdispositioncode ISRD
            INNER JOIN  intakeserreqstatustype ISTT 
                on ISRD.intakeserreqstatustypeid=ISTT.intakeserreqstatustypeid and ISTT.activeflag=1 and ISRD.activeflag=1
        where ISRD.intakeserviceid=v_intakeserviceid and ISTT.intakeserreqstatustypekey='Closed';

        SELECT sc.servicecasenumber,sc.servicecaseid INTO result_record.servicecasenumber,result_record.servicecaseid
        FROM servicecase sc
        LEFT JOIN intakeservicerequest isr ON isr.servicecaseid=sc.servicecaseid
        WHERE sc.activeflag=1 AND isr.servicerequestnumber =servicereqnumber;
                
        IF COALESCE( result_record.servicecasenumber,'') <>'' THEN 
            result_record.caseconnectsent=2;
        END IF;
        result_record.caseconnectsent:= COALESCE(result_record.caseconnectsent,0);

        if(select count(1) >0 from intakeserreqrestitution inr where inr.intakeserviceid =v_intakeserviceid)
        then 
        result_record.isrestitution := true;
        else if (select count(1) >0 from intakeservicerequestcourthearing where intakenumber =v_intakenumber and hearingtypekey='Resti')
        then
        result_record.isrestitution := true;
        end if;
        end if;

        SELECT   json_agg(worker) INTO result_record.responsibleworkers
        FROM   (
        SELECT
            ca.responsibilitytypekey,
            ca.startdate::date,
            ca.enddate::date,
            up.firstname,
            up.lastname,
            up.email,
            (
            SELECT
                json_agg(e) as address
            FROM
                (
                SELECT
                    upa.address,
                    upa.city,
                    upa.county,
                    upa.state,
                    upa.country,
                    upa.zipcode
                FROM
                    userprofileaddress upa
                where
                    upa.securityusersid = up.securityusersid
                ) e
            ),
            (select upp.phonenumber from userprofilephonenumber upp where upp.securityusersid = up.securityusersid and upp.activeflag =1 limit 1)
            , up.supervisorid
            ,(select UP1.firstname || ' ' || UP1.lastname
                    from userprofile UP1
                where up1.securityusersid = up.supervisorid	
                ) as supervisorname
            FROM caseassignment ca
                INNER JOIN userprofile up on up.securityusersid = ca.toworkeridno  
                    AND up.activeflag = 1
            WHERE ca.objectid = v_intakeserviceid
                and ca.enddate is null 
            ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) DESC
        ) worker;

    ELSE

        ------------------------------------------------------------------------
        -- CURRENT LOGIC QUERY (non-expunged, original function body)
        ------------------------------------------------------------------------

        SELECT tm.loadnumber into result_record.da_loadnumber
        FROM userprofile u 
        INNER JOIN   teammemberassignment tma ON tma.SecurityUsersId =  u.SecurityUsersId AND tma.activeflag =1
        INNER JOIN  teammember tm on tm.teammemberid = tma.teammemberid AND tm.activeflag =1
        WHERE u.activeflag =1   AND u.SecurityUsersId = loginsecurityuserid;

        select 
        servicerequestnumber,
        ReportedDate,
        narrativeUpdatedDate,
        intakeservreqinputtypeid,
        intakeservreqtypeid,
        intakeservicerequestclassid,
        intakeserviceid,
        IntakeServReqTypeId,
        intakeserreqstatustypeid,
        Insertedon,
        intakenumber,
        intakenumber,
        countyid,
        hascisdata,
        (select  rt.typedescription  from  responsibilitytype  rt    where  rt.responsibilitytypekey  =  IntakeServiceRequest.responsibilitytypekey  limit  1),
        (select concat_ws(' ',coalesce(per.firstname,null),coalesce(per.middlename,null),coalesce(per.lastname,null),coalesce(per.suffix,null) )  
            from intakeservicerequestactor isra
            join person per on per.personid = isra.personid and isra.activeflag = 1  
            where  ISRA.intakeserviceid=v_intakeserviceid AND  isra.isheadofhousehold=true	 LIMIT 1),
        responsetimer,
        untimely

        into  
        result_record.DA_Number,  
        result_record.DA_ReceivedDate,
        result_record.narrativeUpdatedDate,
        result_record.DA_Communicationid,
        result_record.da_typeid,
        result_record.da_subtypeid,
        v_intakeserviceid ,
        v_IntakeServReqTypeId,
        daStatusTypeId,
        result_record.DA_insertedon,
        result_record.intakenumber,
        v_intakenumber,
        result_record.countyid,
        result_record.hascisdata,
        result_record.da_responsibilitytypekey,
        v_headofhousehold,
        result_record.da_responsetime,
        result_record.untimely
        from  IntakeServiceRequest  where  ServiceRequestNumber  =  servicereqnumber
            and activeflag  = 1;  

        select teamtypekey into result_record.Teamtypekey from  Intakeagencypurpose where intakeservreqtypeid = result_record.da_typeid
        and activeflag =1; 

        /*Commented for Demo
        select split_part(entityroletypekey,'|',1),split_part(entityroletypekey,'|',2) into result_record.DA_Type,result_record.DA_Subtype from ServiceRequestTypeConfigRole where ServiceRequestTypeConfigId  in (
        select ServiceRequestTypeConfigId from ServiceRequestTypeConfig where ActiveFlag =1 
        and IntakeServReqTypeId = v_IntakeServReqTypeId and ServiceRequestSubTypeId = result_record.da_subtypeid
        ) and EntityRoleType = 'DisplayValue';*/

        select classkey into result_record.DA_Subtype from servicerequestsubtype where ServiceRequestSubTypeId = result_record.da_subtypeid;

        select intakeservreqtypekey into result_record.DA_Type from intakeservicerequesttype where IntakeServReqTypeId = v_IntakeServReqTypeId;
        
        select description into result_record.DA_Status from IntakeSerReqStatusType where IntakeSerReqStatusTypeId = daStatusTypeId;

        select Description into result_record.DA_Disposition from ServiceRequestTypeConfigDispositionCode where ServiceRequestTypeConfigIdDispostionId in (
        select ServiceRequestTypeConfigIdDispostionId from IntakeServiceRequestDispositionCode where IntakeServiceId = v_intakeserviceid and activeflag = 1 order by insertedon desc limit 1);

        select typedescription into result_record.DA_Role from ActorType where actortype in (
        select FocusRoletype from ServiceRequestTypeConfig where IntakeServReqTypeId = v_IntakeServReqTypeId 
        and ServiceRequestSubTypeId = result_record.da_subtypeid and ActiveFlag =1);

        select case when count(1) > 0  then 1 else 0 end into result_record.caseconnectsent  from routing where eventcode = 'SCCR' and servicerequestnumber = servicereqnumber and activeflag = 1;

        IF result_record.Teamtypekey = 'CW' then
            
            select INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
            CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename)
                        ELSE '' END),P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
                        into result_record.DA_Focus,result_record.da_focusProfilePhoto,
            result_record.persondob,result_record.assistpid,result_record.cjamspid ,result_record.persondod,result_record.personid
            from person as P where personid in (
            select PersonId from actor where ActorId in (
            select Actorid  from IntakeServiceRequestActor where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('LG') limit 1));
        
            Select coalesce(personidentifiervalue,null) into result_record.DA_Identifier  from PersonIdentifier where personid in (
        select PersonId from actor where ActorId in (
        select Actorid  from IntakeServiceRequestActor where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('LG') limit 1)) and personidentifiertypekey = 'DCN';

        ELSE
            select INITCAP(TRIM(P.lastname)||
            case when P.suffix IS NOT NULL AND P.suffix != '' then ' ' || P.suffix ELSE '' end  
            || ', '||TRIM(P.firstname) ||
            CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ' ' || TRIM(P.middlename)
                        ELSE '' END),P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
                        into result_record.DA_Focus,result_record.da_focusProfilePhoto,
            result_record.persondob,result_record.assistpid,result_record.cjamspid ,result_record.persondod,result_record.personid
            from person as P where personid in (
            select PersonId from actor where ActorId in (
            select Actorid  from IntakeServiceRequestActor where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('RA','RC', 'Youth') limit 1));
        
            
            Select coalesce(personidentifiervalue,null) into result_record.DA_Identifier  from PersonIdentifier where personid in (
            select PersonId from actor where ActorId in (
            select Actorid  from IntakeServiceRequestActor where intakeserviceid = v_intakeserviceid and intakeservicerequestpersontypekey in ('RA','RC', 'Youth') limit 1)) and personidentifiertypekey = 'DCN';
        
        
        END IF;

        select  zipcode into result_record.DA_Zip from PersonAddress where PersonAddressId in  (
        select RoutingAddressId  from IntakeServiceRequestActor where intakeserviceid = v_intakeserviceid and RoutingAddressId IS NOT NULL);

    --	select string_agg(TRIM(lastname) ||', ' ||TRIM(firstname),'|') into result_record.da_assignedto from UserProfile where SecurityUsersId in (select SecurityUsersId from SecurityUsers where SecurityUsersId in (
    --	select SecurityUsersId from TeamMemberAssignment where TeamMemberId  in(select  TeamMemberId from AreaTeamMemberServiceRequest 
    --	where IntakeServiceId = v_intakeserviceid) and ActiveFlag = 1));

        IF result_record.DA_Status = 'Closed' THEN
        select string_agg(TRIM(lastname) ||', ' ||TRIM(firstname),'|') into result_record.da_completedby from UserProfile where SecurityUsersId in (select SecurityUsersId from SecurityUsers where SecurityUsersId in (
        select SecurityUsersId from TeamMemberAssignment where TeamMemberId  in(select  TeamMemberId from AreaTeamMemberServiceRequest 
        where IntakeServiceId = v_intakeserviceid) and ActiveFlag = 1));
        END IF;

        select ca.toworkeridno, ca.toldssid  into v_familyWorkerId, result_record.DA_County  from caseassignment ca where ca.objectid = v_intakeserviceid and
        ca.responsibilitytypekey = 'family' and ca.activeflag = 1 and ca.enddate is NULL
        ORDER BY 
            ca.startdate DESC LIMIT 1;

        IF v_familyWorkerId is not null THEN
        
        SELECT CAST(u1.firstname||' '||u1.lastname AS character varying) into result_record.da_assignedto
        FROM	userprofile u1
        where
        u1.securityusersid = v_familyWorkerId and u1.activeflag = 1;
        
        ELSE
        
        SELECT  CAST(u1.firstname||' '||u1.lastname AS character varying) into result_record.da_assignedto
        FROM	routing r
                -- LEFT JOIN caseassignment ca ON ca.objectid::character varying = r.objectid
                LEFT JOIN userprofile u1 ON u1.securityusersid = r.tosecurityusersid AND r.activeflag = 1
        WHERE 
                r.objectid = v_intakeserviceid::character varying
        ORDER BY 
                r.insertedon DESC LIMIT 1;
        
        END IF;
                
        --## SHOW UNIT SUPERVISOR ON BLUE RIBBON WHEN EVER OPEN A CASE

        SELECT count(DISTINCT supervisorid) into l_supervisorcount FROM v_userprofile WHERE securityusersid = loginsecurityuserid;

        IF l_supervisorcount > 1 THEN
            SELECT 
                (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby 
            FROM v_userprofile vup
            WHERE vup.securityusersid = loginsecurityuserid and countyid in (
                select fromldssid from caseassignment where toworkeridno = loginsecurityuserid
                and objectid = v_intakeserviceid 
                order by enddate NULLS FIRST ) limit 1;
        ELSIF l_supervisorcount = 1 THEN
            SELECT 
                (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby
            FROM v_userprofile vup WHERE vup.securityusersid = loginsecurityuserid limit 1;
        ELSE 
            SELECT  
                (select fullname from userprofile u where u.securityusersid = vup.supervisorid ) into result_record.da_assignedby
            FROM routing r 
            LEFT JOIN v_userprofile vup ON vup.securityusersid = r.fromsecurityusersid
            WHERE r.objectid = v_intakeserviceid::character varying ORDER BY r.insertedon DESC LIMIT 1;
        END IF;

        IF result_record.DA_Zip is not null THEN

        select apsregion into result_record.da_region from county where zipcode::character varying =  TRIM(result_record.DA_Zip);

        ELSEIF result_record.DA_Zip is null and result_record.DA_County != null THEN
        select apsregion into result_record.da_region from county where countyname =  result_record.DA_County;
        END IF;

        select investigationid,intakeserviceid into result_record.da_investigationid,result_record.intakeserviceid from investigation where intakeserviceid = v_intakeserviceid and activeflag=1;

        select duedateoffset into v_duedateoffset from servicerequesttypeconfig where intakeservreqtypeid  = v_IntakeServReqTypeId and servicerequestsubtypeid = result_record.da_subtypeid and activeflag =1 and category= 'Intake' limit 1;

        result_record.da_duedate:= result_record.DA_ReceivedDate::date +v_duedateoffset;

        result_record.da_daystogo:= result_record.da_duedate::date - current_date;

        IF result_record.da_daystogo < 0 THEN
        result_record.da_daystogo = 0;
        END IF;

        --For Fetching Group NUMBER

        select groupnumber into result_record.da_groupnumber  from IntakeServiceRequestGroup where groupid in (select groupid from intakeservicerequestgroupdetails where intakeserviceid = v_intakeserviceid);
        
        -- Fetch Intake JSON
        
        /*select jsondata into result_record.intake_jsondata from intakedastaging s join intakeservicerequest isr on s.intakenumber = isr.intakenumber
            where isr.intakeserviceid = v_intakeserviceid and isr.activeflag = 1 and s.activeflag = 1 order by s.insertedon desc limit 1; */

            --select null into result_record.intake_jsondata
            
            --For Fetching Communication
        select intakeservreqinputtypekey into result_record.DA_Communication from intakeservicerequestinputtype where intakeservreqinputtypeid = result_record.DA_Communicationid;

        --For Fetching Evaluation ComplaintID
        select complaintid into result_record.DA_Complaintid from intakeservicerequestevaluation where objectid ::uuid = v_intakeserviceid;

            --For Fetching Intake Worker
        select (UP.lastname||', '||UP.firstname) into result_record.DA_IntakeWorker from routing as R
        Join intakeservicerequest as ISR
            On ISR.intakenumber = R.objectid
        Join userprofile as UP 
            On UP.securityusersid = R.tosecurityusersid and UP.activeflag=1
        Where isr.intakeserviceid = v_intakeserviceid
            and isr.activeflag  = 1
            and R.toroleid  ='CWIW'  limit 1;
        
        --For Fetching Unsafe flag
        select ischildsafe into result_record.da_unsafe from assessment where objectid ::uuid = v_intakeserviceid and activeflag=1;
        select reporterlastname || ', ' ||reporterfirstname  as reportername 
        , reporterincidentdate , intakedaterecieved 
        into result_record.da_reportername
        , result_record.da_reporterincidentdate, result_record.da_intakedaterecieved
        from intakeservicerequest where intakeserviceid = v_intakeserviceid 
        and activeflag  = 1;

        SELECT 1 INTO result_record.isenablekinship from intakeservicerequestservice ISS 
        INNER JOIN intakeservicerequestsubservice ISST ON ISST.intakeservreqserviceid = ISS.intakeservreqserviceid AND ISST.activeflag =1 
        AND ISST.intakeservsubtypekey ='KN'
        WHERE ISS.activeflag =1 AND iss.intakeserviceid =v_intakeserviceid;
        result_record.isenablekinship:= coalesce(result_record.isenablekinship,0);

        --For Fetching Folder Type
        select FT.foldertypekey,FT.description into result_record.foldertypekey,result_record.foldertypedescription from foldertype as FT
        Join intakeservicerequest as ISR
            On ISR.foldertypekey = FT.foldertypekey
        Where ISR.intakeserviceid = v_intakeserviceid and FT.activeflag=1
            and isr.activeflag  = 1; 

        /*SELECT exitdate INTO result_record.case_closedate 
        FROM intakeservicerequest 
        WHERE intakeserviceid =v_intakeserviceid	AND activeflag =1;*/

        SELECT isrd.insertedon INTO result_record.case_closedate 
        FROM intakeservicerequestdispositioncode ISRD
            INNER JOIN  intakeserreqstatustype ISTT 
                on ISRD.intakeserreqstatustypeid=ISTT.intakeserreqstatustypeid and ISTT.activeflag=1 and ISRD.activeflag=1
        where ISRD.intakeserviceid=v_intakeserviceid and ISTT.intakeserreqstatustypekey='Closed';

        SELECT sc.servicecasenumber,sc.servicecaseid INTO result_record.servicecasenumber,result_record.servicecaseid
        FROM servicecase sc
        LEFT JOIN intakeservicerequest isr ON isr.servicecaseid=sc.servicecaseid
            and isr.activeflag  = 1
        WHERE sc.activeflag=1 
            AND isr.servicerequestnumber =servicereqnumber;
                
        IF COALESCE( result_record.servicecasenumber,'') <>'' THEN 
            result_record.caseconnectsent=2;
        END IF;
        result_record.caseconnectsent:= COALESCE(result_record.caseconnectsent,0);
        --	select true into result_record.isrestitution ;
        -- check weather restitution alredy exist or not :
        if(select count(1) >0 from intakeserreqrestitution inr where inr.intakeserviceid =v_intakeserviceid)
        then 
        result_record.isrestitution := true;
        else if (select count(1) >0 from intakeservicerequestcourthearing where intakenumber =v_intakenumber and hearingtypekey='Resti')
        then
        result_record.isrestitution := true;
        end if;
        end if;

        SELECT   json_agg(worker) INTO result_record.responsibleworkers
            FROM   (
            SELECT
                ca.responsibilitytypekey,
                ca.startdate::date,
                ca.enddate::date,
                up.firstname,
                up.lastname,
                up.email,
                (
                SELECT
                    json_agg(e) as address
                FROM
                    (
                    SELECT
                        upa.address,
                        upa.city,
                        upa.county,
                        upa.state,
                        upa.country,
                        upa.zipcode
                    FROM
                        userprofileaddress upa
                    where
                        upa.securityusersid = up.securityusersid
                    ) e
                ),
                (select upp.phonenumber from userprofilephonenumber upp where upp.securityusersid = up.securityusersid and upp.activeflag =1 limit 1)
                , up.supervisorid
                ,(select UP1.firstname || ' ' || UP1.lastname
                        from userprofile UP1
                    where up1.securityusersid = up.supervisorid	
                    ) as supervisorname
                FROM caseassignment ca
                    INNER JOIN userprofile up on up.securityusersid = ca.toworkeridno  
                        AND up.activeflag = 1
                WHERE ca.objectid = v_intakeserviceid
                    -- and lower(ca.responsibilitytypekey) in ( 'family', 'child' )
                    and ca.enddate is null 
                ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) DESC
            ) worker;

    END IF;

    RETURN result_record;

END;

$function$
;
