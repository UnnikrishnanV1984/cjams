INSERT INTO cjams.relationshiptype 
(sequencenumber, relationshiptypekey, description, activeflag, effectivedate, personrelationship)
VALUES(122, 'STGRCLD', 'Step Grandchild', 1, now(), true);

INSERT INTO cjams.relationshiptypeagency
(teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('CW', 'STGRCLD', 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL);