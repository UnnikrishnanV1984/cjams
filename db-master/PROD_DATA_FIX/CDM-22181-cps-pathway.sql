DO $$
<<block1>>
DECLARE
updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-22181';

BEGIN
UPDATE
  intakeservicerequest
SET
  actiontype = 'IR',
  intakeservicerequestclassid = (
  SELECT
    servicerequestsubtypeid
  FROM
    servicerequestsubtype
  WHERE
    classkey = 'CPS-IR'
    AND activeflag = 1),
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = 'I221010267984'
  AND activeflag = 1;

UPDATE
  intakeservicerequestsdm
SET
  isir = TRUE,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakeservicerequestsdmid = 'f5d8d70e-4d7e-4558-b907-76b16ace1b93'
  AND isar = FALSE
  AND isir = FALSE
  AND activeflag = 1;
END block1 $$;