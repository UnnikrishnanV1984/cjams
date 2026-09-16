/*
   Issue Description: CDM-26333
   Category/ Module  : bug
   Root cause:  need to do data fix to select the supervisor as 'screen in' and one of the status in submission history should be 'accepted'
   also have to update the approved on time in submission history
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



UPDATE
  intakesnapshot
SET 
  updatedby = 'CDM-26333', 
  updatedon = now(), 
  jsondata = REPLACE(REPLACE(jsondata::TEXT, '"supDisposition": ""', '"supDisposition": "Scrnin"'), 
    '"DAStatus": "Review"', '"DAStatus": "Accepted"')::JSONB
WHERE
  intakenumber = 'I221010327693'
  AND activeflag = 1;

UPDATE
  intakedastaging
SET 
  updatedby = 'CDM-26333', 
  updatedon = now(), 
  jsondata = REPLACE(REPLACE(jsondata::TEXT, '"supDisposition": ""', '"supDisposition": "Scrnin"'), 
    '"DAStatus": "Review"', '"DAStatus": "Accepted"')::JSONB,
  ispreintake = FALSE
WHERE
  intakenumber = 'I221010327693'
  AND activeflag = 1;

UPDATE
  intakedastatus
SET 
  status = 2,
  updatedby = 'CDM-26333', 
  updatedon = now()
WHERE
  intakenumber = 'I221010327693'
  AND activeflag = 1;

UPDATE
  routing
SET
  routingstatustypeid = 2,
  updatedby = '1287622e-f1a4-4875-accb-d46953efca5c',
  updatedon = now()
WHERE
  objectid = 'I221010327693'
  AND routingid = 'f1c13f4e-585e-430c-aa40-358ed9147b3f';