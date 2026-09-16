UPDATE
  intakesnapshot
SET 
  updatedby = 'CDM-18485', 
  updatedon = now(), 
  jsondata = REPLACE(REPLACE(jsondata::TEXT, '"supDisposition": ""', '"supDisposition": "Scrnin"'), 
    '"DAStatus": "Review"', '"DAStatus": "Accepted"')::JSONB
WHERE
  intakenumber = 'I211010206072'
  AND activeflag = 1;

UPDATE
  intakedastaging
SET 
  updatedby = 'CDM-18485', 
  updatedon = now(), 
  jsondata = REPLACE(REPLACE(jsondata::TEXT, '"supDisposition": ""', '"supDisposition": "Scrnin"'), 
    '"DAStatus": "Review"', '"DAStatus": "Accepted"')::JSONB,
  ispreintake = FALSE
WHERE
  intakenumber = 'I211010206072'
  AND activeflag = 1;

UPDATE
  intakedastatus
SET 
  status = 2,
  updatedby = 'CDM-18485', 
  updatedon = now()
WHERE
  intakenumber = 'I211010206072'
  AND activeflag = 1;

UPDATE
  routing
SET
  routingstatustypeid = 2,
  updatedby = 'CDM-18485',
  updatedon = now()
WHERE
  objectid = 'I211010206072'
  AND activeflag = 1;