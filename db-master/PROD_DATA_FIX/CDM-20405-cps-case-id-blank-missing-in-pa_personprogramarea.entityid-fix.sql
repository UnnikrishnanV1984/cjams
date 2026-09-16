DO $$
<<block1>>
DECLARE
updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-20405';

BEGIN
UPDATE
  personprogramarea p
SET
  p.entityid = i.servicerequestnumber,
  p.updatedon = updateOn,
  p.updatedby = updateBy
FROM
  intakeservicerequest i
WHERE
  p.objectid = i.intakeserviceid::TEXT
  AND
  (p.entityid IS NULL
    OR p.entityid = '')
  AND p.objecttypekey = 'servicerequest';

UPDATE
  personprogramarea p
SET
  p.entityid = s.servicecasenumber,
  p.updatedon = updateOn,
  p.updatedby = updateBy
FROM
  servicecase s
WHERE
  p.objectid = s.servicecaseid::TEXT
  AND
  (p.entityid IS NULL
    OR p.entityid = '')
  AND p.objecttypekey = 'servicecase';

UPDATE
  personprogramarea p
SET
  p.entityid = a.adoptioncasenumber,
  p.updatedon = updateOn,
  p.updatedby = updateBy
FROM
  adoptioncase a
WHERE
  p.objectid = a.adoptioncaseid::TEXT
  AND
  (p.entityid IS NULL
    OR p.entityid = '')
  AND p.objecttypekey = 'adoptioncase';
END block1 $$;