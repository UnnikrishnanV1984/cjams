
delete from relationshiptypeagency where relationshiptypekey = 'STGRPT'  and activeflag =1 and teamtypekey = 'CW';
delete from relationshiptype where relationshiptypekey = 'STGRPT'  and activeflag =1 ;

INSERT INTO cjams.relationshiptype 
(sequencenumber, relationshiptypekey, description, activeflag, effectivedate, personrelationship)
VALUES(120, 'STGRPT', 'Step Grandparent', 1, now(), true);

INSERT INTO cjams.relationshiptypeagency
(relationshiptypeagencyid, teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES(gen_random_uuid(),'CW', 'STGRPT', 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL);
