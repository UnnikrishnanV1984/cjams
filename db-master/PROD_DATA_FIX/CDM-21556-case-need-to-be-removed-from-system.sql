DO $$
<<block1>>
DECLARE
intakeNum TEXT := 'I202000208307';

dispositionId UUID := '9eeebecd-0618-464e-ace5-ad0896c0f635';

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-21556';

intakeId UUID;

intakeStatusId UUID;

intakeJson JSONB;

BEGIN
intakeStatusId :=(
SELECT
  intakeserreqstatustypeid
FROM
  intakeserreqstatustype
WHERE
  intakeserreqstatustypekey = 'Closed'
  AND activeflag = 1);

UPDATE
  intakeservicerequest
SET
  intakeserreqstatustypeid = intakeStatusId,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

intakeId :=(
SELECT
  intakeserviceid
FROM
  intakeservicerequest
WHERE
  intakenumber = intakeNum
  AND activeflag = 1);

INSERT
  INTO
  servicerequesttypeconfigdispositioncode (servicerequesttypeconfigiddispostionid,
  servicerequesttypeconfigid,
  dispositioncode,
  description,
  intakeserreqstatustypeid,
  effectivedate,
  insertedby,
  insertedon,
  updatedby,
  updatedon)
VALUES (dispositionId,
(
SELECT
  servicerequesttypeconfigid
FROM
  servicerequesttypeconfig
WHERE
  intakeservicerequestplantypekey = 'INV'
  AND category = 'Intake'
  AND duedateoffset = 60
  AND activeflag = 1
ORDER BY
  expirationdate DESC
LIMIT 1),
'ScreenOUT',
'Screen Out',
(
SELECT
  intakeserreqstatustypeid
FROM
  intakeserreqstatustype
WHERE
  intakeserreqstatustypekey = 'Approved'
  AND activeflag = 1),
(
SELECT
  statusdate
FROM
  intakeservicerequestdispositioncode
WHERE
  intakeserviceid = intakeId
  AND activeflag = 1),
  updateBy,
  updateOn,
  updateBy,
  updateOn) ON
CONFLICT DO NOTHING;

UPDATE
  intakeservicerequestdispositioncode
SET
  servicerequesttypeconfigiddispostionid = dispositionId,
  intakeserreqstatustypeid = intakeStatusId,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakeserviceid = intakeId
  AND activeflag = 1;

intakeJson :=(
SELECT
  jsondata
FROM
  intakedastaging
WHERE
  intakenumber = intakeNum
  AND activeflag = 1);

intakeJson := jsonb_set(intakeJson, '{DAType,DATypeDetail,0,supDisposition}', '"ScreenOUT"');

intakeJson := jsonb_set(intakeJson, '{DAType,DATypeDetail,0,dispositioncode}', '"ScreenOUT"');

intakeJson := jsonb_set(intakeJson, '{disposition,0,supDisposition}', '"ScreenOUT"');

intakeJson := jsonb_set(intakeJson, '{disposition,0,dispositioncode}', '"ScreenOUT"');

UPDATE
  intakedastaging
SET
  jsondata = intakeJson,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  intakedastatus
SET
  jsondata = intakeJson,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  intakesnapshot
SET
  jsondata = intakeJson,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  intakenumber = intakeNum
  AND activeflag = 1;

UPDATE
  routing
SET
  routingstatustypeid = (
  SELECT
    sequencenumber
  FROM
    routingstatustype
  WHERE
    routingstatustypekey = 'ACCPT'
    AND activeflag = 1),
  activeflag = 1,
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  objectid = intakeNum
  AND eventcode = 'INTR';
END block1 $$;