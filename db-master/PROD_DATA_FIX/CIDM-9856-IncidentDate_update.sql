-- CIDM-9856 - CW Intake Incident Date
/* Issue Description: The reporterincidentdate shows invalid dates for the intakes listed in the document. The correct date is provided in list

-- Category/ Module: Intake/CW

-- Root cause: The reporterincidentdate shows invalid dates for the intakes listed in the document. The correct date is provided in list. 
-- Fix Provided: Datafix has been provided to update incident dates
-- Pull request# N/A

*/

--I202000583505
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2020-05-31 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I202000583505' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2020-05-31 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I202000583505' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2020-05-31 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='6866f48e-d3c8-4ee8-b1bb-e637a94bb6aa'::uuid;

--I241012120946
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"1984-04-02 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I241012120946' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"1984-04-02 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I241012120946' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='1984-04-02 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='c1724506-d94d-46fe-9ee1-9a499eb33a42'::uuid;

--I211010190715
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"1998-01-01 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I211010190715' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"1998-01-01 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I211010190715' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='1998-01-01 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='219535d7-55f7-483d-a910-38d882635050'::uuid;

--I202000458129
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2020-02-08 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I202000458129' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2020-02-08 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I202000458129' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2020-02-08 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='6ed0af40-f5c2-41c5-a636-036e8c8f6525'::uuid;

--I241012063630
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2018-01-01 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I241012063630' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2018-01-01 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I241012063630' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2018-01-01 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='1a571360-d7ed-408d-b1c9-54e454ae42a7'::uuid;

--I231010388926
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2023-01-25 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I231010388926' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2023-01-25 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I231010388926' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2023-01-25 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='eec5f1a1-16ed-4c10-8a87-b559aad1045d'::uuid;

--I231010602328
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2023-05-12 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I231010602328' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2023-05-12 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I231010602328' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2023-05-12 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='3c1a699c-f736-4b22-89d9-a5865e41a918'::uuid;

--I221010252715
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2022-03-14 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I221010252715' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2022-03-14 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I221010252715' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2022-03-14 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='c61397b7-b215-4b05-9297-cb657cf3d32b'::uuid;

--I231010630474
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2000-09-11 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I231010630474' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2000-09-11 00:00:00"'))),
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakenumber = 'I231010630474' and activeflag =1;

UPDATE cjams.intakeservicerequest
SET reporterincidentdate='2000-09-11 00:00:00',
updatedon=now(), 
updatedby='CIDM-9856'
WHERE intakeserviceid='3069e55a-b53e-4625-adcc-64823053ecce'::uuid;
