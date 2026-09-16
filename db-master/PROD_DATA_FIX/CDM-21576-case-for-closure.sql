DO $$
<<block1>>
DECLARE
dispositionDate TIMESTAMP := '2022-03-14 17:11:59.555';

intakeId UUID;

dispositionId UUID;

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-21576';

BEGIN
intakeId := (
SELECT
  intakeserviceid
FROM
  intakeservicerequest
WHERE
  servicerequestnumber = '221020175183'
  AND activeflag = 1);

dispositionId := (
SELECT
  intakeservicerequestdispositioncodeid
FROM
  intakeservicerequestdispositioncode
WHERE
  intakeserviceid = intakeId
  AND activeflag = 1
ORDER BY
  statusdate DESC
LIMIT 1);

UPDATE
  intakeservicerequestdispositioncode
SET
  statusdate = dispositionDate,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakeservicerequestdispositioncodeid = dispositionId
  AND activeflag = 1;

UPDATE
  routing
SET
  insertedon = dispositionDate,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  objectid = dispositionId::TEXT
  AND activeflag = 1;

UPDATE
  caseassignment
SET
  enddate = dispositionDate,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  objectid = intakeId
  AND activeflag = 1;
END block1 $$;