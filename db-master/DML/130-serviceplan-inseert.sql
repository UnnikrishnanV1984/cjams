delete from documenttemplate where documenttemplateid= 'db578164-47d5-4783-9aaf-c2186b57ddb7';
INSERT INTO cjams.documenttemplate
(documenttemplateid, documentname, s3bucketpathname, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, ismandatory, documenttemplatekey, old_id, downloadtype, inputfields, isheaderrequired, headertemplatehtml)
VALUES('db578164-47d5-4783-9aaf-c2186b57ddb7', 'inhome', 'https://s3-ap-southeast-1.amazonaws.com/welfarestorage/documenttemplates/inhome.doc', NULL, 1, '2018-08-28 12:58:40.285', NULL, NULL, NULL, NULL, false, 'inhome', NULL, 'direct', NULL, false, 'default');
