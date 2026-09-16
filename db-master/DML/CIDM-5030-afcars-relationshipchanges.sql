update relationshiptype set activeflag = 0, updatedby = 'CIDM-5030', updatedon = now()
where sequencenumber = '28' and relationshiptypekey = 'fosterparent';



INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, expirationdate, effectivedate, "timestamp", old_id, personrelationship, fourerelid, fourereldesc, actortypekey)
VALUES(129, 'FOSPARNT', 1, 'Foster-Parent', NULL, '2022-08-10 08:23:48.947', NULL, '2022-08-10 08:23:48.947', NULL, '2022-08-10 08:23:48.947', NULL, NULL, false, NULL, NULL, NULL)ON CONFLICT DO NOTHING; 
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, expirationdate, effectivedate, "timestamp", old_id, personrelationship, fourerelid, fourereldesc, actortypekey)
VALUES(130, 'Kin', 1, 'Kin', NULL, '2022-07-25 10:33:35.669', NULL, '2022-07-25 10:33:35.669', NULL, '2022-07-25 10:33:35.669', NULL, NULL, false, NULL, NULL, NULL)ON CONFLICT DO NOTHING; 
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, expirationdate, effectivedate, "timestamp", old_id, personrelationship, fourerelid, fourereldesc, actortypekey)
VALUES(131, 'Relative', 1, 'Relative', NULL, '2022-07-25 10:33:35.672', NULL, '2022-07-25 10:33:35.672', NULL, '2022-07-25 10:33:35.672', NULL, NULL, false, NULL, NULL, NULL)ON CONFLICT DO NOTHING; 
INSERT INTO cjams.relationshiptype
(sequencenumber, relationshiptypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, expirationdate, effectivedate, "timestamp", old_id, personrelationship, fourerelid, fourereldesc, actortypekey)
VALUES(132, 'NORELTVE', 1, 'Non-Relative', NULL, '2022-07-25 10:33:35.674', NULL, '2022-07-25 10:33:35.674', NULL, '2022-07-25 10:33:35.674', NULL, NULL, false, NULL, NULL, NULL)ON CONFLICT DO NOTHING; 


INSERT INTO cjams.relationshiptypeagency
(relationshiptypeagencyid, teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('09c71c5f-0846-4f8c-8aec-c5487c31f2bb'::uuid, 'CW', 'FOSPARNT', 1, '5030', '2022-07-27 05:34:30.761', '5030', '2022-07-27 05:34:30.761', NULL, NULL)ON CONFLICT DO NOTHING; 
INSERT INTO cjams.relationshiptypeagency
(relationshiptypeagencyid, teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('8d6e835f-bed5-4211-a4db-8100dd7ffee1'::uuid, 'CW', 'Kin', 1, '5030', '2022-08-04 14:02:43.773', '5030', '2022-08-04 14:02:43.773', NULL, NULL)ON CONFLICT DO NOTHING; 
INSERT INTO cjams.relationshiptypeagency
(relationshiptypeagencyid, teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('6f5c61a8-e665-4c40-bddc-22a0dc296464'::uuid, 'CW', 'Relative', 1, '5030', '2022-08-04 14:02:43.781', '5030', '2022-08-04 14:02:43.781', NULL, NULL)ON CONFLICT DO NOTHING; 
INSERT INTO cjams.relationshiptypeagency
(relationshiptypeagencyid, teamtypekey, relationshiptypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('a2bdf7c2-d1f7-40ae-8ae1-ec09231f64f8'::uuid, 'CW', 'NORELTVE', 1, '5030', '2022-08-04 14:02:43.782', '5030', '2022-08-04 14:02:43.782', NULL, NULL)ON CONFLICT DO NOTHING; 
