drop function if exists cjams.getassessmentdetailsbyserviceCASE(objectsid character varying, lassessmenttemplateid uuid, v_roletypecode character varying);
CREATE OR REPLACE FUNCTION cjams.getassessmentdetailsbyservicecase(objectsid character varying, lassessmenttemplateid uuid, v_roletypecode character varying DEFAULT ''::character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
--07/25/2022 - Vijaya Laxmi Devunoori - CDM-23745
--09/07/2022 - Vijaya Laxmi Devunoori - CDM-23621
--Display ISR.servicerequestnumber if exists; otherwise sCASE.serviceCASEnumber as servicerequestnumber
--06/30/2023 -- Chandra / Palani - Query tuning (CIDM-7450)
--7/20/2023-Prasanna -CIDM-7524 query is returing duplicate records when service case id is passed as input
--6/11/2024 -Smitha Somasekharam -CIDM-8661-Add QI assessmnet to Assessment Tab
--1/3/2025 - Vinesh - CIDM-10017 - Fix for child removal and assessment issue
-------------------------------------------------------------------------------------------
declare l_assment json;
 
begin
 
SELECT json_agg(astmp) INTO l_assment
FROM (
select * from(SELECT AST.assessmentTextPositionTypeKey
, AST.assessmentscoresetupid
, AST.assessmenttemplateid
, AST.calculationmethod
, AST.datamappingenabled
, AST.description
, AST.effectivedate
, AST.enableassessmentscore
, AST.expirationdate
, AST.external_templateid
, AST.helptext
, AST.instructions
, AST.isvisible
, AST.name
, AST.scoringname
, AST.titleheadertext
, AST.version
, a.submissionid
, a.submissiondata
--,null as submissiondata
, coalesce(A.score,0) score
, A.assessmentstatustypekey
, A.assessmentid
, CASE  WHEN  exists (SELECT ISR.servicerequestnumber FROM intakeservicerequest ISR where ISR.intakeserviceid=A.objectid::uuid  and activeflag = 1  limit 1)
THEN
(SELECT ISR.servicerequestnumber FROM intakeservicerequest ISR where ISR.intakeserviceid=A.objectid::uuid  and activeflag = 1  limit 1)
ELSE
(SELECT sCASE.serviceCASEnumber  FROM serviceCASE sCASE where sCASE.serviceCASEid=objectsid::uuid)
 END as servicerequestnumber
, A.serviceCASEid
, a.updatedon updateddate
, CASE a.updatedby  WHEN 'migration' THEN  'Migrated' ELSE coalesce(up.lastname,'')||', ' ||coalesce(up.firstname,'') END  as username
, a.insertedon as createddate
,(select up.firstname || ', ' || up.lastname
from userprofile up
where up.securityusersid::character varying  = a.updatedby
and up.activeflag=1  ORDER by up.updatedon desc LIMIT 1
) as updatedusername
, AC.comments
, coalesce(A.ismigrated,0)   ismigration
, A.assessmentsubmissiontypekey
-- , (CASE when AST.name = 'safeCOhp' THEN (SELECT * FROM  getsubmissiondetails(a.submissionid)) ELSE NULL end)::text as migratedsubmissiondata
-- , CASE  WHEN coalesce(A.ismigrated,0)= 1 AND LOWER(AST."name") = 'safe-c'  THEN
-- (SELECT datavalue FROM assessmentsubmission asub WHERE asub.datakey ='safetyassessmentcompletiondate' AND asub.assessmentid = a.assessmentid AND asub.activeflag =1 LIMIT 1)
--  ELSE NULL END safetyassessmentcompletiondate
, NULL as safetyassessmentcompletiondate
,concat(p.firstname,' ',p.middlename,' ',p.lastname) as clientname
,CASE when AST.name = 'placementreqestformpartb' THEN( EXTRACT(YEAR FROM age(now(),p.dob))) ELSE NULL END personage
,CASE when AST.name = 'placementreqestformpartb' THEN( select pl.startdatetime from placement pl where pl.personid =p.personid 
and pl.service_id = 11410 --11410 is QRTP provider service
and pl.enddatetime is NULL
and pl.activeflag =1 
order by updatedon desc limit 1) ELSE NULL END activeplacement
--isr.servicerequestnumber
FROM assessment A --on A.serviceCASEid = isr.serviceCASEid
INNER JOIN assessmenttemplate AST ON AST.assessmenttemplateid = A.assessmenttemplateid AND A.activeflag = 1
leFT join assessmentcomments AC on AC.assessmentid = A.assessmentid and ac.activeflag =1
LEFT join userprofile up on up.securityusersid = a.updatedby
LEFT join person p on p.personid = a.personid
WHERE ( A.serviceCASEid = objectsid::uuid --OR
--A.objectid IN (SELECT intakeserviceid FROM intakeservicerequest WHERE servicecaseid = objectsid::uuid)
)
AND lower(A.assessmentstatustypekey) Not in ( CASE coalesce(v_roletypecode,'')  WHEN '' THEN 'inprocess' ELSE '' END)
AND A.assessmenttemplateid =lassessmenttemplateid
union 
SELECT AST.assessmentTextPositionTypeKey
, AST.assessmentscoresetupid
, AST.assessmenttemplateid
, AST.calculationmethod
, AST.datamappingenabled
, AST.description
, AST.effectivedate
, AST.enableassessmentscore
, AST.expirationdate
, AST.external_templateid
, AST.helptext
, AST.instructions
, AST.isvisible
, AST.name
, AST.scoringname
, AST.titleheadertext
, AST.version
, a.submissionid
, a.submissiondata
--,null as submissiondata
, coalesce(A.score,0) score
, A.assessmentstatustypekey
, A.assessmentid
, CASE  WHEN  exists (SELECT ISR.servicerequestnumber FROM intakeservicerequest ISR where ISR.intakeserviceid=A.objectid::uuid  and activeflag = 1  limit 1)
THEN
(SELECT ISR.servicerequestnumber FROM intakeservicerequest ISR where ISR.intakeserviceid=A.objectid::uuid  and activeflag = 1  limit 1)
ELSE
(SELECT sCASE.serviceCASEnumber  FROM serviceCASE sCASE where sCASE.serviceCASEid=objectsid::uuid)
 END as servicerequestnumber
, A.serviceCASEid
, a.updatedon updateddate
, CASE a.updatedby  WHEN 'migration' THEN  'Migrated' ELSE coalesce(up.lastname,'')||', ' ||coalesce(up.firstname,'') END  as username
, a.insertedon as createddate
,(select up.firstname || ', ' || up.lastname
from userprofile up
where up.securityusersid::character varying  = a.updatedby
and up.activeflag=1  ORDER by up.updatedon desc LIMIT 1
) as updatedusername
, AC.comments
, coalesce(A.ismigrated,0)   ismigration
, A.assessmentsubmissiontypekey
--, (CASE when AST.name = 'safeCOhp' THEN (SELECT * FROM  getsubmissiondetails(a.submissionid)) ELSE NULL end)::text as migratedsubmissiondata
-- , CASE  WHEN coalesce(A.ismigrated,0)= 1 AND LOWER(AST."name") = 'safe-c'  THEN
-- (SELECT datavalue FROM assessmentsubmission asub WHERE asub.datakey ='safetyassessmentcompletiondate' AND asub.assessmentid = a.assessmentid AND asub.activeflag =1 LIMIT 1)
--  ELSE NULL END safetyassessmentcompletiondate
, NULL as safetyassessmentcompletiondate
,concat(p.firstname,' ',p.middlename,' ',p.lastname) as clientname
--isr.servicerequestnumber
,CASE when AST.name = 'placementreqestformpartb' THEN( EXTRACT(YEAR FROM age(now(),p.dob))) ELSE NULL END personage
,CASE when AST.name = 'placementreqestformpartb' THEN( select pl.startdatetime from placement pl where pl.personid =p.personid 
and pl.service_id = 11410 -- 11410 is QRTP provider service
and pl.enddatetime is NULL
and pl.activeflag =1 
order by updatedon desc limit 1) ELSE NULL END activeplacement
FROM assessment A --on A.serviceCASEid = isr.serviceCASEid
INNER JOIN assessmenttemplate AST ON AST.assessmenttemplateid = A.assessmenttemplateid AND A.activeflag = 1
leFT join assessmentcomments AC on AC.assessmentid = A.assessmentid and ac.activeflag =1
LEFT join userprofile up on up.securityusersid = a.updatedby
LEFT join person p on p.personid = a.personid
WHERE ( --A.serviceCASEid = objectsid::uuid OR
A.objectid IN (SELECT intakeserviceid FROM intakeservicerequest WHERE servicecaseid = objectsid::uuid)
)
AND lower(A.assessmentstatustypekey) Not in ( CASE coalesce(v_roletypecode,'')  WHEN '' THEN 'inprocess' ELSE '' END)
AND A.assessmenttemplateid =lassessmenttemplateid
) a ORDER by updateddate desc
) as astmp  ;

return l_assment;        
END;

$function$
;