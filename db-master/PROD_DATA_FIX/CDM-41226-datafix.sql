/*
   Issue Description: CDM-41226
   Category/ Module  : Application  
   Root cause: CPS-AR data is missing as classis is missing from previous fix
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest 
set intakeservicerequestclassid='b74ded78-12dc-4e6d-94db-7662d6eaf093', 
updatedby ='CDM-41226',updatedon= now()
where intakeserviceid ='ea12c607-8928-4cc9-b0df-87657c709965' and activeflag =1;

update intakeservicerequestdispositioncode i
set activeflag=1,
updatedby ='CDM-41226',updatedon= now()
where intakeserviceid='ea12c607-8928-4cc9-b0df-87657c709965'
and activeflag=0;

update caseassignment set toteamid='60296e7e-5bb8-40b2-9bba-bb8a87a325c9',
updatedby = 'CDM-41226',updatedon = now() 
where caseassignmentid='9e04ec23-e796-4f28-9e0d-0cf91321a1d6' and activeflag=1;

update intakeservicerequestsdm
set isnoimmed_risk_harm= true,
updatedby = 'CDM-41226',
updatedon = now()
where intakeservicerequestsdmid='3c40f88a-d127-4229-914f-9dc703a9cc2e' and activeflag=1;

UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata::jsonb,
        '{sdm,noImmediateList,isnoimmed_risk_harm}',
        'true'::jsonb
    ),
    updatedby = 'CDM-41226',
    updatedon = now()
WHERE intakesnapshotid = '8cdd09b5-88fe-4190-b606-3681eb18b547' AND activeflag = 1;