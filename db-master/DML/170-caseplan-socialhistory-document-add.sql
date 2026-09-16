delete from documenttemplate where documenttemplateid='98efb1fd-d907-4120-9895-18a0f0b419ef';


INSERT INTO cjams.documenttemplate
(documenttemplateid, documentname, s3bucketpathname, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, ismandatory, documenttemplatekey, old_id, downloadtype, inputfields, isheaderrequired, headertemplatehtml)
VALUES('98efb1fd-d907-4120-9895-18a0f0b419ef', 'Case Plan Social History', NULL, NULL, 1,  now(), NULL, NULL, NULL, NULL, false, 'CasePlanSocialHistory', NULL, 'direct', NULL, true, 'default');
