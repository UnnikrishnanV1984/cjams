-- Adoptive father
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, 
expirationdate, effectivedate, "timestamp", old_id, personrelationship, actortypekey, fourerelid, fourereldesc)
VALUES(121, 'ADPFTHR', 1, 'Adoptive Father', NULL, now(), NULL, now(), NULL, 
now(), NULL, NULL, true, NULL, 1001, 'Non-Relative');

INSERT INTO cjams.relationshiptypeagency
( teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, 
insertedon, effectivedate, old_id)
VALUES('CW', 'ADPFTHR', 1, 'admin', now(), 'admin', 
 now(), NULL, NULL);


-- Adoptive mother
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, 
expirationdate, effectivedate, "timestamp", old_id, personrelationship, actortypekey, fourerelid, fourereldesc)
VALUES(121, 'ADPMTHR', 1, 'Adoptive Mother', NULL, now(), NULL, now(), NULL, 
now(), NULL, NULL, true, NULL, 1001, 'Non-Relative');

INSERT INTO cjams.relationshiptypeagency
( teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, 
insertedon, effectivedate, old_id)
VALUES('CW', 'ADPMTHR', 1, 'admin', now(), 'admin', 
 now(), NULL, NULL);


-- Adoptive child
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, 
expirationdate, effectivedate, "timestamp", old_id, personrelationship, actortypekey, fourerelid, fourereldesc)
VALUES(121, 'ADPCHLD', 1, 'Adoptive Child', NULL, now(), NULL, now(), NULL, 
now(), NULL, NULL, true, NULL, 1001, 'Non-Relative');

INSERT INTO cjams.relationshiptypeagency
( teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, 
insertedon, effectivedate, old_id)
VALUES('CW', 'ADPCHLD', 1, 'admin', now(), 'admin', 
 now(), NULL, NULL);



