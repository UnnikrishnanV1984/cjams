
update attachmentclassificationtype set subcategory = 'CW-Health_Mental Health' where subcategory = 'CW-Health-Mental CW-Health';

INSERT INTO cjams.attachmentclassificationtype
(sequencenumber, attachmentclassificationtypekey,activeflag,editable, typedescription, datavalue, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id, subcategory)
VALUES(301,'CW-Provider', 1, 0, 'CW-Provider', 301,current_timestamp, NULL, NULL, 'admin', 'admin', current_timestamp, current_timestamp, NULL, 'CW-In-Service Training');
