/*
   Issue Description: CDM-34786
   Category/ Module  : Intake Narrative 
   Root cause: user wants to change incident date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-34786', updatedon = now(), jsondata = jsonb_set(jsondata, '{narrative}',
jsonb_set(jsondata->'narrative', '{0}',
jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2023-09-20T04:00:00.000Z"')))
WHERE intakenumber = 'I231011239900' AND activeflag=1;

UPDATE intakedastaging
SET updatedby = 'CDM-34786', updatedon = now(), jsondata = jsonb_set(jsondata, '{narrative}',
jsonb_set(jsondata->'narrative', '{0}',
jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2023-09-20T04:00:00.000Z"')))
WHERE intakenumber = 'I231011239900' AND activeflag=1;

update intakeservicerequest
set reporterincidentdate = '2023-09-20 04:00:00', reportedtime = '2023-09-20 17:31:44', updatedby = 'CDM-34786', updatedon = now()
where intakeserviceid = 'bddbf0ec-4cfe-4c42-b2e5-474c9ffb3e0f' and activeflag = 1;