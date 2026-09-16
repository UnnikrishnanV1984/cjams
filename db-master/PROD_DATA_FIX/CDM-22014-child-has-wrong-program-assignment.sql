UPDATE
  personprogramarea
SET
  subprogramkey = 'AR',
  updatedby = 'CDM-22014',
  updatedon = now()
WHERE
  subprogramkey = 'IR'
  AND personprogramid = '58920d2b-81bb-403b-96bc-00397590041a'
  AND activeflag = 1;