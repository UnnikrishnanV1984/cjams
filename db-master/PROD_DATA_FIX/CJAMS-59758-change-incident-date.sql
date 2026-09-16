-- CJAMS-59758 - Incident Date Change
/* Issue Description: Wrong incident date added

-- Category/ Module: Intake/Service

-- Root cause: User Error, Wrong incident date added. 
-- Fix Provided: Datafix has been provided to update incident dates
-- Pull request# N/A

*/
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2024-04-01 04:00:00.000"'))),
updatedon=now(), 
updatedby='CJAMS-59758'
WHERE intakenumber = 'I241012579760' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2024-04-01 04:00:00.000"'))),
updatedon=now(), 
updatedby='CJAMS-59758'
WHERE intakenumber = 'I241012579760' and activeflag =1;

--select reporterincidentdate,reportedtime ,* from intakeservicerequest i where intakeserviceid = '2046ac1c-5c3b-44d9-8499-01acd1bf17e4';

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2024-04-01 04:00:00.000',
updatedon=now(), 
updatedby='CJAMS-59758'
WHERE intakeserviceid='2046ac1c-5c3b-44d9-8499-01acd1bf17e4';

/*
select incidentdate ,* from investigationallegation i2 
where investigationid = 'ec748d60-3f99-4477-a6e1-15712e694596'  
and activeflag =1;
*/

update investigationallegation 
set incidentdate = '2024-04-01 04:00:00.000',
	updatedby = 'CJAMS-59758',
	isapproximatedate = 1,
	updatedon = now()
where investigationid = 'ec748d60-3f99-4477-a6e1-15712e694596'  
and activeflag =1;