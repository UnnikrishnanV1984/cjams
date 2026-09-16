/*
Issue: CJAMS-61136 Provider Involved Maltreatment
Category/Module: SDM
Root cause:251023021547 User checked provider involved maltreatment incorrectly and data fix needed to check it as NO
Fix provided:  Data fix has been done to update the provider involved maltreatment as NO.
Data/Code fix ticket#: CJAMS-61136
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
*/

update intakeservicerequestsdm
set ismaltreatment = false,
    isprivateplacement = false,
    updatedby = 'CJAMS-61136',
    updatedon = now()
where intakeserviceid = 'ab072243-4d95-4710-8102-e127d7098e23'
and intakeservicerequestsdmid in ('568b89fd-a3fb-46a7-af0f-6de0af28c27d');

UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"no"' 
        )
    ),
    updatedby = 'CJAMS-61136',
    updatedon = now()            
WHERE intakenumber = 'I251013250494' 
  AND activeflag = 1;


UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"no"' 
        )
    ),
    updatedby = 'CJAMS-61136',
    updatedon = now()            
WHERE intakenumber = 'I251013250494' 
  AND activeflag = 1;


UPDATE cjams.investigationallegation
SET isproviderinvolved = 0,
updatedby='CJAMS-61136',
updatedon=now()
WHERE investigationallegationid = '32462475-a6aa-498f-a259-afc911568419' and activeflag = 1;