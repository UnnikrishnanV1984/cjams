DROP FUNCTION if exists getalldarecordings(searchjson json);
DROP FUNCTION if exists getalldarecordings(searchjson json, character varying, integer);
DROP FUNCTION if exists getalldarecordings(searchjson json, character varying, integer, integer);
DROP FUNCTION if exists getalldarecordings(searchjson json, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getalldarecordings(
    searchjson json,
    isExpungementSuperUser integer DEFAULT 0,
    isexpunged integer DEFAULT 0::integer)
 RETURNS TABLE(totalcount bigint, isintake character varying, others text, uploadedfile json, progressnoteid uuid, progressnotetypeid uuid, progressnotesubtypeid uuid, progressnotereasontypekey character varying, traveltime character varying, totaltime character varying, 
 progressnotepurposetypekey character varying, description text, focusperson json, author character varying, recordingtype character varying, locationname character varying, recordingsubtype text, progressnotereasontypedescription character varying, title character varying, team character varying, 
 draft boolean, attemptind boolean, contactdate timestamp without time zone, contactname character varying, progressroletype jsonb, contactparticipant jsonb, progressnotecontacttrialvisit jsonb, iseditable boolean, contactphone character varying, contactemail character varying, 
 archivedon timestamp without time zone, archivedby character varying, detail text, recordingdate timestamp without time zone, insertedby character varying, documentpropertiesid uuid, doctitle character varying, docdescription character varying, filename character varying, mime character varying, 
 s3bucketpathname character varying, starttime timestamp without time zone, endtime timestamp without time zone, stafftype character varying, instantresults integer, contactstatus boolean, drugscreen boolean, progressnotepurposetype character varying, progressnotereason jsonb, notedetails jsonb,
 initiationindicator boolean, witsid character varying, recordingtypedescription character varying, entitytypeid character varying, entitytype character varying, qualityofcaretochildtext character varying, screeningfortheservicetext character varying, adjustmentfostercaretext character varying, 
 ischildgotoshool boolean, old_id character varying, updatedon timestamp without time zone, mioptions character varying, delayreasons character varying, hasdelay boolean)
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--Revision(s)
--09/07/2022 - Vijaya Laxmi Devunoori - CDM-23621
--Get all notes to include for the intakeservicecaseId for ServiceCase (Case Connect)
-- 09-16-22 - Veera Nadimpalli - CDM-19078
-- 11-22-2022 - Veera Nadimpalli - CDM-22458
--07-28-2023- CIDM-7168--Umasankar Raavi-- Fetching document insertedby  name
--09-18-2023- Palani/Chandra Query tuning (CIDM-7945)
--01-25-2024 - Sreekanth Marrikanti CDM-36719 - progressnotereasontypekey many to many search changes
--04-22-2024 - Vinesh Puthan - CDM-44314 -Duplicate contact notes displayed for mutli county user
-- 11/17/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-- 02/07/2026 -Sreekanth Marrikanti - CIDM-11090 - Applied sorting & pagination to improve stored proc performance
-- 03/10/2026 -Sreekanth Marrikanti - CDM-44727 - Fix to correct contact date sorting when there is no start & end times
-- 04/13/2025 - Vinesh Puthan - CIDM-11321 - Fix to return Motivational interview options for progress notes
-- 06/10/2026 - Raghavendra Puli - CIDM-11381 - fetching delayreasons, hasdelay values of progressnote
-- 07/17/2026 - Vinesh Puthan - CIDM-11321 - Fix to add motivational interview columns check as the part of expungement cases.
----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- SET NOCOUNT ON added to prevent extra result sets from                                  
-- interfering with SELECT statements.                                  
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED                                                                
                                                                                   
DECLARE v_GroupId CHAR(36);                                                                          
v_IntakeServiceID character varying(50);                    
v_RecordingStatusType  character varying(50);                        
v_DateFrom TIMESTAMP;                        
v_DateTo TIMESTAMP;                        
v_Draft BOOLEAN;                        
v_ContactFrom TIMESTAMP;                        
v_ContactTo TIMESTAMP;  
v_GroupActiveFlag INT;  
v_GroupExpirationDate TIMESTAMP;
v_liPageNumber  INT;                              
v_liPageSize   INT;
v_pageoffset int;
v_pagenumber int;  
v_progressnotereasontypekey  character varying;
v_caseworkername character varying;
v_note character varying;
v_sort_by  character varying;
v_sort_dir character varying;
v_progresstype character varying;
v_progresssubtype character varying;
v_actor text;
v_progressnoteInsertedby character varying;
v_uuidornot character varying(50);
v_isexpunged integer;
v_nolimit boolean;
BEGIN


 -- Populate the variables from the temp table.  
                                                                   
v_liPageNumber        := searchjson ->> 'pagenumber' ;
v_liPageSize          := searchjson ->> 'pagesize' ;                                                
v_Draft               := searchjson ->>'draft';                          
v_IntakeServiceID     := searchjson ->>'servicerequestid';                      
v_DateFrom            := searchjson ->>'datefrom';                                                              
v_DateTo              := searchjson ->>'dateto';                      
v_ContactFrom         := searchjson ->>'contactdatefrom';                                                              
v_ContactTo           := searchjson ->>'contactdateto';                                                    
v_RecordingStatusType := searchjson ->>'type';  
v_progressnotereasontypekey := searchjson ->>'progressnotereasontypekey';
v_caseworkername := searchjson ->>'workerName';
v_note := searchjson ->>'note';
v_sort_by := searchjson ->>'sortBy';
v_sort_dir := COALESCE(searchjson ->>'sortDir', 'desc');
v_pagenumber := v_liPageNumber-1;
v_pageoffset = v_pagenumber * v_liPageSize;
v_progresstype := searchjson ->> 'recordingtype' ;
v_progresssubtype := searchjson ->> 'recordingsubtype';
v_actor := (searchjson ->> 'intakeservicerequestactorids') :: text;
v_progressnoteInsertedby := searchjson ->> 'insertedby';
v_nolimit := (searchjson ->> 'nolimit'):: boolean;

RAISE NOTICE 'v_actor %', v_actor;

SELECT * INTO v_uuidornot FROM uuid_or_null(v_IntakeServiceID);

v_isexpunged = 0;
IF isExpungementSuperUser=1 THEN
	v_isexpunged = isexpunged;
END IF;

/*Get adoption case */
IF EXISTS (SELECT * FROM adoptioncase WHERE adoptioncaseid :: character varying =v_IntakeServiceID) THEN
RETURN QUERY
SELECT * FROM getalldarecordingsadoptioncase(searchjson);
ELSE
    IF v_isexpunged=1 THEN
        --------------------------------------------------------------------
        -- FULLY EXPUNGED: ENCRYPTED ONLY
        --------------------------------------------------------------------
        RETURN QUERY
        SELECT  
        count(1) over(),
        PN.isintake,PN.otherpersonname::text,
        (CASE WHEN PN.uploadedfile IS NULL THEN jsonb(json_build_object('data',(SELECT json_agg(docs) FROM(
        SELECT dp.documentpropertiesid,dp.objecttypekey,dp.title,dp.actualdocumentdate,dp.documenttypekey,dp.insertedon,dp.updatedon,
        (SELECT up.fullname AS insertedby FROM userprofile up WHERE up.securityusersid=dp.insertedby),
        dp.updatedby,dp.documentdate,dp.mime,dp.s3bucketpathname,dp.description,dp.other,dp.filename,dp.numberofbytes,dp.originalfilename,dp.other,
        (SELECT row_to_json(x) AS documentattachment FROM(
        SELECT dat.documentpropertiesid,dat.attachmenttypekey,dat.attachmentclassificationtypekey,dat.attachmentclassificationsubtypekey,dat.assessmenttemplateid,
        (SELECT up.fullname AS updatedby FROM userprofile up WHERE up.securityusersid=dat.updatedby) FROM documentattachment dat
        WHERE dat.documentpropertiesid=dp.documentpropertiesid)x),
        dp.uploadstatus,
        dp.finalstatus,
        dp.ecmsdocumentid
        FROM documentproperties dp WHERE dp.additionalobjectid=PN.progressnoteid::varchar AND dp.additionalobjecttype='progressnote' AND dp.activeflag IN(1,3,4,5)
        )docs)))::json ELSE PN.uploadedfile::json END) AS uploadedfile,
        PN.progressnoteid,
        PN.progressnotetypeid,
        PN.progressnotesubtypeid,
        PN.progressnotereasontypekey::character varying,
        PN.traveltime::character varying,
        PN.totaltime::character varying,
        PN.progressnotepurposetypekey,
        PN.description::text,
        PN.focusperson::json,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END AS author,
        COALESCE(PNT.progressnotetypekey,'') AS recordingtype,
        PN.locationname::character varying,
        COALESCE((SELECT pns.description FROM progressnotesubtype pns WHERE pns.progressnotesubtypeid=PN.progressnotesubtypeid),'') AS recordingsubtype,
        COALESCE((SELECT pnrt.typedescription FROM progressnotereasontype pnrt WHERE pnrt.progressnotereasontypekey=PN.progressnotereasontypekey::character varying),'') AS progressnotereasontypedescription,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN '' ELSE COALESCE(TM.roletypekey,'') END AS title,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN '' ELSE COALESCE(TE.teamname,'') END AS team,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 0::boolean ELSE COALESCE(PN.savemode,0::boolean) END AS draft,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN NULL ELSE PN.attemptindicator END AS attemptind,
        CAST(COALESCE(PN.contactdate,PN.insertedon) AS timestamp(3)) AS contactdate,
        COALESCE(PN.contactname,'') AS contactname,
        (SELECT json_agg(roletype) FROM(SELECT prt.contactroletypekey,prt.progressnoteroletypeid FROM progressnoteroletype prt WHERE prt.progressnoteid=PN.progressnoteid AND prt.activeflag=1)roletype)::jsonb AS progressroletype,
        (SELECT json_agg(actor) FROM(
        SELECT cp.contactparticipantid,cp.participanttypekey,cp.intakeservicerequestactorid,
        cp.address1,
        cp.address2,
        cp.city,
        cp.state,
        cp.zipcode::character varying,
        cp.email,
        cp.phonenumber::character varying,
        isra.personid,
        COALESCE(p.prefx,'') AS prefx,
        COALESCE(p.firstname,'') AS firstname,
        COALESCE(p.middlename,'') AS middlename,
        COALESCE(p.lastname,'') AS lastname,
        COALESCE(p.suffix,'') AS suffix,
        isra.actorid::text AS actorid,
        at.actortype,
        at.typedescription,
        (SELECT json_agg(childroles) FROM(
        SELECT DISTINCT typedescription FROM actortype at WHERE at.actortype IN(
        SELECT isa.intakeservicerequestpersontypekey FROM expunge.intakeservicerequestactor_expunge isa
        WHERE isa.actorid=isra.actorid AND isa.activeflag=1))childroles)::jsonb AS childroles
        FROM expunge.contactparticipant_expunge cp
        JOIN expunge.intakeservicerequestactor_expunge isra ON isra.intakeservicerequestactorid=cp.intakeservicerequestactorid
        JOIN person p ON p.personid=isra.personid
        LEFT JOIN actortype at ON at.actortype=isra.intakeservicerequestpersontypekey
        WHERE cp.progressnoteid=PN.progressnoteid AND cp.activeflag=1 AND cp.participanttypekey IS DISTINCT FROM 'COLLATERAL'
        UNION
        SELECT cp.contactparticipantid,cp.participanttypekey,cp.intakeservicerequestactorid,
        cp.address1,
        cp.address2,
        cp.city,
        cp.state,
        cp.zipcode::character varying,
        cp.email,
        cp.phonenumber::character varying,
        c.collateralid,
        COALESCE(c.prefixtypekey,'') AS prefx,
        COALESCE(c.firstname,'') AS firstname,
        COALESCE(c.middlename,'') AS middlename,
        COALESCE(c.lastname,'') AS lastname,
        COALESCE(c.suffixtypekey,'') AS suffix,
        cc.collateralid::text AS actorid,
        at.actortype,
        at.typedescription,
        NULL AS childroles
        FROM expunge.contactparticipant_expunge cp
        LEFT JOIN collateral c ON c.collateralid=cp.intakeservicerequestactorid AND c.activeflag=1
        LEFT JOIN collateralroleconfig cc ON c.collateralid=cc.collateralid AND cc.activeflag=1
        LEFT JOIN actortype at ON at.actortype=cc.actortypekey
        WHERE cp.progressnoteid=PN.progressnoteid AND cp.activeflag=1 AND cp.participanttypekey='COLLATERAL'
        )actor)::jsonb AS contactparticipant,
        (SELECT json_agg(contacttrialvisit) FROM(
        SELECT ctv.contacttrialvisitid,ctv.progressnoteid,ctv.issuedesc,ctv.safetydesc,ctv.services_childdesc,ctv.services_parentdesc,ctv.permanencystepdesc,
        ctv.placementdesc,ctv.educationdesc,ctv.healthdesc,ctv.socialareadesc,ctv.financialliteracydesc,ctv.familyplanningdesc,ctv.skillissuedesc,ctv.transitionplandesc
        FROM contacttrialvisit ctv WHERE ctv.progressnoteid=PN.progressnoteid AND ctv.activeflag=1)contacttrialvisit)::jsonb AS progressnotecontacttrialvisit,
        ((EXTRACT(DAY FROM now() AT TIME ZONE 'utc'-PN.insertedon AT TIME ZONE 'utc')))<=7 AS iseditable,
        COALESCE(PN.contactphone,'') AS contactphone,
        COALESCE(PN.contactemail,'') AS contactemail,
        COALESCE(PN.archivedon,NULL) AS archivedon,
        COALESCE(PN.archivedby,'') AS archivedby,
        (SELECT string_agg(COALESCE(A.description,''||'rn'),'|') FROM(
        SELECT UPF.displayname,PND.insertedon,
        PND.description
        FROM expunge.progressnotedetail_expunge PND
        JOIN userprofile UPF ON PND.insertedby=UPF.securityusersid
        WHERE PND.progressnoteid=PN.progressnoteid AND PND.activeflag=1 AND PND.isaddendum=0
        ORDER BY PND.insertedon DESC LIMIT 1)A) AS detail,
        CAST(COALESCE(PN.insertedon,PN.insertedon) AS timestamp(3)) AS recordingdate,
        PN.insertedby AS insertedby,
        DP.documentpropertiesid,DP.title AS doctitle,DP.description AS docdescription,DP.filename,DP.mime,DP.s3bucketpathname,
        PN.starttime::timestamp AS starttime,PN.endtime::timestamp AS endtime,PN.stafftypekey AS stafftype,PN.instantresults AS instantresults,PN.contactstatus AS contactstatus,
        PN.drugscreen AS drugscreen,COALESCE(PNPT.description,'') AS progressnotepurposetype,
        (SELECT json_agg(progressnotereasons) FROM(
        SELECT prtc.progressnotereasontypeconfigid,prtc.progressnoteid,prtc.personid,prtc.name,prtc.primaryphoneno,prtc.email,prtc.relationship,
        p.firstname||' '||p.lastname AS personname
        FROM progressnotereasontypeconfig prtc
        LEFT JOIN person p ON p.personid=prtc.personid
        WHERE prtc.progressnoteid=PN.progressnoteid AND prtc.activeflag=1)progressnotereasons)::jsonb AS progressnotereason,
        (SELECT json_agg(detailnote) FROM(
        SELECT UPF.displayname,PND.insertedon,PND.description,pntin.progressnotetypekey
        FROM expunge.progressnotedetail_expunge PND
        JOIN userprofile UPF ON PND.insertedby=UPF.securityusersid
        JOIN progressnotetype pntin ON pntin.progressnotetypeid=PN.progressnotetypeid
        WHERE PND.progressnoteid=PN.progressnoteid AND PND.activeflag=1 AND PND.isaddendum=1
        ORDER BY PND.insertedon DESC)detailnote)::jsonb AS notedetails,
        PN.initiationindicator,
        PN.witsid::character varying,
        PNT.description::character varying AS recordingtypedescription,
        PN.entitytypeid,
        PN.entitytype::character varying,
        PN.qualityofcaretochildtext::character varying,
        PN.screeningfortheservicetext::character varying,
        PN.adjustmentfostercaretext::character varying,
        PN.ischildgotoshool,
        PN.old_id,
        PN.updatedon,
        NULL::character varying AS mioptions,
        NULL::character varying AS delayreasons,
        NULL::boolean AS hasdelay
        FROM expunge.progressnote_expunge AS PN
        INNER JOIN progressnotetype AS PNT ON PNT.progressnotetypeid=PN.progressnotetypeid
        LEFT JOIN userprofile up ON PN.insertedby=up.securityusersid
        LEFT JOIN documentproperties DP ON DP.documentpropertiesid=PN.documentpropertiesid
        LEFT JOIN teammemberassignment tma ON tma.teammemberassignmentid=(
        SELECT t.teammemberassignmentid FROM teammemberassignment t WHERE t.securityusersid=up.securityusersid AND t.activeflag=1 ORDER BY insertedon ASC LIMIT 1)
        LEFT JOIN teammember tm ON tm.teammemberid=tma.teammemberid AND tm.activeflag=1
        LEFT JOIN team te ON te.teamid=tm.teamid AND te.activeflag=1
        LEFT JOIN progressnoteroletype AS PNRT ON PN.progressnoteid=PNRT.progressnoteid AND PNRT.activeflag=1
        LEFT JOIN progressnotepurposetype AS PNPT ON PNPT.progressnotepurposetypekey=PN.progressnotepurposetypekey AND PNRT.activeflag=1
        LEFT JOIN progressnotesubtype PNST ON PNST.progressnotesubtypeid = PN.progressnotesubtypeid AND PNST.activeflag = 1
        WHERE
        (
        PN.entitytypeid IN (v_IntakeServiceID::character varying)
        OR
        (CASE WHEN v_uuidornot IS NULL THEN NULL ELSE
        PN.entitytypeid IN(
        (SELECT intakeserviceid::character varying FROM expunge.intakeservicerequest_expunge isr
        WHERE servicecaseid=v_IntakeServiceID::uuid AND activeflag=1 AND intakeserviceid IS NOT NULL ORDER BY isr.updatedon DESC LIMIT 1),
        (SELECT DISTINCT intakenumber
        FROM expunge.intakeservicerequest_expunge
        WHERE (servicecaseid=v_IntakeServiceID::uuid OR intakeserviceid=v_IntakeServiceID::uuid) AND intakenumber IS NOT NULL LIMIT 1)
        ) END)
        )
        AND PNT.progressnoteclassificationtypekey ILIKE 'user'
        AND PN.activeflag=1
        AND (v_DateFrom IS NULL OR (DATE(PN.insertedon) BETWEEN CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))
        AND (v_ContactFrom IS NULL OR (DATE(PN.contactdate) BETWEEN CAST(v_ContactFrom AS DATE) AND CAST(v_ContactTo AS DATE)))
        AND (v_Draft IS NULL OR PN.savemode=v_Draft)
        AND (v_caseworkername IS NULL OR LOWER(UP.displayname) LIKE '%'||LOWER(v_caseworkername)||'%')
        AND (v_note IS NULL OR LOWER(PN.description) LIKE '%'||LOWER(v_note)||'%')
        AND (v_progressnotereasontypekey IS NULL OR commaseparatedstringcheck(v_progressnotereasontypekey,PN.progressnotereasontypekey))
        AND (LOWER(v_RecordingStatusType) IS NULL OR LOWER(COALESCE(PNT.progressnoteclassificationtypekey,'User'))=LOWER(v_RecordingStatusType))
        AND (v_progresssubtype IS NULL OR PN.progressnotesubtypeid=v_progresssubtype::uuid)
        AND (v_progresstype IS NULL OR PNT.progressnotetypeid=v_progresstype::uuid)
        AND (v_progressnoteInsertedby IS NULL OR PN.insertedby::character varying=v_progressnoteInsertedby OR PN.updatedby::character varying=v_progressnoteInsertedby)
        AND(
          v_actor IS NULL OR
          PN.progressnoteid IN(
            SELECT cp.progressnoteid
            FROM expunge.contactparticipant_expunge cp
            WHERE cp.progressnoteid=PN.progressnoteid
              AND cp.activeflag=1
              AND(
                v_actor IS NULL
                OR cp.intakeservicerequestactorid::character varying = ANY(
                  SELECT * FROM jsonb_array_elements_text((v_actor)::jsonb)
                )
              )
          )
        )
        ORDER BY 
          ( CASE v_sort_dir
              WHEN 'asc'
                THEN
                  CASE v_sort_by
                    WHEN 'contactdate' THEN COALESCE(PN.starttime, PN.contactdate)::character varying
                    WHEN 'progressnotereasontypekey' THEN PN.progressnotereasontypekey
                    WHEN 'author' THEN (CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END)::character varying  
                    WHEN 'recordingtype' THEN COALESCE(PNT.progressnotetypekey,'')::character varying
                    WHEN 'recordingsubtype' THEN COALESCE(PNST.description,'')::character varying
                    WHEN 'progressnotepurposetypekey' THEN COALESCE(PN.progressnotepurposetypekey, '')::character varying
                    WHEN 'personcontacted' THEN  COALESCE((SELECT D.firstname from
		                                                          ( SELECT COALESCE(p1.firstname, '') AS firstname  
            	                                                    FROM expunge.contactparticipant_expunge cp1
            		                                                    JOIN expunge.intakeservicerequestactor_expunge isra1 on  isra1.intakeservicerequestactorid = cp1.intakeservicerequestactorid
            		                                                    JOIN person p1 on p1.personid = isra1.personid     
            	                                                    WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                    AND cp1.participanttypekey is distinct from 'COLLATERAL'
			                                                          UNION
			                                                          SELECT COALESCE(c1.firstname, '') AS firstname
            	                                                    FROM expunge.contactparticipant_expunge cp1
            		                                                    LEFT JOIN collateral c1 on  c1.collateralid = cp1.intakeservicerequestactorid and c1.activeflag=1
            	                                                      WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                      AND cp1.participanttypekey = 'COLLATERAL'
			                                                        ) D limit 1)::character varying , null):: character varying
                       
                      ELSE 
                        PN.insertedon::character varying
                  END
          END) ASC NULLS last,
          ( CASE v_sort_dir
              WHEN 'desc'
                THEN
                  CASE v_sort_by
                    WHEN 'contactdate' THEN COALESCE(PN.starttime, PN.contactdate)::character varying
                    WHEN 'progressnotereasontypekey' THEN PN.progressnotereasontypekey
                    WHEN 'author' THEN (CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END)::character varying 
                    WHEN 'recordingtype' THEN COALESCE(PNT.progressnotetypekey,'')::character varying
                    WHEN 'recordingsubtype' THEN COALESCE(PNST.description,'')::character varying
                    WHEN 'progressnotepurposetypekey' THEN COALESCE(PN.progressnotepurposetypekey, '')::character varying
                    WHEN 'personcontacted' THEN  COALESCE((SELECT D.firstname from
		                                                          ( SELECT COALESCE(p1.firstname, '') AS firstname  
            	                                                    FROM expunge.contactparticipant_expunge cp1
            		                                                    JOIN expunge.intakeservicerequestactor_expunge isra1 on  isra1.intakeservicerequestactorid = cp1.intakeservicerequestactorid
            		                                                    JOIN person p1 on p1.personid = isra1.personid     
            	                                                    WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                    AND cp1.participanttypekey is distinct from 'COLLATERAL'
			                                                          UNION
			                                                          SELECT COALESCE(c1.firstname, '') AS firstname
            	                                                    FROM expunge.contactparticipant_expunge cp1
            		                                                    LEFT JOIN collateral c1 on  c1.collateralid = cp1.intakeservicerequestactorid and c1.activeflag=1
            	                                                      WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                      AND cp1.participanttypekey = 'COLLATERAL'
			                                                        ) D limit 1)::character varying , null):: character varying
                      ELSE 
                        PN.insertedon::character varying
                  END
          END) DESC NULLS last
        LIMIT (CASE WHEN v_nolimit IS FALSE THEN v_liPageSize ELSE NULL END)
        OFFSET (CASE WHEN v_nolimit IS FALSE THEN v_pageoffset ELSE NULL END);
        
    ELSIF v_isexpunged=2 THEN
        --------------------------------------------------------------------
        -- PARTIAL EXPUNGED: ENCR UNION ALL NORMAL
        --------------------------------------------------------------------
        RETURN QUERY
        SELECT  
        count(1) over(),
        PN.isintake,PN.otherpersonname::text,
        (CASE WHEN PN.uploadedfile IS NULL THEN jsonb(json_build_object('data',(SELECT json_agg(docs) FROM(
        SELECT dp.documentpropertiesid,dp.objecttypekey,dp.title,dp.actualdocumentdate,dp.documenttypekey,dp.insertedon,dp.updatedon,
        (SELECT up.fullname AS insertedby FROM userprofile up WHERE up.securityusersid=dp.insertedby),
        dp.updatedby,dp.documentdate,dp.mime,dp.s3bucketpathname,dp.description,dp.other,dp.filename,dp.numberofbytes,dp.originalfilename,dp.other,
        (SELECT row_to_json(x) AS documentattachment FROM(
        SELECT dat.documentpropertiesid,dat.attachmenttypekey,dat.attachmentclassificationtypekey,dat.attachmentclassificationsubtypekey,dat.assessmenttemplateid,
        (SELECT up.fullname AS updatedby FROM userprofile up WHERE up.securityusersid=dat.updatedby) FROM documentattachment dat
        WHERE dat.documentpropertiesid=dp.documentpropertiesid)x),
        dp.uploadstatus,
        dp.finalstatus,
        dp.ecmsdocumentid
        FROM documentproperties dp WHERE dp.additionalobjectid=PN.progressnoteid::varchar AND dp.additionalobjecttype='progressnote' AND dp.activeflag IN(1,3,4,5)
        )docs)))::json ELSE PN.uploadedfile::json END) AS uploadedfile,
        PN.progressnoteid,
        PN.progressnotetypeid,
        PN.progressnotesubtypeid,
        PN.progressnotereasontypekey,
        PN.traveltime,
        PN.totaltime,
        PN.progressnotepurposetypekey,
        PN.description,
        PN.focusperson,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END AS author,
        COALESCE(PNT.progressnotetypekey,'') AS recordingtype,
        PN.locationname,
        COALESCE((SELECT pns.description FROM progressnotesubtype pns WHERE pns.progressnotesubtypeid=PN.progressnotesubtypeid),'') AS recordingsubtype,
        COALESCE((SELECT pnrt.typedescription FROM progressnotereasontype pnrt WHERE pnrt.progressnotereasontypekey=PN.progressnotereasontypekey),'') AS progressnotereasontypedescription,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN '' ELSE COALESCE(TM.roletypekey,'') END AS title,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN '' ELSE COALESCE(TE.teamname,'') END AS team,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 0::boolean ELSE COALESCE(PN.savemode,0::boolean) END AS draft,
        CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN NULL ELSE PN.attemptindicator END AS attemptind,
        CAST(COALESCE(PN.contactdate,PN.insertedon) AS timestamp(3)) AS contactdate,
        COALESCE(PN.contactname,'') AS contactname,
        (SELECT json_agg(roletype) FROM(SELECT prt.contactroletypekey,prt.progressnoteroletypeid FROM progressnoteroletype prt WHERE prt.progressnoteid=PN.progressnoteid AND prt.activeflag=1)roletype)::jsonb AS progressroletype,
        (SELECT json_agg(actor) FROM(
          SELECT cp.contactparticipantid,cp.participanttypekey,cp.intakeservicerequestactorid,
            cp.address1 AS address1,
            cp.address2 AS address2,
            cp.city AS city,
            cp.state AS state,
            cp.zipcode AS zipcode,
            cp.email AS email,
            cp.phonenumber AS phonenumber,
            isra.personid,
            COALESCE(p.prefx,'') AS prefx,
            COALESCE(p.firstname,'') AS firstname,
            COALESCE(p.middlename,'') AS middlename,
            COALESCE(p.lastname,'') AS lastname,
            COALESCE(p.suffix,'') AS suffix,
            isra.actorid::text AS actorid,
            at.actortype,
            at.typedescription,
             (SELECT json_agg(childroles) FROM(
            SELECT DISTINCT typedescription FROM actortype at WHERE at.actortype IN(
            SELECT isa.intakeservicerequestpersontypekey FROM intakeservicerequestactor isa WHERE isa.actorid=isra.actorid AND isa.activeflag=1
            union
            SELECT isae.intakeservicerequestpersontypekey as intakeservicerequestpersontypekey FROM expunge.intakeservicerequestactor_expunge isae WHERE isae.actorid=isra.actorid AND isae.activeflag=1 
            ))childroles)::jsonb AS childroles
          FROM contactparticipant cp
          JOIN (SELECT 
              iat.actorid,iat.personid,iat.intakeservicerequestactorid,iat.intakeservicerequestpersontypekey
              FROM contactparticipant cp1 
              inner join intakeservicerequestactor iat on cp1.intakeservicerequestactorid = iat.intakeservicerequestactorid
              where iat.isexpunged != 1 and cp1.progressnoteid=PN.progressnoteid AND cp1.activeflag=1 AND cp1.participanttypekey IS DISTINCT FROM 'COLLATERAL'
              UNION
              SELECT
                iatexpunge.actorid,iatexpunge.personid,iatexpunge.intakeservicerequestactorid,iatexpunge.intakeservicerequestpersontypekey
              FROM contactparticipant cp1 
              inner join expunge.intakeservicerequestactor_expunge iatexpunge on cp1.intakeservicerequestactorid = iatexpunge.intakeservicerequestactorid
              where iatexpunge.activeflag = 1 and cp1.progressnoteid=PN.progressnoteid AND cp1.activeflag=1 AND cp1.participanttypekey IS DISTINCT FROM 'COLLATERAL'
          ) isra ON isra.intakeservicerequestactorid=cp.intakeservicerequestactorid
          -- JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=cp.intakeservicerequestactorid
          JOIN person p ON p.personid=isra.personid
          LEFT JOIN actortype at ON at.actortype=isra.intakeservicerequestpersontypekey
          WHERE cp.progressnoteid=PN.progressnoteid AND cp.activeflag=1 AND cp.participanttypekey IS DISTINCT FROM 'COLLATERAL'
          UNION
          SELECT cp.contactparticipantid,cp.participanttypekey,cp.intakeservicerequestactorid,
            cp.address1 AS address1,
            cp.address2 AS address2,
            cp.city AS city,
            cp.state AS state,
            cp.zipcode AS zipcode,
            cp.email AS email,
            cp.phonenumber AS phonenumber,
            c.collateralid,
            COALESCE(c.prefixtypekey,'') AS prefx,
            COALESCE(c.firstname,'') AS firstname,
            COALESCE(c.middlename,'') AS middlename,
            COALESCE(c.lastname,'') AS lastname,
            COALESCE(c.suffixtypekey,'') AS suffix,
            cc.collateralid::text,
            at.actortype,
            at.typedescription,
            NULL AS childroles
          FROM contactparticipant cp
          LEFT JOIN collateral c ON c.collateralid=cp.intakeservicerequestactorid AND c.activeflag=1
          LEFT JOIN collateralroleconfig cc ON c.collateralid=cc.collateralid AND cc.activeflag=1
          LEFT JOIN actortype at ON at.actortype=cc.actortypekey
          WHERE cp.progressnoteid=PN.progressnoteid AND cp.activeflag=1 AND cp.participanttypekey='COLLATERAL'
        )actor)::jsonb AS contactparticipant,
        (SELECT json_agg(contacttrialvisit) FROM(
        SELECT ctv.contacttrialvisitid,ctv.progressnoteid,ctv.issuedesc,ctv.safetydesc,ctv.services_childdesc,ctv.services_parentdesc,ctv.permanencystepdesc,
        ctv.placementdesc,ctv.educationdesc,ctv.healthdesc,ctv.socialareadesc,ctv.financialliteracydesc,ctv.familyplanningdesc,ctv.skillissuedesc,ctv.transitionplandesc
        FROM contacttrialvisit ctv WHERE ctv.progressnoteid=PN.progressnoteid AND ctv.activeflag=1)contacttrialvisit)::jsonb AS progressnotecontacttrialvisit,
        ((EXTRACT(DAY FROM now() AT TIME ZONE 'utc'-PN.insertedon AT TIME ZONE 'utc')))<=7 AS iseditable,
        COALESCE(PN.contactphone,'') AS contactphone,
        COALESCE(PN.contactemail,'') AS contactemail,
        COALESCE(PN.archivedon,NULL) AS archivedon,
        COALESCE(PN.archivedby,'') AS archivedby,
        (SELECT string_agg(COALESCE(A.description,''||'rn'),'|') FROM(
        SELECT UPF.displayname,PND.insertedon,PND.description::text
        FROM progressnotedetail PND
        JOIN userprofile UPF ON PND.insertedby=UPF.securityusersid
        WHERE PND.progressnoteid=PN.progressnoteid AND PND.activeflag=1 AND PND.isaddendum=0
        ORDER BY PND.insertedon DESC LIMIT 1)A) AS detail,
        CAST(COALESCE(PN.insertedon,PN.insertedon) AS timestamp(3)) AS recordingdate,
        PN.insertedby AS insertedby,
        DP.documentpropertiesid,DP.title AS doctitle,DP.description AS docdescription,DP.filename,DP.mime,DP.s3bucketpathname,
        PN.starttime::timestamp AS starttime,PN.endtime::timestamp AS endtime,PN.stafftypekey AS stafftype,PN.instantresults AS instantresults,PN.contactstatus AS contactstatus,
        PN.drugscreen AS drugscreen,COALESCE(PNPT.description,'') AS progressnotepurposetype,
        (SELECT json_agg(progressnotereasons) FROM(
        SELECT prtc.progressnotereasontypeconfigid,prtc.progressnoteid,prtc.personid,prtc.name,prtc.primaryphoneno,prtc.email,prtc.relationship,
        p.firstname||' '||p.lastname AS personname
        FROM progressnotereasontypeconfig prtc
        LEFT JOIN person p ON p.personid=prtc.personid
        WHERE prtc.progressnoteid=PN.progressnoteid AND prtc.activeflag=1)progressnotereasons)::jsonb AS progressnotereason,
        (SELECT json_agg(detailnote) FROM(
        SELECT UPF.displayname,PND.insertedon,PND.description::text,pntin.progressnotetypekey
        FROM progressnotedetail PND
        JOIN userprofile UPF ON PND.insertedby=UPF.securityusersid
        JOIN progressnotetype pntin ON pntin.progressnotetypeid=PN.progressnotetypeid
        WHERE PND.progressnoteid=PN.progressnoteid AND PND.activeflag=1 AND PND.isaddendum=1
        ORDER BY PND.insertedon DESC)detailnote)::jsonb AS notedetails,
        PN.initiationindicator,
        PN.witsid::character varying,
        PNT.description::character varying AS recordingtypedescription,
        PN.entitytypeid,
        PN.entitytype,
        PN.qualityofcaretochildtext,
        PN.screeningfortheservicetext,
        PN.adjustmentfostercaretext,
        PN.ischildgotoshool,
        PN.old_id,
        PN.updatedon,
        PN.mioptions::character varying,
        PN.delayreasons::character varying,
        PN.hasdelay::boolean 
        FROM progressnote AS PN
        INNER JOIN progressnotetype AS PNT ON PNT.progressnotetypeid=PN.progressnotetypeid
        LEFT JOIN userprofile up ON PN.insertedby=up.securityusersid
        LEFT JOIN documentproperties DP ON DP.documentpropertiesid=PN.documentpropertiesid
        LEFT JOIN teammemberassignment tma ON tma.teammemberassignmentid=(
        SELECT t.teammemberassignmentid FROM teammemberassignment t WHERE t.securityusersid=up.securityusersid AND t.activeflag=1 ORDER BY insertedon ASC LIMIT 1)
        LEFT JOIN teammember tm ON tm.teammemberid=tma.teammemberid AND tm.activeflag=1
        LEFT JOIN team te ON te.teamid=tm.teamid AND te.activeflag=1
        LEFT JOIN progressnoteroletype AS PNRT ON PN.progressnoteid=PNRT.progressnoteid AND PNRT.activeflag=1
        LEFT JOIN progressnotepurposetype AS PNPT ON PNPT.progressnotepurposetypekey=PN.progressnotepurposetypekey AND PNRT.activeflag=1
        LEFT JOIN progressnotesubtype PNST ON PNST.progressnotesubtypeid = PN.progressnotesubtypeid AND PNST.activeflag = 1
        WHERE
        (
        PN.entitytypeid IN(v_IntakeServiceID::character varying)
        OR
        (CASE WHEN v_uuidornot IS NULL THEN NULL ELSE
        PN.entitytypeid IN(
        (SELECT intakeserviceid::character varying FROM intakeservicerequest isr
        WHERE servicecaseid=v_IntakeServiceID::uuid AND activeflag=1 AND intakeserviceid IS NOT NULL ORDER BY isr.updatedon DESC LIMIT 1),
        (SELECT DISTINCT intakenumber::character varying FROM intakeservicerequest
        WHERE (servicecaseid=v_IntakeServiceID::uuid OR intakeserviceid=v_IntakeServiceID::uuid) AND intakenumber IS NOT NULL LIMIT 1)
        ) END)
        )
        AND PNT.progressnoteclassificationtypekey ILIKE 'user'
        AND PN.activeflag=1
        AND (v_DateFrom IS NULL OR (DATE(PN.insertedon) BETWEEN CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))
        AND (v_ContactFrom IS NULL OR (DATE(PN.contactdate) BETWEEN CAST(v_ContactFrom AS DATE) AND CAST(v_ContactTo AS DATE)))
        AND (v_Draft IS NULL OR PN.savemode=v_Draft)
        AND (v_caseworkername IS NULL OR LOWER(UP.displayname) LIKE '%'||LOWER(v_caseworkername)||'%')
        AND (v_note IS NULL OR LOWER(PN.description::text) LIKE '%'||LOWER(v_note)||'%')
        AND (v_progressnotereasontypekey IS NULL OR commaseparatedstringcheck(v_progressnotereasontypekey,PN.progressnotereasontypekey))
        AND (LOWER(v_RecordingStatusType) IS NULL OR LOWER(COALESCE(PNT.progressnoteclassificationtypekey,'User'))=LOWER(v_RecordingStatusType))
        AND (v_progresssubtype IS NULL OR PN.progressnotesubtypeid=v_progresssubtype::uuid)
        AND (v_progresstype IS NULL OR PNT.progressnotetypeid=v_progresstype::uuid)
        AND (v_progressnoteInsertedby IS NULL OR PN.insertedby::character varying=v_progressnoteInsertedby OR PN.updatedby::character varying=v_progressnoteInsertedby)
        AND(
          v_actor IS NULL OR
          PN.progressnoteid IN (
            SELECT cp1.progressnoteid
            FROM contactparticipant cp1
            WHERE cp1.progressnoteid=PN.progressnoteid
              AND cp1.activeflag=1
              AND(
                v_actor IS NULL
                OR cp1.intakeservicerequestactorid::character varying = ANY(
                  SELECT * FROM jsonb_array_elements_text((v_actor)::jsonb)
                )
              )           
          )
        )
        ORDER BY 
          ( CASE v_sort_dir
              WHEN 'asc'
                THEN
                  CASE v_sort_by
                    WHEN 'contactdate' THEN COALESCE(PN.starttime, PN.contactdate)::character varying
                    WHEN 'progressnotereasontypekey' THEN PN.progressnotereasontypekey::character varying 
                    WHEN 'author' THEN (CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END)::character varying  
                    WHEN 'recordingtype' THEN COALESCE(PNT.progressnotetypekey,'')::character varying
                    WHEN 'recordingsubtype' THEN COALESCE(PNST.description,'')::character varying
                    WHEN 'progressnotepurposetypekey' THEN COALESCE(PN.progressnotepurposetypekey, '')::character varying
                    WHEN 'personcontacted' THEN  COALESCE((SELECT D.firstname from
		                                                          ( SELECT COALESCE(p1.firstname, '') AS firstname  
            	                                                    FROM contactparticipant cp1
            		                                                    JOIN intakeservicerequestactor isra1 on  isra1.intakeservicerequestactorid = cp1.intakeservicerequestactorid
            		                                                    JOIN person p1 on p1.personid = isra1.personid      
            	                                                    WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                    AND cp1.participanttypekey is distinct from 'COLLATERAL'
			                                                          UNION
			                                                          SELECT COALESCE(c1.firstname, '') AS firstname
            	                                                    FROM contactparticipant cp1
            		                                                    LEFT JOIN collateral c1 on  c1.collateralid = cp1.intakeservicerequestactorid and c1.activeflag=1
            	                                                      WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                      AND cp1.participanttypekey = 'COLLATERAL'
			                                                        ) D limit 1)::character varying , null):: character varying
                      ELSE 
                        PN.insertedon::character varying
                  END
          END) ASC NULLS last,
          ( CASE v_sort_dir
              WHEN 'desc'
                THEN
                  CASE v_sort_by
                    WHEN 'contactdate' THEN COALESCE(PN.starttime, PN.contactdate)::character varying
                    WHEN 'personcontacted' THEN  (CASE WHEN contactparticipant IS NOT NULL THEN (contactparticipant::json->0->>'firstname')::character varying ELSE ''::character varying END)     
                    WHEN 'progressnotereasontypekey' THEN PN.progressnotereasontypekey::character varying  
                    WHEN 'author' THEN (CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END)::character varying  
                    WHEN 'recordingtype' THEN COALESCE(PNT.progressnotetypekey,'')::character varying
                    WHEN 'recordingsubtype' THEN COALESCE(PNST.description,'')::character varying
                    WHEN 'progressnotepurposetypekey' THEN COALESCE(PN.progressnotepurposetypekey, '')::character varying
                    WHEN 'personcontacted' THEN  COALESCE((SELECT D.firstname from
		                                                          ( SELECT COALESCE(p1.firstname, '') AS firstname  
            	                                                    FROM contactparticipant cp1
            		                                                    JOIN intakeservicerequestactor isra1 on  isra1.intakeservicerequestactorid = cp1.intakeservicerequestactorid
            		                                                    JOIN person p1 on p1.personid = isra1.personid      
            	                                                    WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                    AND cp1.participanttypekey is distinct from 'COLLATERAL'
			                                                          UNION
			                                                          SELECT COALESCE(c1.firstname, '') AS firstname
            	                                                    FROM contactparticipant cp1
            		                                                    LEFT JOIN collateral c1 on  c1.collateralid = cp1.intakeservicerequestactorid and c1.activeflag=1
            	                                                      WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                      AND cp1.participanttypekey = 'COLLATERAL'
			                                                        ) D limit 1)::character varying , null):: character varying
                      ELSE 
                        PN.insertedon::character varying
                  END
          END) DESC NULLS last
        LIMIT (CASE WHEN v_nolimit IS FALSE THEN v_liPageSize ELSE NULL END)
        OFFSET (CASE WHEN v_nolimit IS FALSE THEN v_pageoffset ELSE NULL END);
    ELSE
      -- NORMAL ORIGINAL QUERY
      RETURN QUERY
                      
      SELECT  
      count(1) over() ,    
      PN.isintake,PN.otherpersonName::text,
      (case when PN.uploadedfile is null then jsonb(json_build_object ('data',(SELECT json_agg(docs) FROM  (
      SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
      (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
      dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.other,
      (SELECT row_to_json(x) AS documentattachment FROM(                                                                              
      SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
      (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                  
      WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
      ) x),
      dp.uploadstatus,
      dp.finalstatus,
      dp.ecmsdocumentid
      from documentproperties dp where dp.additionalobjectid = PN.progressnoteid::varchar and dp.additionalobjecttype = 'progressnote' and dp.activeflag in (1,3,4,5)
      )docs)))::json else PN.uploadedfile::json end) as uploadedfile,
      PN.ProgressNoteId,      
      PN.progressnotetypeid,
      PN.progressnotesubtypeid,
      PN.Progressnotereasontypekey,
      PN.traveltime,
      PN.totaltime,
      PN.progressnotepurposetypekey,
      PN.description,
      PN.focusperson,
      CASE WHEN (PNT.ProgressNoteClassificationTypeKey = 'System') THEN 'System' ELSE COALESCE(UP.DisplayName, '') END AS Author,                
      COALESCE(PNT.progressnotetypekey, '') AS RecordingType,   
      PN.locationname,
      COALESCE((SELECT pns.description FROM progressnotesubtype pns  where pns.progressnotesubtypeid = PN.progressnotesubtypeid), '') AS RecordingSubType,
      COALESCE((SELECT pnrt.typedescription FROM progressnotereasontype pnrt where pnrt.progressnotereasontypekey = PN.progressnotereasontypekey), '') AS Progressnotereasontypedescription,                    
      CASE WHEN (PNT.ProgressNoteClassificationTypeKey = 'System') THEN '' ELSE COALESCE(TM.RoleTypeKey, '') END AS Title,                
      CASE WHEN (PNT.ProgressNoteClassificationTypeKey = 'System') THEN '' ELSE COALESCE(TE.TeamName, '') END AS Team,                        
      CASE WHEN (PNT.ProgressNoteClassificationTypeKey = 'System') THEN 0::boolean ELSE COALESCE(PN.SaveMode,0::boolean) END AS Draft,
      CASE WHEN (PNT.ProgressNoteClassificationTypeKey = 'System') THEN null ELSE PN.AttemptIndicator END AS AttemptInd,                
      CAST(COALESCE ( PN.ContactDate, PN.insertedon) AS TIMESTAMP(3)) AS ContactDate,                
      COALESCE (PN.ContactName, '') AS ContactName,    
              (SELECT json_agg(roletype) FROM
                (SELECT prt.contactroletypekey, prt.progressnoteroletypeid from progressnoteroletype prt
              where prt.progressnoteid=PN.progressnoteid  and prt.activeflag=1)roletype) :: jsonb  AS progressroletype,
      (SELECT Json_agg(actor)
      FROM ((SELECT cp.contactparticipantid,cp.participanttypekey,cp.intakeservicerequestactorid,cp.address1,
      cp.address2,cp.city,cp.state,cp.zipcode,cp.email,cp.phonenumber,
      isra.personid,
      COALESCE(p.prefx, '') AS prefx,
      COALESCE(p.firstname, '') AS firstname,  
      COALESCE(p.middlename, '') AS middlename,  
      COALESCE(p.lastname, '') AS lastname,        
      COALESCE(p.suffix, '') AS suffix,        
      isra.actorid,
      at.actortype,
      at.typedescription,
      (select Json_agg(childroles)from (
                  SELECT distinct  typedescription FROM actortype at
                  where at.actortype in  (select isa.intakeservicerequestpersontypekey from intakeservicerequestactor isa where
                  isa.actorid = isra.actorid 
                  and isa.activeflag = 1)
                ) childroles):: jsonb as childroles
            FROM contactparticipant cp
            JOIN intakeservicerequestactor isra on  isra.intakeservicerequestactorid = cp.intakeservicerequestactorid
            JOIN person p on p.personid = isra.personid      
            LEFT JOIN actortype at on at.actortype = isra.intakeservicerequestpersontypekey  
            WHERE cp.progressnoteid = PN.progressnoteid AND cp.activeflag = 1 AND
                        cp.participanttypekey is distinct from 'COLLATERAL') UNION
      
      (SELECT cp.contactparticipantid,cp.participanttypekey,cp.intakeservicerequestactorid,cp.address1,
      cp.address2,cp.city,cp.state,cp.zipcode,cp.email,cp.phonenumber,
      c.collateralid,
      COALESCE(c.prefixtypekey, '') AS prefx,
      COALESCE(c.firstname, '') AS firstname,  
      COALESCE(c.middlename, '') AS middlename,  
      COALESCE(c.lastname, '') AS lastname,        
      COALESCE(c.suffixtypekey, '') AS suffix,        
      cc.collateralid,
      at.actortype,
      at.typedescription,
                  null as childroles
            FROM contactparticipant cp
            LEFT JOIN collateral c on  c.collateralid = cp.intakeservicerequestactorid and c.activeflag=1
        LEFT JOIN collateralroleconfig  cc on c.collateralid = cc.collateralid and cc.activeflag=1
        LEFT JOIN actortype at on at.actortype = cc.actortypekey  
            WHERE cp.progressnoteid = PN.progressnoteid AND cp.activeflag = 1 AND
                        cp.participanttypekey = 'COLLATERAL')
      )actor) :: jsonb AS contactparticipant,
      (SELECT Json_agg(contacttrialvisit)
      FROM (SELECT ctv.contacttrialvisitid,
      ctv.progressnoteid,
      ctv.issuedesc,
      ctv.safetydesc,
      ctv.services_childdesc,
      ctv.services_parentdesc,
      ctv.permanencystepdesc,
      ctv.placementdesc,
      ctv.educationdesc,
      ctv.healthdesc,
      ctv.socialareadesc,
      ctv.financialliteracydesc,
      ctv.familyplanningdesc,
      ctv.skillissuedesc,
      ctv.transitionplandesc
      FROM contacttrialvisit ctv
      WHERE ctv.progressnoteid = PN.progressnoteid AND ctv.activeflag = 1)
      contacttrialvisit) :: jsonb AS progressnotecontacttrialvisit,
      ((extract (day FROM now() at time zone 'utc' -  PN.insertedon at time zone 'utc'))) <=7 as iseditable ,                    
      COALESCE(PN.ContactPhone, '') AS ContactPhone,                
      COALESCE(PN.ContactEmail, '') AS ContactEmail,      
      COALESCE (PN.ArchivedOn, NULL) AS ArchivedOn,    
      COALESCE (PN.ArchivedBy, '') AS ArchivedBy,
      (SELECT string_agg( COALESCE( A.Description,''  || 'rn' ) ,'|')  
      FROM (SELECT UPF.DisplayName ,PND.insertedon,pnd.Description FROM ProgressNoteDetail pnd      
      JOIN UserProfile UPF ON PND.insertedby = UPF.SecurityUsersId      
      WHERE pnd.ProgressNoteId = PN.ProgressNoteId AND pnd.activeflag=1 AND pnd.isaddendum = 0
      ORDER by PND.insertedon DESC limit 1) as A) AS Detail,
      CAST(COALESCE (PN.insertedon , PN.insertedon) AS TIMESTAMP(3)) AS RecordingDate ,                
      PN.insertedby AS Insertedby, DP.DocumentPropertiesId, DP.title as doctitle, DP.description as docdescription, DP.filename, DP.mime, DP.s3bucketpathname,
      PN.starttime ::timestamp  AS StartTime ,PN.endtime ::timestamp   AS EndTime ,PN.stafftypekey  AS StaffType,PN.instantresults  AS InstantResults,PN.contactstatus  AS ContactStatus,
      PN.drugscreen  AS DrugScreen,COALESCE(PNPT.description, '')  AS ProgressNotePurposeType,
      (SELECT Json_agg(progressnotereasons)
      FROM (SELECT prtc.progressnotereasontypeconfigid,
      prtc.progressnoteid,
      prtc.personid,
      prtc.name,
      prtc.primaryphoneno,
      prtc.email,
      prtc.relationship,
      p.firstname||' '|| p.lastname as personname
      FROM progressnotereasontypeconfig prtc
      left join person p on p.personid=prtc.personid
      WHERE prtc.progressnoteid = PN.progressnoteid AND prtc.activeflag = 1)
      progressnotereasons) :: jsonb AS progressnotereason,
      (SELECT Json_agg(detailNote)
      FROM (SELECT UPF.DisplayName ,PND.insertedon,pnd.Description,pntin.progressnotetypekey FROM ProgressNoteDetail pnd      
      JOIN UserProfile UPF ON PND.insertedby = UPF.SecurityUsersId  
      JOIN ProgressNoteType pntin on pntin.ProgressNoteTypeId = PN.ProgressNoteTypeId  
      WHERE pnd.ProgressNoteId = PN.ProgressNoteId AND pnd.activeflag=1 AND pnd.isaddendum = 1
      ORDER by PND.insertedon DESC )
      detailNote) :: jsonb AS notedetails,
      PN.initiationindicator,
      PN.witsid:: character varying,
      PNT.description::character varying as Recordingtypedescription,
      PN.EntityTypeId,
      PN.EntityType,
      PN.qualityofcaretochildtext,
      PN.screeningfortheservicetext,
      PN.adjustmentfostercaretext,
      PN.ischildgotoshool,
      PN.old_id,
      PN.updatedon,
      PN.mioptions::character varying,
      PN.delayreasons::character varying,
      PN.hasdelay::boolean
      FROM  ProgressNote AS PN
      INNER JOIN ProgressNoteType AS PNT ON PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId        
      LEFT JOIN UserProfile up on pn.insertedby = up.SecurityUsersId  
      LEFT JOIN DocumentProperties DP On DP.DocumentPropertiesId = PN.DocumentPropertiesId                  
      LEFT JOIN teammemberassignment tma on tma.teammemberassignmentid = (
          select t.teammemberassignmentid from teammemberassignment t where t.securityusersid = up.securityusersid and t.activeflag = 1
          order by insertedon asc limit 1
      )                
      LEFT JOIN TeamMember tm on tm.TeamMemberId = tma.TeamMemberId AND tm.ActiveFlag = 1                
      LEFT JOIN Team te on te.TeamId = tm.TeamId AND te.ActiveFlag = 1
      LEFT JOIN Progressnoteroletype AS PNRT ON PN.ProgressNoteId = PNRT.ProgressNoteId AND PNRT.ActiveFlag = 1
      LEFT JOIN progressnotepurposetype AS PNPT ON PNPT.progressnotepurposetypekey = PN.progressnotepurposetypekey AND PNRT.ActiveFlag = 1   
      LEFT JOIN progressnotesubtype PNST ON PNST.progressnotesubtypeid = PN.progressnotesubtypeid AND PNST.activeflag = 1

      WHERE
      (PN.EntityTypeId
      in (v_IntakeServiceID :: character varying)
      OR
      (CASE WHEN v_uuidornot IS NULL
      THEN null
      ELSE
      PN.EntityTypeId in
      (
      (SELECT intakeserviceid:: character varying FROM intakeservicerequest isr
      WHERE servicecaseid =v_IntakeServiceID::uuid AND activeflag =1 and intakeserviceid is not null order by isr.updatedon desc LIMIT 1),
      (SELECT DISTINCT intakenumber:: character varying FROM intakeservicerequest
      WHERE (servicecaseid =v_IntakeServiceID::uuid OR intakeserviceid =v_IntakeServiceID::uuid ) and intakenumber is not null LIMIT 1)
      )
      END )
      )
      AND (PNT.ProgressNoteClassificationTypeKey) ilike 'user' 
      AND PN.activeflag = 1                    
      AND (v_DateFrom IS NULL OR (date(PN.insertedon) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))                                                            
      AND (v_ContactFrom IS NULL OR (date(PN.ContactDate) between CAST(v_ContactFrom AS DATE) AND CAST(v_ContactTo AS DATE)))                                                        
      AND (v_Draft IS NULL OR PN.SaveMode = v_Draft )  
      AND (v_caseworkername  IS NULL OR lower(UP.DisplayName) LIKE '%'|| lower(v_caseworkername) || '%' )
      AND (v_note  IS NULL OR lower(PN.description) LIKE '%'|| lower(v_note) || '%' )
      AND (v_progressnotereasontypekey IS NULL OR commaseparatedstringcheck(v_progressnotereasontypekey, PN.progressnotereasontypekey))
      AND (lower(v_RecordingStatusType) IS NULL OR lower(COALESCE(PNT.ProgressNoteClassificationTypeKey,'User')) = lower(v_RecordingStatusType))
      AND (v_progresssubtype IS NULL OR PN.progressnotesubtypeid = v_progresssubtype::uuid )
      AND (v_progresstype IS NULL OR PNT.progressnotetypeid = v_progresstype::uuid )
      and (v_progressnoteInsertedby IS NULL OR PN.insertedby:: character varying = v_progressnoteInsertedby OR PN.updatedby:: character varying = v_progressnoteInsertedby)
      and (v_actor IS NULL OR
      PN.progressnoteid in
      (select cp.progressnoteid
        FROM contactparticipant cp
        WHERE cp.progressnoteid = PN.progressnoteid AND cp.activeflag = 1
      and case when v_actor is not null then cp.intakeservicerequestactorid :: character varying = ANY
      (select * from jsonb_array_elements_text((v_actor):: jsonb)) else true end))  
      ORDER BY 
          ( CASE v_sort_dir
              WHEN 'asc'
                THEN
                  CASE v_sort_by
                    WHEN 'contactdate' THEN COALESCE(PN.starttime, PN.contactdate)::character varying
                    WHEN 'progressnotereasontypekey' THEN PN.progressnotereasontypekey::character varying  
                    WHEN 'author' THEN (CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END)::character varying  
                    WHEN 'recordingtype' THEN COALESCE(PNT.progressnotetypekey,'')::character varying
                    WHEN 'recordingsubtype' THEN COALESCE(PNST.description,'')::character varying
                    WHEN 'progressnotepurposetypekey' THEN COALESCE(PN.progressnotepurposetypekey, '')::character varying
                    WHEN 'personcontacted' THEN  COALESCE((SELECT D.firstname from
		                                                          ( SELECT COALESCE(p1.firstname, '') AS firstname  
            	                                                    FROM contactparticipant cp1
            		                                                    JOIN intakeservicerequestactor isra1 on  isra1.intakeservicerequestactorid = cp1.intakeservicerequestactorid
            		                                                    JOIN person p1 on p1.personid = isra1.personid      
            	                                                    WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                    AND cp1.participanttypekey is distinct from 'COLLATERAL'
			                                                          UNION
			                                                          SELECT COALESCE(c1.firstname, '') AS firstname
            	                                                    FROM contactparticipant cp1
            		                                                    LEFT JOIN collateral c1 on  c1.collateralid = cp1.intakeservicerequestactorid and c1.activeflag=1
            	                                                      WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                      AND cp1.participanttypekey = 'COLLATERAL'
			                                                        ) D limit 1)::character varying , null):: character varying      
                      ELSE 
                        PN.insertedon::character varying
                  END
          END) ASC NULLS last,
          ( CASE v_sort_dir
              WHEN 'desc'
                THEN
                  CASE v_sort_by
                    WHEN 'contactdate' THEN COALESCE(PN.starttime, PN.contactdate)::character varying
                    WHEN 'progressnotereasontypekey' THEN PN.progressnotereasontypekey::character varying   
                    WHEN 'author' THEN (CASE WHEN PNT.progressnoteclassificationtypekey='System' THEN 'System' ELSE COALESCE(UP.displayname,'') END)::character varying      
                    WHEN 'recordingtype' THEN COALESCE(PNT.progressnotetypekey,'')::character varying
                    WHEN 'recordingsubtype' THEN COALESCE(PNST.description,'')::character varying
                    WHEN 'progressnotepurposetypekey' THEN COALESCE(PN.progressnotepurposetypekey, '')::character varying
                    WHEN 'personcontacted' THEN  COALESCE((SELECT D.firstname from
		                                                          ( SELECT COALESCE(p1.firstname, '') AS firstname  
            	                                                    FROM contactparticipant cp1
            		                                                    JOIN intakeservicerequestactor isra1 on  isra1.intakeservicerequestactorid = cp1.intakeservicerequestactorid
            		                                                    JOIN person p1 on p1.personid = isra1.personid      
            	                                                    WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                    AND cp1.participanttypekey is distinct from 'COLLATERAL'
			                                                          UNION
			                                                          SELECT COALESCE(c1.firstname, '') AS firstname
            	                                                    FROM contactparticipant cp1
            		                                                    LEFT JOIN collateral c1 on  c1.collateralid = cp1.intakeservicerequestactorid and c1.activeflag=1
            	                                                      WHERE cp1.progressnoteid = PN.progressnoteid AND cp1.activeflag = 1 
                                                                      AND cp1.participanttypekey = 'COLLATERAL'
			                                                        ) D limit 1)::character varying , null):: character varying
                      ELSE 
                        PN.insertedon::character varying
                  END
          END) DESC NULLS last
        LIMIT (CASE WHEN v_nolimit IS FALSE THEN v_liPageSize ELSE NULL END)
        OFFSET (CASE WHEN v_nolimit IS FALSE THEN v_pageoffset ELSE NULL END);
                 

END IF;

END IF;
END;
$function$;
