UPDATE progressnotereasontype
SET activeflag=0
WHERE progressnotereasontypekey='ICPS';

UPDATE progressnotereasontype
SET activeflag=0
WHERE progressnotereasontypekey='BFV';

INSERT INTO progressnotereasontype
(progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), 'IVCPS', 1, 'Investigation & CPS', now(), 'admin', 'admin', now(), now(), '');

INSERT INTO progressnotereasontype
(progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), 'BIFV', 1, 'Biological Family Visits', now(), 'admin', 'admin', now(), now(), '');

UPDATE progressnotetype
SET description='Phone/Electronic', updatedon=now()
WHERE progressnotetypekey='Phone' and Lower(progressnoteclassificationtypekey) = 'user';

UPDATE progressnotetype
SET description='Text message', updatedon=now()
WHERE progressnotetypekey='Text message' and Lower(progressnoteclassificationtypekey) = 'user';