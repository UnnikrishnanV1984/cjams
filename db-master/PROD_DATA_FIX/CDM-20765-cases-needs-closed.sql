DO $$
<<block1>>
DECLARE
caseDispositionId UUID := '1cdadd6a-fda4-4e66-b5e3-2587370dd9d1';

userId UUID := '846a2ba6-4b62-45db-af56-076ab5d0b400';

caseCloseDate TIMESTAMP := '2022-02-18 00:00:00';

caseStatus TEXT := 'Closed';

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-20765';

caseId UUID;

BEGIN
caseId := (
SELECT
  servicecaseid
FROM
  servicecase
WHERE
  servicecasenumber = '221030014316');

UPDATE
  servicecase
SET
  statustypekey = caseStatus,
  dispositioncode = caseStatus,
  enddate = caseCloseDate,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  servicecaseid = caseId;

INSERT
  INTO
  servicecasedisposition (servicecasedispositionid,
  servicecaseid,
  statusdate,
  intakeserreqstatustypekey,
  dispositioncode,
  "comments",
  effectivedate,
  insertedby,
  insertedon,
  updatedby,
  updatedon)
VALUES (caseDispositionId,
caseId,
caseCloseDate,
caseStatus,
caseStatus,
'Case opened in Error', 
caseCloseDate,
userId,
updateOn,
updateBy,
updateOn) ON
CONFLICT DO NOTHING;

INSERT
  INTO
  routing (routingid,
  eventcode,
  fromsecurityusersid,
  tosecurityusersid,
  fromroleid,
  toroleid,
  objectid,
  routingstatustypeid,
  insertedby,
  insertedon,
  updatedby,
  updatedon)
VALUES ('a633436e-30cd-4cbc-b5b9-628d9bcfbfee',
'SCDR',
'30af9b82-e4d5-441f-8ede-a19af5447151',
userId,
'CWSP',
'CWSP',
caseDispositionId,
16,
updateBy,
updateOn,
updateBy,
updateOn) ON
CONFLICT(routingid) DO
UPDATE
SET
  objectid = EXCLUDED.objectid;
END block1 $$;