-- CIDM-8613 - fix for the providers with multiple addresses marked as default data issue

-- 1) Provider Address Fix Audit Log type
delete from auditlogtype where insertedby = 'CIDM-8613' ;

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'PROVADDRESS', 'The Provider address default switch was updated as No', 'Provider Address', now(), 
		NULL, 'CIDM-8613', 'CIDM-8613', now(), now(), NULL
	);
	

