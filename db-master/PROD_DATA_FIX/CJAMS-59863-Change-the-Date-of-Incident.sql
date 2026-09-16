-- CJAMS-59863 - Incident Date Change
/* Issue Description: Wrong incident date added
-- Category/ Module: Intake/Service
-- Root cause: User Error, Wrong incident date added. 
-- Fix Provided: Datafix has been provided to update incident dates
-- Pull request# N/A
*/
--select jsondata,* from intakedastaging where intakenumber = 'I241013005505' and activeflag=1;

UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2024-07-19T04:00:00.000Z"'))),--2024-08-13T04:00:00.000Z
updatedon=now(), 
updatedby='CJAMS-59863'
WHERE intakenumber = 'I241013005505' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2024-07-19T04:00:00.000Z"'))),
updatedon=now(), 
updatedby='CJAMS-59863'
WHERE intakenumber = 'I241013005505' and activeflag =1;

--select reporterincidentdate,reportedtime ,* from intakeservicerequest i where intakeserviceid = '842fb3e0-a92c-46e6-b5b5-48a4519118a4';

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2024-07-19T04:00:00.000Z',
updatedon=now(), 
updatedby='CJAMS-59863'
WHERE intakeserviceid='842fb3e0-a92c-46e6-b5b5-48a4519118a4';

/*
select incidentdate ,* from investigationallegation i2 
where investigationid = 'aa817077-cf08-48ae-8451-4a75b6b0c4d2'  
and activeflag =1;
*/

update investigationallegation 
set incidentdate = '2024-07-19T04:00:00.000Z',
	updatedby = 'CJAMS-59863',
	updatedon = now()
where investigationid = 'aa817077-cf08-48ae-8451-4a75b6b0c4d2'  
and activeflag =1;