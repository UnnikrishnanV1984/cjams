
--B-120424 delete request value for routing event code

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('QPDR', 46, 'Quick Person Delete Request', 'Quick Person Delete Request', NULL, 1, 1, 'B-120424', now(), NULL, now(), NULL, NULL, NULL);
