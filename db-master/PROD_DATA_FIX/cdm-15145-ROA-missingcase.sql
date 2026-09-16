SELECT
  *
FROM
  cjams.createservicecase('8f96a564-2fcf-4d83-9bca-bdc83ee8296a',
  NULL,
  1,
  'd01eb0ea-2486-4422-87ce-8e036fe78425',
  'intake');

UPDATE
  intakeservicerequest
SET
  activeflag = 1,
  updatedon = now(),
  updatedby = 'CDM-15145'
WHERE
  intakenumber = 'I211010174224'
  AND activeflag = 0;