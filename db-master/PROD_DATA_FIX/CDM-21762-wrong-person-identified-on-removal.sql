DO $$
<<block1>>
DECLARE
primaryCaregiverIdentifier int8 := 3901094;

BEGIN
UPDATE
  intakeservreqchildremoval
SET
  primarycaregiverid = primaryCaregiverIdentifier,
  primarycaregiveractorid = (
  SELECT
    personid
  FROM
    person
  WHERE
    cjamspid = primaryCaregiverIdentifier
    AND activeflag = 1),
  updatedby = 'CDM-21762',
  updatedon = now()
WHERE
  servicecaseid = (
  SELECT
    servicecaseid
  FROM
    servicecase
  WHERE
    servicecasenumber = '221030015182')
  AND personid = (
  SELECT
    personid
  FROM
    person
  WHERE
    cjamspid = '200871939')
  AND activeflag = 1;
END block1 $$;