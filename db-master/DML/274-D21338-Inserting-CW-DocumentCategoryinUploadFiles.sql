/* Need to verify the sequencenumber, datavalue and subcategory values */

INSERT INTO cjams.attachmentclassificationtype
(sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id, subcategory)
VALUES(302, 'CW-Document', 1, 302, 0, 'CW-Document', now(), NULL, NULL, 'admin', 'admin', now(), now(), NULL, 'CW-Document');