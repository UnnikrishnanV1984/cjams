DELETE FROM cjams.documenttemplate
	WHERE documentname IN ('cpsintakereport','cpsintakereportE');
	
	
INSERT INTO cjams.documenttemplate(
	documenttemplateid, documentname, s3bucketpathname, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, ismandatory, documenttemplatekey, old_id, downloadtype, inputfields, isheaderrequired, headertemplatehtml)
	VALUES (cjams.gen_random_uuid(), 'cpsintakereport', 'https://s3-ap-southeast-1.amazonaws.com/welfarestorage/documenttemplates/cpsintakereport.doc',
			null, 1, '2019-03-22 16:15:23.14137', null, null, null, null, false, 'cpsintakereport', null, 'direct', null, false, 'default');
	

	