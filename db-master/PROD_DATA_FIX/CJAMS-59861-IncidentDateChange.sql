/* Issue Description: Wrong incident date added

-- Category/ Module: Intake/Service

-- Root cause: The System does not allow setting a maltreament incident date earlier than the CPS-IR case start date, requiring SSA/Product owner approval for exceptions.
-- Fix Provided: No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2022-01-01 00:00:00.000"'))),
updatedon=now(), 
updatedby='CJAMS-59861'
WHERE intakenumber = 'I241013034595' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2022-01-01 00:00:00.000"'))),
updatedon=now(), 
updatedby='CJAMS-59861'
WHERE intakenumber = 'I241013034595' and activeflag =1;

--select reporterincidentdate,reportedtime ,* from intakeservicerequest i where intakeserviceid = '2046ac1c-5c3b-44d9-8499-01acd1bf17e4';

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2022-01-01 00:00:00.000',
updatedon=now(), 
updatedby='CJAMS-59861'
WHERE intakeserviceid='0836c412-208f-4599-bcdd-a4751876310e';

/*
select incidentdate ,* from investigationallegation i2 
where investigationid = 'ec748d60-3f99-4477-a6e1-15712e694596'  
and activeflag =1;
*/

update investigationallegation 
set incidentdate = '2022-01-01 00:00:00.000',
	updatedby = 'CJAMS-59861',
	updatedon = now()
where investigationid = '73e46c11-5941-40e5-952b-c8d1febccdac'  
and activeflag =1;
