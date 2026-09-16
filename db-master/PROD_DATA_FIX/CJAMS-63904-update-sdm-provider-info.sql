/*
Issue Description:Provider selected in error
Category/Module: SDM
Root cause: Description:251023139854:The provider box was selected in error. The alleged maltreator is the parent who was caring for the child, who is placed in foster care through Virginia.
            Data fix needed to update the value for Provider involved maltreatment as 'No' in SDM in the intake and case.
Fix provided: Data fix needed to update the value for Provider involved maltreatment as 'No' in SDM in the intake and case.
Data/Code fix ticket#: CJAMS-63904
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix is needed as per the system design.
*/


update intakeservicerequestsdm
set isfclivingarrangement = false,
    ismaltreatment = false,
    updatedby = 'CJAMS-63904',
    updatedon = now()
where intakeserviceid = 'bbc579b8-bc72-4b2c-bbb0-5a4527bdb3af'
and intakeservicerequestsdmid in ('16b06b92-fdec-4309-abb9-c9f8a1c9edc6','e63c8e55-130c-450d-a1ff-ddc2609e1aa2');

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
    updatedby = 'CJAMS-63904',
    updatedon = now()            
WHERE intakenumber = 'I251013373586' 
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
    updatedby = 'CJAMS-63904',
    updatedon = now()            
WHERE intakenumber = 'I251013373586' 
  AND activeflag = 1;
