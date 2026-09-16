/*
Issue Description:CJAMS-65166
Category/Module: Data fix
Root cause:iser error User requested for a data fix
Fix provided:  data fix Provided as below

Change the Intake Created & Received Date to 12/22/2025 9:43am
Change the Intake last Narrative Update Date & Time to 12/22/2025 10:15am
Update the Intake SDM by checking the SEN box
Update the Intake number & system created date in the service case (case # 3293236) Summary screen.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
                  jsonb_set(
                      jsonb_set(
                          jsondata,
                          '{General,RecivedDate}',
                          to_jsonb('2025-12-22 09:43:00 AM'::text)
                      ),
                      '{General,CreatedDate}',
                      to_jsonb('2025-12-22 14:43:00.000Z'::text)
                  ),
                  '{General,narrativeUpdatedDate}',
                  to_jsonb('2025-12-22 15:15:00.000Z'::text)
              ),
    updatedby = 'CJAMS-65166',
    updatedon = NOW()
WHERE intakenumber = 'I261013890442'
AND activeflag = 1;

UPDATE intakedastaging 
SET 
    jsondata = jsonb_set(
                  jsonb_set(
                      jsonb_set(
                          jsondata,
                          '{General,RecivedDate}',
                          to_jsonb('2025-12-22 09:43:00 AM'::text)
                      ),
                      '{General,CreatedDate}',
                      to_jsonb('2025-12-22 14:43:00.000Z'::text)
                  ),
                  '{General,narrativeUpdatedDate}',
                  to_jsonb('2025-12-22 15:15:00.000Z'::text)
              ),
    updatedby = 'CJAMS-65166',
    updatedon = NOW()
WHERE intakenumber = 'I261013890442'
AND activeflag = 1;


UPDATE intakesnapshot 
SET updatedby  ='CJAMS-65166',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
 WHERE intakenumber = 'I261013890442' AND activeflag = 1;


 UPDATE intakedastaging 
SET updatedby  ='CJAMS-65166',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
 WHERE intakenumber = 'I261013890442' AND activeflag = 1;

update intakeservicerequestsdm 
set drugexposednewbornflag=1,
updatedby = 'CJAMS-65166', 
updatedon = now()
where intakeserviceid='ea625c40-bcb1-4ca3-b22b-633e8b2bc798' and activeflag =1;



update intakeservicerequest set activeflag=0, updatedby = 'CJAMS-65166', updatedon = now()
where intakeserviceid in('0d51f7f3-45e7-46d4-97bb-acaf2e1c6139','7005b46c-1229-4cea-95d5-a66cdc75ef79') and activeflag=1;

update intakeservicerequest set servicecaseid='2ed3d4dd-3cae-40d0-8ee3-fb0e10e0570d', updatedby = 'CJAMS-65166', updatedon = now()
where intakeserviceid ='39503bae-ae79-48f9-925f-f0334de462eb' and activeflag=1;


update intakeservicerequest
set reporteddate='2025-12-22 10:15:00',updatedby='CJAMS-65166',updatedon= now() where intakeserviceid ='39503bae-ae79-48f9-925f-f0334de462eb' and activeflag=1;

