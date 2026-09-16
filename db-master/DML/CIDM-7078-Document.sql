

 INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(1001, 'investigation', 1, 1001, 0, 'investigation', now(), NULL, NULL, 'Admin', NULL, now(), NULL, NULL)on conflict do nothing;
 
INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(1005, 'Case', 1, 1005, 0, 'Case', now(), NULL, NULL, 'Admin', NULL, now(), NULL, NULL)on conflict do nothing;	
		