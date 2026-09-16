SELECT
  *
FROM
  cjams.createservicecase('f1eae0c1-d7cf-4d79-b817-8c20d33a771f',
  NULL,
  1,
  '7d806f8b-ad55-41b4-91cf-969251ed2233',
  'intake');

UPDATE
  intakeservicerequest
SET
  activeflag = 1,
  updatedon = now(),
  updatedby = 'CDM-21700'
WHERE
  intakenumber = 'I221010251670'
  AND activeflag = 0;