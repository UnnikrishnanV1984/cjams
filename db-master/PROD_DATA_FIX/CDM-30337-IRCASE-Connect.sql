/*
   Issue Description: CDM-30337
   Category/ Module  : service case creation
   Root cause: service case is not created for the intake 
   Pull request# for code fix: 8747
   Reason why no related code fix: 
    requested a data fix to resolve
*/

UPDATE
  intakeservicerequest
SET
  actiontype = 'IR',
  intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
  intakeservicerequestclassid = (
  SELECT
    servicerequestsubtypeid
  FROM
    servicerequestsubtype
  WHERE
    classkey = 'CPS-IR'
    AND activeflag = 1),
  updatedon = now(),
  updatedby = 'CDM-30337'
WHERE
  intakenumber = 'I231010489619'
  AND activeflag = 1;

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
VALUES ('2232ac6c-baf6-49cc-9875-48464cc6b3d7',
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
'Scrnin',
'Screen In',
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
  intakeserviceid = 'c1d42d82-95a0-4aeb-b44e-febbbaf35429'),
  'CDM-30337',
  now(),
  'CDM-30337',
  now()) ON
CONFLICT DO NOTHING;

UPDATE
  intakeservicerequestdispositioncode
SET
  servicerequesttypeconfigiddispostionid = '2232ac6c-baf6-49cc-9875-48464cc6b3d7',
  updatedon = now(),
  updatedby = 'CDM-30337'
WHERE
  intakeserviceid = 'c1d42d82-95a0-4aeb-b44e-febbbaf35429'
  AND activeflag = 1;


UPDATE
  intakedastaging
SET
  jsondata = jsonb_set(jsonb_set(jsondata, '{disposition,0,supDisposition}', '"Scrnin"'), '{DAType,DATypeDetail,0,supDisposition}', '"Scrnin"'),
  updatedon = now(),
  updatedby = 'CDM-30337'
WHERE
  intakenumber = 'I231010489619'
  AND activeflag = 1;

UPDATE
  intakedastatus
SET
  jsondata = jsonb_set(jsonb_set(jsondata, '{disposition,0,supDisposition}', '"Scrnin"'), '{DAType,DATypeDetail,0,supDisposition}', '"Scrnin"'),
  updatedon = now(),
  updatedby = 'CDM-30337'
WHERE
  intakenumber = 'I231010489619'
  AND activeflag = 1;

UPDATE
  intakesnapshot
SET
  jsondata = jsonb_set(jsonb_set(jsondata, '{disposition,0,supDisposition}', '"Scrnin"'), '{DAType,DATypeDetail,0,supDisposition}', '"Scrnin"'),
  updatedon = now(),
  updatedby = 'CDM-30337'
WHERE
  intakenumber = 'I231010489619'
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
  updatedon = now(),
  updatedby = 'CDM-30337'
WHERE
  objectid = 'I231010489619'
  AND eventcode = 'INTR';