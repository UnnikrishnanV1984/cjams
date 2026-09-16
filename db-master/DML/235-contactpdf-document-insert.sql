delete from documenttemplate  where documenttemplatekey='contactpdf';


INSERT INTO cjams.documenttemplate
( documentname, s3bucketpathname, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, ismandatory, documenttemplatekey, old_id, downloadtype, inputfields, isheaderrequired, headertemplatehtml)
VALUES( 'Contact Notes PDF', '', NULL, 1, now(), NULL, NULL, NULL, NULL, false, 'contactpdf', NULL, 'direct', NULL, false, 'default');
