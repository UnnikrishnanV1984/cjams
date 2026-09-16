/*
Issue: CJAMS-64305 SDM provider maltreatment
Category/Module: SDM/Maltreatment 
Root cause: User didn't select the correct maltreatment type and data fix is needed to update the Provider Involved Maltreatment from No to Yes in both case and Intake.
Fix provided: Data fix has been done to change the value for Provider Involved Maltreatment from No to Yes in both case and Intake.
              Intake:I251013625568
              Case:251023374967
Data/Code fix ticket#: CJAMS-64305 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
*/

update intakeservicerequestsdm
set ismaltreatment = true,
    updatedby = 'CJAMS-64305',
    updatedon = now()
where intakeserviceid = '9acb833e-3850-4557-a5a0-7b66e27116d6'
and activeflag = 1;

UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"yes"' 
        )
    ),
    updatedby = 'CJAMS-64305',
    updatedon = now()            
WHERE intakenumber = 'I251013625568' 
  AND activeflag = 1;


UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"yes"' 
        )
    ),
    updatedby = 'CJAMS-64305',
    updatedon = now()            
WHERE intakenumber = 'I251013625568' 
  AND activeflag = 1;


update investigationallegation
set isproviderinvolved = 1,
    updatedon =now(),
    updatedby = 'CJAMS-64305'
where investigationid = '10058134-f59d-488f-94aa-f5061f528490'
and activeflag = 1;    
