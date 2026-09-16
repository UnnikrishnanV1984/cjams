/*
Issue:CJAMS-61241-CHANGE-TO-PROVIDER-INVOLVED
Category/Module: SDM/Maltreatment 
Root cause: User didn't select the correct maltreatment type and data fix is needed to update the Provider Involved Maltreatment from No to Yes in both case and Intake.
Fix provided:  Provided needed datafix.     
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
*/


update intakeservicerequestsdm
set ismaltreatment = true,isprivateplacement = true,
    updatedby = 'CJAMS-61241',
    updatedon = now()
where intakeservicerequestsdmid='090cb6bd-5ee1-4eaf-a0a6-2ffdd14c6546'
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
    updatedby = 'CJAMS-61241',
    updatedon = now()            
WHERE intakenumber = 'I251013223546' 
  AND activeflag = 1;


  UPDATE intakesnapshot
SET jsondata = jsonb_set(
    jsondata::jsonb,
    '{sdm,provider}',
    '[
      {
        "providerid": 6163607,
        "providername": "Silver Oak Academy",
        "providerphone": "999 Crouse Mill Rd KENYMAR MD 21757"
      }
    ]'::jsonb,
    true
),
updatedby = 'CJAMS-661241',
updatedon = now()
WHERE intakenumber = 'I251013223546' 
  AND activeflag = 1;



  UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{isprivateplacement}', 
            '"true"' 
        )
    ),
    updatedby = 'CJAMS-61241',
    updatedon = now()            
WHERE intakenumber = 'I251013223546' 
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
    updatedby = 'CJAMS-61241',
    updatedon = now()            
WHERE intakenumber = 'I251013223546' 
  AND activeflag = 1;


  UPDATE intakedastaging
SET jsondata = jsonb_set(
    jsondata::jsonb,
    '{sdm,provider}',
    '[
      {
        "providerid": 6163607,
        "providername": "Silver Oak Academy",
        "providerphone": "999 Crouse Mill Rd KENYMAR MD 21757"
      }
    ]'::jsonb,
    true
),
updatedby = 'CJAMS-661241',
updatedon = now()
WHERE intakenumber = 'I251013223546' 
  AND activeflag = 1;



  UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{isprivateplacement}', 
            '"true"' 
        )
    ),
    updatedby = 'CJAMS-61241',
    updatedon = now()            
WHERE intakenumber = 'I251013223546' 
  AND activeflag = 1;



update investigationallegation
set isproviderinvolved = 1,
    updatedon =now(),
    updatedby = 'CJAMS-61241'
where investigationid = 'aef35d1c-e313-409c-879f-a9b6cd6469e0'
and activeflag = 1; 


update investigationmaltreatment
set providerid='6163607',
    providername='Silver Oak Academy',
    providerphonenumber='999 Crouse Mill Rd KENYMAR MD 21757',
    updatedon =now(),
    updatedby = 'CJAMS-61241'
where investigationid = 'aef35d1c-e313-409c-879f-a9b6cd6469e0' and activeflag = 1;


INSERT INTO cjams.allegationprovidermaltreatment
(allegationprovidermaltreatmentid, investigationallegationid, 
providermaltreatmenttypekey, activeflag, insertedby, updatedby, effectivedate, 
insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), 'f6fec46d-81ca-4c9b-b6b9-394acfb4f2ce', 'PP', 1,
'CJAMS-61241', 'CJAMS-61241', '2025-02-21 16:11:57', now(), now(), NULL);


INSERT INTO cjams.allegationprovidermaltreatment
(allegationprovidermaltreatmentid, investigationallegationid, 
providermaltreatmenttypekey, activeflag, insertedby, updatedby, effectivedate, 
insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), '9aea8179-6a1c-4951-82fa-9df165831b21', 'PP', 1,
'CJAMS-61241', 'CJAMS-61241', '2025-02-28 16:11:57', now(), now(), NULL);


