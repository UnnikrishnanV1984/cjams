/*
 * CJAMS-57970 - Foster care Milestone
 * Customer Email ID:kevin.buckley@maryland.gov
 * Description: 231030071971:This safe-c was approved on 2/14/2025, but it is not showing up on the milestone report. 
 * 
 */

 --select * from cjams.assessmentactor where updatedby = 'CJAMS-57970';
INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid, activeflag, insertedby, updatedby, effectivedate, insertedon, updatedon) 
SELECT * FROM  (
    SELECT ast.assessmentid
        ,isra.intakeservicerequestactorid
        ,1
        ,ast.insertedby
        ,'CJAMS-57970'
        ,ast.insertedon
        ,ast.insertedon
        ,now()
     FROM assessment ast  
    INNER JOIN person p  ON p.cjamspid = (ast.submissiondata ->> 'clientid')::integer AND p.activeflag = 1 
    INNER JOIN intakeservicerequestactor isra on (isra.servicecaseid = ast.servicecaseid OR isra.intakeserviceid = ast.objectid) and isra.personid = p.personid AND isra.isprimary = true AND isra.activeflag = 1
    WHERE  ast.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035'
    AND ast.submissiondata IS NOT NULL
    AND ast.insertedon::date >= '2025-01-17' and (select count(*) from assessmentactor a where a.assessmentid =  ast.assessmentid and a.activeflag = 1) = 0
 ) asta;

-- select assessmentid,count(*)  from cjams.assessmentactor where activeflag =1 and updatedby = 'CJAMS-57970' 
-- group by assessmentid;

-- select a.assessmentid, (json_build_object('assessmentactor', json_agg(json_build_object('intakeservicerequestactorid', a.intakeservicerequestactorid))))::jsonb as assessmentactor
--  from cjams.assessmentactor a
--  where a.activeflag = 1 and a.updatedby = 'CJAMS-57970' 
--  group by assessmentid;

with ti_update as (  
 select a.assessmentid, 
 (a2.submissiondata || (json_build_object('assessmentactor', json_agg(json_build_object('intakeservicerequestactorid', a.intakeservicerequestactorid))))::jsonb) updated_submns_data
 from cjams.assessmentactor a
 inner join cjams.assessment a2 on a2.assessmentid = a.assessmentid and a2.submissiondata is not null 
 where a.activeflag = 1 and a.assessmentid in (
select assessmentid  from cjams.assessmentactor where activeflag = 1 and updatedby = 'CJAMS-57970' 
group by assessmentid 
)
and a2.submissiondata->>'assessmentactor'  is  null
group by a.assessmentid, a2.submissiondata)
UPDATE assessment a3 
SET updatedon  = now(), updatedby ='CJAMS-57970', 
submissiondata = ti_update.updated_submns_data 
from ti_update 
WHERE a3.assessmentid = ti_update.assessmentid;
