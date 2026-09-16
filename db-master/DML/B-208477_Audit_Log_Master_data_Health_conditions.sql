-- B-208477 - Conditions/Disorders Audit Log

-- 'open-health-condition', 'User visited Conditions/Disorders page.'
-- 'User clicked on add new Conditions/Disorders page'

Delete from auditlogtype where modulename = 'Health_Conditions' ;

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'open-health-condition', 'User visited Conditions/Disorders page.', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'add-health-condition', 'User clicked on add new Conditions/Disorders page', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'edit-health-condition', 'User clicked on edit Conditions/Disorders page', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'view-health-condition', 'User viewed the Conditions/Disorders page.', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'delete-health-condition', 'User Deleted the Conditions/Disorders page.', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'leave-from-health-condition', 'User moved to another page from the Conditions/Disorders page.', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);


INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'yes-popup-health-condition', 'User selected Yes from Conditions/Disorders popup.', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'no-popup-health-condition', 'User selected No from Conditions/Disorders popup.', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);	


INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'close-health-condition', 'User closed the Conditions/Disorders popup', 'Health_Conditions', now(), 
		NULL, 'B-208477', 'B-208477', now(), now(), NULL
	);	