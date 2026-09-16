-- Daughter in law
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, 
expirationdate, effectivedate, "timestamp", old_id, personrelationship, fourerelid, fourereldesc, actortypekey)
VALUES(122, 'DAUGINLAW', 1, 'Daughter in Law', NULL, now(), NULL, now(), NULL, now(), NULL, NULL, true, 1001, 'within', NULL);

INSERT INTO cjams.relationshiptypeagency
(teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('CW', 'DAUGINLAW', 1, 'admin', now(), 'admin', now(), NULL, NULL);

-- Son in law
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, 
expirationdate, effectivedate, "timestamp", old_id, personrelationship, fourerelid, fourereldesc, actortypekey)
VALUES(123, 'SONINLAW', 1, 'Son in Law', NULL, now(), NULL, now(), NULL, now(), NULL, NULL, true, 1001, 'within', NULL);

INSERT INTO cjams.relationshiptypeagency
(teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('CW', 'SONINLAW', 1, 'admin', now(), 'admin', now(), NULL, NULL);