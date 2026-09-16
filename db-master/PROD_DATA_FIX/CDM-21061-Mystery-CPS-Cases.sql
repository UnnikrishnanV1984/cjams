DO $$
<<block1>>
DECLARE
caseNums TEXT[] := ARRAY['211020141299',
'211020141301'];

caseNum TEXT;

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-21061';

intakeNum TEXT;

BEGIN 
FOREACH caseNum IN ARRAY caseNums LOOP

UPDATE
  intakeservicerequest
SET
  activeflag = 0,
  intakeserreqstatustypeid = (
  SELECT
    intakeserreqstatustypeid
  FROM
    intakeserreqstatustype
  WHERE
    intakeserreqstatustypekey = 'Closed'
    AND activeflag = 1),
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  servicerequestnumber = caseNum;

intakeNum :=(
SELECT
    intakenumber
FROM
    intakeservicerequest
WHERE
    servicerequestnumber = caseNum);

UPDATE
  intakesnapshot
SET
  jsondata = jsonb_set(jsondata, '{DAType}', 
      jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
      jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
      jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))),
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  intakedastaging
SET
  status = 'Closed',
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  intakesnapshot
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum;

UPDATE
  intakedastaging
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum;

UPDATE
  intakedastatus
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum;
END LOOP;
END block1 $$;