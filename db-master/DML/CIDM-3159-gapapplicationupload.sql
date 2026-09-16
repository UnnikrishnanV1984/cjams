INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(949, 'gapapplication', 1, 949, 0, 'gap', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL) on conflict do nothing ;
