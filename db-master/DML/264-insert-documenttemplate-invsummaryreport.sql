-- DELETE FROM cjams.documenttemplate
-- 	WHERE documenttemplatekey = 'invsummaryreport'; 
	
	
INSERT INTO cjams.documenttemplate(
			documenttemplateid, documentname, s3bucketpathname, 
			description, activeflag, effectivedate, 
			insertedby, updatedby, insertedon, updatedon, ismandatory, 
			documenttemplatekey, old_id, downloadtype, inputfields, 
			isheaderrequired, headertemplatehtml)
	VALUES (cjams.gen_random_uuid(), 'InvestigationSummaryReport', null,
			'Investigation Summary Report', 1, '2000-01-01 16:15:23.14137', 
			null, null, now(), now(), false, 
			'invsummaryreport', null, 'direct', null,
			false, 'default');
	
	