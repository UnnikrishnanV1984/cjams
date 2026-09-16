delete from attachmentclassificationtype where attachmentclassificationtypekey='CW-CPS-APPEALS';

INSERT INTO cjams.attachmentclassificationtype
(sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id, subcategory)
VALUES(311, 'CW-CPS-APPEALS', 1, 50, 0, 'CW-CPS-APPEALS', now(), NULL, NULL, 'admin', 'admin', now(), now(), NULL, 'CW-CPS-APPEALS');
