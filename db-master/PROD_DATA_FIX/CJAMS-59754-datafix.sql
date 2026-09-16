-- CJAMS-59754 Incident date needs to be changed

/*
-- Issue Description: 
	241022391728:The dates of the Incident are incorrect. 
    They should be 4/2/2024 and the approximate date box needs to be checked

-- Category/ Module: Persons
-- Root cause: 241022391728:The dates of the Incident are incorrect. 
They should be 4/2/2024 and the approximate date box needs to be checked
-- Resolution: Data fix has been made to change the incident dates
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update investigationallegation 
set incidentdate ='2024-04-02 04:00:00',
updatedby ='CJAMS-59754',
updatedon =now() 
where investigationallegationid in ('f872f61a-ded2-4620-a1db-97c39008154b','14d58481-abb2-4828-a253-d6b9540cb60d');

UPDATE intakesnapshot
SET
  updatedby = 'CJAMS-59754',
  updatedon = now(),
  jsondata = jsonb_set(jsondata,'{narrative}',
    jsonb_set( jsondata->'narrative','{0}',
   jsonb_set(jsondata->'narrative'->0,'{isapproximate}', 'true'::jsonb) ) )
WHERE intakenumber = 'I241012579760'
  AND activeflag = 1;

UPDATE cjams.intakeservicerequest
  SET reporterincidentdate='2024-04-02 04:00:00.000',
      updatedon=now(), 
      updatedby='CJAMS-59754'
WHERE intakeserviceid='2046ac1c-5c3b-44d9-8499-01acd1bf17e4';

 
UPDATE cjams.intakedastaging 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2024-04-02 04:00:00.000"'))),
updatedon=now(), 
updatedby='CJAMS-59754'
WHERE intakenumber = 'I241012579760' and activeflag =1;

UPDATE cjams.intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2024-04-02 04:00:00.000"'))),
updatedon=now(), 
updatedby='CJAMS-59754'
WHERE intakenumber = 'I241012579760' and activeflag =1;
