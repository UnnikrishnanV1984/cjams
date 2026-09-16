DO $$
<<block1>>
DECLARE
updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-22347';

BEGIN
UPDATE
  intakeservicerequest
SET
  intakeserreqstatustypeid = (
  SELECT
    intakeserreqstatustypeid
  FROM
    intakeserreqstatustype
  WHERE
    intakeserreqstatustypekey = 'Open'
    AND activeflag = 1),
  exitdate = NULL,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  servicerequestnumber = '211020158104'
  AND activeflag = 1;

UPDATE
  intakeservicerequestdispositioncode
SET
  activeflag = 0,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakeservicerequestdispositioncodeid IN ('97886296-8cdf-4dae-b8a6-3f7c7ab9f0d6', 
  'd93ac709-acf0-4bb5-9c6a-ebff18d681f5', '42b77421-e561-4403-8da5-10e938658ca2')
  AND activeflag = 1;
END block1 $$;