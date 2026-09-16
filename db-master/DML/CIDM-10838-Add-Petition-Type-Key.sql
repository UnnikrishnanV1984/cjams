-- Adult Public Guardianship Transition (APGT)
DELETE FROM cjams.petitiontype WHERE petitiontypekey = 'APGT';

INSERT INTO cjams.petitiontype
(petitiontypeid, petitiontypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon)
VALUES(
  gen_random_uuid(),
  'APGT',
  'Adult Public Guardianship Transition',
  1,
  now(),
  'CIDM-10838',
  'CIDM-10838',
  now(),
  now()
)
ON CONFLICT DO NOTHING;