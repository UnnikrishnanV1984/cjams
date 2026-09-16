DELETE FROM objecttype WHERE sequencenumber = 902 AND objecttypekey = 'AdoptionSubsidy' ;
INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(902, 'AdoptionSubsidy', 1, 902, 0, 'AdoptionSubsidy', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
