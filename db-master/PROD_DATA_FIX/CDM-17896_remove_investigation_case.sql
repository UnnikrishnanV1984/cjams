/*
   Issue Description: CDM-17896
   Category/ Module  :  Duplicate investigation case
   Root cause: user asked to remvove the duplicate investigation case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest 
set activeflag =0, updatedon =now(), updatedby ='CDM-17896'
where intakeserviceid ='45b306c8-cdc2-45ef-965c-cebd9717029c';

update intakeservicerequestactor
set activeflag =0, updatedon =now(), updatedby ='CDM-17896'
where intakeserviceid ='45b306c8-cdc2-45ef-965c-cebd9717029c';

update caseassignment 
set activeflag =0, updatedon =now(), updatedby ='CDM-17896'
where caseassignmentid = '44772c7e-d0c3-45d5-96d5-e805a7f121c1';

UPDATE intakesnapshot 
SET updatedby = 'CDM-17896', 
    updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}', 
                jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
                jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
                jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I211010186986' AND activeflag=1;
